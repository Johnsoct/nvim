return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                bash = { "bash" },
                css = { "stylelint" },
                go = { "golangcilint" },
                html = { "htmlhint" },
                javascript = { "eslint_d" },
                json = { "jsonlint" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                sass = { "stylelint" },
                scss = { "stylelint" },
                typescript = { "eslint_d" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
