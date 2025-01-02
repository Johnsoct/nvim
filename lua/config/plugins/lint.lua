return {
    {
        "mfussenegger/nvim-lint",
        enabled = true,
        config = function()
            local lint = require("lint")
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

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

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    print("Configured linter for filetype: ", vim.inspect(lint.linters_by_ft[vim.bo.filetype]))

                    require("lint").try_lint()
                end,
            })

            vim.keymap.set("n", "<space>l", function()
                require("lint").try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
