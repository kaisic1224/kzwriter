local m = require("core.options")

local map = function(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local execute = function()
    return vim.api.nvim_buf_get_name(0)
end

map('n', '<leader>E', ':!python ' ..execute().. "<CR>")
