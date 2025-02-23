return {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    init = function()
        -- Reserve a space in the gutter
        vim.opt.signcolumn = 'yes'
    end,
    config = function()
        -- Change the Diagnostic symbols in the sign column (gutter)
        vim.diagnostic.config({
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = '✘',
                [vim.diagnostic.severity.WARN] = '▲',
                [vim.diagnostic.severity.HINT] = '⚑',
                [vim.diagnostic.severity.INFO] = '»',
              },
            },
        })

        -- Add autocompletion capabilities
        local lsp_defaults = require('lspconfig').util.default_config

        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        lsp_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lsp_defaults.capabilities,
            require('blink.cmp').get_lsp_capabilities()
        )

        -- Executes the callback function every time a
        -- language server is attached to a buffer.
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP Actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                opts.desc = "LSP: Show hover information"
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

                opts.desc = "LSP: [g]o to [d]efinitions"
                vim.keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>', opts)

                opts.desc = "LSP: [g]o to [D]eclaration"
                vim.keymap.set('n', 'gD', '<cmd>FzfLua lsp_declarations jump_to_single_result=true ignore_current_line=true<cr>', opts)

                opts.desc = "LSP: [g]o to [i]mplementation"
                vim.keymap.set('n', 'gi', '<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>', opts)

                opts.desc = "LSP: [g]o to type definiti[o]n"
                vim.keymap.set('n', 'go', '<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>', opts)

                opts.desc = "LSP: [g]o to [r]eferences"
                vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<cr>', opts)

                opts.desc = "LSP: [g]o to [s]ignature"
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

                opts.desc = "LSP: [c]ode [r]ename symbol"
                vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

                opts.desc = "LSP: Select [c]ode [a]ction"
                vim.keymap.set('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions', opts)
            end,
        })
    end
}
