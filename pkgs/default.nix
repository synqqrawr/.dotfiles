# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: { custom-fonts = pkgs.callPackage ./custom-fonts/default.nix { inherit pkgs; }; }
