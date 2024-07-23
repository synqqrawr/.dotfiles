{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [ wl-clipboard ];

  imports = [ inputs.hyprland.nixosModules.default ];

}
