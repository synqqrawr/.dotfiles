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
    ];
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [config.stylix.fonts.serif.name "Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = [config.stylix.fonts.sansSerif.name "Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = [config.stylix.fonts.monospace.name];
        emoji = [config.stylix.fonts.emoji.name];
      };
    };
  };
}
