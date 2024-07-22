{
  pkgs,
  config,
  osConfig,
  ...
}:
{
  home.packages = with pkgs; [ grimblast ];
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
        inner_color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.85)";
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

          color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.75)";
          font_size = "20";
          font_family = "SF Pro Display Bold";
          shadow_passes = "4";
          shadow_size = "2";
          position = "0, 400";
          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:200] echo \"<b>$(date +'%k:%M')</b>\"";

          color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.75)";
          font_size = "93";
          font_family = "SF Pro Display Bold";
          shadow_passes = "4";
          shadow_size = "2";
          position = "0, 330";
          valign = "center";
          halign = "center";
        }
        # # {
        # #   monitor = "";
        # #   text = "cmd[update:1000] echo \"<b><big> $(date +\"%H\") </big></b>\"";
        # #   color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.7)";
        # #   font_size = "112";
        # #   font_family = "Jetbrains Mono";
        # #   shadow_passes = "3";
        # #   shadow_size = "4";
        # #
        # #   position = "0, 220";
        # #   halign = "center";
        # #   valign = "center";
        # # }
        # {
        #   monitor = "";
        #   text = "cmd[update:1000] echo \"<b><big> $(date +\"%M\") </big></b>\"";
        #   color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.7)";
        #   font_size = "112";
        #   font_family = "Jetbrains Mono";
        #   shadow_passes = "3";
        #   shadow_size = "4";
        #
        #   position = "0, 80";
        #   halign = "center";
        #   valign = "center";
        # }
        # {
        #   monitor = "";
        #   # text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
        #   text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
        #   color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.8)";
        #   font_size = "25";
        #   font_family = "Jetbrains Mono";
        #   rotate = "0";
        #   shadow_passes = "3";
        #   shadow_size = "4";
        #
        #   position = "0, 50";
        #   halign = "center";
        #   valign = "center";
        # }
        # {
        #   monitor = "";
        #   text = "cmd[update:18000000] echo \"<b> \"$(date +'%d %b')\" </b>\"";
        #   color = "rgba(${config.lib.stylix.colors.base05-rgb-r}, ${config.lib.stylix.colors.base05-rgb-g}, ${config.lib.stylix.colors.base05-rgb-b}, 0.8)";
        #   font_size = "18";
        #   font_family = "Jetbrains Mono";
        #
        #   position = "0, 20";
        #   halign = "center";
        #   valign = "center";
        # }
      ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "fcitx5 -d"
        "ags"
      ];
      "$mod" = "SUPER";
      monitor = ",1920x1080,0x0,1";
      general = {
        border_size = 0;
      };
      decoration = {
        rounding = 8;
        shadow_range = 12;
        dim_inactive = true;
      };
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod, Q, killactive"
          "$mod, Return, exec, kitty"
          "$mod, W, exec, firefox"
          "$mod, F, togglefloating"
          # "$mod, F, centerwindow"
          "$mod_ALT, L, exec, hyprlock"
          "$mod, F, pin"
          "$mod, P, pseudo"

          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"

          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, l, movewindow, r"

          # "$mod SHIFT, D, exec, grimblast copy area"
          # "$mod SHIFT_ALT, D, exec, grimblast --freeze copy area"
          # "$mod SHIFT, F, exec, grimblast copysave output ~/.screenshots/$(date +'%s_hypr.png')"
          # "$mod SHIFT, G, exec, grimblast copy active"
          "$mod SHIFT, D, exec, ags -r 'recorder.start()'"
          "$mod SHIFT, S, exec, ags -r 'recorder.screenshot()'"
          "$mod, S, exec, ags -r 'recorder.screenshot(true)'"

          "$mod_CTRL_SHIFT, R, exec, ags -q && ags"
          "$mod, R, exec, ags -t launcher"
          ",XF86PowerOff, exec, ags -t powermenu"
          "$mod, Tab, exec, ags -t overview"

          "$mod, G, fullscreen"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                "$mod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
    };
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlck";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          "on-timeout" = "brightnessctl -s set 10";
          "on-resume" = "brightnessctl -r";
        }
        {
          timeout = 300;
          "on-timeout" = "loginctl lock-session";
        }
        {
          timeout = 330;
          "on-timeout" = "hyprctl dispatch dpms off";
          "on-resume" = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          "on-timeout" = "systemctl suspend";
        }
      ];
    };
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "hyprland" ];
      };
      hyprland = {
        default = [
          "gtk"
          "hyprland"
        ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

}
