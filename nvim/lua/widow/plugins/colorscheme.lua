return {
    {
        "folke/tokyonight.nvim",
        lazy = false,  -- make sure it loads at startup
        priority = 1000,  -- make sure to load this before other plugins
        config = function()
            require("tokyonight").setup({
                -- your config here
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    }
}
