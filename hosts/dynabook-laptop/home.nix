{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../../home-manager/configs/shell.nix
    ../../home-manager/configs/kitty.nix
    # ./configs/firefox.nix
    ../../home-manager/configs/hypr.nix
    ../../home-manager/configs/neovim.nix
    ../../home-manager/configs/fcitx5.nix
    ../../home-manager/configs/xdg.nix
    ../../home-manager/configs/git.nix
    ../../home-manager/configs/gtk.nix
    ../../home-manager/configs/ags.nix
    ../../home-manager/configs/foot.nix
    # ../../home-manager/configs/swww.nix
    ../../home-manager/configs/spotify.nix
    ../../home-manager/configs/stylix.nix
    ../../home-manager/configs/discord.nix
    ../../home-manager/configs/browsers.nix
    ../../home-manager/configs/emote.nix
    ../../home-manager/configs/games.nix
    ../../home-manager/configs/obsidian.nix
    ../../home-manager/configs/ghostty.nix
    ../../nixos/config/nix.nix
  ];

  # TODO: Set your username
  home = {
    username = "async";
  };

  programs = {
    mpv.enable = true;
    lazygit.enable = true;
    feh.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {
      jdks = [
        jdk17
        jdk8
        jdk21
      ];
    })
    (pkgs.buildFHSEnv rec {
      pname = "grayjay";
      version = "2";
      # Absolute path to where the contents of Grayjay.Desktop-linux-x64-v{x} is located
      installDir = "/home/async/Grayjay";

      # grayjay script wrapper that sets cwd to `installdir'
      start-grayjay = pkgs.writeShellScriptBin "start-grayjay" ''cd ${installDir} && ./Grayjay'';

      # grayjay desktop file.
      grayjay-desktop-file = pkgs.makeDesktopItem {
        name = "Grayjay";
        type = "Application";
        desktopName = "Grayjay";
        genericName = "Desktop Client for Grayjay";
        comment = "A desktop client for Grayjay to stream and download video content";
        icon = "${installDir}/grayjay.png";
        exec = pname;
        path = installDir;
        terminal = false;
        categories = ["Network"];
        keywords = [
          "YouTube"
          "Player"
        ];
        startupNotify = true;
        startupWMClass = "Grayjay";
        prefersNonDefaultGPU = false;
      };

      targetPkgs = _:
        with pkgs; [
          start-grayjay
          grayjay-desktop-file
          libz
          icu
          openssl # For updater

          xorg.libX11
          xorg.libXcomposite
          xorg.libXdamage
          xorg.libXext
          xorg.libXfixes
          xorg.libXrandr
          xorg.libxcb

          gtk3
          glib
          nss
          nspr
          dbus
          atk
          cups
          libdrm
          expat
          libxkbcommon
          pango
          cairo
          udev
          alsa-lib
          mesa
          libGL
          libsecret
        ];
      runScript = "start-grayjay";
      extraInstallCommands = ''
        mkdir -p $out/share/applications/
        cp ${grayjay-desktop-file}/share/applications/Grayjay.desktop $out/share/applications/
      '';
    })
  ];

  home.activation.forceUpdateFontConfigCache = lib.hm.dag.entryAfter ["intallPackages"] ''
    echo "Rebuilding font cache"
    ${pkgs.fontconfig}/bin/fc-cache -rf
  '';
}
