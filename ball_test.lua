local luaunit = require 'luaunit'

local Ball = require 'ball'

local screen = {
    getWidth = function() return 800 end,
    getHeight = function() return 600 end,
}

TestBall = {}
function TestBall.test_ball_moves()
    local ball = Ball.new {
        radius = 0,
        position = { x = 0, y = 0 },
        speed = { x = 100, y = 200 },
    }

    ball:update(1.5, screen)

    luaunit.assertEquals(ball.position.x, 150)
    luaunit.assertEquals(ball.position.y, 300)
end

function TestBall.test_ball_bounces()
    local cases = {
        {
            initial = { x = 20, y = 20},
            speed = { x = -30, y = 0 },
            final = { x = 30, y = 20 },
        },
        {
            initial = { x = 20, y = 30},
            speed = { x = 0, y = -50 },
            final = { x = 20, y = 40 },
        },
        {
            initial = { x = 780, y = 20 },
            speed = { x = 100, y = 0 },
            final = { x = 700, y = 20 },
        },
        {
            initial = { x = 20, y = 500 },
            speed = { x = 0, y = 200 },
            final = { x = 20, y = 480 },
        }
    }
    for _, case in ipairs(cases) do
        local ball = Ball.new {
            radius = 10,
            position = case.initial,
            speed = case.speed,
        }

        ball:update(0.5, screen)
        ball:update(0.5, screen)

        luaunit.assertEquals(ball.position.x, case.final.x)
        luaunit.assertEquals(ball.position.y, case.final.y)
    end
end

TestBall.paddle_bouncing_cases = {
    { paddle_x = 350, bounced = true, final_y = 430},
    { paddle_x = 100, bounced = false, final_y = 510},
}
for i, case in ipairs(TestBall.paddle_bouncing_cases) do
    TestBall['test_ball_bounces_on_paddle_' .. i] = function()
        local paddle = {
            position = { x = case.paddle_x, y = 480 },
            size = { x = 100, y = 20 },
        }
        local ball = Ball.new {
            radius = 10,
            position = { x = 350, y = 430 },
            speed = { x = 40, y = 40 },
        }
        ball:update(1, screen, paddle)

        -- it should not have bounced
        luaunit.assertIsFalse(ball.speed.y < 0)
        luaunit.assertItemsEquals(ball.position, { x = 390, y = 470 })

        ball:update(1, screen, paddle)

        -- it could have bounced
        luaunit.assertEquals(ball.speed.y < 0, case.bounced)
        luaunit.assertItemsEquals(ball.position, { x = 430, y = case.final_y })
    end
end
