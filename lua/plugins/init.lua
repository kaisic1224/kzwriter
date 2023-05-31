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
                event = { "VeryLazy" },
                config = function()
                        require("plugins.config.autopairs") 
                end
        },

        -- lsp stuffs --
        {
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
        },
        {
                'hrsh7th/nvim-cmp',
                lazy = true,
                event = "InsertEnter",
                config = function()
                        require("plugins.config.cmp")
                end
        },
        {
                'neovim/nvim-lspconfig',
                lazy = true,
                event = { "BufReadPre", "BufNewFile" },
                config = function()
                        require("plugins.config.lspconfig")
                end
        },
        {
                'simrat39/rust-tools.nvim',
                dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim"},
                name = "rust-tools",
                ft = "rust",
                opts = function()
                        return require("plugins.config.rust-tools")
                end,
                config = function(_, opts)
                        local rt = require("rust-tools")
                        rt.setup(opts)
                        rt.hover_actions.hover_actions()
                end
        },
        -- Bufferline --
        {
                'akinsho/bufferline.nvim',
                name = 'bufferline',
                event = { "BufWinEnter" },
                priority = 1000,
                config = function()
                        require("plugins.config.bufferline")
                end
        },
        -- debugger --
        {
                'mfussenegger/nvim-dap',
                -- lazy = false,
                -- config = function()
                --         require("plugins.config.dap")
                -- end

        },
        {
                'kevinhwang91/nvim-ufo',
                dependencies = { 'kevinhwang91/promise-async' },
                init = function()
                        vim.o.foldcolumn = '1' -- '0' is not bad
                        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
                        vim.o.foldlevelstart = 99
                        vim.o.foldenable = true
                end,
                config = function() 
                        require('ufo').setup({
                                preview = {
                                        mappings = {
                                                scrollU = '<C-u>',
                                                scrollD = '<C-d>',
                                        }
                                }
                        })
                end
        },
        -- comments
        {
                'numToStr/Comment.nvim',
                lazy = true,
                keys = { "gcc" },
                config = function()
                        require('Comment').setup()
                end

        },
        -- better escape --
        {
                "max397574/better-escape.nvim",
                name = "better-escape",
                lazy = false,
                config = function()
                        require("plugins.config.better-escape")
                end
        },
        {
                "mg979/vim-visual-multi",
                name = "visual-multi",
                lazy = true,
                keys = { "<C-n>", desc = "visual-multi" },
        },

        -- Nvim tree file viewer --

        {
                'nvim-tree/nvim-tree.lua',
                name = 'nvim-tree',
                cmd = { "NvimTreeToggle", "NvimTreeFocus" },
                config = function()
                        require("plugins.config.nvim-tree")
                end
        },

        -- Telescope stuffs -- 
        {
                'alvarosevilla95/telescope.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
                name = 'telescope',
                lazy = true,
                cmd = { "Telescope" },
                config = function()
                        require('telescope').setup{}
                end
        },

        -- Treesitter stuffs --
        {
                'nvim-treesitter/nvim-treesitter',
                name = 'treesitter',
                cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
                event = { "BufNewFile", "BufReadPre" },
                build = ":TSUpdate",
                lazy = true,
                config = function()
                        require("plugins.config.treesitter")
                end
        },

        -- Statusline (staline) --
        -- {
        --         'tamton-aquib/staline.nvim',
        --         lazy = true,
        --         name = 'staline',
        --         events = { "BufWinEnter" },
        --         config = function()
        --                 require("plugins.config.staline")
        --         end
        -- },

        -- gitsigns stuffs --
        {
                'lewis6991/gitsigns.nvim',
                name = 'gitsigns',
                lazy = true,
                event = { "BufWritePre", "BufReadPre" },
                config = function()
                        require("plugins.config.gitsigns")
                end
        },
        -- {
        --         'jose-elias-alvarez/null-ls.nvim',
        --         lazy = false,
        --         config = function()
        --                 require("plugins.config.null-ls")
        --         end
        -- },
        {
                'windwp/nvim-ts-autotag',
                name = "ts-autotag",
                lazy = true,
                ft = { "tsx", "jsx", "html", "typescriptreact", "javascriptreact", "svelte" },
                config = function()
                        require('nvim-ts-autotag').setup()
                end
        },
        -- {
        --         'MunifTanjim/prettier.nvim',
        --         lazy = false,
        --         config = function()
        --                 require("plugins.config.prettier")
        --         end
        -- },
        -- {
        --         'nvim-tree/nvim-web-devicons',
        --         lazy = true,
        --         config = function()
        --                 require("plugins.config.icons")
        --         end
        -- }


},{ 
        performance = {
                rtp = {
                        disabled_plugins = {      
                                "2html_plugin",
                                "tohtml",
                                "getscript",
                                "getscriptPlugin",
                                "gzip",
                                "health",
                                "logipat",
                                "man",
                                "matchparen",
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
