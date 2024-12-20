local M = {};

local set_option = function(option, value)
        if type(vim.o[option]) == 'boolean' or type(vim.o[option]) == 'number' then
                vim.o[option] = value
        else
                vim.o[option] = tostring(value)
        end
end

local set_buffer_option = function(option, value)
        if type(vim.bo[option]) == 'boolean' or type(vim.o[option]) == 'number' then
                vim.bo[option] = value
        else
                vim.bo[option] = tostring(value)
        end
end

local set_window_option = function(option, value)
        if type(vim.wo[option]) == 'boolean' or type(vim.o[option]) == 'number' then
                vim.wo[option] = value
        else
                vim.wo[option] = tostring(value)
        end
end

vim.g.mapleader = " "
vim.g.netrw_banner = 0;
vim.g.vimtex_view_method = 'zathura'
vim.cmd('filetype plugin indent on')
-- disable language provider support (lua and vimscript plugins only)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
-- vim.opts.rocks.hererocks = false
-- vim.o.rocks.enabled = false
-- nvim-ufo

-- cmp
set_option("completeopt", "menu,menuone,noinsert")
set_option('shortmess', vim.o.shortmess .. 'c')
set_option('pumheight', 0)
set_option('fileencoding', 'utf-8')
set_option('cmdheight', 1)
set_option('whichwrap', 'b,s,<,>,[,[,h,l')
set_option('splitbelow', true)
set_option('splitright', true)
set_option('termguicolors', true)
set_option('conceallevel', 0)
set_option('showtabline', 0)
set_option('showmode', false)
set_option('backup', false)
set_option('writebackup', false)
set_option('updatetime', 300)
set_option('timeoutlen', 750)
set_option('clipboard', "unnamedplus")
set_option('hlsearch', false)
set_option('ignorecase', true)
set_option('scrolloff', 3)
set_option('sidescrolloff', 5)
-- set_option('mouse', "")
set_window_option('wrap', false)
set_window_option('number', true)
set_option('relativenumber', true)
set_window_option('signcolumn', "yes")
set_option('tabstop', 4)
set_option('softtabstop', 4)
set_buffer_option('tabstop', 4)
set_option('shiftwidth', 4)
set_buffer_option('shiftwidth', 4)
set_option('autoindent', true)
set_buffer_option('autoindent', true)
set_option('expandtab', true)
set_buffer_option('expandtab', true)
-- export the functions
M.set_option = set_option;
M.set_buffer_option = set_buffer_option;
M.set_window_option = set_window_option;
return M
