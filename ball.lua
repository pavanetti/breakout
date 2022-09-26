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
    self:bounce_x(screen)
    self:bounce_y(screen)
end

function Ball:bounce_x(screen)
    local vertex = self.radius
    if self.position.x < vertex then
        self.position.x = 2 * vertex - self.position.x
        self.speed.x = -self.speed.x
    end

    local vertex = screen.getWidth() - self.radius
    if self.position.x > vertex then
        self.position.x = 2 * vertex - self.position.x
        self.speed.x = -self.speed.x
    end
end

function Ball:bounce_y(screen)
    local vertex = self.radius
    if self.position.y < vertex then
        self.position.y = 2 * vertex - self.position.y
        self.speed.y = -self.speed.y
    end

    local vertex = screen.getHeight() - self.radius
    if self.position.y > vertex then
        self.position.y = 2 * vertex - self.position.y
        self.speed.y = -self.speed.y
    end
end

return Ball
