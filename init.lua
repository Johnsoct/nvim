require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

---------------
---NVIM-TREE---
---------------
-- disable netrw (nvim built in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Optionally enabled 24-bit colour
vim.opt.termguicolors = true
