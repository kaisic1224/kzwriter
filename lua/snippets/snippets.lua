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
        -- s("cso", {
        --         t({ '#include "cs136.h"',
        --                 '',
        --                 'int main(void) {',
        --                 '      ' }),
        --         i(1),
        --         t({ '', '',
        --                 '      return 0;',
        --                 '}', })
        -- }, {
        --         key = "c"
        -- }),
        -- s("cst", {
        --         t({ '#include "cs136-trace.h"',
        --                 '',
        --                 'int main(void) {',
        --                 '      ' }),
        --         i(1),
        --         t({ '', '',
        --                 '      return 0;',
        --                 '}', })
        -- }, {
        --         key = "c"
        -- }),
        s("ah", {
                t({ '#include <stdio.h>',
                        '#include <assert.h>',
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
})

local function get_func_signature(_, parent)
    local line_nr = vim.fn.line(".")  -- current line
    local prev_line = vim.api.nvim_buf_get_lines(0, line_nr - 2, line_nr - 1, false)[1] or ""

    -- Match Python function signature
    local func_name, args_str = string.match(prev_line, "def%s+([%w_]+)%s*%(([^)]*)%)")

    -- insert args into table
    local args = {}
    for arg in string.gmatch(args_str, "[^,%s]+") do
        if arg ~= "self" then
            table.insert(args, arg)
        end
    end


    return func_name, args
end


-- Dynamic node that generates the docstring
local function generate_docstring(_, _, _)
  local name, args = get_func_signature()
  -- if not name then
  --   return sn(nil, { t("No function found above cursor") })
  -- end

  local nodes = {}

  local arg_line = table.concat(args, ", ")

  table.insert(nodes, t(name .. "(" .. arg_line .. ") "))
  table.insert(nodes, i(1, "does something"))
  table.insert(nodes, t({"", "Effects: "}))
  table.insert(nodes, i(2, "Mutates ..."))
  -- Insert nodes for types
  table.insert(nodes, t({"", name .. "("}))
  for idx, arg in ipairs(args) do
    table.insert(nodes, i(idx + 2, "<" .. arg .. ">"))
    if idx < #args then
      table.insert(nodes, t(", "))
    end
  end
  table.insert(nodes, t(") -> "))
  table.insert(nodes, i(#args + 2, "void"))


  local requires_lines = {}
  for idx, arg in ipairs(args) do
      if idx ~= 1 then
        table.insert(requires_lines, "          " .. arg .. ",")
    else
        table.insert(requires_lines, arg)
    end
  end
  -- remove trailing comma from last
  if #requires_lines > 0 then
    requires_lines[#requires_lines] = requires_lines[#requires_lines]:gsub(",$", "")
  end

  table.insert(nodes, t({"", "Requires: "}))
  table.insert(nodes, t(requires_lines))

  table.insert(nodes, t({"", "Examples: ", ""}))

  return sn(nil, nodes)
end

ls.add_snippets("python", {
    s("header", {
        t({ "##",
        "## =======================================================",
        "## CS 234 Spring 2025",
        "## Assignment "}),i(1),t({", P"}),i(2),
        t({'', ''}),
        t({"## =======================================================",
        "##"})
    }, {
        key = "python"
    }),

    s("class", {
        t({"class "}),i(1, "className"), t({":"}),
        t({'', '\t"""'}),
        t({'', "\tFields: "}), i(2, "field (<type>)"),
        t({'', "\tRequires: "}), i(3),
        t({'', '', '\t"""', '', ''}),
        t({}),
        i(0)
    }),

    s("fdoc", {
        t({'"""', ''}),
        d(1, generate_docstring),
        t({'', '"""', ''}),
        i(0)
    })
})
