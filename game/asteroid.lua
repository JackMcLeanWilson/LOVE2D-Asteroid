local Asteroid = {}
Asteroid.__index = Asteroid

function Asteroid:new(x, y, rotation)
	local obj = {}
    setmetatable(obj, self)
    self.__index = self

	-- Position
	obj.x = x + math.cos(rotation)
    obj.y = y + math.sin(rotation)
	obj.rotation = rotation or 0

	-- Velocity 
	obj.vx = 0
    obj.vy = 0

	-- Asteroid Properties
	obj.level = 1
	
end

function Asteroid:update(dt)

end

function Asteroid:draw()

end
