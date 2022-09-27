local Game = require 'game'

local game = Game.initial(love.graphics, Game.default_configs())

function love.draw()
    game:draw(love.graphics)
end

function love.update(dt)
    game:update(dt, love.graphics)
end

function love.keypressed(key)
    if key == 'q' or key == 'escape' then
        love.event.quit()
    end
    game:key_pressed(key)
end

function love.keyreleased(key)
    game:key_released(key)
end
