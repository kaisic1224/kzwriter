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
  -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
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


local uv = vim.uv

local function exists(p) return uv.fs_stat(p) ~= nil end

local cwd = uv.cwd()
local venv_python = cwd .. "/.venv/bin/python"

local python_settings = {
  analysis = {
    typeCheckingMode = "basic",
    autoSearchPaths = true,
    diagnosticMode = "openFilesOnly",
    useLibraryCodeForTypes = true,
  },
}

if exists(venv_python) then
  python_settings.pythonPath = venv_python
  python_settings.venvPath = cwd
  python_settings.venv = ".venv"
end

vim.lsp.config("pyright", {
  -- filetypes = { "python" },
  -- root_dir = function(bufnr)
  --   local fname = vim.api.nvim_buf_get_name(bufnr)
  --   return vim.fs.root(fname, { ".git", "pyproject.toml", "requirements_lock.txt", "WORKSPACE", "MODULE.bazel" })
  -- end,

  -- before_init = function(_, config)
  --   local root = config.root_dir
  --   if root then
  --     local py = root .. "/.venv/bin/python"
  --     if vim.uv.fs_stat(py) then
  --       config.settings = config.settings or {}
  --       config.settings.python = config.settings.python or {}
  --       config.settings.python.pythonPath = py
  --       config.settings.python.venvPath = root
  --       config.settings.python.venv = ".venv"
  --     end
  --   end
  -- end,

  settings = {
      python = python_settings
  }
  -- settings = {
  --   python = {
  --     analysis = {
  --       typeCheckingMode = "basic",
  --       autoSearchPaths = true,
  --       diagnosticMode = "openFilesOnly",
  --       useLibraryCodeForTypes = true,
  --     },
  --   },
  -- },
})

vim.lsp.config("clangd", {
  -- extra clangd-specific settings can go here if you want
  filetypes = {"c"}
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

