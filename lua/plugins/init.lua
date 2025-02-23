return {
    "imxdn/neovim",
    priority = 10000,
    lazy = false,
    opts = {},
    cond = true,
    version = "*",
    config = function()
        require("init").setup({})
    end
}
