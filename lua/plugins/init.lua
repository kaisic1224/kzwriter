local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then 
        print "Waittt, bootstrapping lazy.nvim ..."
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, 'lazy')
if not ok then return end
lazy.setup({

        -- Colorscheme --
--{
--        'rose-pine/neovim',
--        name = 'rose-pine',
--        lazy = false,
--        priority = 1000,
--        config = function()
--                vim.cmd('colorscheme rose-pine')
--        end
--},
--
{
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = function()
                vim.cmd('colorscheme catppuccin-mocha')
        end
},


-- Autopairings --
{ 
        'windwp/nvim-autopairs',
        name = 'nvim-autopairs',
        lazy = false,
        config = function()
                require("nvim-autopairs").setup()
        end
},
-- lsp stuffs --
{
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'simrat39/rust-tools.nvim',
        'L3MON4D3/LuaSnip',
        'neovim/nvim-lspconfig',
},

{

        'hrsh7th/nvim-cmp',
        config = function()
                require("plugins.config.cmp")
        end


},
{
        'mfussenegger/nvim-jdtls',
        config = function()
                require("plugins.config.jdtls")
        end
},
-- Bufferline --

{

        'akinsho/bufferline.nvim',
        name = 'bufferline',
        lazy = false,
        priority = 1000,
        config = function()
                require("plugins.config.bufferline")
        end
},
-- better escape --
{
        "max397574/better-escape.nvim",
        lazy = false,
        config = function()
                require("plugins.config.better-escape")
        end
},

-- Nvim tree file viewer --

{
        'nvim-tree/nvim-tree.lua',
        name = 'nvim-tree',
        lazy = false,
        config = function()
                require("plugins.config.nvim-tree")
        end
},

-- Telescope stuffs -- 

{
        'nvim-lua/plenary.nvim',
        lazy = true
},

{

        'alvarosevilla95/telescope.nvim',
        name = 'telescope',
        lazy = true,
        priotity = 1000,
        config = function()
                require("plugins.config.telescope")
        end
},

-- Treesitter stuffs --
{
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        lazy = true,
        config = function()
                require("plugins.config.treesitter")
        end
},

-- Statusline (staline) --

{
        'tamton-aquib/staline.nvim',
        name = 'staline',
        lazy = false,
        config = function()
                require("plugins.config.staline")
        end
},

-- Floating terminal --
{
        'akinsho/toggleterm.nvim',
        name = 'toggleterm',
        lazy = false,
        config = function()
                require("plugins.config.term")
        end
},

-- gitsigns stuffs --

{
        'lewis6991/gitsigns.nvim',
        name = 'gitsigns',
        lazy = true,
        config = function()
                require("plugins.config.gitsigns")
        end
},



},{ 
        performance = {
                rtp = {
                        disabled_plugins = {      
                                "2html_plugin",
                                "tohtml",
                                "getscript",
                                "getscriptPlugin",
                                "gzip",
                                "logipat",
                                "netrw",
                                "netrwPlugin",
                                "netrwSettings",
                                "netrwFileHandlers",
                                "matchit",
                                "tar",
                                "tarPlugin",
                                "rrhelper",
                                "spellfile_plugin",
                                "vimball",
                                "vimballPlugin",
                                "zip",
                                "zipPlugin",
                                "tutor",
                                "rplugin",
                                "syntax",
                                "synmenu",
                                "optwin",
                                "compiler",
                                "bugreport",
                                "ftplugin",
                        },
                },
        },                                                                                                                                                                                                                          
}
)                                                                                                                                                                                                                            
