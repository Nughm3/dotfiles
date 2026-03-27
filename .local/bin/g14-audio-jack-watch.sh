#!/usr/bin/env bash
set -euo pipefail

TARGET_PCI_BDF="0000:65:00.6"
HOME_DIR="${HOME:-/home/isaac}"
FIX_SCRIPT="${HOME_DIR}/.local/bin/g14-audio-fix-alsa.sh"

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
  echo "g14-audio-jack-watch: could not find ALSA card for $TARGET_PCI_BDF" >&2
  exit 0
fi

hw="hw:${card_index}"

# Apply once on startup.
"$FIX_SCRIPT" || true

# Some paths appear to flip mixer state without emitting ALSA control events.
# Run a lightweight periodic enforcement too (the fixer only changes state when it is 0/off).
(
  while true; do
    sleep 3
    "$FIX_SCRIPT" || true
  done
) &

# Watch for jack events and re-apply.
stdbuf -oL alsactl monitor "$hw" 2>/dev/null | while IFS= read -r line; do
  case "$line" in
    *"Headphone Jack"*|*"#30"*)
      "$FIX_SCRIPT" || true
      ;;
  esac
done
