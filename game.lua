local Ball = require 'ball'
local Paddle = require 'paddle'

local Game = {}

function Game.default_configs()
    return {
        paddle = {
            size = { x = 100, y = 20 },
            speed = { default = 250 },
        },
        ball = {
            radius = 10,
            speed = { x = 250, y = -250 },
        },
    }
end

function Game._initial_paddle(screen, configs)
    local paddle_size = configs.paddle.size
    local bottom_middle = {
        x = (screen.getWidth() - paddle_size.x) / 2,
        y = screen.getHeight() - paddle_size.y,
    }
    return Paddle.new {
        size = paddle_size,
        position = bottom_middle,
        speed = configs.paddle.speed,
    }
end

function Game._initial_ball(screen, configs)
    local paddle_size = configs.paddle.size
    local radius = configs.ball.radius
    local speed = configs.ball.speed
    return Ball.new {
        radius = radius,
        speed = speed,
        position = {
            x = screen.getWidth() / 2,
            y = screen.getHeight() - paddle_size.y - radius,
        }
    }
end

function Game.initial(screen, configs)
    return Game.new {
        ball = Game._initial_ball(screen, configs),
        paddle = Game._initial_paddle(screen, configs),
    }
end

function Game.new(obj)
    return setmetatable(obj, { __index = Game })
end

function Game:draw(graphics)
    self.ball:draw(graphics)
    self.paddle:draw(graphics)
end

function Game:update(dt, screen)
    if self.running then
        self.ball:update(dt, screen, self.paddle)
        self.paddle:update(dt, screen)
    end
end

function Game:key_pressed(key)
    self.running = true
    self.paddle:key_pressed(key)
end

function Game:key_released(key)
    self.paddle:key_released(key)
end

return Game
