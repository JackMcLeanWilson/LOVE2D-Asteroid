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
    obj.lifespan = 2
    obj.width = 6
    obj.height = 1

    -- Sprites
    obj.sprite = love.graphics.newImage("assets/sprites/laser.png")

    obj.timer = 0

    return obj
end

function Laser:update(dt)

	-- Update Position
    self.x = self.x + math.cos(self.rotation) * self.speed * dt
    self.y = self.y + math.sin(self.rotation) * self.speed * dt

	-- Update Lifespan
    self.lifespan = self.lifespan - 0.1 * dt

    -- Check lifespan
    self.timer = self.timer + dt
    if self.timer >= self.lifespan then
        self.isGone = true
    end

    -- Check bounds (Loop)
    if self.x > (love.graphics.getWidth() + 10) then
        self.x = -5
    elseif self.x < -10 then
        self.x = love.graphics.getWidth()
    end

    if self.y > (love.graphics.getHeight() + 10) then
        self.y = -5
    elseif self.y < -10 then
        self.y = love.graphics.getHeight()
    end
end

function Laser:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.rotation, 1, 1, self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
end

return Laser
