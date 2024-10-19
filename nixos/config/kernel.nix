{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.scx.enable = false;
}
