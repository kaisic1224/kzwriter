local export = {}
local M = require("plugins.config.lspconfig")

local path_to_jdtls = "/usr/share/java/jdtls"
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_path = home .. "/.local/share/jdtls/"
local workspace_dir = workspace_path .. project_name

local path_to_jar = vim.fn.glob(path_to_jdtls .. '/plugins/org.eclipse.equinox.launcher_*\\.jar')
local path_to_config = path_to_jdtls .. '/config_linux'

local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
        vim.fn.glob(
                "/home/vincent/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/.*/com.microsoft.java.debug.plugin-*.jar",
                1)
};

-- This is the new part
-- add vscode-java test suite
-- vim.list_extend(bundles, vim.split(vim.fn.glob("/path/to/microsoft/vscode-java-test/server/*.jar", 1), "\n"))

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
                '-jar', path_to_jar,
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                -- Must point to the                                                     Change this to
                -- eclipse.jdt.ls installation                                           the actual version


                -- 💀
                '-configuration', path_to_config,
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                -- Must point to the                      Change to one of `linux`, `win` or `mac`
                -- eclipse.jdt.ls installation            Depending on your system.


                -- 💀
                -- See `data directory configuration` section in the README
                '-data', workspace_dir
        },
        root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
        on_attach = function(client, buf)
                M.on_attach(client, buf)
        end,
        capabilities = M.capabilities,
        init_options = {
                bundles = bundles,
                extendedClientCapabilities = extendedClientCapabilities
        },
}

-- require('jdtls').start_or_attach(config)
export.config = config

return export
