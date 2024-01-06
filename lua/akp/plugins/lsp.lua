return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = { 'gopls' }
        })

        local on_attach = function()
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
        end
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig').gopls.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        require('lspconfig').tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        require('lspconfig').cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end
}
