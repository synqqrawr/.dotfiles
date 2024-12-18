{
  config,
  pkgs,
  ...
}: {
  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
  };

  home.packages = [
    pkgs.neovim-remote
  ];
}
