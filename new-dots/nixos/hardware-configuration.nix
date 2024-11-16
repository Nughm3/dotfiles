{ pkgs, lib, inputs, config, ... }: {
  imports = let hardware = inputs.nixos-hardware; in [
    hardware.nixosModules.asus-battery { hardware.asus.battery.chargeUpTo = 96; }
    hardware.nixosModules.asus-zephyrus-ga401
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
  };

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

    enableAllFirmware = true;
  };

  systemd.services = {
    alsa-store.enable = lib.mkForce false;
    nvidia-powerd.enable = lib.mkForce false;
  };

  virtualisation.docker.enableNvidia = true;
}
