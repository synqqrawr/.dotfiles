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
        "SUPER, Return, exec, ghostty"
        "SUPER, W, exec, zen"
        "SUPER, F, togglefloating"
        # "SUPER, F, centerwindow"
        "SUPER_ALT, L, exec, hyprlock"

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
            ]
          )
          10
        )
      );
    binds = let
      # Define the key mappings with their position values directly
      keyMap = {
        "u" = {
          value = 1;
          pos = 0;
        };
        "i" = {
          value = 2;
          pos = 1;
        };
        "o" = {
          value = 4;
          pos = 2;
        };
        "p" = {
          value = 8;
          pos = 3;
        };
      };

      # Helper function for power calculation
      pow = base: exp:
        if exp == 0
        then 1
        else base * pow base (exp - 1);

      # Helper function to get lists without an element
      removeAt = n: list:
        (builtins.genList (x: builtins.elemAt list x) n)
        ++ (builtins.genList (x: builtins.elemAt list (x + n + 1)) ((builtins.length list) - n - 1));

      # Generate all permutations of a list
      permutations = list:
        if builtins.length list == 0
        then [[]]
        else
          builtins.concatMap
          (i: let
            elem = builtins.elemAt list i;
            rest = removeAt i list;
            restPerms = permutations rest;
          in
            map (perm: [elem] ++ perm) restPerms)
          (builtins.genList (x: x) (builtins.length list));

      # Helper function to get all keys that are "pressed" based on a binary number
      getActiveKeys = n: let
        keys = builtins.attrNames keyMap;
        # Check if bit is set at the key's position
        checkBit = key: n: let
          pos = keyMap.${key}.pos;
          mask = builtins.bitAnd n (pow 2 pos);
        in
          mask != 0;
        # Filter keys without sorting
      in
        builtins.filter (key: checkBit key n) keys;

      # Calculate workspace number by summing values of pressed keys
      calculateWorkspace = keys:
        builtins.foldl' (sum: key: sum + keyMap.${key}.value) 0 keys;

      # Generate all combinations using numbers 1 to 15 (2^4 - 1)
      numbers = builtins.genList (x: x + 1) 15;

      # Convert each number to all possible permutations
      combinations = builtins.concatMap (n: let
        activeKeys = getActiveKeys n;
        workspace = calculateWorkspace activeKeys;
        # Generate all permutations of the active keys
        allPerms = permutations activeKeys;
        # Convert each permutation to a list of strings
        permStrings =
          builtins.concatMap (perm: let
            keyString = builtins.concatStringsSep "&" perm;
          in [
            "SUPER_L, ${keyString}, workspace, ${toString workspace}"
            "SHIFT_L&SUPER_L, ${keyString}, movetoworkspace, ${toString workspace}"
            "SHIFT_R&SUPER_L, ${keyString}, movetoworkspace, ${toString workspace}"
          ])
          allPerms;
      in
        permStrings)
      numbers;
    in
      combinations;
  };
}
