return {
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
            require('cyberdream').setup({
                theme = {
                    saturation = 0,
                },
            })
            vim.cmd.colorscheme("cyberdream")
        end,
    }
}
