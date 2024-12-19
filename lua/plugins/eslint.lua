return {
    {
        "neovim/nvim-lspconfig",
            opts = {
                servers = {
                    eslint = {
                        settings = {
                            workingDirectories = { mode = "auto" },
                            format = auto_format,
                        },
                    },
                },
                setup = {
                    eslint = function(_, opts)
                        -- Disable LSP formatting if you want to use null-ls for formatting
                        opts.on_attach = function(client, bufnr)
                            client.server_capabilities.documentFormattingProvider = false
                        end
                    end,
                },
            },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            local null_ls = require("null-ls")
            opts.sources = opts.sources or {}

            -- Add eslint_d for formatting and diagnostics
            vim.list_extend(opts.sources, {
                null_ls.builtins.formatting.eslint_d.with({
                    -- Only enabled ESLint integration if eslint file is found
                    condition = function(utils)
                        return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js", "eslint.config.js" })
                    end,
                }),
                null_ls.builtins.diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js" , "eslint.config.js" })
                    end,
                }),
            })

            -- Set the timeout for null-ls
            opts.timeout_ms = 5000
        end,
    }
}
