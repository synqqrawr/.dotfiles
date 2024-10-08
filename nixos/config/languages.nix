{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # nix
    nil
    nixd
    nixfmt-rfc-style

    # rust
    inputs.fenix.packages.x86_64-linux.default.toolchain
    rust-analyzer

    # c
    clang-tools
    clang
    gcc
    cmake
    ninja
    extra-cmake-modules

    # toml
    taplo

    # web dev
    prettierd
    bun
    emmet-ls
    tailwindcss-language-server
    nodejs
    eslint_d
    nodePackages.typescript-language-server

    #css
    vscode-langservers-extracted
    # svelte
    nodePackages.svelte-language-server

    # lua
    stylua
    lua-language-server

    # java
    jdk17

    # markdown
    marksman
    markdown-oxide

    # python
    python3
    basedpyright
    ruff-lsp
    black
    vscode-extensions.ms-python.debugpy
  ];
}
