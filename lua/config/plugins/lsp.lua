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
                    "css-lsp",
                    "eslint-lsp",
                    "html-lsp",
                    "json-lsp",
                    "marksman",
                    "sqls",
                    "stylelint-lsp",
                    "typescript-language-server",
                    "vtsls",
                    "vue-language-server",
                    "yaml-language-server",
                },
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
            require("lspconfig").lua_ls.setup {}

            -- Create autocmd on LspAttach: key config entry point for what the lsp will do in any given buffer
            -- i.e. when we attach a file (Editor) and any given language server
            -- (the lack of a buffer argument inside of the {} for LspAttach implies it happens every single
            -- time we attach a file with a language server
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    -- Does this client actually support formatting, and if it does
                    -- create another autocmd for BufWritePre with a buffer parameter
                    -- (i.e. only listen to these events (textDocument/formatting) inside of this current buffer
                    -- so you're not calling format on an open file that doesn't have an attached LSP)
                    if client:supports_method('textDocument/formatting') then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })
        end,
    }
}
