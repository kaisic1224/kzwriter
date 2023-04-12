vim.g.mapleader = " "

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

-- Normal mode other keys
map('n', '<C-s>', ':w <CR>')
map('n', '<C-q>', ':bd!<CR>')

-- Bufferline 
map('n', '<TAB>', ':BufferLineCycleNext<CR>')
map('n', '<S-TAB>', ':BufferLineCyclePrev<CR>')

-- Nvim tree
map('n', '<leader>a', ':NvimTreeToggle<CR>')
map('n', '<leader>af', 'NvimTreeFocus<CR>')

-- Telescope
map('n', '<leader>F', ':Telescope find_files <CR>')
map('n', '<leader>fl', ':Telescope live_grep <CR>')
map('n', '<leader>b', ':Telescope buffers<CR>')

-- Window splitting
map('n', '<leader>v', ':vsplit<CR>')
map('n', '<leader>h', ':split<CR>')
map('n', '<leader>x', '<C-w>c')


-- Extras
map('n', '<C-c>', ':%y+<CR>')
