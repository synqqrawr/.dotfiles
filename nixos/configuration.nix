# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./home-manager.nix
    ./stylix
    ./config/hyprland.nix
    ./fonts.nix
    ./config/languages.nix
    ./config/fcitx5.nix
    ./config/gaming.nix
    ./config/keyboard.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

      # You can also add overlays exported from other flakes:
      inputs.neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      (final: prev: {
        neovimUtils = prev.neovimUtils // {
          grammarToPlugin =
            grammar:
            let
              prevPlugin = prev.neovimUtils.grammarToPlugin grammar;
            in
            prevPlugin.overrideAttrs (prevAttrs: {
              buildCommand = ''
                mkdir -p $out/parser
                ln -s ${grammar}/parser $out/parser/${lib.removePrefix "vimplugin-treesitter-grammar-" prevAttrs.name}.so
              '';
            });
        };
      })
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          nvim-treesitter-main = prev.vimUtils.buildVimPlugin {
            pname = "nvim-treesitter";
            src = inputs.nvim-treesitter-src;
            version = "2024-07-28";
          };
        };
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
        substituters = [
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  # FIXME: Add the rest of your current configuration
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled by defauly in most desktopManager).
  services.libinput.enable = true;

  # TODO: Set your hostname
  networking.hostName = "nixos";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    async = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "incorrect";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [
        "wheel"
        "input"
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    fzf
    lsd
    keepassxc
    obsidian

    sqlite
    gcc
    ripgrep

    tree-sitter
    zip
    unzip
    p7zip
    lazygit

    mpv
    killall

    tor-browser
  ];

  environment.variables = {
    EDITOR = "nvim";
    sqlite_nix_path = "${pkgs.sqlite.out}";
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/async/.dotfiles";
  };

  services.resolved = {
    enable = true;
    extraConfig = ''
      DNS=45.90.28.0#d12453.dns.nextdns.io
      DNS=2a07:a8c0::#d12453.dns.nextdns.io
      DNS=45.90.30.0#d12453.dns.nextdns.io
      DNS=2a07:a8c1::#d12453.dns.nextdns.io
      DNSOverTLS=yes
    '';
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
