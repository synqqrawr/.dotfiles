{
  description = ":D";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # stylix
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # neovim-nightly-overlay
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    prismlauncher = {
      url = "github:synqqrawr/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen = {
      url = "git+file:./home-manager/configs/zen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };
    fast-syntax-highlighting = {
      url = "github:zdharma-continuum/fast-syntax-highlighting";
      flake = false;
    };
    zsh-history-substring-search = {
      url = "github:zsh-users/zsh-history-substring-search";
      flake = false;
    };
    zsh-fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      # NOTE: The below 2 lines are only required on nixos-unstable,
      # if you're on stable, they may break your build
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
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
    # overlays = import ./overlays {inherit inputs;};
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
          ./hosts/dynabook-laptop/configuration.nix

          # stylix
          inputs.stylix.nixosModules.stylix
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
          ./hosts/dynabook-laptop/home.nix
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
