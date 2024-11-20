{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    # betterfox
    betterfox.url = "github:yokoffing/BetterFox";
    betterfox.flake = false;

    # shyfox
    shyfox.url = "github:Naezr/ShyFox";
    shyfox.flake = false;

    # neovim-nightly-overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    prismlauncher.url = "github:Diegiwg/PrismLauncher-Cracked";
    prismlauncher.inputs.nixpkgs.follows = "nixpkgs";

    chaotic = {
      url = "github:chaotic-cx/nyx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    shadower = {
      url = "github:n3oney/shadower";
    };

    zen = {
      url = "path:./home-manager/configs/zen";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = nixpkgs.legacyPackages.x86_64-linux;
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = system: nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          flake = self;
        };
        modules = [
          # > Our main nixos configuration file <
          ./nixos/configuration.nix

          # stylix
          inputs.stylix.nixosModules.stylix
          # chaotic
          inputs.chaotic.nixosModules.default
        ];
      };
    };
    homeConfigurations = {
      "async@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          flake = self;
        };
        # useGlobalPkgs = true;
        # backupFileExtension = "bak";
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
          inputs.stylix.homeManagerModules.stylix
          ./nixos/stylix/default.nix
          {
            stylix.targets = {
              hyprland.enable = false;
              kde.enable = false;
              neovim.enable = false;
              lazygit.enable = false;
            };
          }
        ];
      };
    };
  };
}
