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

function Ball:update(dt, screen)
    self.position.x = self.position.x + self.speed.x * dt
    self.position.y = self.position.y + self.speed.y * dt

    self:bounce(screen)
end

function Ball:bounce(screen)
    for v, d in pairs{ x = screen.getWidth(), y = screen.getHeight() } do
        self:bounce_axis(v, d)
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
