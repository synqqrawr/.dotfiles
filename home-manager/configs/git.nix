{
  programs.git = {
    enable = true;

    userEmail = "git.nest608@passinbox.com";
    userName = "synqqrawr";

    extraConfig = {

      init = {
        defaultBranch = "main";
      };
    };
  };
}
