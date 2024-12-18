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
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
          useConfig = false;
        };
        branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
        allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium";
      };
      os = {
        editPreset = "nvim-remote";
      };
    };
  };
  programs.git.delta = {
    enable = true;
    options = {
      syntax-theme = "base16-stylix";
    };
  };
}
