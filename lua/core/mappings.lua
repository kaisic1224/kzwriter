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
map('n', '<A-j>', ':move +1 <CR>')
map('n', '<A-k>', ':move -2 <CR>')

-- Visual mode other keys
-- moving highlighted block of text
map('x', '<S-l>', 'dp`[1v')
map('x', '<S-h>', 'dhhp`[1v')
map('x', '<S-k>', 'dkp1v')
map('x', '<S-j>', 'djp1v')
map('x', '<A-k>', '$o0dkp1v')
map('x', '<A-j>', '$o0djp1v')

-- Bufferline 
map('n', '<TAB>', ':BufferLineCycleNext<CR>')
map('n', '<S-TAB>', ':BufferLineCyclePrev<CR>')

-- Nvim tree
map('n', '<leader>a', ':NvimTreeToggle<CR>')
-- Telescope
map('n', '<leader>F', ':Telescope find_files<CR>')
map('n', '<leader>fl', ':Telescope live_grep<CR>')

-- Window splitting
map('n', '<leader>v', ':vsplit<CR>')
map('n', '<leader>h', ':split<CR>')
map('n', '<leader>x', '<C-w>c')

-- Debugging
map('n', '<C-b>', ':DapToggleBreakpoint<CR>')
map('n', '<leader>dx', ':DapTerminate<CR>')
map('n', '<leader>do', ':DapStepOver<CR>')
map('n', '<leader>dt', ':lua local widgets = require("dap.ui.widgets"); local sidebar = widgets.sidebar(widgets.scopes); sidebar.open()<CR>')

-- Extras
--map('n', "<C-b>", ":lua require'dap'.toggle_breakpoint()<CR>")
--map('n', "<S-CR>", ":lua require'dap'.continue()<CR>")
--map('n', "<C-bl>", ":lua require'dap'.step_over()<CR>")
--map('n', "<C-bj>", ":lua require'dap'.step_into()<CR>")
