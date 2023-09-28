{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, hardware, ... }@inputs:
  let inherit (self) outputs; in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs; };
      modules = [
        ./nixos/configuration.nix

        hardware.nixosModules.asus-battery { hardware.asus.battery.chargeUpto = 96; }
        hardware.nixosModules.asus-zephyrus-ga401
      ];
    };

    homeConfigurations."isaac@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs outputs; };
      modules = [ ./home-manager/home.nix ];
    };
  };
}
