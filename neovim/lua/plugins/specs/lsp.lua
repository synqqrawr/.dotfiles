return {
  {
    "neovim/nvim-lspconfig",
    event = "User LazyFile",
    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("configs.lspconfig")
      require("nvchad.lsp")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = function()
      return require("configs.conform")
    end,
    init = function()
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    cmd = "ConformInfo",
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        ["javascript.jsx"] = { "eslint_d" },
        ["typescript.tsx"] = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },

        svelte = { "eslint_d" },
      },
      linters = {},
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.linters_by_ft
      require("lint").linters = opts.linters
    end,
    event = "LspAttach",
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter",
      "nvim-cmp",
      "nvim-lspconfig",
    },
    config = function()
      require("otter").activate({ "javascript", "python" }, true, true, nil)
    end,
  },
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {},
  },
}
