return {
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true

            local transparent = true

            -- if transparent then
            --     vim.cmd([[
            --         highlight Normal guibg=none
            --         highlight NonText guibg=none
            --         highlight Normal ctermbg=none
            --         highlight NonText ctermbg=none
            --     ]])
            -- end
 
            require('cyberdream').setup({
                theme = {
                    saturation = 0,
                },
                transparent = transparent,
            })
            vim.cmd.colorscheme("cyberdream")
        end,
    }
}
