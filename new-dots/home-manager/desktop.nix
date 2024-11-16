{ pkgs, ... }: {
  wayland.windowManager.river = {
    enable = true;
    extraConfig = builtins.readFile ../config/river/init;
  };

  home.packages = with pkgs; [
    bemenu
    glib
    grim
    iwgtk
    brightnessctl
    mako
    pamixer
    playerctl
    pulsemixer
    slurp
    wayland
    wbg
    wlr-randr
    xdg-utils
  ];

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
    platformTheme.name = "gtk";
  };
}
