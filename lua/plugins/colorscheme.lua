return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        style = "deep",
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        day_brightness = 1,
        im_inactive = true, -- dims inactive windows
        -- lualine_bold = true,
      }
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent_mode = true,
      }
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        italic_comments = true,
      }
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
    end,
  },
}
