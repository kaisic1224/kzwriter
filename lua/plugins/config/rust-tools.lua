local M = require("plugins.config.lspconfig")
-- Update this path
local extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.1-universal/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
-- Setup rust_analyzer via rust-tools.nvim
local options = {
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
                on_attach = M.lsp_attach,
                ["rust-analyzer"] = {
                        checkOnSave = {
                                command = "clippy"
                        }	
                },
        },
        dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        }
}

return options
