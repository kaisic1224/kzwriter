local conform = require("conform")

conform.setup({
        formatters_by_ft = {
                python = { "ruff" },
                go = { "gofmt" },
                cpp = { "clang-format" }
        },
        -- formatters = {
        --     clang_format = {
        --         command = "clang-format",
        --         prepend_args = { '--style="{ColumnLimit: 80}"', '--falback-style=LLVM' }
        --     }
        -- },
        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
})
