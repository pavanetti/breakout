local Ball = {}

function Ball.new(obj)
    obj = obj or {}
    return setmetatable(obj, { __index = Ball })
end

function Ball:draw(screen)
    screen.circle(
        'fill',
        self.position.x, self.position.y,
        self.radius
    )
end

function Ball:update(dt, screen)
    self.position.x = self.position.x + self.speed.x * dt
    self.position.y = self.position.y + self.speed.y * dt

    if self.position.x - self.radius < 0 then
        self.position.x = 2 * self.radius - self.position.x
        self.speed.x = -self.speed.x
    end

    if self.position.y - self.radius < 0 then
        self.position.y = 2 * self.radius - self.position.y
        self.speed.y = -self.speed.y
    end

    local sw, sh = screen.getWidth(), screen.getHeight()
    if self.position.x + self.radius > sw then
        self.position.x = 2 * (sw - self.radius) - self.position.x
        self.speed.x = -self.speed.x
    end

    if self.position.y + self.radius > sh then
        self.position.y = 2 * (sh - self.radius) - self.position.y
        self.speed.y = -self.speed.y
    end
end

return Ball
