{
  services.kanata = {
    enable = true;
    keyboards.allKeyboards = {
      extraDefCfg =
        #scheme
        ''
          process-unmapped-keys yes
        '';
      config =
        #scheme
        ''
          (defsrc
            caps
          )
          (defalias
            escctrl (tap-hold 200 200 esc lctl)
          )

          (deflayer base
            @escctrl
          )
        '';
    };
  };
}
