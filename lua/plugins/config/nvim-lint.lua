local lint = require('lint')
local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
        py_path = venv_path .. "/bin/python3"
else
        py_path = vim.g.python3_host_prog
end


lint.linters_by_ft = {
        python = {
                'ruff'
        }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
                lint.try_lint()
        end,
})
