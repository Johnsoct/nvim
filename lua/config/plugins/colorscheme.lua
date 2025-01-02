return {
    {
        -- github.com/folke/tokyonight.nvim (clones the repo into the nvim runtime path)
        -- {
        --     "folke/tokyonight.nvim",
        --     config = function()
        --         vim.cmd.colorscheme("tokyonight-storm")
        --     end,
        -- },
        -- {
        --     "nyoom-engineering/oxocarbon.nvim",
        --     config = function()
        --         vim.opt.background = "dark"
        --         vim.cmd.colorscheme("oxocarbon")
        --     end,
        -- },
        {
            "scottmckendry/cyberdream.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("cyberdream")

                local transparent = true

                if transparent then
                    vim.cmd([[
                        highlight Normal guibg=none
                        highlight NonText guibg=none
                        highlight Normal ctermbg=none
                        highlight NonText ctermbg=none
                    ]])
                end

                require("cyberdream").setup({
                    cache = false, -- improve start up time by caching highlights
                    theme = {
                        variant = "default",
                        saturation = 0.33,
                    },
                    transparent = transparent,
                })

                -- The event data property will contain a string with either "default" or "light" respectively
                vim.api.nvim_create_autocmd("User", {
                    pattern = "CyberdreamToggleMode",
                    callback = function(event)
                        -- Your custom code here!
                        -- For example, notify the user that the colorscheme has been toggled
                        print("Switched to " .. event.data .. " mode!")
                    end,
                })
            end,
        },
        -- {
        --     "catppuccin/nvim",
        --     name = "catppuccin",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd.colorscheme("catppuccin")
        --
        --         require("catppuccin").setup({
        --             transparent_background = true,
        --             dim_inactive = {
        --                 enabled = true,
        --                 shade = "dark",
        --                 percentage = 0.15,
        --             },
        --         })
        --     end,
        -- },
    },
}
