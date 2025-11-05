-- Set GH_HOST for GitHub Enterprise (only affects nvim)
vim.env.GH_HOST = "git.enova.com"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
