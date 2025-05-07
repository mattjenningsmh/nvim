return {
    "folke/which-key.nvim",
    lazy = true,
    keys = {
        "<leader>"
    },
    event = "VeryLazy",
    config = function()
        require("which-key").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}
