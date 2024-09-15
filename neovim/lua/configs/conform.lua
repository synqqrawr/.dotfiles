local options = {
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    css = { "prettierd" },
    html = { "prettierd" },
    fish = { "fish_indent" },
    nix = { "nixfmt" },
    lua = { "stylua" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    python = { "black" },
  },
}

return options
