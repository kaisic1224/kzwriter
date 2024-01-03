local lspconfig = require('lspconfig')
-- Setup buffer-local keymaps / options for LSP buffers
local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_attach = function(client, buf)
        -- local opts = { noremap = true, silent = true }
        -- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
        -- or a plugin like which-key.nvim
        -- <lhs>        <rhs>                        <desc>
        -- "K"          vim.lsp.buf.hover            "Hover Info"
        -- "<leader>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
        -- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
        -- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
        -- "<leader>e"  vim.diagnostic.open_float    "Explain Diagnostic"
        -- "<leader>ca" vim.lsp.buf.code_action      "Code Action"
        -- "<leader>cr" vim.lsp.buf.rename           "Rename Symbol"
        -- "<leader>fs" vim.lsp.buf.document_symbol  "Document Symbols"
        -- "<leader>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
        -- "<leader>gq" vim.lsp.buf.formatting_sync  "Format File"
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf })
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
        -- vim.keymap.set("n", "<leader>fs", vim.lsp.buf.document_symbol, { buffer = buf })

        if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_command [[augroup Format]]
                vim.api.nvim_command [[autocmd! * <buffer>]]
                vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
                vim.api.nvim_command [[autogroup END]]
        end
end


lspconfig.tsserver.setup {
        on_attach = lsp_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
        capabilities = capabilities
}

lspconfig.tailwindcss.setup {
        on_attach = lsp_attach,
        filetypes = { "typescriptreact", "typescript.tsx", "css", "svelte" },
        root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'postcss.config.js'),
        cmd = { "tailwindcss-language-server", "--stdio" },
        capabilities = capabilities
}

lspconfig.svelte.setup {
        on_attach = lsp_attach,
        filetypes = { "svelte" },
        cmd = { "svelteserver", "--stdio" },
        capabilities = capabilities
}

lspconfig.lua_ls.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        filetypes = { "lua" },
        settings = {
                Lua = {
                        format = {
                                enable = true,
                                -- Put format options here
                                -- NOTE: the value should be STRING!!
                                defaultConfig = {
                                        indent_style = "space",
                                        indent_size = "2",
                                }
                        },
                }
        }
}

-- local function get_python_path(path)
--         conda = vim.env.CONDA_PREFIX
--         if conda then
--                 return path .. path.join(conda, "lib", "python3.11", "site-packages")
--         end
-- end


-- lspconfig.pylsp.setup {
--         before_init = function(_, config)
--                 config.settings.python.pythonPath = get_python_path('/home/vincent/miniconda3/envs/nvim/bin/pylsp:')
--                 vim.g.python3_host_prog = '/home/vincent/miniconda3/envs/nvim/bin/python'
--         end,
--         on_attach = lsp_attach,
--         capabilities = capabilities,
--         filetypes = { "python" },
--         cmd = { "/home/vincent/miniconda3/envs/nvim/bin/pylsp" },
--         settings = {
--                 pylsp = {
--                         plugins = {
--                                 pycodestyle = {
--                                         ignore = { 'W391' },
--                                         maxLineLength = 140
--                                 },
--                                 jedi_completion = { fuzzy = true },
--                         }
--                 }
--         }
-- }

lspconfig.pyright.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        cmd = { "/home/vincent/miniconda3/envs/nvim/bin/pyright-langserver", "--stdio" },
        settings = {
                python = {
                        analysis = {
                                typeCheckingMode = "basic",
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = true
                        },
                        pythonPath = vim.fn.exepath("python3")
                }
        }
}

M.capabilities = capabilities;
M.on_attach = lsp_attach;
return M
