local Laser = {}
Laser.__index = Laser

function Laser:new(x, y, rotation)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self

    local offset = 20 -- Offset the laser's initial position
    obj.x = x + math.cos(rotation) * offset
    obj.y = y + math.sin(rotation) * offset
    obj.rotation = rotation or 0

    -- Laser properties
    obj.speed = 500
    obj.lifespan = 5
    obj.width = 6
    obj.height = 1

    -- Sprites
    obj.sprite = love.graphics.newImage("assets/sprites/laser.png")

    obj.timer = 0

    return obj
end

function Laser:update(dt)
    self.x = self.x + math.cos(self.rotation) * self.speed * dt
    self.y = self.y + math.sin(self.rotation) * self.speed * dt

    -- Handle lifespan
    self.timer = self.timer + dt
    if self.timer >= self.lifespan then
        self.isGone = true
    end
end

function Laser:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.rotation, 1, 1, self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
end

return Laser
