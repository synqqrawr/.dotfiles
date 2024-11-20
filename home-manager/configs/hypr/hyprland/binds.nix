{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    bind =
      [
        "SUPER, Q, killactive"
        # https://github.com/kovidgoyal/kitty/issues/330#issuecomment-1145085171
        # The initial window will take more time to startup but it is fast enough to a point where there will be no precievable difference
        "SUPER, Return, exec, kitty -1"
        "SUPER, W, exec, zen"
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
        ", end, exec, ${lib.getExe pkgs.grimblast} save area - | shadower | tee /tmp/screenshot.png | wl-copy -t image/png && notify-send -i /tmp/screenshot.png \"Screenshot Taken\" \"Your screenshot has been copied to the clipboard.\" && rm /tmp/screenshot.png"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, S, movetoworkspace, +0"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, S, movetoworkspace, special:magic"
        "SUPER, S, togglespecialworkspace, magic"

        "SUPER SHIFT, Z, exec, pypr zoom"
        "SUPER, Z, exec, pypr zoom ++0.5"
        "SUPER CTRL, Z, exec, pypr zoom --0.5"

        "SUPER, G, fullscreen"

        "SUPER, T, togglegroup"

        "SUPER, R, exec, ags toggle launcher"

        "SUPER, mouse_down, workspace, e-1"
        "SUPER, mouse_up, workspace, e+1"
      ]
      ++ (
        # workspaces
        # binds SUPER + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (
          builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "SUPER, ${ws}, workspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              "SUPER CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"

              "SUPER_ALT, ${ws}, workspace, ${toString (x + 11)}"
              "SUPER_ALT SHIFT, ${ws}, movetoworkspace, ${toString (x + 11)}"
              "SUPER_ALT CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 11)}"
            ]
          )
          10
        )
      );
  };
}
