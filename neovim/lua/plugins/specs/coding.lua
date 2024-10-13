return {
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    -- credits 2 lazyvim
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    config = function(_, opts)
      require("utils.mini").pairs(opts)
    end,
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    -- lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    -- version = "v0.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = "cargo build --release",

    opts = {
      nerd_font_variant = "normal",
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
      keymap = {
        accept = "<C-y>",
        select_prev = { "<Up>", "<C-k>" },
        select_next = { "<Down>", "<C-j>" },
      },
    },
  },
  {
    "benlubas/cmp2lsp",
    lazy = true,
    config = vim.schedule_wrap(function()
      require("cmp2lsp").setup({ sources = { "lazydev" } })
      -- require("cmp2lsp").setup({ sources = { {"lazydev"}, {"crates"} } })
    end),
  },
}
