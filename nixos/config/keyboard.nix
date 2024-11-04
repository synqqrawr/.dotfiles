{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "overload(control, esc)"; # Ctrl/esc combo.
        };
      };
    };
  };
}
