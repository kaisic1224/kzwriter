local lspconfig = require('lspconfig')
-- Setup buffer-local keymaps / options for LSP buffers
local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
}

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
        filetypes = {"typescript", "typescriptreact", "typescript.tsx", "css", "svelte"},
        cmd = {"tailwindcss-language-server", "--stdio"},
        capabilities = capabilities
}

lspconfig.svelte.setup {
        on_attach = lsp_attach,
        filetypes = {"svelte"},
        cmd = { "svelteserver", "--stdio" },
        capabilities = capabilities
}

return M
