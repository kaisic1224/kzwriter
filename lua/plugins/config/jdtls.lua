local export = {}
local M = require("plugins.config.lspconfig")

local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_path = home .. "/.local/share/jdtls/"
local workspace_dir = workspace_path .. project_name

local config = {
        cmd = {
                -- 💀
                'java', -- or '/path/to/java17_or_newer/bin/java'
                -- depends on if `java` is in your $PATH env variable and if it points to the right version.

                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xmx1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

                -- 💀
                '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                -- Must point to the                                                     Change this to
                -- eclipse.jdt.ls installation                                           the actual version


                -- 💀
                '-configuration', '/usr/share/java/jdtls/config_linux',
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                -- Must point to the                      Change to one of `linux`, `win` or `mac`
                -- eclipse.jdt.ls installation            Depending on your system.


                -- 💀
                -- See `data directory configuration` section in the README
                '-data', workspace_dir
        },
        root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
        init_options = {
                bundles = {
                        vim.fn.glob(
                                "/home/vincent/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.52.0/com.microsoft.java.debug.plugin-0.52.0.jar",
                                1)
                }
        },
        capabilities = M.capabilities,
        on_attach = function(client, buf)
                M.on_attach(client, buf)
        end,
}

-- require('jdtls').start_or_attach(config)
export.config = config

return export
