{ pkgs, ... }:
{
  imports = [ ./themes/pasteldark.nix ];
  stylix = {
    enable = true;
    fonts = {
      serif = {
        package = pkgs.custom-fonts;
        name = "SF Pro";
      };

      sansSerif = {
        package = pkgs.custom-fonts;
        name = "SF Pro";
      };

      monospace = {
        package = pkgs.maple-mono;
        name = "Maple Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes.popups = 16;
    };
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };
  };
  home-manager.sharedModules = [
    {
      stylix.targets.kde.enable = false;
      stylix.targets.neovim.enable = false;
      stylix.targets.lazygit.enable = false;
      stylix.targets.btop.enable = true;
      stylix.targets.gtk.extraCss = ''
        button.titlebutton,
        windowcontrols > button {
          color: transparent;
          min-width: 16px;
          min-height: 16px;
          box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.2);
        }

        button.titlebutton:backdrop {
          opacity: 0.5;
        }

        windowcontrols > button {
          border-radius: 100%;
          padding: 0;
          margin: 0 3px;
        }

        windowcontrols > button > image {
          padding: 0;
        }

        button.titlebutton {
          margin: 0 2px;
        }

        .titlebar .right {
          margin-right: 8px;
        }

        .titlebar .left {
          margin-left: 8px;
        }

        windowcontrols.end {
          margin-right: 8px;
        }

        windowcontrols.start {
          margin-left: 8px;
        }

        button.titlebutton.close, button.titlebutton.close:hover:backdrop,
        windowcontrols > button.close,
        windowcontrols > button.close:hover:backdrop {
          background-color: #ff605c;
        }

        button.titlebutton.close:hover,
        windowcontrols > button.close:hover {
          background-color: shade(#ff605c,0.9);
        }

        button.titlebutton.maximize, button.titlebutton.maximize:hover:backdrop,
        windowcontrols > button.maximize,
        windowcontrols > button.maximize:hover:backdrop {
          background-color: #00ca4e;
        }

        button.titlebutton.maximize:hover,
        windowcontrols > button.maximize:hover {
          background-color: shade(#00ca4e,0.9);
        }

        button.titlebutton.minimize, button.titlebutton.minimize:hover:backdrop,
        windowcontrols > button.minimize,
        windowcontrols > button.minimize:hover:backdrop {
          background-color: #ffbd44;
        }

        button.titlebutton.minimize:hover,
        windowcontrols > button.minimize:hover {
          background-color: shade(#ffbd44,0.9);
        }

        button.titlebutton.close:backdrop, button.titlebutton.maximize:backdrop, button.titlebutton.minimize:backdrop,
        windowcontrols > button.close:backdrop,
        windowcontrols > button.maximize:backdrop,
        windowcontrols > button.minimize:backdrop {
          background-color: #c0bfc0;
        }
      '';
    }
  ];
}
