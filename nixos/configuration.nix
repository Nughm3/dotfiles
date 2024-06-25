{ lib, config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./cachix.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;

      efi.canTouchEfiVariables = true;
      # efi.efiSysMountPoint = "/boot/efi";
    };

    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  documentation = {
    enable = true;
    dev.enable = true;
    man.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Commmand line
      cachix
      curl
      efibootmgr
      home-manager
      neovim
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
      hotspot
      linuxPackages_latest.perf
      lldb
      llvmPackages_latest.bintools
      llvmPackages_latest.clang
      mold-wrapped
      pkg-config
      python3
      rustup

      # Documentation
      man-pages
      man-pages-posix
    ];

    variables = {
      LIBVA_DRIVER_NAME = "nvidia";
    };
  };

  fonts.packages = with pkgs; [
    google-fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Iosevka"
        "IosevkaTerm"
        "JetBrainsMono"
        "RobotoMono"
        "SourceCodePro"
        "Terminus"
        "UbuntuMono"
        "VictorMono"
      ];
    })
  ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        egl-wayland
      ];
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      nvidiaSettings = true;
    };

    # pulseaudio.enable = true;
    enableAllFirmware = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
    
    # inputMethod.enabled = "fcitx5";
  };

  networking = {
    hostName = "nixos";

    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };

    # networkmanager.enable = true;
    firewall.enable = false;
  };

  nix = {
    package = pkgs.nixFlakes;

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;

    settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    cudaSupport = true;
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
        iwgtk
        light
        mako
        nomacs
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

    # weylus = {
    #   enable = true;
    #   users = [ "isaac" ];
    # };

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
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd river";
        user = "greeter";
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
    };

    cron = {
      enable = true;
      systemCronJobs = [
        "@reboot echo 96 > /sys/class/power_supply/BAT0/charge_control_end_threshold"
      ];
    };

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    xserver = {
      # TODO: disable
      enable = true;
      displayManager.startx.enable = true;

      videoDrivers = [ "nvidia" ];
      xkb.layout = "us";
      xkb.variant = "";
    };

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media"       
    '';

    auto-cpufreq.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    printing.enable = true;
    upower.enable = true;
  };

  sound.enable = true;

  systemd.services = {
    alsa-store.enable = lib.mkForce false;
    nvidia-powerd.enable = lib.mkForce false;
  };

  time = {
    timeZone = "Asia/Hong_Kong";
    hardwareClockInLocalTime = true;
  };

  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac Hung";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      # "dialout" # Connecting to serial ports
      # "adbusers" # Enable Android debugging
    ];
  };

  # Enable Android debugging
  # programs.adb.enable = true;

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
  system.stateVersion = "23.11";
}
