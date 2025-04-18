local conform = require("conform")

conform.setup({
        formatters_by_ft = {
                python = { "ruff" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
                go = { "gofmt" },
                cpp = { "clang-format" }
        },
        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
        -- format_on_save = {
        --         lsp_fallback = true,
        --         timeout_ms = 500,
        -- },
})

-- conform.formatters.python = function()
--         local py_root = require("conform.util").root_file({
--                 "setup.py", "pyproject.toml", ".style.yapf", ".git",
--         })
-- end
