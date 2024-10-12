{ config, pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = [
      # noto-fonts
      pkgs.noto-fonts-cjk
      # noto-fonts-emoji
      # unifont
      # ubuntu_font_family
      (pkgs.nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "SpaceMono"
        ];
      })
      pkgs.material-symbols
      pkgs.google-fonts
      # fira-code
      # fira-code-symbols
      pkgs.mplus-outline-fonts.githubRelease
      pkgs.jetbrains-mono
    ];
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      defaultFonts = {
        serif = [ config.stylix.fonts.serif.name ];
        sansSerif = [ config.stylix.fonts.sansSerif.name ];
        monospace = [ config.stylix.fonts.monospace.name ];
        emoji = [ config.stylix.fonts.emoji.name ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
        <edit mode="assign" name="antialias">       <bool>true</bool></edit>
        <edit mode="assign" name="hinting">         <bool>true</bool></edit>
        <edit mode="assign" name="hintstyle">       <const>hintmedium</const></edit>
        <edit mode="assign" name="lcdfilter">       <const>lcddefault</const></edit>
        <edit mode="assign" name="rgba">            <const>rgb</const></edit>

        <edit mode="assign" name="hintstyle"><const>hintnone</const></edit>
        <!-- Japanese -->
        <!-- "lang=ja" or "lang=ja-*" -->
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>ja</string>
            </test>
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="append" binding="strong">
              <string>MPlus Code 50</string>
            </edit>
          </match>
          <alias>
            <family>monospace</family>
            <prefer><family>${config.stylix.fonts.emoji.name}</family></prefer>
            <prefer><family>${config.stylix.fonts.monospace.name}</family></prefer>
          </alias>
        </fontconfig>
      '';
    };
  };
}
