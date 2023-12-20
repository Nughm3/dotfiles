{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;

      efi.canTouchEfiVariables = true;
      # efi.efiSysMountPoint = "/boot/efi";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  environment.systemPackages = with pkgs; [
    # Commmand line
    cachix
    curl
    efibootmgr
    home-manager
    kakoune
    rsync
    unzip
    wget
    wl-clipboard
    xclip
    zip

    # Development tools
    clang-tools
    cudatoolkit
    gcc
    linuxPackages_latest.perf
    llvmPackages_latest.bintools
    llvmPackages_latest.clang
    llvmPackages_latest.llvm
    mold
    pkg-config
    pypy3
    python3
    rustup
  ];

  fonts.packages = with pkgs; [
    google-fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "Iosevka"
        "IosevkaTerm"
        "JetBrainsMono"
        "RobotoMono"
        "SourceCodePro"
        "Terminus"
        "Ubuntu"
        "UbuntuMono"
        "VictorMono"
      ];
    })
  ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      nvidiaSettings = true;
    };

    pulseaudio.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      trusted-users = [ "root" "isaac" ];
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

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
    };

    river = {
      enable = true;
      extraPackages = with pkgs; [
        bemenu
        glib
        grim
        imv
        light
        mako
        pamixer
        playerctl
        pulsemixer
        river
        slurp
        wayland
        wbg
        wlr-randr
        xdg-utils
      ];
    };

    fish.enable = true;
    htop.enable = true;
    neovim.enable = true;
    waybar.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd river";
        user = "greeter";
      };
    };

    # pipewire = {
    #   enable = true;
    #   alsa = {
    #     enable = true;
    #     support32Bit = true;
    #   };
    #   pulse.enable = true;
    #   wireplumber.enable = true;
    # };

    cron = {
      enable = true;
      systemCronJobs = [
        "@reboot echo 96 > /sys/class/power_supply/BAT0/charge_control_end_threshold"
      ];
    };
    
    xserver = {
      enable = true;
      displayManager.startx.enable = true;

      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };

      videoDrivers = [ "nvidia" ];
      libinput.enable = true;
      layout = "us";
      xkbVariant = "";
    };

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media"       
    '';

    auto-cpufreq.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    # teamviewer.enable = true;
    upower.enable = true;
  };

  sound.enable = true;

  time.timeZone = "Asia/Hong_Kong";

  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac Hung";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    
    mime.defaultApplications = {
      "application/pdf" = ["sioyek.desktop" "org.pwmt.zathura.desktop"];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
