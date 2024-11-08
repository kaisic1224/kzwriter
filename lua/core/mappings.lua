local map = function(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Navigation keys in insert mode
map('i', '<C-h>', '<Left>')
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-l>', '<Right>')
-- map('i', '<C-e>', '<End>')

-- Normal mode other keys
-- map('n', '<C-s>', ':w <CR>')
map('n', '<C-q>', ':bd!<CR>')
-- map('n', '<A-j>', ':move +1 <CR>')
-- map('n', '<A-k>', ':move -2 <CR>')

-- Formatting
map('n', "<leader>gq", ":lua require('conform').format()<CR>")

-- Visual mode other keys
-- moving highlighted block of text
-- map('x', '<A-j>', '$o0djp1v')
-- map('x', '<A-k', '$o0dkkp1v')
-- surrounding in quotes
-- map('x', '<S-s>', ':s/\\%V\\(.*\\)\\%V/"\\1"/<CR>')
-- map('x', '(', ':s/\\%V\\(.*\\)\\%V/(\\1)/<CR>')

-- Bufferline
map('n', '<TAB>', ':bnext<CR>')
map('n', '<S-TAB>', ':bprevious<CR>')

-- Nvim tree
-- map('n', '<leader>a', ':NvimTreeToggle<CR>')
map('n', '<leader>a', ':Explore<CR>')

-- TreeSitter
-- map("n", "[c", ":lua require('treesitter-context').go_to_context()<CR>")
-- map("x", "[c", ":lua require('treesitter-context').go_to_context()<CR>")

-- Telescope
map('n', '<leader>F', ":Telescope find_files<CR>")
map('n', '<leader>fl', ':Telescope live_grep<CR>')

-- Window splitting
map('n', '<leader>v', ':vsplit<CR>')
map('n', '<leader>h', ':split<CR>')
-- map('n', '<leader>x', '<C-w>c')

-- Debugging
map('n', '<leader>bb', ':DapToggleBreakpoint<CR>')
map('n', '<leader>c', ':DapContinue<CR>')
map('n', '<leader>dx', ':DapTerminate<CR>')
map('n', '<leader>do', ':DapStepOver<CR>')
map('n', '<leader>dt',
        ':lua local widgets = require("dap.ui.widgets"); local sidebar = widgets.sidebar(widgets.scopes); sidebar.open()<CR>')

-- Trouble nvim
-- map('n', '<leader>xd', ':TroubleToggle quickfix<CR>')
