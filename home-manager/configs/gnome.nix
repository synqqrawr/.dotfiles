{
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      "natural-scrolling" = false;
      "click-method" = "areas";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "/usr/bin/env kitty";
      name = "Terminal";
    };
  };
}
