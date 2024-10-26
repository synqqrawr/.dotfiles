{ pkgs, ... }:
{
  environment.systemPackages = [
    # nix
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt-rfc-style

    # rust
    pkgs.clippy
    pkgs.rustc
    pkgs.cargo
    pkgs.rust-analyzer

    # c
    pkgs.clang-tools
    pkgs.clang
    pkgs.gcc
    pkgs.cmake
    pkgs.ninja
    pkgs.extra-cmake-modules

    # toml
    pkgs.taplo

    # web dev
    pkgs.prettierd
    pkgs.bun
    pkgs.emmet-ls
    pkgs.tailwindcss-language-server
    pkgs.nodejs
    pkgs.eslint_d
    pkgs.nodePackages.typescript-language-server
    pkgs.deno

    #css
    pkgs.vscode-langservers-extracted
    # svelte
    pkgs.nodePackages.svelte-language-server

    # lua
    pkgs.stylua
    pkgs.lua-language-server

    # java
    pkgs.jdk17

    # markdown
    pkgs.marksman
    pkgs.markdown-oxide

    # python
    pkgs.python3
    pkgs.basedpyright
    pkgs.ruff-lsp
    pkgs.black
    pkgs.vscode-extensions.ms-python.debugpy
    pkgs.pipx
  ];
}
