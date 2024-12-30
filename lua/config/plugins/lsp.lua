return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "css_variables",
                    "cssmodules_ls",
                    "gopls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "somesass_ls",
                    "sqlls",
                    "sqls",
                    "stylelint_lsp",
                    "ts_ls",
                    "volar",
                },
            })

            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({})
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["vtsls"] = function()
                -- require("vtsls").setup {}
                -- end
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lsp = require("lspconfig")

            lsp.lua_ls.setup({ capabilities = capabilities })
            lsp.ts_ls.setup({
                on_attach = function(client, bufnr)
                    -- Disable tsserver's own diagnostics
                    client.handlers["textDocument/publishDiagnostics"] = function() end
                end,
            })
            lsp.cssmodules_ls.setup({
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "css",
                    "scss",
                    "sass",
                },
                -- on_attach = function(client)
                --     -- avoid race conditions with other LSPs, such as ts_ls, for go-to-definition support
                --     client.server_capabilities.definitionProvider = false
                -- end,
            })
            lsp.custom_elements_ls.setup({
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            })

            -- Create autocmd on LspAttach: key config entry point for what the lsp will do in any given buffer
            -- i.e. when we attach a file (Editor) and any given language server
            -- (the lack of a buffer argument inside of the {} for LspAttach implies it happens every single
            -- time we attach a file with a language server
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    -- Does this client actually support formatting, and if it does
                    -- create another autocmd for BufWritePre with a buffer parameter
                    -- (i.e. only listen to these events (textDocument/formatting) inside of this current buffer
                    -- so you're not calling format on an open file that doesn't have an attached LSP)
                    if client:supports_method("textDocument/formatting") then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })

            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
        end,
    },
}
