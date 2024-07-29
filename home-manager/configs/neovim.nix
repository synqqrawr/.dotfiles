{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{
  home.file."${config.xdg.configHome}/dots.nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
  };
  home.file."${config.xdg.configHome}/nvim/lua" = {
    recursive = true;
    source = ./neovim/nvim/lua;
  };

  imports = [ ./neovim/nix/hls.nix ];

  programs.neovim = {
    package = pkgs.neovim;
    enable = true;
    defaultEditor = true;

    withRuby = false;
    withPython3 = false;
    withNodeJs = false;

    plugins = with pkgs.vimPlugins; [
      rec {
        plugin = pkgs.symlinkJoin {
          name = "nvim-treesitter";
          paths = [
            nvim-treesitter.withAllGrammars
            nvim-treesitter.withAllGrammars.dependencies
          ];
        };
        type = "lua";
        optional = true;
        config =
          # You can also *only* enable highlighting if you use: vim.treesitter.start(...)
          # Which would be more performant but, on the downside, it won't have the injections, indentation and folding stuff (some may work w/o nvim-treesitter), so I'll just opt with just nvim-treesitter.
          # The autocmd only runs once.
          # lua
          ''
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
              callback = function()
                vim.cmd.packadd("${plugin.name}")
                require("nvim-treesitter.configs").setup({
                  highlight = { enable = true },
                })
              end
            })
          '';
      }
      rec {
        plugin = mini-nvim;
        type = "lua";
        optional = true;
        config =
          # lua
          ''
            local packadded_mini_nvim = false
            -- Trust me, I can name things better than this :D.
            local package_preload = function(a, o)
              if not packadded_mini_nvim then
                vim.cmd.packadd("${plugin.pname}")
                packadded_mini_nvim = true
              end
              package.loaded[a] = nil
              package.loaded[a] = nil
              require(a).setup(o)
              return a
            end

            package_preload("mini.pick", {
              window = {
                prompt_prefix = "   ",
                prompt_cursor = "",
              },
            })
            package_preload("mini.files")
            package_preload("mini.icons")
            package_preload("mini.diff", {
              view = {
                style = "sign", 
                signs = {
                  add = "▎",
                  change = "▎",
                  delete = "",
                },
              }
            })
            package_preload("mini.git")

            package.preload["nvim-web-devicons"] = function()
              require("mini.icons").mock_nvim_web_devicons()
              return package.loaded["nvim-web-devicons"]
            end
            vim.keymap.set("n", "<leader>ff", function()
              vim.keymap.del("n", "<leader>ff")
              vim.keymap.set("n", "<leader>ff", function() require("mini.pick").builtin.files({ tool = "rg" }) end)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Ignore><leader>ff", true, true, true), "i", false)
            end)
            vim.keymap.set("n", "<leader>fg", function()
              vim.keymap.del("n", "<leader>fg")
              vim.keymap.set("n", "<leader>fg", function() require("mini.pick").builtin.grep_live({ tool = "rg" }) end)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Ignore><leader>fg", true, true, true), "i", false)
            end)
            vim.keymap.set("n", "<leader>to", function()
              vim.keymap.del("n", "<leader>to")
              vim.keymap.set("n", "<leader>to", function() require("mini.files").open() end)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Ignore><leader>to", true, true, true), "i", false)
            end)

            vim.api.nvim_create_autocmd("User", {
              group = vim.api.nvim_create_augroup("dots.nvim/mini.git", { clear = true }),
              pattern = "LazyFile",
              callback = function()
                require("mini.git")
                vim.api.nvim_del_augroup_by_name("dots.nvim/mini.git")
              end
            })
            vim.api.nvim_create_autocmd("User", {
              group = vim.api.nvim_create_augroup("dots.nvim/mini.diff", { clear = true }),
              pattern = "LazyFile",
              callback = function()
                require("mini.diff")
                vim.api.nvim_del_augroup_by_name("dots.nvim/mini.diff")
              end
            })
          '';
      }
      rec {
        plugin = nvim-lspconfig;
        type = "lua";
        optional = true;
        config =
          # lua
          ''
            package.preload["lspconfig"] = function()
              vim.cmd.packadd("${plugin.pname}")
              package.loaded["lspconfig"] = nil
              package.preload["lspconfig"] = nil
              return require("lspconfig")
            end
            vim.api.nvim_create_autocmd("User", {
              pattern = "LazyFile",
              once = true,
              callback = function()
                require("config.lspconfig")
              end,
            })
          '';
      }
    ];
    extraLuaConfig = # lua
      ''
        vim.go.loadplugins = false
        -- Optimize `runtimepath` when running from Nix
        local rtp = vim.opt.runtimepath:get()
        local vimpackdir
        for _, dir in ipairs(rtp) do
          if string.sub(dir, -12) == "vim-pack-dir" then
            vimpackdir = dir
            break
          end
        end
        if vimpackdir then
          local config_home = vim.env.XDG_CONFIG_HOME and vim.env.XDG_CONFIG_HOME .. "/nvim"
            or vim.env.HOME .. "/.config/nvim"
          vim.opt.runtimepath = {
            config_home,
            vimpackdir,
            vim.env.VIMRUNTIME,
            config_home .. "/after",
          }
          vim.opt.packpath = {
            vimpackdir,
            vim.env.VIMRUNTIME,
          }
        end
        vim.loader.enable()
        ${builtins.readFile ./neovim/nvim/options.lua}
        ${builtins.readFile ./neovim/nvim/settings.lua}
        ${builtins.readFile ./neovim/nvim/autocmd.lua}
        ${builtins.readFile ./neovim/nvim/lsp.lua}
        vim.o.statusline = "%!v:lua.require'stl'.render()"
        require("buf").setup()

        require("hls").load()
      '';
  };
}
