local m = require("core.options")
local jdt_config = require("plugins.config.jdtls")

require('jdtls').start_or_attach(jdt_config.config)
