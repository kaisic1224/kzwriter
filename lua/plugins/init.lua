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
        -- Autopairings --
        {
                'windwp/nvim-autopairs',
                name = 'nvim-autopairs',
                event = { "InsertEnter" },
                config = function()
                        require("nvim-autopairs").setup({
                            disable_filetype = { "TelescopePrompt" , "vim" },
                            fast_wrap = {},
                        })
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
                        -- 'hrsh7th/cmp-nvim-lsp-signature-help',
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
                "folke/trouble.nvim",
                name = "trouble",
                cmd = { "TroubleToggle" },
                config = function()
                        require('trouble').setup {
                                icons = false,
                                fold_open = "v",      -- icon used for open folds
                                fold_closed = ">",    -- icon used for closed folds
                                indent_lines = false, -- add an indent guide below the fold icons
                                signs = {
                                        -- icons / text used for a diagnostic
                                        error = "error",
                                        warning = "warn",
                                        hint = "hint",
                                        information = "info"
                                },
                                use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
                        }
                end
        },
        -- debugger --
        {
                'mfussenegger/nvim-dap',
                name = "nvim-dap",
                cmd = { "DapToggleBreakpoint", "DapContinue", "DapTerminate" },
                config = function()
                        require("plugins.config.dap")
                end

        },
        {
                'kevinhwang91/nvim-ufo',
                name = "nvim-ufo",
                dependencies = { 'kevinhwang91/promise-async' },
                event = { "VeryLazy" },
                init = function ()
                    vim.o.foldcolumn = '1' -- '0' is not bad
                    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
                    vim.o.foldlevelstart = 99
                    vim.o.foldenable = true
                end,
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
        -- {
        --         'numToStr/Comment.nvim',
        --         event = { "BufNewFile", "BufReadPre" },
        --         config = function()
        --                 require('Comment').setup {}
        --         end
        -- },
        -- {
        --         "mg979/vim-visual-multi",
        --         name = "visual-multi",
        --         lazy = true,
        --         keys = { "<C-n>", desc = "visual-multi" },
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
        {
                'mfussenegger/nvim-lint',
                name = 'nvim-lint',
                ft = { "python" },
                config = function()
                        require("plugins.config.nvim-lint")
                end
        },
        {
                "stevearc/conform.nvim",
                name = "conform.nvim",
                event = { "BufNewFile", "BufReadPre" },
                config = function()
                        require("plugins.config.formatter")
                end
        },
        {
                'lervag/vimtex',
                name = 'vimtex',
                ft = { "tex" },
        },
        {
            'williamboman/mason.nvim',
            name = 'mason',
            config = function()
                require("plugins.config.mason")
            end,
            -- cmd = { "Mason" }
        },
    },
    {
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
                                "shada",
                                "spellfile",
                                "editorconfig"
                        },
                },
        },
}
)
