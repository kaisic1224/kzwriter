local cmp = require'cmp'
local luasnip = require('luasnip')
local lspconfig = require('lspconfig')
vim.opt.completeopt = "menu,menuone,noinsert"
local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
cmp.setup({
        snippet = {
                expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
        },
        mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                                cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                        elseif has_words_before() then
                                cmp.complete()
                        else
                                fallback()
                        end
                end, { "i", "s" }),         
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                                cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                        else
                                fallback()
                        end
                end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp', max_item_count = 30, keyword_length = 6, },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "path" },
        }, {
                { name = 'buffer', keyword_length = 3 },
        })
})

cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
                { name = 'path' }
        }, {
                { name = 'cmdline' }
        })
})

-- Setup buffer-local keymaps / options for LSP buffers
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
}
local lsp_attach = function(client, buf)
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
require("rust-tools").setup({
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
