local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node


ls.add_snippets("c", {
        s("cso", {
                t({ '#include "cs136.h"',
                        '',
                        'int main(void) {',
                        '      ' }),
                i(1),
                t({ '', '',
                        '      return 0;',
                        '}', })
        }, {
                key = "c"
        }),
        s("cst", {
                t({ '#include "cs136-trace.h"',
                        '',
                        'int main(void) {',
                        '      ' }),
                i(1),
                t({ '', '',
                        '      return 0;',
                        '}', })
        }, {
                key = "c"
        })
})
