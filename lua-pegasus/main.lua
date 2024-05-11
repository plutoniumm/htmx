local Pegasus = require 'pegasus'
local Files = require 'pegasus.plugins.files'
local Router = require 'pegasus.plugins.router'


local routes do
  local data = {
    {"Lua", "https://www.lua.org/", "https://www.lua.org/images/logo.gif"},
    {"HTMX", "https://htmx.org/docs", "https://htmx.org/img/htmx_logo.2.png"},
    {"Pegasus", "https://evandrolg.github.io/pegasus.lua/", "https://evandrolg.github.io/pegasus.lua/pegasus.lua.svg"},
  }

  local html = [[ <ul> %s </ul> ]]
  local list = ""
  for _, v in ipairs(data) do
    list = list .. string.format(
      '<li><img src="%s"><a href="%s">%s</a></li>',
      v[3], v[2], v[1]
    )
  end

  routes = {
    ["/details"] = {
      GET = function(req, resp)
        resp:statusCode(200)
        resp:write(html:format(list))
      end
    }
  }
end


local server = Pegasus:new({
  port = '3000',
  plugins = {
    Files:new {
      location = '/',
    },

    Router:new {
      prefix = "/",
      routes = routes,
    },
  }
})

server:start()