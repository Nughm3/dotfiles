# CachyOS-specific config
source /usr/share/cachyos-fish-config/cachyos-config.fish
function fish_greeting
    # CachyOS runs fastfetch on shell startup
    # This no-op greeting disables fastfetch
end
functions -e rip # remove the `rip` alias to avoid conflicts with rm-improved
# End CachyOS-specific config

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no

set -g async_prompt_functions _pure_prompt_git
set -g pure_enable_single_line_prompt true
set -g pure_enable_nixdevshell true
set -g pure_show_jobs true
set -g pure_show_prefix_root_prompt true
set -g pure_color_success green
set -g pure_symbol_git_unpulled_commits "↓"
set -g pure_symbol_git_unpushed_commits "↑"
set -g sponge_purge_only_on_exit true

alias hx="helix"
set -gx EDITOR helix
set -gx SHELL /usr/bin/fish

set -gx DISABLE_TELEMETRY 1 # Claude Code
set -gx RTK_TELEMETRY_DISABLED 1
set -gx NEXT_TELEMETRY_DISABLED
set -gx ASTRO_TELEMETRY_DISABLED
set -gx CUDA_PATH /opt/cuda
set -gx DEBUGINFOD_URLS https://debuginfod.archlinux.org

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/lib/rustup/bin
fish_add_path /opt/cuda/bin

abbr e "$EDITOR"
abbr c cargo

alias ls "eza --icons --git --group-directories-first"
abbr la "ls -la"
abbr lt "ls -T"

alias rm "rm -i"
alias mv "mv -i"
alias cp "cp -ir"
alias scp "scp -r"
alias mkdir "mkdir -p"
abbr md mkdir

abbr py python
alias fd "fd -H"
alias watchexec "watchexec --clear=clear"
abbr wx watchexec
abbr dbx distrobox

abbr g git
abbr ga "git add"
abbr gc "git commit -am"
abbr gca "git commit --amend --no-edit"
abbr gd "git diff"
abbr gl "git log --oneline --graph"
abbr gs "git status"
abbr gp "git push"
abbr gu "git pull"
abbr gsw "git switch"
abbr gg 'cd (git rev-parse --show-toplevel)'
abbr rt "git rev-parse --show-toplevel"

bind \cz 'fg 2>/dev/null; commandline -f repaint'
bind \ce '$EDITOR (fzf)'

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return

    # Check if we are inside a git directory
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
        set cwd (pwd -P)
        # While we are still inside the git directory, find the closest
        # virtualenv starting from the current directory.
        while string match "$gitdir*" "$cwd" &>/dev/null
            if test -e "$cwd/.venv/bin/activate.fish"
                source "$cwd/.venv/bin/activate.fish" &>/dev/null
                return
            else
                set cwd (path dirname "$cwd")
            end
        end
    end
    # If virtualenv activated but we are not in a git directory, deactivate.
    if test -n "$VIRTUAL_ENV"
        deactivate
    end
end

if status is-login
    if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
        systemctl --user start niri.service
    end
end

if status is-interactive
    if command -q direnv
        direnv hook fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end

    __auto_source_venv
end
