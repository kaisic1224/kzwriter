local lspconfig = require('lspconfig')
-- Setup buffer-local keymaps / options for LSP buffers
local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_attach = function(client, buf)
        local opts = { noremap = true, silent = true }
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
        filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
        cmd = { "typescript-language-server", "--stdio"},
        capabilities = capabilities
}

lspconfig.tailwindcss.setup {
        on_attach = lsp_attach,
        filetypes = {"typescriptreact", "typescript.tsx", "css", "svelte"},
        cmd = {"tailwindcss-language-server", "--stdio"},
        capabilities = capabilities
}

lspconfig.svelte.setup {
        on_attach = lsp_attach,
        filetypes = {"svelte"},
        cmd = { "svelteserver", "--stdio" },
        capabilities = capabilities
}

local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
        py_path = venv_path .. "/bin/python3"
else
        py_path = vim.g.python3_host_prog
end

lspconfig.pyright.setup {
        on_attach = lsp_attach,
        filetypes = {"python"},
        cmd = { "pyright-langserver", "--stdio" },
        capabilities = capabilities,
        settings = {
                python = {
                        analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = true,
                                typeCheckingMode = 'basic',
                                -- stubPath = vim.fn.stdpath("data") .. "/site/p"
                        },
                }
        }
}


M.capabilities = capabilities;
M.on_attach = lsp_attach;

return M
