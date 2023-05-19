local lspconfig = require('lspconfig')
-- Setup buffer-local keymaps / options for LSP buffers
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
        vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
        vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
        vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
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
        filetypes = {"typescript", "typescriptreact", "typescript.tsx", "css"},
        cmd = {"tailwindcss-language-server", "--stdio"},
        capabilities = capabilities
}
-- Setup rust_analyzer via rust-tools.nvim
local rt = require("rust-tools")
rt.setup({
        tools = {
                inlay_hints = {
                        auto = true,
                        show_parameter_hints = false,
                        parameter_hints_prefix = "",
                        other_hints_prefix = "",
                }
        },
        server = {
                capabilities = capabilities,
                on_attach = lsp_attach,
                ["rust-analyzer"] = {
                        checkOnSave = {
                                command = "clippy"
                        }	
                }
        }
})

rt.hover_actions.hover_actions()
