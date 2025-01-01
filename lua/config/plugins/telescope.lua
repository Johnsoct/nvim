return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local ts = require("telescope")
            local tsbiff = require("telescope.builtin").find_files
            local tsbiht = require("telescope.builtin").help_tags
            local tsgs = require("telescope.builtin").grep_string

            -----------------------
            -- Telescope options --
            -----------------------
            ts.setup({
                defaults = {
                    file_ignore_patterns = {
                        "^node_modules/",
                    },
                },
                extensions = {
                    fzf = {},
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                    },
                },
            })

            -----------------------
            -- Telescope keymaps --
            -----------------------
            vim.keymap.set("n", "<space><space>", tsbiht) -- find help documentation
            vim.keymap.set("n", "<space>fs", tsgs)        -- find help documentation
            vim.keymap.set("n", "<space>fd", tsbiff)      -- find within cwd
            vim.keymap.set("n", "<space>en", function()   -- find neovim config files
                tsbiff({
                    cwd = vim.fn.stdpath("config"),
                })
            end)
            vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { noremap = true, silent = true })
        end,
    },
}
