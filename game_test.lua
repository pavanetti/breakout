local luaunit = require 'luaunit'

local Game = require 'game'

local screen = {
    getWidth = function() return 800 end,
    getHeight = function() return 600 end,
}

TestGame = {}

function TestGame.test_inits_paddle_in_the_middle()
    local game = Game.initial(screen, Game.default_configs())
    local paddle = game.paddle

    luaunit.assertEquals(paddle.position.x, 350)
    luaunit.assertEquals(paddle.position.y, 580)
end

function TestGame.test_inits_ball_over_the_paddle()
    local game = Game.initial(screen, Game.default_configs())
    local ball = game.ball

    luaunit.assertEquals(ball.position.x, 400)
    luaunit.assertEquals(ball.position.y, 570)
end

function TestGame.test_moves_paddle()
    local game = Game.initial(screen, Game.default_configs())
    local paddle = game.paddle

    luaunit.assertEquals(paddle.position.x, 350)

    game:key_pressed('left')
    game:update(1, screen)

    luaunit.assertEquals(paddle.position.x, 100)

    game:key_released('left')
    game:update(1, screen)

    luaunit.assertEquals(paddle.position.x, 100)
end

function TestGame.test_starts_game_on_key_pressed()
    local game = Game.initial(screen, Game.default_configs())
    local ball = game.ball
    game:update(1, screen)

    luaunit.assertItemsEquals(ball.position, { x = 400, y = 570 })

    game:key_pressed('?')
    game:update(1, screen)

    luaunit.assertItemsEquals(ball.position, { x = 650, y = 320 })
end
