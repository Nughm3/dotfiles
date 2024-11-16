{ pkgs, ... }: {
  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
    };

    fish = {
      enable = true;

      plugins = with pkgs.fishPlugins; [
        pure
        done
        sponge
        puffer
        autopair
        async-prompt
        colored-man-pages
      ];

      functions = {
        dotfiles-update = "nix flake update ~/.dotfiles $argv";
        profile-update = "nix profile upgrade '.*' --impure $argv";
        home-update = "home-manager switch --flake ~/.dotfiles#isaac@nixos --impure $argv";
        nixos-update = "sudo nixos-rebuild switch --upgrade-all --flake ~/.dotfiles#nixos --impure $argv";
        nixos-clean = ''
          sudo nix-collect-garbage -d
          nix store optimise
        '';
        update = ''
          dotfiles-update
          nixos-update
          home-update
          profile-update
        '';
      };

      shellInit = ''
        set -g fish_greeting
        set -g async_prompt_functions _pure_prompt_git
        set -g pure_enable_single_line_prompt true
        set -g pure_show_jobs true
        set -g pure_show_prefix_root_prompt true
        set -g pure_color_success green
        set -g pure_symbol_git_unpulled_commits "↓"
        set -g pure_symbol_git_unpushed_commits "↑"

        set -gx NIXPKGS_ALLOW_UNFREE 1
        set -gx NEXT_TELEMETRY_DISABLED
        set -gx ASTRO_TELEMETRY_DISABLED
        set -gx BEMENU_OPTS "-i -p run --fn 'JetBrainsMono Nerd Font 11' -H 30 --ch 16 --cw 2 --hp 8 --tb '#61afef' --tf '#282c34' --ff '#c8ccd4' --fb '#1e222a' --nb '#282c34' --nf '#61afef' --hb '#61afef' --hf '#282c34' --ab '#282c34' --af '#61afef' --scrollbar autohide"

        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin

        bind \cz 'fg 2>/dev/null; commandline -f repaint'
      '';

      shellAbbrs = {
        c = "cargo";
        e = "$EDITOR";
        n = "nix";
        
        la = "ls -la";
        lt = "ls -T";
        md = "mkdir";
        py = "python";
        wx = "watchexec";

        g = "git";
        ga = "git add";
        gc = "git commit -am";
        gd = "git diff";
        gl = "git log --oneline --graph";
        gs = "git status";
        gp = "git push";
        gu = "git pull";
      };

      shellAliases = {
        ls = "eza --icons --git";
        rm = "rm -i";
        mv = "mv -i";
        cp = "cp -ir";
        mkdir = "mkdir -p";

        rt = "git rev-parse --show-toplevel";
        gg = "rt | xargs cd";

        home-config = "$EDITOR ~/.dotfiles/home-manager/home.nix";
        nixos-config = "$EDITOR ~/.dotfiles/nixos/configuration.nix";
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    gh = {
      enable = true;
      settings.aliases = {
        clone = "repo clone";
        new = "repo create";
      };
    };

    git = {
      enable = true;
      # delta.enable = true;
      difftastic.enable = true;
      lfs.enable = true;
    };

    gitui = {
      enable = true;
      theme = ''
        (
            selected_tab: None,
            command_fg: None,
            selection_bg: None,
            selection_fg: None,
            cmdbar_bg: None,
            cmdbar_extra_lines_bg: None,
            disabled_fg: None,
            diff_line_add: None,
            diff_line_delete: None,
            diff_file_added: None,
            diff_file_removed: None,
            diff_file_moved: None,
            diff_file_modified: None,
            commit_hash: None,
            commit_time: None,
            commit_author: None,
            danger_fg: None,
            push_gauge_bg: None,
            push_gauge_fg: None,
            tag_fg: None,
            branch_fg: None,
        )
      '';
    };

    go = {
      enable = true;
      goPath = ".go";
    };

    helix = {
      enable = true;
      defaultEditor = true;
    };

    mpv.enable = true;

    sioyek = {
      enable = true;
      bindings = {
        "screen_up" = [ "<C-u>" "K" "<pgup>" ];
        "screen_down" = [ "<C-d>" "J" "<pgdn>" ];
        "new_window" = "<C-t>";
        "fit_to_page_width" = "w";
        "fit_to_page_width_smart" = "W";
        "fit_to_page_height_smart" = "H";
        "open_last_document" = "<A-o>";
        "toggle_highlight" = "<C-h>";
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    bat.enable = true;
    btop.enable = true;
    firefox.enable = true;
    jq.enable = true;
    pandoc.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    yt-dlp.enable = true;
  };

  services = {
    autorandr.enable = true;
    syncthing.enable = true;
  };

  home.packages = with pkgs; [
    # Applications
    aseprite
    nomacs
    discord
    figma-linux
    xfce.thunar
    wezterm
    sqlitebrowser
    obsidian
    gvfs

    # Command-line tools
    acpi
    bore-cli
    broot
    distrobox
    du-dust
    fd
    ffmpeg
    fx
    glow
    httpie
    imagemagick
    just
    kondo
    nmap
    procs
    rm-improved
    sd
    tokei
    watchexec

    # Language tools
    bacon
    black
    deno
    dockerfile-language-server-nodejs
    emmet-ls
    evcxr
    gopls
    marksman
    nil
    nodejs
    nodePackages_latest.bash-language-server
    nodePackages_latest.pnpm
    nodePackages_latest.prettier
    nodePackages_latest.svelte-language-server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    pypy3
    python3Packages.pip
    python3Packages.python-lsp-server
    rustup
    sqlite
    tailwindcss-language-server
    tectonic
    texlab
    (texlive.combine { inherit (texlive) scheme-medium biber bibtex biblatex latexmk chktex; })
    trunk

    # Development tools
    cmake
    gdb
    hyperfine
    meson
    ninja
    rr
    strace
    valgrind

    # Cargo plugins
    cargo-audit
    cargo-binutils
    cargo-bloat
    cargo-clone
    cargo-dist
    cargo-expand
    cargo-feature
    cargo-geiger
    cargo-modules
    cargo-nextest
    cargo-outdated
    cargo-release
    cargo-show-asm
    cargo-sweep
    cargo-udeps
    cargo-update
    cargo-watch
    cargo-workspaces
  ];
}
