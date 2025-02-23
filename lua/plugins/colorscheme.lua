return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
        -- Default options:
        require("catppuccin").setup {
            flavour = "mocha",
        }
        vim.o.background = "dark"
        vim.cmd.colorscheme("catppuccin")
    end,
}
