-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Custom keymaps for Go
vim.api.nvim_set_keymap("n", "<leader>gl", ":!golint %<CR>", { noremap = true, silent = true }) -- Lint Go file
vim.api.nvim_set_keymap("n", "<leader>gt", ":!go test %<CR>", { noremap = true, silent = true }) -- Run Go tests
