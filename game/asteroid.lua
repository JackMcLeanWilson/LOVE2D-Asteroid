local Asteroid = {}
Asteroid.__index = Asteroid

local function switch(value)
	return function(cases)
		setmetatable(cases, cases)
		
		local f = cases[value]
		if f then
			f()
		end
	end
end

function Asteroid:new()
	local obj = {}
    setmetatable(obj, self)
    self.__index = self

	-- Position
	obj.x = nil
	while obj.x == nil or (obj.x > 350 and obj.x < 550) do
		obj.x = math.random(900)
	end

	obj.y = math.random(900)

	-- Velocity 
	obj.vx = math.random(-50, 50)
	obj.vy = math.random(-50, 50)

	-- Asteroid Properties
	obj.level = 1

	-- Sprites
	local spriteAlt1 = love.graphics.newImage("sprites/asteroid1.png")
	local spriteAlt2 = love.graphics.newImage("sprites/asteroid2.png")
	local spriteAlt3 = love.graphics.newImage("sprites/asteroid3.png")

	SetSprite = math.random(3)
	if SetSprite == 1 then
		obj.sprite = spriteAlt1
	elseif SetSprite == 2 then
		obj.sprite = spriteAlt2
	elseif SetSprite == 3 then
		obj.sprite = spriteAlt3
	end

	obj.width = obj.sprite:getWidth()
	obj.height = obj.sprite:getHeight()

end

function Asteroid:update(dt)

end

function Asteroid:draw()
	love.graphics.draw(self.sprite, self.x, self.y, self.rotation, self.width / self.sprite:getWidth(), self.height / self.sprite:getHeight(), self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
end
