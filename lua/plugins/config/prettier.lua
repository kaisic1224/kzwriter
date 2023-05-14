local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
  },
    tab_width = 2,
    use_tabs = false,
}

