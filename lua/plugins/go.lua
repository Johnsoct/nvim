-- Add Go-specific plugins
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "go" }, -- Add Go to the list of languages to be installed
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {

					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				}, -- Use the Go Language Server Protocol (gopls)
			},
		},
	},
}
