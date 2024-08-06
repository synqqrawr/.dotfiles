return {
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    branch = "dev",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("LoadLazyFile_markview", { clear = true }),
        pattern = "LazyFile",
        callback = function()
          local function load_markview()
            if not require("lazy.core.config").plugins["markview.nvim"]._.loaded then
              require("lazy").load({ plugins = "markview.nvim" })
            end
          end
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "*.md" },
            callback = load_markview,
          })
          if vim.bo.filetype == "markdown" then
            load_markview()
          end
        end,
      })
    end,
    opts = {
      modes = { "n", "i", "c" },
      hybrid_modes = { "i" },
    },
    dependencies = {
      -- You may not need this if you don't lazy load
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",

      "nvim-tree/nvim-web-devicons",
    },
  },
}
