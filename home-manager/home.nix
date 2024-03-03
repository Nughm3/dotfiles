{ pkgs, ... }: {
  home = {
    username = "isaac";
    homeDirectory = "/home/isaac";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.breeze-icons;
    name = "Breeze_Snow";
  };

  gtk = {
    enable = true;
    font = {
      name = "Inter";
      package = pkgs.inter;
    };
    theme = {
      name = "Arc-Lighter";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
    cursorTheme = {
      name = "Breeze_Snow";
      package = pkgs.breeze-icons;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
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
        "open_selected_url" = "Q";
        "toggle_synctex" = "X";
        
      };
    };

    # starship = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

    zathura = {
      enable = true;
      options = {
        default-bg = "#282c34";
        default-fg = "#353b45";
        statusbar-fg = "#565c64";
        statusbar-bg = "#3e4451";
        inputbar-bg = "#282c34";
        inputbar-fg = "#c8ccd4";
        notification-bg = "#282c34";
        notification-fg = "#c8ccd4";
        notification-error-bg = "#282c34";
        notification-error-fg = "#e06c75";
        notification-warning-bg = "#282c34";
        notification-warning-fg = "#e06c75";
        highlight-color = "#e5c07b";
        highlight-active-color = "#61afef";
        completion-bg = "#353b45";
        completion-fg = "#61afef";
        completion-highlight-fg = "#c8ccd4";
        completion-highlight-bg = "#61afef";
        recolor-lightcolor = "#282c34";
        recolor-darkcolor = "#b6bdca";
        recolor = false;
        recolor-keephue = false;
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    firefox.enable = true;
    # managed externally
    # fish.enable = true;
    # foot.enable = true;
    helix.enable = true;
    home-manager.enable = true;
    # kakoune.enable = true;
    mpv.enable = true;
    neovim.enable = true;

    bat.enable = true;
    btop.enable = true;
    jq.enable = true;
    pandoc.enable = true;
    ripgrep.enable = true;
    # taskwarrior.enable = true;
    tealdeer.enable = true;
    xplr.enable = true;
    yazi.enable = true;
    yt-dlp.enable = true;
    zellij.enable = true;

    go.enable = true;
  };

  services = {
    autorandr.enable = true;
    syncthing.enable = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      cudaSupport = true;
    };
  };

  home.packages = with pkgs; [
    # Applications
    # anki
    aseprite
    discord
    drawio
    figma-linux
    gvfs
    noisetorch
    # nyxt
    obsidian
    sqlitebrowser
    wezterm
    xfce.thunar
    zotero

    # Command line utilities
    acpi
    bore-cli
    broot
    bun
    d2
    distrobox
    du-dust
    fd
    fend
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
    # timewarrior
    tokei
    watchexec
    zola

    # Language tools
    bacon
    black
    bun
    deno
    emmet-ls
    evcxr
    gopls
    lua
    # luajit
    marksman
    nil
    nodejs
    nodePackages_latest.pnpm
    nodePackages_latest.prettier
    nodePackages_latest.svelte-language-server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    poetry
    pypy3
    python3Packages.pip
    python3Packages.python-lsp-server
    # (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
    #   extensions = [
    #     "cargo"
    #     "clippy"
    #     "llvm-tools"
    #     "miri"
    #     "rust-analyzer"
    #     "rustc"
    #     "rust-docs"
    #     "rustfmt"
    #     "rust-src"
    #     "rust-std"
    #   ];

    #   targets = [
    #     "x86_64-unknown-linux-gnu"
    #     "wasm32-unknown-unknown"
    #     "thumbv7em-none-eabihf"
    #   ];
    # }))
    sqlite
    tailwindcss-language-server
    tectonic
    texlab
    texlive.combined.scheme-medium
    trunk
    zig
    zls

    # Development tools
    gdb
    hyperfine
    meson
    ninja
    podman
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
    cargo-udeps
    cargo-update
    cargo-watch
    cargo-workspaces
  ];

  home.stateVersion = "23.05";
}
