#!/usr/bin/env bash
set -euo pipefail

TARGET_PCI_BDF="0000:65:00.6"

INTERNAL_SINK_NAME="alsa_output.pci-0000_65_00.6.analog-stereo"

find_card_index() {
  for card_path in /sys/class/sound/card*; do
    [[ -e "$card_path" ]] || continue
    local dev
    dev="$(readlink -f "$card_path/device" 2>/dev/null || true)"
    if [[ "$dev" == *"/$TARGET_PCI_BDF"* ]]; then
      basename "$card_path" | sed 's/^card//'
      return 0
    fi
  done
  return 1
}

card_index="$(find_card_index || true)"
if [[ -z "${card_index:-}" ]]; then
  echo "g14-audio-fix-alsa: could not find ALSA card for $TARGET_PCI_BDF" >&2
  exit 0
fi

amixer_card=(amixer -c "$card_index")

# Don't fight intentional user mutes at the PipeWire level.
if command -v pactl >/dev/null 2>&1; then
  default_sink="$(pactl get-default-sink 2>/dev/null || true)"
  if [[ "$default_sink" == "$INTERNAL_SINK_NAME" ]]; then
    if pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -qi "Mute: yes"; then
      exit 0
    fi
  fi
fi

jack_on=0
if "${amixer_card[@]}" cget numid=30 2>/dev/null | grep -q "values=on"; then
  jack_on=1
fi

ensure_on_and_nonzero() {
  local control="$1"
  local target_percent="$2"
  local min_percent="${3:-$target_percent}"

  local out
  out="$("${amixer_card[@]}" sget "$control" 2>/dev/null || true)"
  [[ -n "$out" ]] || return 0

  local is_off=0
  if grep -q "\[off\]" <<<"$out"; then
    is_off=1
  fi

  local percent
  percent="$(grep -oE "\[[0-9]+%\]" <<<"$out" | head -n1 | tr -d '[]%' || true)"
  percent="${percent:-0}"

  if [[ "$is_off" -eq 1 || "$percent" -lt "$min_percent" ]]; then
    "${amixer_card[@]}" sset "$control" "${target_percent}%" unmute >/dev/null
  fi
}

ensure_switch_on() {
  local control="$1"
  local out
  out="$(${amixer_card[@]} sget "$control" 2>/dev/null || true)"
  [[ -n "$out" ]] || return 0
  if grep -q "\[off\]" <<<"$out"; then
    "${amixer_card[@]}" sset "$control" on >/dev/null 2>&1 || true
  fi
}

ensure_enum() {
  local control="$1"
  local value="$2"
  "${amixer_card[@]}" sset "$control" "$value" >/dev/null 2>&1 || true
}

ensure_master_full_gain() {
  ensure_on_and_nonzero "Master" 100 100
}

# This stack keeps flipping these back to defaults; enforce sane values.
ensure_enum "Auto-Mute Mode" "Enabled"

# With WirePlumber soft-mixer enabled, hardware playback gain should stay at 0dB.
# Firmware/driver paths on this machine sometimes push these down; keep them pinned.
ensure_master_full_gain
ensure_on_and_nonzero "PCM" 100 100
ensure_switch_on "Bass Speaker"

if [[ "$jack_on" -eq 1 ]]; then
  ensure_on_and_nonzero "Headphone" 100 100
  # Keep speaker sane too; some firmware/driver paths end up disabling both.
  ensure_on_and_nonzero "Speaker" 100 100
else
  ensure_on_and_nonzero "Speaker" 100 100
  ensure_on_and_nonzero "Headphone" 100 100
fi

exit 0