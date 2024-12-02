{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.firejail = {
    enable = false;
    wrappedBinaries = {
      equibop = {
        executable = "${lib.getExe pkgs.equibop}";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
        extraArgs = [
          "--mkdir=~/.config/equibop"
          "--whitelist=~/.config/equibop"
          # Open files and urls
          "--dbus-user.talk=org.freedesktop.portal.OpenURI.*"
          "--dbus-user.talk=org.freedesktop.portal.Desktop"
        ];
      };
      spotify = {
        executable = "${lib.getExe pkgs.spotify}";
        profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
      };
    };
  };
}
