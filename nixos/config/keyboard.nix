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
            caps a s d f j k l ;
          )
          (defvar
            tap-time 150
            hold-time 200
          )

          (defalias
            escctrl (tap-hold 200 200 esc lctl)
            a (tap-hold $tap-time $hold-time a lmet)
            s (tap-hold $tap-time $hold-time s lalt)
            d (tap-hold $tap-time $hold-time d lsft)
            f (tap-hold $tap-time $hold-time f lctl)
            j (tap-hold $tap-time $hold-time j rctl)
            k (tap-hold $tap-time $hold-time k rsft)
            l (tap-hold $tap-time $hold-time l ralt)
            ; (tap-hold $tap-time $hold-time ; rmet)
          )

          (deflayer base
            @escctrl @a @s @d @f @j @k @l @;
          )
        '';
    };
  };
}
