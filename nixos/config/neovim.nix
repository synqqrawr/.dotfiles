{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = let
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "c51bf5a6b24928ac04d0bb129b1b424d4c78f28d";
      sha256 = "sha256-DVlI7ua+VOkqC70WpSbJO+FjQyBEarGZnKoql7I7Unk=";
    };
    deps = lib.pipe "${src}/cmake.deps/deps.txt" [
      builtins.readFile
      (lib.splitString "\n")
      (map (builtins.match "([A-Z0-9_]+)_(URL|SHA256)[[:space:]]+([^[:space:]]+)[[:space:]]*"))
      (lib.remove null)
      (lib.flip builtins.foldl' {} (
        acc: matches: let
          name = lib.toLower (builtins.elemAt matches 0);
          key = lib.toLower (builtins.elemAt matches 1);
          value = lib.toLower (builtins.elemAt matches 2);
        in
          acc
          // {
            ${name} =
              acc.${name}
              or {}
              // {
                ${key} = value;
              };
          }
      ))
      (builtins.mapAttrs (lib.const pkgs.fetchurl))
    ];
  in {
    enable = true;
    package =
      (pkgs.neovim-unwrapped.override
        {
          lua = pkgs.luajit;
        })
      .overrideAttrs (old: {
        version = "nightly";
        src = src;
        preConfigure = ''
          ${old.preConfigure}
          substituteAll cmake.config/versiondef.h.in \
            --replace-fail '@NVIM_VERSION_PRERELEASE@' '-nightly+${inputs.neovim-src.shortRev or "dirty"}'
        '';
        postInstall = ''
          ${old.postInstall or ""}
          ${builtins.concatStringsSep "\n" (map (target: "rm -f $out/share/nvim/runtime/${target}") [
            "indent.vim"
            "menu.vim"
            "mswin.vim"
            "plugin/matchit.vim"
            "plugin/matchparen.vim"
            "plugin/rplugin.vim"
            "plugin/shada.vim"
            "plugin/tohtml.vim"
            "plugin/tohtml.lua"
            "plugin/tutor.vim"
            "plugin/gzip.vim"
            "plugin/tarPlugin.vim"
            "plugin/zipPlugin.vim"
            "plugin/netrwPlugin.vim"
            "plugin/spellfile.vim"
          ])}
        '';
        buildInputs = with pkgs;
          [
            # TODO: remove once upstream nixpkgs updates the base drv
            (utf8proc.overrideAttrs (_: {
              src = deps.utf8proc;
            }))
          ]
          ++ old.buildInputs;
        patchPhase = ''
          set -x
          patch -p1 < ${pkgs.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/neovim/neovim/pull/31631.patch";
            hash = "sha256-ne0VseSBd2cANp2PEXCZpZ5kDzJ7mTIzL+jQ0/seAnY=";
          }}
          patch -p1 < ${pkgs.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/neovim/neovim/pull/31400.patch";
            hash = "sha256-DYtqfZ6H3uk2CUsu8h5/5fi48FT4tVYfGcmaf/+UIew=";
          }} || true
          sed -i '/<<<<<<</,/>>>>>>/d' runtime/doc/news.txt || true
        '';
        NIX_CFLAGS_COMPILE = "-march=native -O3";
        NIX_LDFLAGS = "-fuse-ld=mold";
        hardeningDisable = ["all"];
        nativeBuildInputs =
          old.nativeBuildInputs
          ++ [
            pkgs.mold-wrapped
          ];
      });
    vimAlias = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
    defaultEditor = true;
  };
}
