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

            -----------------------
            -- Telescope options --
            -----------------------
            ts.setup({
                -- defaults = {
                --     file_ignore_patterns = {
                --         "^node_modules/",
                --     },
                -- },
                extensions = {
                    fzf = {
                        -- Default options
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
                pickers = {
                    -- TODO: help telescioe.builtin.find_files
                    find_files = {
                        hidden = true,
                        theme = "dropdown",
                    },
                },
            })

            -----------------------
            -- Extension Loading --
            -----------------------
            require("telescope").load_extension("fzf")

            -----------------------
            -- Telescope keymaps --
            -----------------------
            local tsff = require("telescope.builtin").find_files
            local tsht = require("telescope.builtin").help_tags
            local tsgs = require("telescope.builtin").grep_string
            local tslg = require("telescope.builtin").live_grep
            local tsbuffers = require("telescope.builtin").buffers
            local tsoldfiles = require("telescope.builtin").oldfiles

            --en*
            vim.keymap.set("n", "<space>en", function()
                tsff({
                    cwd = vim.fn.stdpath("config"),
                })
            end, { desc = "telesceope neovim config files" })

            --f*
            vim.keymap.set("n", "<space><space>", tsht, { desc = "telescope help tags" })
            vim.keymap.set("n", "<space>fb", tsbuffers, { desc = "telescope open buffers" })
            vim.keymap.set("n", "<space>ff", tsff, { desc = "telescope find files" })
            vim.keymap.set("n", "<space>fg", tslg, { desc = "telescope live grep" })
            vim.keymap.set("n", "<space>fo", tsoldfiles, { desc = "telescope open old files" })
            vim.keymap.set("n", "<space>fs", tsgs, { desc = "telescope grep string" })

            --g*
            vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { noremap = true, silent = true })
        end,
    },
}
