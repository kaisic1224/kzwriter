local dap = require('dap')
dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
                -- CHANGE THIS to your path!
                command = '/usr/bin/codelldb',
                args = { "--port", "${port}" },

                -- On windows you may have to uncomment this:
                -- detached = false,
        }
}

dap.configurations.c = {
        {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
        },
}

-- dap.configurations.java = {
--         {
--                 -- You need to extend the classPath to list your dependencies.
--                 -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
--                 -- classPaths = {},
--
--                 -- If using multi-module projects, remove otherwise.
--                 -- projectName = "yourProjectName",
--
--                 javaExec = "java",
--                 -- mainClass = "your.package.name.MainClassName",
--
--                 -- If using the JDK9+ module system, this needs to be extended
--                 -- `nvim-jdtls` would automatically populate this property
--                 -- modulePaths = {},
--                 name = "Launch YourClassName",
--                 request = "launch",
--                 type = "java"
--         },
-- }

dap.configurations.rust = dap.configurations.c
