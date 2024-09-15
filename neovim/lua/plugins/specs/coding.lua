return {
  {
    "altermo/ultimate-autopair.nvim",
    opts = {
      bs = {
        indent_ignore = true,
      },
    },
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require("cmp")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        performance = {
          max_view_entries = 20,
          debounce = 150,
        },
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
              },
            },
          },
          { name = "path" },
          { name = "crates" },
          -- https://github.com/hrsh7th/cmp-buffer
          {
            name = "buffer",
            keyword_length = 4,
            max_item_count = 10,
            option = {
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end,
              indexing_interval = 1000,
            },
          },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
              cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
              vim.schedule(function()
                vim.snippet.jump(-1)
              end)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
              ellipsis_char = "...",
            })(entry, vim_item)
            -- vim_item.kind = dots.UI.icons.LSP.kind[item]
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = (strings[1] or "")
            kind.concat = kind.abbr

            return vim_item
          end,
        },
        experimental = {
          ghost_text = true,
        },
        view = {
          entries = {
            follow_cursor = true,
          },
        },
      }
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    event = "InsertEnter",
    cmd = "CmpStatus",
  },
  {
    "hrsh7th/cmp-cmdline",
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
    dependencies = {
      "nvim-cmp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    event = "CmdlineEnter",
  },
}
