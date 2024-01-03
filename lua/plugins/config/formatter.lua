local util = require("formatter.util")

require("formatter").setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
                typescript = {
                        require("formatter.filetypes.typescript").prettierd
                }
        }
}
