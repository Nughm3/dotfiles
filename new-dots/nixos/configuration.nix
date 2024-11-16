{ pkgs, ... }: {
  imports = [
    ./programs.nix
    /etc/nixos/hardware-configuration.nix # global, system-dependent hardware configuration
    ./hardware-configuration.nix # custom hardware configuration
    ./cachix.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
      
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  documentation = {
    enable = true;
    dev.enable = true;
    man.enable = true;
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

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  sound.enable = true;

  time = {
    timeZone = "Asia/Hong_Kong";
    hardwareClockInLocalTime = true;
  };

  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac Hung";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "docker" ];
  };

  virtualisation = {
    containers.enable = true;
    docker.enable = true;
    podman.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  system.stateVersion = "24.05";
}
