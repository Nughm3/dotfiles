{ pkgs, ... }: {
  imports = [
    ./desktop.nix
    ./programs.nix
    ./development.nix
    ../nixos/cachix.nix
  ];

  home = {
    username = "isaac";
    homeDirectory = "/home/isaac";
  };

  nix = {
    package = pkgs.nixFlakes;

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

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
