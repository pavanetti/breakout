local Paddle = {}

function Paddle.new(obj)
    obj = obj or {}
    obj.speed = obj.speed or {}
    obj.speed.current = obj.speed.current or 0
    obj._keys = {}

    return setmetatable(obj, { __index = Paddle })
end

function Paddle:draw(screen)
    screen.rectangle(
        'fill',
        self.position.x, self.position.y,
        self.size.x, self.size.y
    )
end

function Paddle:update(dt, screen)
    self.position.x = self.position.x + self.speed.current * dt
    self:bound_to_screen(screen)
end

function Paddle:key_pressed(key)
    self._keys[key] = true
    if key == 'right' or key == 'left' then
        self:move(key)
    end
end

function Paddle:key_released(key)
    if key == 'right' or key == 'left' then
        self:stop()
    end

    self._keys[key] = false
    if self._keys.right then self:move('right') end
    if self._keys.left then self:move('left') end
end

---

function Paddle:bound_to_screen(screen)
    local width = screen.getWidth()
    if self.position.x > width - self.size.x then
        self.position.x = width - self.size.x
    end

    if self.position.x < 0 then
        self.position.x = 0
    end
end

function Paddle:move(direction)
    if direction == 'right' then
        self.speed.current = self.speed.default
    end

    if direction == 'left' then
        self.speed.current = -self.speed.default
    end
end

function Paddle:stop()
    self.speed.current = 0
end

return Paddle
