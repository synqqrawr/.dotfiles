{ config, lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8 center";
        font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=14";
      };
    };
  };
}
