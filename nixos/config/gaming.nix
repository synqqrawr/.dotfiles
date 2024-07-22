{ inputs, ... }:
{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];

  services.pipewire = {
    lowLatency = {
      # enable this module
      enable = true;
      # defaults (no need to be set unless modified)
      quantum = 64;
      rate = 48000;
    };
  };

  programs.gamemode.enable = true;
}
