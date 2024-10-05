local conf = require("nvconfig").lsp
local map = vim.keymap.set
local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
  map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
  map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts("List workspace folders"))

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))

  map("n", "<leader>ra", function()
    require("nvchad.lsp.renamer")()
  end, opts("NvRenamer"))

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
  map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end

  vim.b.inlay_hints_enabled = true
  vim.lsp.inlay_hint.enable(true)
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      vim.lsp.inlay_hint.enable(false)
    end,
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      vim.lsp.inlay_hint.enable(vim.b.inlay_hints_enabled or false)
    end,
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("nvchad.lsp").diagnostic_config()

local lspconfig = require("lspconfig")

local servers = {
  basedpyright = {},
  clangd = {
    on_attach = function(c, b)
      c.server_capabilities.signatureHelpProvider = false
      on_attach(c, b)
    end,
  },
  svelte = {},
  emmet_ls = {},
  tailwindcss = {},
  nil_ls = {
    settings = {
      ["nil"] = {
        nix = { flake = { autoArchive = true } },
      },
    },
  },
  ts_ls = {},
  nixd = {
    on_attach = function(c, b)
      c.server_capabilities.semanticTokensProvider = nil
      on_attach(c, b)
    end,
  },
  markdown_oxide = {
    on_attach = function(c, b)
      on_attach(c, b)

      vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

      -- setup Markdown Oxide daily note commands
      if c.name == "markdown_oxide" then
        vim.api.nvim_create_user_command("Daily", function(args)
          local input = args.args

          vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
        end, { desc = "Open daily note", nargs = "*" })
      end
    end,
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }),
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        check = {
          command = "clippy",
          allFeatures = true,
          extraArgs = {
            "--",
            "-W clippy::pedantic",
            "-W clippy::nursery",
            "-W clippy::unwrap_used",
            "-W clippy::expect_used",
          },
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
          -- arrayIndex = "Disable",
        },
        runtime = {
          pathStrict = true,
        },
        completion = {
          callSnippet = "Both",
        },
        diagnostics = {
          globals = {
            "vim",
          },
        },
        workspace = {
          maxPreload = 100000,
          preloadFileSize = 10000,
          checkThirdParty = false,
        },
      },
    },
  },
  cssls = {},
  ruff_lsp = {
    on_attach = function(c, b)
      on_attach(c, b)
      c.server_capabilities.hoverProvider = false
    end,
  },
  -- marksman = {},
}

for name, opts in pairs(servers) do
  opts.on_init = opts.on_init and opts.on_init or on_init
  opts.on_attach = opts.on_attach and opts.on_attach or on_attach
  opts.capabilities = opts.capabilities and opts.capabilities or capabilities

  require("lspconfig")[name].setup(opts)
end
