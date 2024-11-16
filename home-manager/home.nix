{ pkgs, ... }: {
  home = {
    username = "isaac";
    homeDirectory = "/home/isaac";
  };

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;

  #   name = "Capitaine Cursors - White";
  #   package = pkgs.capitaine-cursors;
  # };

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
    # cursorTheme = {
    #   name = "Capitaine Cursors - White";
    #   package = pkgs.capitaine-cursors;
    # };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman ];
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = "auto";
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

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
      ];
    };

    sioyek = {
      enable = true;

      bindings = {
        screen_up = [ "<C-u>" "K" "<pgup>" ];
        screen_down = [ "<C-d>" "J" "<pgdn>" ];
        fit_to_page_width = "W";
        fit_to_page_height = "H";
      };

      config = {
        text_highlight_color = "#bad3fc";
        synctex_highlight_color = "#b2fba5";
      };
    };

    # starship = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

    # zathura = {
    #   enable = true;
    #   options = {
    #     default-bg = "#282c34";
    #     default-fg = "#353b45";
    #     statusbar-fg = "#565c64";
    #     statusbar-bg = "#3e4451";
    #     inputbar-bg = "#282c34";
    #     inputbar-fg = "#c8ccd4";
    #     notification-bg = "#282c34";
    #     notification-fg = "#c8ccd4";
    #     notification-error-bg = "#282c34";
    #     notification-error-fg = "#e06c75";
    #     notification-warning-bg = "#282c34";
    #     notification-warning-fg = "#e06c75";
    #     highlight-color = "#e5c07b";
    #     highlight-active-color = "#61afef";
    #     completion-bg = "#353b45";
    #     completion-fg = "#61afef";
    #     completion-highlight-fg = "#c8ccd4";
    #     completion-highlight-bg = "#61afef";
    #     recolor-lightcolor = "#282c34";
    #     recolor-darkcolor = "#b6bdca";
    #     recolor = false;
    #     recolor-keephue = false;
    #   };
    # };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    firefox.enable = true;
    # managed externally
    # fish.enable = true;
    foot.enable = true;
    helix.enable = true;
    home-manager.enable = true;
    # kakoune.enable = true;
    mpv.enable = true;
    # neovim.enable = true;

    btop.enable = true;
    jq.enable = true;
    pandoc.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    # xplr.enable = true;
    yazi.enable = true;
    yt-dlp.enable = true;
    zellij.enable = true;

    go = {
      enable = true;
      goPath = ".go";
    };
  };

  services = {
    autorandr.enable = true;
    syncthing.enable = true;
  };

  nix = {
    package = pkgs.nixVersions.stable;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    cudaSupport = true;
  };

  home.packages = with pkgs; [
    # Applications
    aseprite
    discord
    drawio
    # figma-linux
    # gimp
    gvfs
    inkscape
    # noisetorch
    # nyxt
    obsidian
    p7zip
    qbittorrent
    sqlitebrowser
    # wezterm
    xfce.thunar
    # zotero

    # Command line utilities
    acpi
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    ast-grep
    bore-cli
    broot
    devenv
    distrobox
    dive
    du-dust
    entr
    fd
    fend
    ffmpeg
    fx
    glow
    httpie
    hugo
    imagemagick
    jpegoptim
    just
    kondo
    nmap
    oxipng
    procs
    rm-improved
    sd
    sq
    tokei
    watchexec
    zola

    # Language tools
    bacon
    black
    bun
    deno
    dockerfile-language-server-nodejs
    emmet-ls
    evcxr
    gopls
    lua
    # luajit
    marksman
    nil
    nodejs
    nodePackages_latest.bash-language-server
    nodePackages_latest.pnpm
    nodePackages_latest.prettier
    nodePackages_latest.svelte-language-server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    # poetry # FIXME
    # pypy3 # FIXME
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
    (texlive.combine { inherit (texlive) scheme-medium biber bibtex biblatex chktex latexmk; })
    trunk

    # Development tools
    # binsider # TODO: waiting on nixpkgs
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
    # cargo-clone # FIXME
    cargo-dist
    cargo-expand
    # cargo-feature # FIXME
    # cargo-geiger # FIXME
    cargo-modules
    cargo-mutants
    cargo-nextest
    cargo-outdated
    cargo-release
    cargo-show-asm
    # cargo-sweep # FIXME
    cargo-udeps
    cargo-update
    cargo-workspaces
  ];

  home.stateVersion = "23.11";
}
