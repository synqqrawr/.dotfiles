# WELCOME TO HELL, BABY
# This file has 400LOC, and guess what -- I'm too lazy to modualize this.
# Please help me. Also the comments add 3 more LOC.
{
  inputs,
  lib,
  config,
  ...
}: let
  C = config.lib.stylix.colors;
  # Main highlight (bg)
  M = C.base02;
  # Highlight on the bg
  F = C.base05;

  searx = "search.bus-hit.me/search";
in {
  programs.firefox = {
    enable = true;
    policies = {
      Extensions = {
        Uninstall = [
          "google@search.mozilla.org"
          "bing@search.mozilla.org"
          "amazondotcom@search.mozilla.org"
          "ebay@search.mozilla.org"
          "twitter@search.mozilla.org"
          "wikipedia@search.mozilla.org"
        ];
        Install = [
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/userchrome_toggle_extended/latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/latest/keepassxc_browser/latest.xpi"
        ];
      };
    };
    profiles = {
      async = {
        name = "async";
        id = 0;
        userChrome =
          # css
          ''
            @import "${inputs.shyfox}/chrome/userChrome.css";

            :root {
              --outline: 0;
              color-scheme: ${config.stylix.polarity};
            }

            html#main-window,
            html#main-window > * {
              --lwt-accent-color: #${M};
              --lwt-text-color: #${F};
              --arrowpanel-background: #${C.base02};
              --arrowpanel-color: #${C.base05};
              --arrowpanel-border-color: rgba(0, 0, 0, 0);
              --toolbar-field-background-color: #${C.base03};
              --toolbar-bgcolor: #${C.base03};
              --toolbar-color: #${C.base05};
              --toolbar-field-color: #${C.base05};
              --toolbar-field-border-color: rgba(0, 0, 0, 0);
              --toolbar-field-focus-background-color: #${C.base03};
              --toolbar-field-focus-color: #${C.base05};
              --toolbar-field-focus-border-color: rgba(0, 0, 0, 0);
              --newtab-background-color: #${M};
              --newtab-background-color-secondary: #${C.base00};
              --newtab-text-primary-color: #${F};
              --tab-loading-fill: #${C.base0C};
              --tab-selected-bgcolor: rgba(${C.base04-rgb-r}, ${C.base04-rgb-g}, ${C.base04-rgb-b}, 0.7);
              --tab-selected-textcolor: #${C.base00};
              --lwt-tab-line-color: #${M};
              --tabs-navbar-separator-color: rgba(0, 0, 0, 0);
              --tabs-navbar-separator-style: none;
              --chrome-content-separator-color: rgba(0, 0, 0, 0);;
              --urlbarView-highlight-background: #${C.base0C};
              --urlbarView-highlight-color: #${M};
              --sidebar-background-color: #${M};
              --sidebar-text-color: #${C.base05};
              --tabpanel-background-color: #${M};
            }

            #contentAreaContextMenu[showservicesmenu="true"],
            #contentAreaContextMenu[showservicesmenu="true"] menupopup
            {
              --panel-background: var(--arrowpanel-background) !important;
               --toolbar-field-focus-background-color: var(--arrowpanel-background) !important;
              --panel-border-color: rgba(0, 0, 0, 0) !important;

              menu:where([_moz-menuactive="true"]:not([disabled="true"])), menuitem:where([_moz-menuactive="true"]:not([disabled="true"])) {
                background-color: ${C.base04} !important;
                color: ${C.base05} !important;
              }
            }

            findbar {
              background-color: var(--arrowpanel-background) !important;

              .findbar-textbox {
                background-color: #${C.base03} !important;
              }

              & > * {
                color: #${C.base05} !important;
              }
            }
          '';
        userContent =
          # css
          ''
            @import "${inputs.shyfox}/chrome/userContent.css";

            @-moz-document regexp("^moz-extension://.*?/sidebar/sidebar.html") {
              #root.root {
                --toolbar-fg: #${F} !important;
                --frame-fg: #${F} !important;
                --toolbar-bg: #${M} !important;
                --frame-bg: #${M} !important;
                --tabs-activated-bg: #${C.base04} !important;
              }
              .Tab[data-pin="true"] .body {
                border: 0 !important;
              }

              /* selected tab outline */
              .Tab[data-pin="true"][data-active="true"] .body
              {
                border: 0 !important;
                background-color: #${C.base04} !important;
              }
            }
          '';
        search = {
          default = "SearXNG (${searx})";
          force = true;
          engines = {
            "MyNixOS" = {
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://mynixos.com/favicon-dark.svg";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@mno"];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@hm"];
            };
            "SearXNG (${searx})" = {
              urls = [
                {
                  template = "https://${searx}";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@s"];
            };
            "Github Code" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "utf8";
                      value = "✓";
                    }
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                    {
                      name = "type";
                      value = "Code";
                    }
                  ];
                }
              ];
              definedAliases = [
                "!!ghc"
                "@ghc"
              ];
            };
            "Github" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "utf8";
                      value = "✓";
                    }
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "!!gh"
                "@gh"
              ];
            };
            "Nixpkgs" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "!!nixpkg"
                "@nixpkg"
                "!!nixpkgs"
                "@nixpkgs"
              ];
            };
            "Youtube" = {
              urls = [
                {
                  template = "https://youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "!!youtube"
                "@youtube"
                "!!yt"
                "@yt"
              ];
            };
            "12ft" = {
              urls = [
                {
                  template = "https://12ft.io/proxy";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "Wikipedia (en)".metaData.alias = "@wiki";
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Amazon.co.jp".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
        };
        extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.betterfox}/user.js")
          (builtins.readFile "${inputs.shyfox}/user.js")
          # javascript
          ''
            user_pref("network.trr.mode", 3);
            user_pref("network.trr.uri", "https://dns.nextdns.io/d12453"); // TRR/DoH
            user_pref("svg.context-properties.content.enabled", true);
            user_pref("layout.css.has-selector.enabled", true);

            user_pref("shyfox.larger.context.menu", false);
            user_pref("shyfox.enable.context.menu.icons", true);
            user_pref("browser.startup.page", 3); // 0102
            user_pref("shyfox.disable.floating.search", false);
            user_pref("shyfox.disable.compact.unified.extensions", true);

            user_pref("media.ffmpeg.vaapi.enabled", true);
            user_pref("gfx.webrender.all", true);

            user_pref("cookiebanners.service.mode", 0); // I'm using Easylist cookie so it should be fine :D
            user_pref("cookiebanners.service.mode.privateBrowsing", 0);
            user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);

            user_pref("gfx.webrender.all", true);

            user_pref("browser.download.useDownloadDir", false);

            // PREF: disable login manager
            user_pref("signon.rememberSignons", false);

            // PREF: disable address and credit card manager
            user_pref("extensions.formautofill.addresses.enabled", false);
            user_pref("extensions.formautofill.creditCards.enabled", false);
          ''
        ];
      };
    };
  };
}
