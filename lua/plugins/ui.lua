return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
    },
  },

  -- animations
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      {
        "<leader>bs",
        function()
          local bufs = vim.tbl_filter(function(buf)
            return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
          end, vim.api.nvim_list_bufs())
          table.sort(bufs, function(a, b)
            return vim.api.nvim_buf_get_name(a) < vim.api.nvim_buf_get_name(b)
          end)
          for i, buf in ipairs(bufs) do
            vim.cmd(i .. "buf " .. buf)
          end
        end,
        desc = "Sort buffers by path",
      },
    },
    opts = {
      options = {
      -- Use mini.bufremove
      -- stylua: ignore
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,

        -- LSP features (already enabled)
        diagnostics = "nvim_lsp",

        -- Don't show the bar if there is only one buffer
        always_show_bufferline = false,

        -- LSP diagnostics indicator
        diagnostics_indicator = function(_, _, diag)
          -- Assumes you have 'lazyvim.config'
          -- If not, replace 'icons' with your own table: e.g., local icons = { Error = " ", Warn = " " }
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,

        -- Offset for neo-tree
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
      highlights = {
        -- Set all background highlights to 'NONE'
        background = { bg = "NONE" },
        fill = { bg = "NONE" },

        -- Buffer states
        buffer_selected = { bg = "NONE" },
        buffer_visible = { bg = "NONE" },

        -- Diagnostic states
        diagnostic_selected = { bg = "NONE" },
        diagnostic_visible = { bg = "NONE" },

        -- Separators
        separator = { bg = "NONE" },
        separator_visible = { bg = "NONE" },
        separator_selected = { bg = "NONE" },
        offset_separator = { bg = "NONE" },
      },
    },
  },
  { "nvim-mini/mini.bufremove", event = "VeryLazy" },

  -- statusline

  {
    "nvim-lualine/lualine.nvim",
    event = "BufWinEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      -- 1. DEFINE GRUVBOX COLORS
      -- This table now uses the gruvbox palette
      local colors = {
        bg = "#282828",
        fg = "#ebdbb2",
        yellow = "#fabd2f", -- Diagnostics warn
        cyan = "#8ec07c", -- LSP (aqua)
        green = "#b8bb26", -- Git added
        orange = "#fe8019", -- Git modified
        violet = "#d3869b", -- Git branch (purple)
        magenta = "#d3869b", -- Filename (purple)
        blue = "#83a598", -- Side bars |
        red = "#fb4934", -- Mode, Diagnostics error
      }

      -- 2. DEFINE CONDITIONS
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
      }

      -- 3. DEFINE THE MAIN CONFIG (using the evil_lualine.lua logic)
      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = {
            -- Set the base theme colors
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- 4. MANUALLY BUILD THE LEFT SECTION (lualine_c)
      config.sections.lualine_c = {
        -- Left-most bar
        {
          function()
            return "|"
          end,
          color = { fg = colors.blue },
          padding = { left = 0, right = 1 },
        },
        -- Mode icon
        {
          function()
            return ""
          end, -- You can change this icon
          color = function()
            -- Use gruvbox colors for modes
            local mode_color = {
              n = colors.red,
              i = colors.green,
              v = colors.blue,
              [""] = colors.blue,
              V = colors.blue,
              c = colors.magenta,
              no = colors.red,
              s = colors.orange,
              S = colors.orange,
              [""] = colors.orange,
              ic = colors.yellow,
              R = colors.violet,
              Rv = colors.violet,
              cv = colors.red,
              ce = colors.red,
              r = colors.cyan,
              rm = colors.cyan,
              ["r?"] = colors.cyan,
              ["!"] = colors.red,
              t = colors.red,
            }
            return { fg = mode_color[vim.fn.mode()] }
          end,
          padding = { right = 1 },
        },
        -- Filesize
        {
          "filesize",
          cond = conditions.buffer_not_empty,
        },
        -- Filename
        {
          "filename",
          cond = conditions.buffer_not_empty,
          color = { fg = colors.magenta, gui = "bold" },
        },
        -- Location
        { "location" },
        -- Progress
        { "progress", color = { fg = colors.fg, gui = "bold" } },
        -- Diagnostics
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          diagnostics_color = {
            error = { fg = colors.red },
            warn = { fg = colors.yellow },
            info = { fg = colors.cyan },
          },
        },
        -- Spacer
        {
          function()
            return "%="
          end,
        },
        -- LSP Client
        {
          function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients == 0 then
              return ""
            end
            local client_names = {}
            for _, client in ipairs(clients) do
              table.insert(client_names, client.name)
            end
            return table.concat(client_names, ", ")
          end,
          icon = "< LSP:",
          color = { fg = colors.cyan, gui = "bold" },
        },
      }

      -- 5. MANUALLY BUILD THE RIGHT SECTION (lualine_x)
      config.sections.lualine_x = {
        -- Encoding
        {
          "encoding",
          fmt = string.upper,
          cond = conditions.hide_in_width,
          color = { fg = colors.green, gui = "bold" },
        },
        -- Fileformat
        {
          "fileformat",
          fmt = string.upper,
          icons_enabled = false,
          color = { fg = colors.green, gui = "bold" },
        },
        -- Git Branch
        {
          "branch",
          icon = "",
          color = { fg = colors.violet, gui = "bold" },
        },
        -- Git Diff
        {
          "diff",
          symbols = { added = " ", modified = " ", removed = " " },
          diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
          },
          cond = conditions.hide_in_width,
        },
        -- Right-Mmost bar
        {
          function()
            return "|"
          end,
          color = { fg = colors.blue },
          padding = { left = 1 },
        },
      }

      -- 6. RETURN THE CONFIG
      return config
    end,
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "navarasu/onedark.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
}
