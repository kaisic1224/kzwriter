-- lua, default settings
require("better_escape").setup {
        -- mapping = {
        --     i = {
        --         j = {
        --            j = "<Esc>"
        --         }
        --     }
        -- }, -- a table with mappings to use
        -- timeout = 300,         -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        -- clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        -- keys = "<Esc>",        -- keys used for escaping, if it is a function will use the result everytime
        -- example(recommended)
        -- keys = function()
        --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
        -- end,
}
