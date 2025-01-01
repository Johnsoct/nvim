-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file
return {
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            local conform = require("conform")

            conform.setup({
                format_on_save = function(bufnr)
                    -- Disable with a global or buffer-local variable
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end

                    return {
                        -- These options are passed to conform.format()
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
                end,
                formatters_by_ft = {
                    -- Conform will run the first available formatter
                    -- javascript = { "prettierd", "prettier", stop_after_first = true }

                    bash = { "shfmt" },
                    -- css = { "prettierd", "prettier", lsp_format = "fallback" },
                    go = { "goimports", "gofumpt" },
                    html = { "djlint" },
                    javascript = { "eslint_d" },
                    json = { "fixjson" },
                    lua = { "stylua" },
                    markdown = { "markdownfmt" },
                    -- scss = { "prettierd", "prettier", lsp_format = "fallback" },
                    sql = { "sqlfmt" },
                    typescript = { "eslint_d" },
                    vue = { "eslint_d" },
                },
            })

            -- Custom formatting options
            -- conform.formatters.eslint_d = function(bufnr)
            -- ...
            -- end,
            --
            -- OR you can prepend arguments to the default formatter properties
            -- conform.formatters.eslint_d = {
            -- prepend_args = function(self, ctx)
            -- return { options... }
            -- end,
            -- }

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })
        end,
    },
}
