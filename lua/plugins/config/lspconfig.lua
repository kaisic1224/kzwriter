-- local lspconfig = require('lspconfig'

local M = {}

-- Capabilities (cmp-nvim-lsp)
local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = false

-- Buffer-local LSP mappings
local function lsp_attach(client, buf)
  -- Example keymaps; tweak as you like
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf })
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
end

---------------------------------------------------------------------
-- Global defaults for ALL servers (merged with server-specific config)
---------------------------------------------------------------------
vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = lsp_attach,
})

---------------------------------------------------------------------
-- Server-specific configs
---------------------------------------------------------------------

vim.lsp.config("lua_ls", {
  filetypes = { "lua" },
  settings = {
    Lua = {
      format = {
        enable = true,
        -- NOTE: values must be strings for lua_ls defaultConfig
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
})

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
      pythonPath = vim.fn.exepath("python3"),
    },
  },
})

vim.lsp.config("clangd", {
  -- extra clangd-specific settings can go here if you want
})

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  -- Equivalent to old root_pattern("go.work", "go.mod", ".git")
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedParams = true,
      },
    },
  },
})

---------------------------------------------------------------------
-- Enable the configs
---------------------------------------------------------------------
for _, server in ipairs({ "lua_ls", "pyright", "clangd", "gopls" }) do
  vim.lsp.enable(server)
end

-- M.capabilities = capabilities
-- M.on_attach = lsp_attach

return M

