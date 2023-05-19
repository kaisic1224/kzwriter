local cmp = require'cmp'
local luasnip = require('luasnip')
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
                { name = 'nvim_lsp', max_item_count = 30, keyword_length = 3, },
                { name = "luasnip" },
                -- { name = "path" },
        }, {
                { name = 'buffer', keyword_length = 3 },
        })
})

-- cmp.setup.cmdline(':', {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = cmp.config.sources({
--                 { name = 'path' }
--         }, {
--                 { name = 'cmdline' }
--         })
-- })
