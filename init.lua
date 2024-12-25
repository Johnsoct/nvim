require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 250

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Displays floating linting messages
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float({ focusable = false, scope = "line" })
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

---------------
--- FOLDING ---
---------------
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            vim.cmd("normal! zR")
        end, 10) -- Delay slightly (10ms) to ensure folds are calculated
    end,
})
