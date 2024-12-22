return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local api = require("nvim-tree.api")
            vim.keymap.set("n", "<space>e", api.tree.toggle)
            vim.keymap.set("n", "<space>fe", api.tree.focus)

            require("nvim-tree").setup({
                on_attach = my_on_attach,
                view = {
                    width = 40,
                },
            })
        end,
    },
}
