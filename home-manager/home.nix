{ inputs, pkgs, ... }: {
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";

  programs = {
    helix.enable = true;
    home-manager.enable = true;
    kakoune.enable = true;
  };

  services.syncthing.enable = true;

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
    firefox
    flyctl
    foot
    mpv
    noisetorch
    nyxt
    obsidian
    sqlitebrowser
    wezterm
    zathura
    zotero

    # Command line utilities
    acpi
    bat
    bore-cli
    btop
    bun
    d2
    delta
    difftastic
    direnv
    distrobox
    du-dust
    eva
    eza
    fd
    fend
    ffmpeg
    fzf
    gitui
    glow
    imagemagick
    just
    procs
    pulsemixer
    ripgrep
    rm-improved
    sd
    starship
    taskwarrior
    tealdeer
    timewarrior
    tokei
    watchexec
    xplr
    yt-dlp
    zellij
    zoxide

    # Language tools
    bacon
    black
    bun
    deno
    evcxr
    go
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
    pandoc
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
    texlab
    texlive.combined.scheme-basic
    trunk
    zig
    zls

    # Development tools
    gdb
    github-cli
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
