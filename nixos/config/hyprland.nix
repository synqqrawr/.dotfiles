{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.wl-clipboard ];
}
