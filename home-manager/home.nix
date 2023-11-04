{ inputs, pkgs, ... }: {
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";

  programs = {
    direnv = {
      enable = true;
      enableFishIntegration = true;
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
      extensions = with pkgs; [ gh-cal gh-eco ];
      settings.aliases = {
        co = "pr checkout";
        new = "repo create";
        clone = "repo clone";
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

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require("wezterm")
        local mux = wezterm.mux

        wezterm.on("gui-startup", function()
          local tab, pane, window = mux.spawn_window{}
          window:gui_window():maximize()
        end)

        return {
          color_scheme = "OneDark (base16)",
          default_prog = { "/run/current-system/sw/bin/fish" },

          font = wezterm.font("JetBrainsMono Nerd Font Mono"),
          font_size = 10.5,

          use_fancy_tab_bar = false,
          hide_tab_bar_if_only_one_tab = true,
  
          window_frame = {
            active_titlebar_bg = "#1e222a",
            inactive_titlebar_bg = "#1e222a",

            inactive_titlebar_border_bottom = "#1e222a",
            active_titlebar_border_bottom = "#1e222a",
    
            button_bg = "#1e222a",
            button_hover_bg = "#353b45",
          },

          colors = {
            tab_bar = {
              background = "#282c34",
      
              active_tab = {
                fg_color = "#c8ccd4",
                bg_color = "#353b45",

                intensity = "Bold",
              },
      
              inactive_tab = {
                fg_color = "#abb2bf",
                bg_color = "#282c34",
              },

              inactive_tab_hover = {
                fg_color = "#c8ccd4",
                bg_color = "#3e4451",
              },
      
              new_tab = {
                fg_color = "#c8ccd4",
                bg_color = "#282c34",
              },

              new_tab_hover = {
                fg_color = "#1e222a",
                bg_color = "#61afef",
              }
            },
          },

          window_close_confirmation = "NeverPrompt"
        }
      '';
    };

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
    foot.enable = true;
    helix.enable = true;
    home-manager.enable = true;
    kakoune.enable = true;
    mpv.enable = true;

    bat.enable = true;
    btop.enable = true;
    gh-dash.enable = true;
    jq.enable = true;
    pandoc.enable = true;
    ripgrep.enable = true;
    taskwarrior.enable = true;
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      cudaSupport = true;
    };

    overlays = [ inputs.rust-overlay.overlays.default ];
  };

  home.packages = with pkgs; [
    # Applications
    aseprite
    discord
    drawio
    figma-linux
    noisetorch
    nyxt
    obsidian
    # ollama
    sqlitebrowser
    zotero

    # Command line utilities
    acpi
    bore-cli
    bun
    d2
    distrobox
    du-dust
    eva
    fd
    fend
    ffmpeg
    fx
    glow
    httpie
    imagemagick
    just
    procs
    rm-improved
    sd
    timewarrior
    tokei
    watchexec

    # Language tools
    bacon
    black
    bun
    deno
    evcxr
    gopls
    lua
    # luajit
    nil
    nodejs
    nodePackages_latest.pnpm
    nodePackages_latest.prettier
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server
    marksman
    pypy3
    python3Packages.pip
    python3Packages.python-lsp-server
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [
        "cargo"
        "clippy"
        "llvm-tools"
        "miri"
        "rust-analyzer"
        "rustc"
        "rust-docs"
        "rustfmt"
        "rust-src"
        "rust-std"
      ];

      targets = [
        "x86_64-unknown-linux-gnu"
        "wasm32-unknown-unknown"
        "thumbv7em-none-eabihf"
      ];
    }))
    tectonic
    texlab
    texlive.combined.scheme-basic
    trunk
    zig
    zls

    # Development tools
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
    cargo-cache
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
