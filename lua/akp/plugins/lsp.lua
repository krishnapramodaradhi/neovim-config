return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    opts = {
        capabilities = {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true
                }
            }
        }
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = { 'gopls' }
        })

        local on_attach = function()
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
        end
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local util = require 'lspconfig/util'

        require('lspconfig').gopls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { 'gopls' },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    completeUnimported = true,
                    analyses = {
                        unusedparams = true,
                    }
                }
            }
        }

        require('lspconfig').lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        require('lspconfig').tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        require('lspconfig').html.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        require('lspconfig').cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end
}
