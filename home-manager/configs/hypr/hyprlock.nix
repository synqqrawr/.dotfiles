{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "${config.stylix.image}";
          blur_passes = 3;
          blur_size = 4;
          noise = 1.0e-2;
          contrast = 1.3;
          brightness = 0.7;
          vibrancy = 0.1;
          vibrancy_darkness = 0.0;
        }
      ];
      input-field = {
        monitor = "";

        size = "300, 50";
        outline_thickness = 0;

        dots_spacing = 0.3;
        dots_center = true;
        inner_color = "rgb(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b})";
        placeholder_text = "<i>Input Password...</i>";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        position = "0, 100";

        halign = "center";
        valign = "bottom";
      };
      label = [
        {
          monitor = "";
          text = "cmd[update:200] echo \"<b>$(date +'%A, %B %d')</b>\"";

          color = "rgb(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b})";
          font_size = "20";
          font_family = "${config.stylix.fonts.sansSerif.name}";
          shadow_passes = "0";
          shadow_size = "0";
          position = "0, 400";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:200] echo \"<b>$(date +'%k:%M')</b>\"";

          color = "rgb(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b})";
          font_size = "93";
          font_family = "${config.stylix.fonts.sansSerif.name}";
          shadow_passes = "0";
          shadow_size = "0";
          position = "0, 330";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
