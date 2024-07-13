{
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    users = {
      # Import your home-manager configuration
      async = import ../home-manager/home.nix;
    };
  };
}
