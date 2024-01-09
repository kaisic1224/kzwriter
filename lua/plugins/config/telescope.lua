require("telescope").setup {
        defaults = {
                vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--hidden',
                        '--line-number',
                        '--column',
                },
        },
        pickers = {
                find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
                }
        }
}
