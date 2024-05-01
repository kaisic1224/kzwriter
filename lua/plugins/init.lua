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
        -- {
        --        'rose-pine/neovim',
        --        name = 'rose-pine',
        --        lazy = false,
        --        priority = 1000,
        --        config = function()
        --                vim.cmd('colorscheme rose-pine')
        --        end
        -- },
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
                priority = 10000,
                event = { "VeryLazy" },
                config = function()
                        require("plugins.config.autopairs")
                end
        },

        -- lsp stuffs --
        {
                'hrsh7th/nvim-cmp',
                dependencies = {
                        'L3MON4D3/LuaSnip',
                        'saadparwaiz1/cmp_luasnip',
                        'hrsh7th/cmp-nvim-lsp',
                        'hrsh7th/cmp-buffer',
                        'hrsh7th/cmp-nvim-lsp-signature-help',
                },
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
                'mrcjkb/rustaceanvim',
                name = "rustaceanvim",
                version = '^4',
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "mfussenegger/nvim-dap"
                },
                ft = { "rust" },
                config = function()
                        require("plugins.config.rust-tools")
                end
        },
        -- {
        --         "folke/trouble.nvim",
        --         name = "trouble",
        --         cmd = { "TroubleToggle" },
        --         config = function()
        --                 require('trouble').setup {
        --                         icons = false,
        --                         fold_open = "v",      -- icon used for open folds
        --                         fold_closed = ">",    -- icon used for closed folds
        --                         indent_lines = false, -- add an indent guide below the fold icons
        --                         signs = {
        --                                 -- icons / text used for a diagnostic
        --                                 error = "error",
        --                                 warning = "warn",
        --                                 hint = "hint",
        --                                 information = "info"
        --                         },
        --                         use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        --                 }
        --         end
        -- },
        -- Bufferline --
        -- {
        --         'akinsho/bufferline.nvim',
        --         name = 'bufferline',
        --         event = { "BufWinEnter" },
        --         priority = 1000,
        --         config = function()
        --                 require("plugins.config.bufferline")
        --         end
        -- },
        -- debugger --
        {
                'mfussenegger/nvim-dap',
                name = "nvim-dap",
                lazy = true,
                -- keys = { "<C-b> " },
                config = function()
                        require("plugins.config.dap")
                end

        },
        {
                'kevinhwang91/nvim-ufo',
                name = "nvim-ufo",
                dependencies = { 'kevinhwang91/promise-async' },
                init = function()
                        vim.o.foldcolumn = '1' -- '0' is not bad
                        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
                        vim.o.foldlevelstart = 99
                        vim.o.foldenable = true
                end,
                event = { "BufReadPre", },
                config = function()
                        require('ufo').setup({
                                provider_selector = function(bufnr, filetype, buftype)
                                        return { 'treesitter', 'indent' }
                                end,
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
                lazy = false,
                config = function()
                        require('Comment').setup {}
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

        -- {
        --         'nvim-tree/nvim-tree.lua',
        --         name = 'nvim-tree',
        --         cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        --         config = function()
        --                 require("plugins.config.nvim-tree")
        --         end
        -- },

        -- Telescope stuffs --
        {
                'alvarosevilla95/telescope.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
                name = 'telescope',
                lazy = true,
                cmd = { "Telescope" },
                config = function()
                        require('plugins.config.telescope')
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
        {
                'nvim-treesitter/nvim-treesitter-context',
                name = 'treesitter-context',
                event = { "BufNewFile", "BufReadPre" },
                lazy = true,
                config = function()
                        require('treesitter-context').setup {}
                end,
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
        -- {
        --         'lewis6991/gitsigns.nvim',
        --         name = 'gitsigns',
        --         lazy = true,
        --         event = { "BufWritePre", "BufReadPre" },
        --         config = function()
        --                 require("plugins.config.gitsigns")
        --         end
        -- },
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
                ft = { "tsx", "jsx", "html", "typescriptreact", "javascriptreact", "svelte", "xml", "php" },
                config = function()
                        require('nvim-ts-autotag').setup()
                end
        },
        -- {
        --         'mfussenegger/nvim-lint',
        --         name = 'nvim-lint',
        --         ft = { "python" },
        --         config = function()
        --                 require("plugins.config.nvim-lint")
        --         end
        -- },
        {
                'mfussenegger/nvim-jdtls',
                dependencies = { "mfussenegger/nvim-dap" },
                lazy = true,
        },
        {
                "stevearc/conform.nvim",
                name = "conform.nvim",
                lazy = true,
                ft = { "python", "javscript", "javascriptreact", "typescriptreact", "jsx" },
                config = function()
                        require("plugins.config.formatter")
                end
        },
        -- {
        --         'mhartington/formatter.nvim',
        --         name = 'formatter',
        --         config = function()
        --                 require("plugins.config.formatter")
        --         end
        -- }
        -- {
        --         'nvim-tree/nvim-web-devicons',
        --         lazy = true,
        --         config = function()
        --                 require("plugins.config.icons")
        --         end
        -- }
        {
                'lervag/vimtex',
                name = 'vimtex',
                config = function()
                        require("plugins.config.vimtex")
                end,
                ft = { "tex" },
        }


}, {
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
                                -- "netrw",
                                -- "netrwPlugin",
                                -- "netrwSettings",
                                -- "netrwFileHandlers",
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
