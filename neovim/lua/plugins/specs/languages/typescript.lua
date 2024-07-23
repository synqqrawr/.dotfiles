return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("LoadLazyFile_typescript-tools", { clear = true }),
        pattern = "LazyFile",
        callback = function()
          local function load_typescript_tools()
            if not require("lazy.core.config").plugins["typescript-tools.nvim"]._.loaded then
              require("lazy").load({ plugins = "typescript-tools.nvim" })
            end
          end
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "*.ts,*.tsx,*.js,*.jsx" },
            callback = load_typescript_tools,
          })
          if
            vim.bo.filetype == "typescript"
            or vim.bo.filetype == "javascript"
            or vim.bo.filetype == "javascriptreact"
            or vim.bo.filetype == "typescriptreact"
            or vim.bo.filetype == "javascript.jsx"
            or vim.bo.filetype == "typescript.tsx"
          then
            load_typescript_tools()
          end
        end,
      })
    end,
  },
}
