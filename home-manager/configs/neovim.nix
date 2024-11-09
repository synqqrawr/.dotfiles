{
  config,
  pkgs,
  ...
}: {
  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
  };

  programs.neovim = {
    package = pkgs.neovim;
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
