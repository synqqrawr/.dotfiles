return {
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    config = function(_, opts)
      require("mini.icons").setup(opts)
      dofile(vim.g.base46_cache .. "devicons")
    end,
  },
  {
    "NvChad/base46",
    branch = "v2.5",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "NvChad/ui",
    branch = "v3.0",
    lazy = false,
    config = function()
      require("nvchad")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User LazyFile",
    opts = {
      indent = { highlight = "IblChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")
      require("ibl").setup(opts)
      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
  -- CREDITS TO: https://www.lazyvim.org/plugins/ui#dressingnvim
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "echasnovski/mini.hipatterns",
    event = "User LazyFile",
    opts = function()
      return require("configs.hipatterns")
    end,
    config = function(_, opts)
      require("mini.hipatterns").setup(opts)

      vim.defer_fn(function()
        require("mini.hipatterns").enable()
      end, 0)
    end,
  },
  {
    "nvchad/minty",
    keys = {
      {
        "<leader>ms",
        function()
          require("minty.shades").open()
        end,
        desc = "Minty: Open shades",
      },
      {
        "<leader>mh",
        function()
          require("minty.huefy").open()
        end,
        desc = "Minty: Open huefy",
      },
    },
    dependencies = {
      "nvchad/volt",
    },
  },
}
