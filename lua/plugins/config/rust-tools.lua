local M = require("plugins.config.lspconfig")
-- Setup rust_analyzer via rust-tools.nvim

vim.g.rustaceanvim = {
        tools = {
                inlay_hints = {
                        auto = true,
                        show_parameter_hints = false,
                        parameter_hints_prefix = "",
                        other_hints_prefix = "",
                },
                hover_actions = {
                        auto_focus = true,
                },
        },
        server = {
                capabilities = M.capabilities,
                on_attach = function(client, buf)
                        M.on_attach(client, buf)
                end,
                settings = {
                        ["rust-analyzer"] = {
                                checkOnSave = {
                                        command = "clippy"
                                }
                        },
                },
        },
}
