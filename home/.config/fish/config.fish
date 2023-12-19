# Arch Linux changes `hx` to `helix`
# alias hx="helix"

set -g fish_greeting
set -gx SHELL /run/current-system/sw/bin/fish
set -gx EDITOR hx
set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx NEXT_TELEMETRY_DISABLED
set -gx ASTRO_TELEMETRY_DISABLED
set -gx CARGO_UNSTABLE_GC true
set -gx BEMENU_OPTS "-i -p run --fn 'JetBrainsMono Nerd Font 11' -H 30 --ch 16 --cw 2 --hp 8 --tb '#61afef' --tf '#282c34' --ff '#c8ccd4' --fb '#1e222a' --nb '#282c34' --nf '#61afef' --hb '#61afef' --hf '#282c34' --ab '#282c34' --af '#61afef' --scrollbar autohide"

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

alias rc="$EDITOR ~/.config/fish/config.fish"
alias so="source ~/.config/fish/config.fish"

alias dotfiles-update="nix flake update ~/.dotfiles"
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
    nix store gc
    nix store optimise
end

function update
    dotfiles-update
    nixos-update
    home-update
end

alias e="$EDITOR"
alias c="cargo"

alias ls="eza --icons --git"
alias la="ls -la"
alias lt="ls -T --git-ignore"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -ir"
alias mkdir="mkdir -p"
alias md="mkdir"

alias py="python3 -q"
alias fd="fd -H"
alias watchexec="watchexec --clear=clear"
alias wx="watchexec"
alias yz="yazi"
alias zj="zellij"
alias at='zellij attach (zellij list-sessions | fzf -0 -1)'
alias ac='zellij attach --create (basename $PWD)'

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph"
alias gu="git pull"
alias gp="git push"
alias gg='cd (git rev-parse --show-toplevel)'
alias rt="git rev-parse --show-toplevel"

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
    data = f.read().splitlines()\n\n" > $solution_file
    end

    if test $EDITOR = "hx" -o $EDITOR = "helix"
        $EDITOR $solution_file:(count < $solution_file)
    else if test $EDITOR = "vim" -o $EDITOR = "nvim"
        $EDITOR $solution_file +
    else
        $EDITOR $solution_file
    end
end

if status is-interactive
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source
    zellij setup --generate-completion fish | source
    # INHIBIT_THEME_HIST=1 theme.sh onedark
end

set -gx AOC_SESSION_ID "53616c7465645f5f3a29c7bf6293a85f724d50449c6b074657eaf6cf9df6cd01d8d01476eb0f0874b5d97d83ed813fa53354d5c98774fc611ae2865cc95cf4af"
