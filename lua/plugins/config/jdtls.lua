local export = {}
local M = require("plugins.config.lspconfig")

local path_to_jdtls = "/usr/share/java/jdtls"
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_path = home .. "/.local/share/jdtls/"
local workspace_dir = workspace_path .. project_name

local path_to_jar = vim.fn.glob(path_to_jdtls .. '/plugins/org.eclipse.equinox.launcher_*\\.jar')
local path_to_config = path_to_jdtls .. '/config_linux'

local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
        vim.fn.glob(
                "/home/vincent/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/.*/com.microsoft.java.debug.plugin-*.jar",
                true)
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
        root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml' }),
        on_attach = function(client, buf)
                M.on_attach(client, buf)
        end,
        capabilities = M.capabilities,
        init_options = {
                bundles = bundles,
                extendedClientCapabilities = extendedClientCapabilities
        },
}


config.settings = {
    java = {
      references = {
        includeDecompiledSources = true,
      },
      -- format = {
      --   enabled = true,
      --   settings = {
      --     url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
      --     profile = "GoogleStyle",
      --   },
      -- },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      -- eclipse = {
      -- 	downloadSources = true,
      -- },
      -- implementationsCodeLens = {
      -- 	enabled = true,
      -- },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          -- flags = {
          -- 	allow_incremental_sync = true,
          -- },
        },
        useBlocks = true,
      },
      -- configuration = {
      --     runtimes = {
      --         {
      --             name = "java-17-openjdk",
      --             path = "/usr/lib/jvm/default-runtime/bin/java"
      --         }
      --     }
      -- }
      -- project = {
      -- 	referencedLibraries = {
      -- 		"**/lib/*.jar",
      -- 	},
      -- },
    },
  }


-- require('jdtls').start_or_attach(config)
export.config = config

return export
