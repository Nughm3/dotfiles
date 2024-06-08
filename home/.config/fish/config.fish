# Arch Linux changes `hx` to `helix`
# alias hx="helix"

set -g fish_greeting
set -g async_prompt_functions _pure_prompt_git
set -g pure_enable_single_line_prompt true
set -g pure_show_jobs true
set -g pure_show_prefix_root_prompt true
set -g pure_color_success green
set -g pure_symbol_git_unpulled_commits "↓"
set -g pure_symbol_git_unpushed_commits "↑"

set -gx SHELL /run/current-system/sw/bin/fish
set -gx EDITOR hx
set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx NEXT_TELEMETRY_DISABLED
set -gx ASTRO_TELEMETRY_DISABLED
set -gx BEMENU_OPTS "-i -p run --fn 'JetBrainsMono Nerd Font 11' -H 30 --ch 16 --cw 2 --hp 8 --tb '#61afef' --tf '#282c34' --ff '#c8ccd4' --fb '#1e222a' --nb '#282c34' --nf '#61afef' --hb '#61afef' --hf '#282c34' --ab '#282c34' --af '#61afef' --scrollbar autohide"

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

alias rc="$EDITOR ~/.config/fish/config.fish"
alias so="source ~/.config/fish/config.fish"

alias dotfiles-update="nix flake update ~/.dotfiles"
alias profile-update="nix profile upgrade '.*' --impure"
alias home-config="$EDITOR ~/.dotfiles/home-manager/home.nix"
alias nixos-config="$EDITOR ~/.dotfiles/nixos/configuration.nix"

function home-update
    home-manager switch \
        --flake ~/.dotfiles#isaac@nixos \
        --impure \
        $argv
end

function nixos-update
    sudo nixos-rebuild switch \
        --upgrade-all \
        --flake ~/.dotfiles#nixos \
        --impure \
        $argv
end

function nixos-clean
    sudo nix-collect-garbage -d
    nix store optimise
end

function update
    dotfiles-update
    nixos-update
    home-update
    profile-update
end

abbr n nix
abbr e "$EDITOR"
abbr c cargo

alias ls "eza --icons --git"
abbr la "ls -la"
abbr lt "ls -T"

alias rm "rm -i"
alias mv "mv -i"
alias cp "cp -ir"
alias mkdir "mkdir -p"
abbr md mkdir

abbr py python
alias man batman
alias watchexec "watchexec --clear=clear"
abbr wx watchexec
abbr yz yazi
abbr zj zellij
alias at 'zellij attach (zellij list-sessions -s | fzf -0 -1)'
alias ac 'zellij attach --create (basename $PWD)'

abbr g git
abbr ga "git add"
abbr gc "git commit -am"
abbr gd "git diff"
abbr gl "git log --oneline --graph"
abbr gs "git status"
abbr gp "git push"
abbr gu "git pull"
abbr gg 'cd (git rev-parse --show-toplevel)'
abbr rt "git rev-parse --show-toplevel"

bind \cz 'fg 2>/dev/null; commandline -f repaint'

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
end
