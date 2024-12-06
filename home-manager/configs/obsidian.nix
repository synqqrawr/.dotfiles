{pkgs, ...}: {
  stylix.targets.obsidian = {
    enable = true;
    vaults = ["Vault"];
  };
  home.packages = [
    (pkgs.obsidian.overrideAttrs (e: rec {
      desktopItem = e.desktopItem.override (d: {
        exec = "${d.exec} --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime";
      });
      installPhase = builtins.replaceStrings ["${e.desktopItem}"] ["${desktopItem}"] e.installPhase;
    }))
  ];
}
