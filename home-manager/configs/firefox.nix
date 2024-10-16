{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  C = config.lib.stylix.colors;
  # Main highlight (bg)
  M = C.base02;
  # Highlight on the bg
  F = C.base05;
in
{
  programs.firefox = {
    package = inputs.nixpkgs-small.legacyPackages.x86_64-linux.firefox;
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
          "https://addons.mozilla.org/firefox/downloads/file/4359936/ublock_origin-1.60.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4360577/sponsorblock-5.9.3.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4246774/sidebery-5.2.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4342747/return_youtube_dislikes-3.0.0.17.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4340783/indie_wiki_buddy-3.10.1.xpi"
          "https://github.com/bpc-clone/bpc_updates/releases/download/latest/bypass_paywalls_clean-latest.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4341014/userchrome_toggle_extended-2.0.1.xpi"
        ];
      };
      "3rdparty".Extensions."uBlock0@raymondhill.net" = {
        adminSettings = {
          dynamicFilteringString = lib.concatMapStrings (x: x + "\n") [
            "no-csp-reports: * true"
            "no-large-media: behind-the-scene false"
            "behind-the-scene * * noop"
            "behind-the-scene * inline-script noop"
            "behind-the-scene * 1p-script noop"
            "behind-the-scene * 3p-frame noop"
            "behind-the-scene * image noop"
            "behind-the-scene * 3p noop"
          ];
          userFilters = lib.concatMapStrings (x: x + "\n") [
            "||0.0.0.0^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local "

            "en.wikipedia.org##+js(trusted-set-cookie, enwikimwclientpreferences, skin-theme-clientpref-night%2Cvector-feature-limited-width-clientpref-1%2Cvector-feature-custom-font-size-clientpref-1%2Cvector-feature-appearance-pinned-clientpref-0)"
            "ja.wikipedia.org##+js(trusted-set-cookie, jawikimwclientpreferences, skin-theme-clientpref-night%2Cvector-feature-limited-width-clientpref-1%2Cvector-feature-custom-font-size-clientpref-1%2Cvector-feature-appearance-pinned-clientpref-0)"
            "searx.be##+js(trusted-set-cookie, categories, general)"

            ''
              ! YT Homepage and Subscriptions (Grid View) - Hide the Shorts section
              youtube.com##[is-shorts]
              ! YT Menu - Hide the Shorts button
              www.youtube.com###guide [title="Shorts"], .ytd-mini-guide-entry-renderer[title="Shorts"]
              ! YT Search - Hide Shorts
              www.youtube.com##ytd-search ytd-video-renderer:has([overlay-style="SHORTS"])
              ! YT Search, Channels, Subscriptions (List View) and Sidebar/Below Player Recommendations - Hide the Shorts sections
              www.youtube.com##ytd-reel-shelf-renderer
              ! YT Channels - Hide the Shorts tab
              www.youtube.com##[tab-title="Shorts"]
              ! YT Subscriptions - Hide Shorts - Grid View
              www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-grid-video-renderer:has([overlay-style="SHORTS"])
              ! YT Subscriptions - Hide Shorts - List View
              www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-video-renderer:has([overlay-style="SHORTS"])
              ! YT Subscriptions - New Layout - Hide Shorts
              www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-rich-item-renderer:has([overlay-style="SHORTS"])
              ! YT Sidebar - Hide Shorts
              www.youtube.com###related ytd-compact-video-renderer:has([overlay-style="SHORTS"])

              ! YT Mobile - Hide the Shorts Menu button
              m.youtube.com##ytm-pivot-bar-item-renderer:has(>.pivot-shorts)
              ! YT Mobile - Hide the Shorts sections
              m.youtube.com##ytm-reel-shelf-renderer
              m.youtube.com##ytm-rich-section-renderer:has([d^="M17.77,10.32l-1.2"])
              ! YT Mobile - Hide Shorts in search results
              m.youtube.com##ytm-search ytm-video-with-context-renderer:has([data-style="SHORTS"])
              ! YT Mobile - Hide the Shorts button on Channels
              m.youtube.com##[tab-title="Shorts"]
            ''
            ''
              ! YT Search - keep only videos (no shorts)
              youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,yt-showing-results-for-renderer,[icon-name="promo-full-height:EMPTY_SEARCH"]),ytd-video-renderer:has([aria-label="Shorts"])),ytd-secondary-search-container-renderer

              ! YT Search - keep only videos (no shorts) and channels
              youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,ytd-channel-renderer,yt-showing-results-for-renderer,[icon-name="promo-full-height:EMPTY_SEARCH"]),ytd-video-renderer:has([aria-label="Shorts"])),ytd-secondary-search-container-renderer

              ! YT Search - keep only videos (no shorts), channels and playlists
              youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,ytd-channel-renderer, ytd-playlist-renderer,yt-showing-results-for-renderer,[icon-name="promo-full-height:EMPTY_SEARCH"]),ytd-video-renderer:has([aria-label="Shorts"])),ytd-secondary-search-container-renderer
            ''
            ''
              ! YT Sidebar - Hide videos based on their titles
              youtube.com###related ytd-compact-video-renderer:has(#video-title:is([title*="mrbeast"i]))
            ''
          ];
          hostnameSwitchesString = lib.concatMapStrings (x: x + "\n") [
            "no-large-media: behind-the-scene false"
            "no-csp-reports: * true"
          ];
        };
        advancedSettings = [
          [
            "cnameMaxTTL"
            "720"
          ]
          [
            "filterAuthorMode"
            "true"
          ]
        ];
        userSettings = [
          [
            "advancedUserEnabled"
            "true"
          ]
          [
            "ignoreGeneticCosmeticFilters"
            "true"
          ]
          [
            "popupPanelSections"
            "31"
          ]
          [
            "userFiltersTrusted"
            "true"
          ]
        ];
        toOverwrite = {
          filterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "adguard-spyware-url"
            "urlhaus-1"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "fanboy-social"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "ublock-annoyances"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://filters.adtidy.org/extension/ublock/filters/3.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
          ];
          externalLists = lib.concatMapStrings (x: x + "\n") [
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://filters.adtidy.org/extension/ublock/filters/3.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
          ];
          importedLists = [
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://filters.adtidy.org/extension/ublock/filters/3.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
          ];
          trustedSiteDirectives = [
            "about-scheme"
            "chrome-extension-scheme"
            "chrome-scheme"
            "edge-scheme"
            "moz-extension-scheme"
            "opera-scheme"
            "vivaldi-scheme"
            "wyciwyg-scheme"
          ];
        };
      };
    };
    profiles = {
      test = {
        name = "test";
        id = 1;
        userChrome = ''
          @import "${inputs.shyfox}/chrome/userChrome.css";
        '';
        userContent = ''
          @import "${inputs.shyfox}/chrome/userContent.css"
        '';
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("svg.context-properties.content.enabled", true);
          user_pref("layout.css.color-mix.enabled", true);
          user_pref("layout.css.light-dark.enabled", true);
          user_pref("layout.css.has-selector.enabled", true);
        '';
      };
      async = {
        name = "async";
        id = 0;
        userChrome =
          # css
          ''
            @import "${inputs.shyfox}/chrome/userChrome.css";

            :root {
              --outline: 0;
              color-scheme: dark dark;
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
              --urlbarView-highlight-background: #${M};
              --urlbarView-highlight-color: #${C.base00};
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
            }
          '';
        search = {
          default = "SearXNG";
          force = true;
          engines = {
            "Brave" = {
              urls = [
                {
                  template = "https://search.brave.com/search?q={searchTerms}";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.brave}/share/icons/hicolor/64x64/apps/brave-browser.png";
              definedAliases = [
                # fuck you, bing. i aint using you
                "!b"
                "@brave"
              ];
            };
            "Noogle" = {
              urls = [
                {
                  template = "https://noogle.dev/q";
                  params = [
                    {
                      name = "term";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://noogle.dev/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@ng" ];
            };
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
              definedAliases = [ "@mno" ];
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
              definedAliases = [ "@hm" ];
            };
            "SearXNG" = {
              urls = [
                {
                  template = "https://searx.be/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "@s" ];
            };
            "Marginalia.nu" = {
              urls = [
                {
                  template = "https://search.marginalia.nu/search?query={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [ "@mn" ];
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
          # javascript
          ''
            user_pref("network.trr.mode", 3);
            user_pref("network.trr.uri", "https://dns.nextdns.io/d12453"); // TRR/DoH
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("svg.context-properties.content.enabled", true);
            user_pref("layout.css.has-selector.enabled", true);

            user_pref("shyfox.larger.context.menu", true);
            user_pref("shyfox.enable.context.menu.icons", true);
            user_pref("browser.startup.page", 3); // 0102

            user_pref("cookiebanners.service.mode", 0); // I'm using Easylist cookie so it should be fine :D
            user_pref("cookiebanners.service.mode.privateBrowsing", 0);
            user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);

            user_pref("gfx.webrender.all", true);

            user_pref("browser.download.useDownloadDir", false);
            user_pref("accessibility.force_disabled", 1);
            // user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_3c078156-979c-498b-8990-85f7987dd929_-browser-action\",\"atbc_easonwong-browser-action\",\"_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action\",\"_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action\",\"_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"userchrome-toggle-extended_n2ezr_ru-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"dearrow_ajay_app-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"magnolia_12_34-browser-action\",\"customizableui-special-spring8\",\"fullscreen-button\",\"screenshot-button\",\"firefox-view-button\",\"downloads-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"ublock0_raymondhill_net-browser-action\",\"_3c078156-979c-498b-8990-85f7987dd929_-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"developer-button\",\"atbc_easonwong-browser-action\",\"magnolia_12_34-browser-action\",\"userchrome-toggle-extended_n2ezr_ru-browser-action\",\"_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action\",\"_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action\",\"_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action\",\"dearrow_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"PersonalToolbar\",\"TabsToolbar\",\"toolbar-menubar\"],\"currentVersion\":20,\"newElementCount\":10}");
            // user_pref("browser.theme.toolbar-theme", 0);
            // user_pref("browser.theme.content-theme", 0);
            // user_pref("browser.tabs.inTitlebar", 0);
            // user_pref("browser.uidensity", 0);
            // user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");

          ''
        ];
      };
    };
  };
}
