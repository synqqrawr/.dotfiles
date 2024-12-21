{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    # nix
    nixd
    alejandra

    # rust
    clippy
    rustc
    cargo
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
    pnpm
    emmet-ls
    inputs.nixpkgs-small.legacyPackages.x86_64-linux.tailwindcss-language-server
    nodejs
    eslint_d
    nodePackages.typescript-language-server
    deno

    #css
    vscode-langservers-extracted
    stylelint-lsp
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
    ruff
    black
    vscode-extensions.ms-python.debugpy
    pipx
    poetry
    python312Packages.pip
  ];
}
