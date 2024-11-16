{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # Nix and NixOS
    inputs.home-manager.packages.${pkgs.system}.default
    cachix

    # Basic tools
    curl
    efibootmgr
    gcc
    pkg-config
    python3
    rsync
    unzip
    wget
    zip

    # Documentation
    man-pages
    man-pages-posix
  ];

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

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
    };

    htop.enable = true;
    neovim.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
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

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
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
}
