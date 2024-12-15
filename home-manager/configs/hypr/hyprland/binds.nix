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
        ", end, exec, ${lib.getExe pkgs.grimblast} save area - | wl-copy -t image/png && notify-send \"Screenshot Taken\" \"Your screenshot has been copied to the clipboard.\""
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, S, movetoworkspace, +0"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, S, movetoworkspace, special:magic"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER, E, exec, nautilus"
        "SUPER, period, exec, emote"

        "SUPER, O, pin"

        "SUPER, G, fullscreen"

        "SUPER, T, togglegroup"

        "SUPER, R, exec, ags toggle launcher"

        "SUPER, mouse_down, workspace, e-1"
        "SUPER, mouse_up, workspace, e+1"

        "SUPER, M, exec, ${pkgs.writeShellScriptBin "awesome-layout" ''
          FLOATING_STATE_FILE="$HOME/.hyprland_floating_state"

          if [ -f "$FLOATING_STATE_FILE" ]; then
              hyprctl reload
              rm "$FLOATING_STATE_FILE"
          else
              hyprctl --batch "keyword windowrulev2 float, class:.*"
              touch "$FLOATING_STATE_FILE"
          fi
        ''}/bin/awesome-layout"
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
