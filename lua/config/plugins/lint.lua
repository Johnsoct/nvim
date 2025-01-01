return {
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            vim.env.ESLINT_D_PPID = vim.fn.getpid()

            lint.linters_by_ft = {
                bash = { "bash" },
                css = { "stylelint" },
                go = { "golangcilint" },
                html = { "htmlhint" },
                javascript = { "eslint_d" },
                json = { "jsonlint" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                scss = { "stylelint" },
                typescript = { "eslint_d" },
                vue = { "eslint_d" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
