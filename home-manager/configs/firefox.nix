{
  inputs,
  lib,
  pkgs,
  ...
}:
{
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
          "https://addons.mozilla.org/firefox/downloads/file/4290466/ublock_origin-1.58.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4308094/sponsorblock-5.7.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4246774/sidebery-5.2.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4308076/return_youtube_dislikes-3.0.0.16.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4045009/auto_tab_discard-0.6.7.xpi"
        ];
      };
      SearchEngines = {
        Remove = [
          "Google"
          "Bing"
          "Amazon.com"
          "eBay"
          "Twitter"
          "Wikipedia"
        ];
      };
      "3rdparty".Extensions."uBlock0@raymondhill.net" = {
        adminSettings = {
          dynamicFilteringString = lib.concatMapStrings (x: x + "\n") [
            "no-cosmetic-filtering: * true"
            "no-csp-reports: * true"
            "no-large-media: behind-the-scene false"
            "behind-the-scene * * noop"
            "behind-the-scene * inline-script noop"
            "behind-the-scene * 1p-script noop"
            "behind-the-scene * 3p-frame noop"
            "behind-the-scene * image noop"
            "behind-the-scene * 3p noop"
            "* * 3p-frame block"
            "* * 3p-script block"
            # compat stuf
            "duolingo.com * 3p-frame noop"
            "github.com githubassets.com * noop"
            "chatgpt.com oaistatic.com * noop"
            "x.com * 3p-frame noop"
            "x.com edgecastcdn.net * noop"
            "x.com twimg.com * noop"
            "x.com twitter.com * noop"
            "reddit.com redditstatic.com * noop"
            "www.reddit.com reddit.map.fastly.net * noop"
            "youtube.com * 3p-frame noop"
            "youtube.com * 3p-script noop"
            "* jquery.com * noop"
            "* fontawesome.com * noop"
            "* gstatic.com * noop"
            "* cloudflare.net * noop"
            "* fastly.net * noop"
            "* *.fastly.net * noop"
            "* jsdelivr.net * noop"
            "* *.cloudfront.net * noop"
            "* cloudfront.net * noop"
            "* cloudflare.com * noop"
            "* recaptcha.net * noop"
            "* google.com * noop"
            "* unpkg.com * noop"
            "* youtube-nocookie.com * noop"
            "knowyourmeme.com kym-cdn.com * noop"
            "knowyourmeme.com llnwi.net * noop"
            "lichess.org lichess1.org * noop"
            "wallhaven.cc whvn.cc * noop"
            "open.spotify.com spotifycdn.com * noop"
            "open.spotify.com spotifycdn.map.fastly.net * noop"
            "open.spotify.com scdn.co * noop"
            "open.spotify.com spotify.map.fastly.net * noop"
            "msn.com d.akamaiedge.net * noop"
            "* gravatar.com * noop"
            "* discourse-cdn.com * noop"
            "quora.com quoracdn.net * noop"
            "boards.4chan.org 4cdn.org * noop"
            "codepen.io cdpn.io * noop"
            ""
            "10fastfingers.com bootstrapcdn.com * noop"
            # tbh you'll be *fine* w/o cosmetic filtering except on for youtube ig
            "no-cosmetic-filtering: youtube.com false"
          ];
          userFilters = lib.concatMapStrings (x: x + "\n") [
            # "! (Firefox below 121) - Hide Homepage Videos Below 1K Views"
            # "www.youtube.com##ytd-browse[page-subtype=\"home\"] #video-title-link:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])):upward(ytd-rich-item-renderer)"
            "! (Chromium + FF121+) - Hide Homepage Videos Below 1K Views"
            ''www.youtube.com##ytd-browse[page-subtype="home"] ytd-rich-item-renderer:has(#video-title:not(:is([aria-label*=",0"],[aria-label*=",1"],[aria-label*=",2"],[aria-label*=",3"],[aria-label*=",4"],[aria-label*=",5"],[aria-label*=",6"],[aria-label*=",7"],[aria-label*=",8"],[aria-label*=",9"])))''
            # "! (Firefox below 121) - Hide Sidebar Videos Below 1K Views"
            # "www.youtube.com##ytd-compact-video-renderer #video-title:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])):upward(ytd-compact-video-renderer)"
            "! (Chromium + FF121+) - Hide Sidebar Videos Below 1K Views"
            ''www.youtube.com##ytd-compact-video-renderer:has(#video-title:not(:is([aria-label*=",0"],[aria-label*=",1"],[aria-label*=",2"],[aria-label*=",3"],[aria-label*=",4"],[aria-label*=",5"],[aria-label*=",6"],[aria-label*=",7"],[aria-label*=",8"],[aria-label*=",9"])))''

            "youtube-nocookie.com,youtube.com##.ytp-pause-overlay, .show-video-thumbnail-button"
            "~youtube-nocookie.com,~youtube.com##iframe ~ #topvbar > #rvid"

            "! YT Search - keep only videos (no shorts), channels and playlists"
            ''youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,ytd-channel-renderer, ytd-playlist-renderer,yt-showing-results-for-renderer),ytd-video-renderer:has([aria-label="Shorts"])),ytd-secondary-search-container-renderer''

            "! Move homepage placeholders to the end"
            ''www.youtube.com##ytd-browse[page-subtype="home"] :is(ytd-rich-grid-row, #contents.ytd-rich-grid-row):style(display: contents !important)''

            "/annotations_module.js$script,xhr,important,domain=youtube.com"
            "/endscreen.js$script,xhr,important,domain=youtube.com"

            "youtube.com##.ytp-button.ytp-cards-button"
            "youtube.com##.ytp-button.branding-img-container"
            "youtube.com##.ytp-suggested-action"

            "youtube.com##.ytp-quality-menu .ytp-menuitem:has(.ytp-premium-label)"
            "youtube.com##ytd-popup-container > tp-yt-paper-dialog > ytd-mealbar-promo-renderer, ytd-popup-container > tp-yt-paper-dialog > yt-mealbar-promo-renderer:has-text(/Claim Offer|Join now|Not Now|No thanks|YouTube TV|live TV|Live TV|movies|sports|Try it free|unlimited DVR|watch NFL/)"

            "! Hide related searches and related results from the YouTube search results, only leaving organic matches for your search"
            "www.youtube.com##ytd-search ytd-item-section-renderer ytd-shelf-renderer"
            "www.youtube.com##ytd-search ytd-item-section-renderer ytd-horizontal-card-list-renderer"

            # "! Hide next video video, which may accidentally be clicked since it's near the Play button"
            # "www.youtube.com##.ytp-button.ytp-next-button"

            "! REDDIT"
            "! Hide AutoModerator comments"
            "! https://www.reddit.com/r/uBlockOrigin/comments/140lp15/any_way_to_hide_automoderator_comments_with_ublock/"
            ''reddit.com##[data-testid="comment_author_link"][href="/user/AutoModerator/"]:upward(.Comment)''
            ''reddit.com##.comment .author[href="https://old.reddit.com/user/AutoModerator"]:upward(.comment)''
            ''! To hide AutoModerator, anyone who contains "mod" or "bot"''
            ''old.reddit.com##.comment[data-author="AutoModerator"]''
            ''! old.reddit.com##.comment[data-author*="mod"]''
            ''old.reddit.com##.comment[data-author*="bot"]''
            "! To hide any mod"
            "! old.reddit.com##.comment:has(.entry .tagline .moderator)"
            "! Hide Moderator section"
            "www.reddit.com###moderation_section"

            # remove the sign in w/ google stuff
            "||accounts.google.com/gsi/*$xhr,script,3p"
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
            "prefetchingDisabled"
            "false"
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
            "block-lan"
            "easyprivacy"
            "urlhaus-1"
            "plowe-0"
            "ublock-annoyances"
            "adguard-generic"
            "adguard-spyware"
            "adguard-spyware-url"
            "adguard-popup-overlays"
            "adguard-social"
            "adguard-widgets"
            "adguard-cookies"
            "ublock-cookies-adguard"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "fanboy-social"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "easylist"
            "JPN-1"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
          ];
          externalLists = lib.concatMapStrings (x: x + "\n") [
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
          ];
          importedLists = [
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
            # "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
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
        bookmarks = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "Youtube";
                url = "https://www.youtube.com";
              }
              {
                name = "Reddit";
                url = "https://www.reddit.com";
              }
              {
                name = "shitjustworks";
                url = "https://sh.itjust.works";
              }
              {
                name = "/g/";
                url = "https://boards.4chan.org/g/";
              }
              {
                name = "/lit/";
                url = "https://boards.4chan.org/lit/";
              }
              {
                name = "/his/";
                url = "https://boards.4chan.org/his/";
              }
              {
                name = "/sci/";
                url = "https://boards.4chan.org/sci/";
              }
              {
                name = "r/keeb";
                url = "https://reddit.com/r/mechanicalkeyboards";
              }
              {
                name = "r/unixporn";
                url = "https://reddit.com/r/unixporn";
              }
              {
                name = "r/til";
                url = "https://reddit.com/r/todayilearned";
              }
              {
                name = "r/piracy";
                url = "https://reddit.com/r/Piracy";
              }
              {
                name = "r/privacy";
                url = "https://reddit.com/r/privacy";
              }
              {
                name = "r/sci";
                url = "https://reddit.com/r/science";
              }
              {
                name = "r/obs";
                url = "https://reddit.com/r/ObsidianMD/";
              }
              {
                name = "r/nixos";
                url = "https://reddit.com/r/NixOS/";
              }
              {
                name = "r/ubo";
                url = "https://reddit.com/r/uBlockOrigin/";
              }
              {
                name = "r/nvim";
                url = "https://reddit.com/r/neovim/";
              }
              {
                name = "r/space";
                url = "https://reddit.com/r/space/";
              }
              {
                name = "r/technology";
                url = "https://reddit.com/r/technology/";
              }
              {
                name = "r/tech";
                url = "https://reddit.com/r/tech/";
              }
              {
                name = "hn";
                url = "https://news.ycombinator.com/";
              }
            ];
          }
        ];
        userChrome =
          # css
          ''
            @import "${inputs.shyfox}/chrome/userChrome.css";
            @import "${inputs.edge-frfox}/chrome/icons/icons.css";
            @import "${inputs.edge-frfox}/chrome/global/popup.css";
            @import "${inputs.edge-frfox}/chrome/global/tree.css";
            @import "${inputs.edge-frfox}/chrome/global/tweaks.css";

            :root {
              --outline: 0;
            }
          '';
        userContent = # css
          ''
            @import "${inputs.shyfox}/chrome/userContent.css";

            @-moz-document regexp("^moz-extension://.*?/sidebar/sidebar.html")
            {
              #nav_bar {
                box-shadow: none !important;
              }

              #icon_settings path {
                d: path("M8 0a8.02 8.02 0 0 0-1.672.174.474.474 0 0 0-.367.377L5.617 2.44a.942.942 0 0 1-1.242.717L2.57 2.512a.47.47 0 0 0-.508.127A7.998 7.998 0 0 0 .386 5.537a.47.47 0 0 0 .143.504l1.463 1.242a.94.94 0 0 1 0 1.433L.529 9.958a.471.471 0 0 0-.143.504 7.988 7.988 0 0 0 1.676 2.898.47.47 0 0 0 .508.127l1.805-.644a.941.941 0 0 1 1.242.717l.344 1.889c.034.187.18.337.367.377A8.022 8.022 0 0 0 8 15.999c.567 0 1.126-.057 1.672-.173a.472.472 0 0 0 .366-.377l.345-1.89a.942.942 0 0 1 1.242-.717l1.805.645a.47.47 0 0 0 .508-.127 7.998 7.998 0 0 0 1.676-2.898.47.47 0 0 0-.143-.504l-1.463-1.242a.94.94 0 0 1 0-1.433l1.463-1.242a.471.471 0 0 0 .143-.504 7.988 7.988 0 0 0-1.676-2.898.47.47 0 0 0-.508-.127l-1.805.645a.941.941 0 0 1-1.242-.717L10.037.55a.472.472 0 0 0-.365-.376A8.027 8.027 0 0 0 8 0zm0 .941c.395 0 .786.032 1.17.096l.285 1.572a1.88 1.88 0 0 0 2.486 1.434l1.502-.537c.5.605.897 1.289 1.172 2.025l-1.219 1.033a1.883 1.883 0 0 0 0 2.87l1.22 1.034a7.043 7.043 0 0 1-1.173 2.025l-1.502-.537a1.882 1.882 0 0 0-2.486 1.433l-.285 1.572a7.135 7.135 0 0 1-2.342 0l-.283-1.572a1.88 1.88 0 0 0-2.486-1.433l-1.502.537a7.054 7.054 0 0 1-1.172-2.025l1.219-1.033a1.883 1.883 0 0 0 0-2.871L1.384 5.53a7.046 7.046 0 0 1 1.173-2.025l1.502.537a1.882 1.882 0 0 0 2.486-1.434l.283-1.572A7.132 7.132 0 0 1 8 .941zm0 4.56A2.5 2.5 0 1 0 8 10.5a2.5 2.5 0 0 0 0-5zm0 1a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3z") !important;
              }

              /* selected tab outline */
              .Tab[data-pin="true"][data-active="true"] .body {
                border: 0 !important;
                background-color: var(--tabs-activated-bg) !important;
              }

              /* NAVBAR */

              /** #root.root {--nav-btn-width: 25px;}
              #root.root {--nav-btn-height: 25px;}
              #root.root {--nav-btn-margin: 2px;} **/
              #root.root {--toolbar-bg: transparent;}

              .PinnedTabsBar {margin: 10px 0px;}
            }
          '';
        search = {
          default = "Brave";
          force = true;
          engines = {
            "Brave" = {
              urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
              icon = "${pkgs.brave}/share/icons/hicolor/64x64/apps/brave-browser.png";
              definedAliases = [
                "!b"
                "@brave"
              ];
            };
            "Noogle" = {
              urls = [ { template = "https://noogle.dev/q?term={searchTerm}"; } ];
              iconUpdateURL = "https://noogle.dev/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [
                "@ng"
                "!ng"
              ];
            };
            "MyNixOS" = {
              urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
              iconUpdateURL = "https://mynixos.com/favicon-dark.svg";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [
                "@mno"
                "!mno"
              ];
            };
            "Home Manager Options" = {
              urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
              iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [
                "@hm"
                "!hm"
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
          # javascript
          ''
            user_pref("network.trr.mode", 3);
            user_pref("network.trr.uri", "https://dns.nextdns.io/d12453"); // TRR/DoH
          ''
          # javascript
          ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("svg.context-properties.content.enabled", true);
            user_pref("layout.css.color-mix.enabled", true);
            user_pref("layout.css.light-dark.enabled", true);
            user_pref("layout.css.has-selector.enabled", true);
          ''
          # javascript
          ''
            user_pref("browser.startup.page", 3); // 0102
            // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
            // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
            user_pref("privacy.clearOnShutdown.history", false); // 2811
            // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del
          ''
          #javascript
          ''
            user_pref("browser.download.useDownloadDir", false);
            user_pref("dom.security.https_only_mode", true);
            user_pref("gfx.webrender.all", true);
            user_pref("gfx.webrender.all", true);
            user_pref("dom.webgpu.enabled", true);
            user_pref("layers.gpu-process.enabled", true);
            user_pref("layers.mlgpu.enabled", true);
            user_pref("media.gpu-process-decoder", true);
            user_pref("media.ffmpeg.vaapi.enabled", true);
          ''
          # javascript
          ''
            user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"atbc_easonwong-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"ublock0_raymondhill_net-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"_3c078156-979c-498b-8990-85f7987dd929_-browser-action\",\"screenshot-button\",\"firefox-view-button\",\"downloads-button\",\"fullscreen-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\",\"customizableui-special-spring5\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"ublock0_raymondhill_net-browser-action\",\"_3c078156-979c-498b-8990-85f7987dd929_-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"developer-button\",\"atbc_easonwong-browser-action\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"PersonalToolbar\",\"TabsToolbar\",\"toolbar-menubar\"],\"currentVersion\":20,\"newElementCount\":5}");
            user_pref("browser.theme.toolbar-theme", 0);
            user_pref("browser.theme.content-theme", 0);
            user_pref("browser.tabs.inTitlebar", 0);

          ''
        ];
      };
    };
  };
}
