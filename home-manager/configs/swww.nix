{
  config,
  pkgs,
  ...
}: rec {
  home.packages = [pkgs.swww];

  home.sessionVariables = {
    SWWW_TRANSITION = "grow";
    SWWW_TRANSITION_STEP = "90";
  };

  systemd.user.services.swww = {
    Unit = {
      Description = "Swww Wayland wallpaper manager";
      Documentation = "https://github.com/LGFae/swww";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };

    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      ExecStartPost = "${pkgs.swww}/bin/swww img ${config.stylix.image} --transition-step=${home.sessionVariables.SWWW_TRANSITION_STEP} --transition-type=${home.sessionVariables.SWWW_TRANSITION}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
