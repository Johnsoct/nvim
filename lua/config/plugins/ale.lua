return {
    {
        "dense-analysis/ale",
        enabled = false,
        config = function()
            local g = vim.g

            g.ale_fixers = {
                css = { "prettier" },
                scss = { "prettier" },
            }

            g.ale_linters = {
                bash = { "shfmt" },
                css = { "stylelint" },
                go = { "golangcilint" },
                html = { "htmlhint" },
                javascript = { "eslint" },
                json = { "jsonlint" },
                lua = { "luacheck" },
                markdown = { "markdownlint" },
                scss = { "stylelint" },
                typescript = { "eslint" },
                vue = { "eslint" },
            }
        end,
    },
}
