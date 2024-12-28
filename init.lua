require("config.lazy")

vim.opt.clipboard = "unnamedplus"
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
---ACTIVE WINDOW HIGHLIGHTING---
---------------
-- vim.cmd([[hi NormalActive guibg=#203040 | hi InactiveWindow guibg=#222222]])
-- vim.cmd([[set winhighlight=Normal:NormalActive,NormalNC:InactiveWindow]])
-- Helper function to darken a hex color
local function darken_color(hex, percent)
    local r = math.floor(tonumber(tostring(hex):sub(2, 3), 16) * percent)
    local g = math.floor(tonumber(tostring(hex):sub(4, 5), 16) * percent)
    local b = math.floor(tonumber(tostring(hex):sub(6, 7), 16) * percent)
    return string.format("#%02x%02x%02x", r, g, b)
end

-- Get the current 'Normal' highlight group (https://stackoverflow.com/a/14048055/28203646)
local normal_hl = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("StatusLine")), "bg")
-- Calculate lighter/darker colors
local active_bg = normal_hl and darken_color(normal_hl, 0.9) or "#222222"

-- Apply highlight groups dynamically
vim.api.nvim_set_hl(0, "NormalActive", { bg = active_bg })
vim.api.nvim_set_hl(0, "InactiveWindow", { bg = normal_hl.bg })

-- Apply winhighlight
vim.cmd([[set winhighlight=Normal:NormalActive,NormalNC:InactiveWindow]])

vim.cmd([[hi default UfoFoldedBg guibg=DarkYellow]])
