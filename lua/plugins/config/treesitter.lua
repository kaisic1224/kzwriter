require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the four listed parsers should always be installed)
        ensure_installed = {
                "rust",
                "typescript",
                -- "javascript",
                "html",
                "css",
                "tsx",
                "dockerfile",
                "yaml",
                "json",
                "python",
                "sql",
                -- "vue",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        -- Recommendation: set to false
        auto_install = false,
        highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
        },
}
