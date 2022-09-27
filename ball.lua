local Ball = {}

function Ball.new(obj)
    obj = obj or {}
    return setmetatable(obj, { __index = Ball })
end

function Ball:draw(graphics)
    graphics.circle(
        'fill',
        self.position.x, self.position.y,
        self.radius
    )
end

function Ball:update(dt, screen, paddle)
    self.position.x = self.position.x + self.speed.x * dt
    self.position.y = self.position.y + self.speed.y * dt

    self:bounce(screen, paddle)
end

function Ball:bounce(screen, paddle)
    self:bound_on_paddle(paddle)
    for v, d in pairs{ x = screen.getWidth(), y = screen.getHeight() } do
        self:bounce_axis(v, d)
    end
end

function Ball:bound_on_paddle(paddle)
    if paddle and self.speed.y > 0 then
        local vertex = paddle.position.y - self.radius
        local below_paddle = self.position.y > vertex
        local between_paddle_edges = paddle.position.x <= self.position.x
            and self.position.x <= paddle.position.x + paddle.size.x
        if below_paddle and between_paddle_edges then
            self.position.y = 2 * vertex - self.position.y
            self.speed.y = -self.speed.y
        end
    end
end

function Ball:bounce_axis(v, max_dimension)
    if self.speed[v] == 0 then return end

    local direction = self.speed[v] < 0 and -1 or 1
    local vertex = direction < 0
        and self.radius
        or max_dimension - self.radius
    if self.position[v] * direction > vertex * direction then
        self.position[v] = 2 * vertex - self.position[v]
        self.speed[v] = -self.speed[v]
    end
end

return Ball
