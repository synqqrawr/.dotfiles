{
  config,
  pkgs,
  ...
}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.symbols-only
      noto-fonts-emoji
      material-symbols
      google-fonts
      fira
      ipafont
      kochi-substitute
      mplus-outline-fonts.githubRelease
    ];
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [config.stylix.fonts.serif.name "IPAGothic" "Noto Color Emoji"];
        sansSerif = [config.stylix.fonts.sansSerif.name "IPAGothic" "Noto Color Emoji"];
        monospace = [config.stylix.fonts.monospace.name];
        emoji = [config.stylix.fonts.emoji.name];
      };
    };
  };
}
