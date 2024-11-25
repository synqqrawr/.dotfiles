{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.swww];

  systemd.user.services.swww = {
    Unit = {
      Description = "Swww Wayland wallpaper manager";
      Documentation = "https://github.com/LGFae/swww";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };

    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      ExecStartPost = "${pkgs.swww}/bin/swww img ${config.stylix.image}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
