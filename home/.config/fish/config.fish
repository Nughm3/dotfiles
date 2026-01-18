# Arch Linux changes `hx` to `helix`
alias hx="helix"
set -gx EDITOR helix

set -g fish_greeting
set -g async_prompt_functions _pure_prompt_git
set -g pure_enable_single_line_prompt true
set -g pure_enable_nixdevshell true
set -g pure_show_jobs true
set -g pure_show_prefix_root_prompt true
set -g pure_color_success green
set -g pure_symbol_git_unpulled_commits "↓"
set -g pure_symbol_git_unpushed_commits "↑"
set -g sponge_purge_only_on_exit true

source /etc/locale.conf

set -gx SHELL /usr/bin/fish
# set -gx EDITOR hx

# set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx NEXT_TELEMETRY_DISABLED
set -gx ASTRO_TELEMETRY_DISABLED
set -gx CUDA_PATH /opt/cuda

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/lib/rustup/bin
fish_add_path /opt/cuda/bin

if test "$WAYLAND_DISPLAY" = ""; and test "$XDG_VTNR" = 1
    exec dbus-run-session river
    # exec dbus-run-session -- qtile start --backend wayland
end

alias rc="$EDITOR ~/.config/fish/config.fish"
alias so="source ~/.config/fish/config.fish"

# alias dotfiles-update="nix flake update ~/.dotfiles"
# alias profile-update="nix profile upgrade '.*' --impure"
# alias home-config="$EDITOR ~/.dotfiles/home-manager/home.nix"
# alias nixos-config="$EDITOR ~/.dotfiles/nixos/configuration.nix"

# function home-update
#     if command -q nh
#         nh home switch -- $argv
#     else
#         home-manager switch \
#             --flake ~/.dotfiles#isaac@nixos \
#             --impure \
#             $argv
#     end
# end

# function nixos-update
#     if command -q nh
#         nh os switch -- --impure $argv
#     else
#         sudo nixos-rebuild switch \
#             --upgrade-all \
#             --flake ~/.dotfiles#nixos \
#             --impure \
#             $argv
#     end
# end

# function nixos-clean
#     if command -q nh
#         nh clean all
#     else
#         sudo nix-collect-garbage -d
#         nix store optimise
#     end
# end

# function update
#     dotfiles-update
#     nixos-update
#     home-update
#     profile-update
# end

# abbr n nix
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
# abbr yz yazi
# abbr zj zellij
# alias at 'zellij attach (zellij list-sessions -s | fzf -0 -1)'
# alias ac 'zellij attach --create (basename $PWD)'

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

alias nvchad="NVIM_APPNAME=nvchad nvim"
alias lazyvim="NVIM_APPNAME=lazyvim nvim"

bind \cz 'fg 2>/dev/null; commandline -f repaint'
bind \ce '$EDITOR (fzf)'

function aoc
    set day (date +%-d)
    set year (date +%Y)

    set input_file "input$day"
    set solution_file "day$day.py"

    if not test -e $input_file
        curl -s -b session=$AOC_SESSION_ID "https://adventofcode.com/$year/day/$day/input" -o $input_file
    end

    if not test -e $solution_file
        echo -e "\
with open(\"$input_file\") as f:
    data = f.read().splitlines()\n\n" >$solution_file
    end

    if test $EDITOR = hx -o $EDITOR = helix
        $EDITOR $solution_file:(count < $solution_file)
    else if test $EDITOR = vim -o $EDITOR = nvim
        $EDITOR $solution_file +
    else
        $EDITOR $solution_file
    end
end

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

if status is-interactive
    if command -q atuin
        atuin init fish --disable-up-arrow | source
    end
    if command -q direnv
        direnv hook fish | source
    end
    if command -q starship
        starship init fish | source
    end
    if command -q zellij
        zellij setup --generate-completion fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end

    __auto_source_venv
end

function vcut
    ffmpeg -hwaccel nvdec -i $argv[1] -ss $argv[2] -to $argv[3] -c:v h264_nvenc "$argv[4].mp4"
end

function vcompress
    ffmpeg -hwaccel nvdec -i $argv[1] -crf 28 -c:v h264_nvenc "$argv[1].compress.mp4"
end

function mkv2mp4
    ffmpeg -i $argv[1] -c copy "$argv[1].mp4"
end

# source /opt/miniconda3/etc/fish/conf.d/conda.fish

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/isaac/.lmstudio/bin
# End of LM Studio CLI section
