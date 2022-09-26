luaunit = require 'luaunit'

require 'ball_test'
require 'paddle_test'

os.exit(luaunit.LuaUnit.run())
