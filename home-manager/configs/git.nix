{
  programs.git = {
    enable = true;

    userEmail = "174339922+synqqrawr@users.noreply.github.com";
    userName = "synqqrawr";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.git.difftastic.enable = true;
  programs.git.difftastic.display = "inline";

  programs.lazygit = {
    enable = true;
    settings = {
      git.paging.externalDiffCommand = "difft --color=always";
    };
  };
}
