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

        require('lspconfig').templ.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { 'templ', 'lsp' },
            filetypes = { 'templ' },
            root_dir = util.root_pattern('go.work', 'go.mod', '.git')
        }

        require('lspconfig').cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }

        require('lspconfig').tailwindcss.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }


        require('lspconfig').emmet_language_server.setup({
            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
            -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
            -- **Note:** only the options listed in the table are supported.
            init_options = {
                ---@type table<string, string>
                includeLanguages = {},
                --- @type string[]
                excludeLanguages = {},
                --- @type string[]
                extensionsPath = {},
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                preferences = {},
                --- @type boolean Defaults to `true`
                showAbbreviationSuggestions = true,
                --- @type "always" | "never" Defaults to `"always"`
                showExpandedAbbreviation = "always",
                --- @type boolean Defaults to `false`
                showSuggestionsAsSnippets = false,
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                syntaxProfiles = {},
                --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                variables = {},
            },
        })
    end
}
