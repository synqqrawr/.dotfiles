{
  config,
  ...
}:
{
  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
