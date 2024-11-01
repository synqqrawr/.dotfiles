{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    bind =
      [
        "SUPER, Q, killactive"
        "SUPER, Return, exec, foot"
        "SUPER, W, exec, firefox"
        "SUPER, F, togglefloating"
        # "SUPER, F, centerwindow"
        "SUPER_ALT, L, exec, hyprlock"
        "SUPER, P, pseudo"

        "SUPER, h, movefocus, l"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"
        "SUPER, l, movefocus, r"

        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, j, movewindow, d"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, l, movewindow, r"
        ", end, exec, ${pkgs.grimblast}/bin/grimblast save area - | shadower | wl-copy -t image/png"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, S, movetoworkspace, +0"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, S, movetoworkspace, special:magic"
        "SUPER, S, togglespecialworkspace, magic"

        "SUPER SHIFT, Z, exec, pypr zoom"
        "SUPER, Z, exec, pypr zoom ++0.5"
        "SUPER CTRL, Z, exec, pypr zoom --0.5"

        # "SUPER SHIFT, D, exec, grimblast copy area"
        # "SUPER SHIFT_ALT, D, exec, grimblast --freeze copy area"
        # "SUPER SHIFT, F, exec, grimblast copysave output ~/.screenshots/$(date +'%s_hypr.png')"
        # "SUPER SHIFT, G, exec, grimblast copy active"
        # "SUPER SHIFT, D, exec, ags -r 'recorder.start()'"
        # "SUPER SHIFT, S, exec, ags -r 'recorder.screenshot()'"
        # "SUPER, S, exec, ags -r 'recorder.screenshot(true)'"

        # "SUPER_CTRL_SHIFT, R, exec, ags -q && ags"
        # "SUPER, R, exec, ags -t launcher"
        # ",XF86PowerOff, exec, ags -t powermenu"
        # "SUPER, Tab, exec, ags -t overview"

        "SUPER, G, fullscreen"

        "SUPER, T, togglegroup"

        "SUPER, R, exec, ags -t app-launcher"
      ]
      ++ (
        # workspaces
        # binds SUPER + [shift +] {1..10} to [move to] workspace {1..10}
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
              "SUPER, ${ws}, workspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              "SUPER CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"

              "SUPER_ALT, ${ws}, workspace, ${toString (x + 11)}"
              "SUPER_ALT SHIFT, ${ws}, movetoworkspace, ${toString (x + 11)}"
              "SUPER_ALT CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 11)}"
            ]
          ) 10
        )
      );
  };
}
