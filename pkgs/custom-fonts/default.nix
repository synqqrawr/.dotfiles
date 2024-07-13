{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "fonts";
  version = "1.0";

  src = ./src;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts
    mkdir -p $out/share/fonts/truetype
    mkdir -p $out/share/fonts/opentype
    cp $src/*.ttf $out/share/fonts/truetype
    cp $src/*.otf $out/share/fonts/opentype

    runHook postInstall
  '';
}
