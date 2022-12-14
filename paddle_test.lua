local luaunit = require 'luaunit'

local Paddle = require 'paddle'

local screen = {
    getWidth = function() return 800 end,
    getHeight = function() return 600 end,
}

TestPaddle = {}
function TestPaddle.test_paddle_moves_horizontally()
    local paddle = Paddle.new {
        size = { x = 50 },
        position = { x = 0, y = 500 },
        speed = { default = 100 },
    }

    paddle:move('right')
    paddle:update(1, screen)

    luaunit.assertEquals(paddle.position.x, 100)

    paddle:move('left')
    paddle:update(0.5, screen)

    luaunit.assertEquals(paddle.position.x, 50)
end

function TestPaddle.test_paddle_stops_on_wall()
    local paddle = Paddle.new {
        size = { x = 50 },
        position = { x = 600, y = 500 },
        speed = { default = 100 },
    }

    paddle:move('right')
    paddle:update(2, screen)

    luaunit.assertEquals(paddle.position.x, 750)

    paddle:move('left')
    paddle:update(10, screen)

    luaunit.assertEquals(paddle.position.x, 0)
end

TestPaddle.handle_keys_cases = {
    { key = 'right', position = 300 },
    { key = 'left', position = 100 },
    { key = 'p', position = 200 },
}
for i, case in ipairs(TestPaddle.handle_keys_cases) do
    TestPaddle['test_paddle_handles_keys_to_move_' .. i] = function()
        local paddle = Paddle.new {
            size = { x = 50 },
            position = { x = 200, y = 500 },
            speed = { default = 100 },
        }

        paddle:key_pressed(case.key)
        paddle:update(1, screen)

        luaunit.assertEquals(paddle.position.x, case.position)

        paddle:key_released(case.key)
        paddle:update(1, screen)

        luaunit.assertEquals(paddle.position.x, case.position)
    end
end

TestPaddle.multiple_key_cases = {
    { seq = {'left', 'right'}, position = 300 },
    { seq = {'right', 'left'}, position = 100 },
}
for i, case in ipairs(TestPaddle.multiple_key_cases) do
    TestPaddle['test_paddle_handles_multiple_keys_' .. i] =  function()
        local paddle = Paddle.new {
            size = { x = 50 },
            position = { x = 200, y = 500 },
            speed = { default = 100 },
        }

        paddle:key_pressed(case.seq[1])
        paddle:key_pressed(case.seq[2])
        paddle:update(1, screen)

        luaunit.assertEquals(paddle.position.x, case.position)
    end
end


TestPaddle.still_pressed_cases = {
    { seq = {'left', 'right'}, position = 100 },
    { seq = {'right', 'left'}, position = 300 },
}
for i, case in ipairs(TestPaddle.still_pressed_cases) do
    TestPaddle['test_paddle_handle_key_still_pressed_' .. i] = function()
        local paddle = Paddle.new {
            size = { x = 50 },
            position = { x = 200, y = 500 },
            speed = { default = 100 },
        }

        paddle:key_pressed(case.seq[1])
        paddle:key_pressed(case.seq[2])
        paddle:key_released(case.seq[2])
        paddle:update(1, screen)

        luaunit.assertEquals(paddle.position.x, case.position)
    end
end
