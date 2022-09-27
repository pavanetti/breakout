luaunit = require 'luaunit'

require 'ball_test'
require 'paddle_test'
require 'game_test'

os.exit(luaunit.LuaUnit.run())
