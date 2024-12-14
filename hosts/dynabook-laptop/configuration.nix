{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../nixos/stylix
    ../../nixos/config/hyprland.nix
    ../../nixos/config/fonts.nix
    ../../nixos/config/languages.nix
    ../../nixos/config/fcitx5.nix
    ../../nixos/config/keyboard.nix
    ../../nixos/config/power.nix
    ../../nixos/config/nix.nix
    ../../nixos/config/sound.nix
    ../../nixos/config/xdg.nix
    ../../nixos/config/shell.nix
    ../../nixos/config/security.nix
    ../../nixos/config/neovim.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # TODO: Set your hostname
  networking.hostName = "nixos";

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

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

  services.resolved = {
    enable = true;
    extraConfig = ''
      DNS=45.90.28.0#f82bcf.dns.nextdns.io
      DNS=2a07:a8c0::#f82bcf.dns.nextdns.io
      DNS=45.90.30.0#f82bcf.dns.nextdns.io
      DNS=2a07:a8c1::#f82bcf.dns.nextdns.io
      DNSOverTLS=yes
    '';
  };

  # enable fish vendor completions
  programs.fish.enable = true;

  nix = {
    settings = {
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    keepassxc
    sqlite
    ripgrep
    tree-sitter
    zip
    unzip
    p7zip
    killall
    (brave.override {commandLineArgs = "--enable-wayland-ime";})
    grim
    age
    nautilus
    newsflash
    brightnessctl
    nvtopPackages.intel
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];

  services.flatpak.enable = true;

  zramSwap.enable = true;
}
