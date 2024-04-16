local m = require("core.options")

local jdt_config = require("plugins.config.jdtls")

local map = function(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>df', "<Cmd>lua require'jdtls'.test_class()<CR>")
map('n', '<leader>dn', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>")
map('n', '<leader>ds', ":JdtUpdateDebugConfig<CR>")

require('jdtls').start_or_attach(jdt_config.config)
