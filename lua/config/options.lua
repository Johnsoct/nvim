-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false 

-- Enforce traditional VIM practices
vim.opt.mouse = ""

-- Update intendation from 2 to 8 (Linux Kernal Stylguide)
-- https://www.kernel.org/doc/html/v4.11/process/coding-style.html#indentation
vim.opt.autoindent = true -- Enable automatic indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Automatically indent new lines
vim.opt.shiftwidth = 4 -- Number of spaces used for each indentation step
vim.opt.softtabstop = 4
vim.opt.tabstop = 4 -- number of spaces a tab counts for

-- Enable yanking to the system clipboard
vim.opt.clipboard = "unnamedplus"
