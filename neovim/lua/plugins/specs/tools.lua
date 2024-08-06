return {
  {
    "kkharji/sqlite.lua",
    config = function()
      if dots.sqlite.path then
        vim.g.sqlite_clib_path = dots.sqlite.path .. "/lib/libsqlite3.so"
      end
    end,
  },
  {
    "echasnovski/mini.pick",
    opts = {
      window = {
        prompt_prefix = "   ",
        prompt_cursor = "",
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("mini.pick").builtin.files({ tool = "rg" })
        end,
        desc = "mini.pick: files",
      },
      {
        "<leader>fg",
        function()
          require("mini.pick").builtin.grep_live({ tool = "rg" })
        end,
        desc = "mini.pick: live_grep",
      },
      {
        "<leader>fb",
        function()
          require("mini.pick").builtin.buffers()
        end,
        desc = "mini.pick: buffers",
      },
    },
    cmd = { "Pick" },
  },
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = true,
      },
    },
    keys = {
      { "<leader>to", "<cmd>lua require('mini.files').open()<CR>", desc = "mini.files: Open" },
    },
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("mini.files")
        end
      end
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id

          vim.api.nvim_win_set_config(win_id, { border = "solid" })
        end,
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    opts = true,
    keys = {
      { "<leader>s", "<Cmd>lua require('spectre').toggle()<CR>", desc = "Spectre: toggle" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
      })
    end,
  },
  {
    "echasnovski/mini.visits",
    opts = true,
    keys = {
      {
        "<leader>pp",
        function()
          require("mini.visits").select_path()
        end,
      },
    },
  },
  {
    "isakbm/gitgraph.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      symbols = {
        merge_commit = "M",
        commit = "*",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>gl", function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end, { desc = "new git graph" })
    end,
  },
}
