require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.autoindent = true  -- Enable automatic indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Automatically indent new lines
vim.opt.shiftwidth = 4     -- Number of spaces used for each indentation step
vim.opt.softtabstop = 4
vim.opt.tabstop = 4        -- number of spaces a tab counts for
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
--- MOTIONS ---
---------------
vim.keymap.set("n", "j", "jzz", { desc = "Move down and vertically center" })
vim.keymap.set("n", "k", "kzz", { desc = "Move up and vertically center" })

---------------
---NVIM-TREE---
---------------
-- disable netrw (nvim built in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Optionally enabled 24-bit colour
vim.opt.termguicolors = true

--------------------------------
---ACTIVE WINDOW HIGHLIGHTING---
--------------------------------
local function darken_color(hex, percent)
    local r = math.floor(tonumber(tostring(hex):sub(2, 3), 16) * percent)
    local g = math.floor(tonumber(tostring(hex):sub(4, 5), 16) * percent)
    local b = math.floor(tonumber(tostring(hex):sub(6, 7), 16) * percent)
    return string.format("#%02x%02x%02x", r, g, b)
end

local normal_hl = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("StatusLine")), "bg")
local active_bg = normal_hl and darken_color(normal_hl, 0.9) or "#222222"

-- Apply highlight groups dynamically
vim.api.nvim_set_hl(0, "NormalActive", { bg = active_bg })
vim.api.nvim_set_hl(0, "InactiveWindow", { bg = normal_hl })

-- Apply winhighlight
vim.cmd([[set winhighlight=Normal:NormalActive,NormalNC:InactiveWindow]])

--------------
---QUICKFIX---
--------------
-- vim.keymap.set("n", "<leader>h", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
-- vim.keymap.set("n", "<leader>;", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })
-- vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Forward location list" })
-- vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Backward location list" })

--------------
---TERMINAL---
--------------
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end

    vim.cmd("normal i")
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set({ "n", "t" }, "<C-_>", toggle_terminal)
