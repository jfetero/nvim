-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<C-f>", ":!tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<C-d>", "<c-d>zz")
keymap.set("n", "<C-u>", "<c-u>zz")
keymap.set("n", "Y", "y$")
keymap.set("n", "J", "mzJ'z")
keymap.set("x", "<leader>p", '"_dP')

-- Yanking to clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

-- Deleting without Yanking
keymap.set("n", "<leader>d", '"_d', { desc = "Delete w/o yank" })
keymap.set("v", "<leader>d", '"_d', { desc = "Delete w/o yank" })

keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word" })
keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", opts)
keymap.set("n", "<A-a>", "gg<S-v>G")

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", "!", "!<c-g>u")
keymap.set("i", "?", "?<c-g>u")
keymap.set("i", "/", "/<c-g>u")
keymap.set("i", "\\", "\\<c-g>u")
