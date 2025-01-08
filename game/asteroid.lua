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

	-- Sprites
	local spriteAlt1 = ("sprites/asteroid1.png")
	local spriteAlt2 = ("sprites/asteroid2.png")
	local spriteAlt3 = ("sprites/asteroid3.png")

	-- Set Sprite 
	SetSprite = math.random(3)
	switch (SetSprite) {
		[1] = function()
			obj.sprite = spriteAlt1
		end,

		[2] = function()
			obj.sprite = spriteAlt2
		end,

		[3] = function()
			obj.sprite = spriteAlt3
		end
	}

	-- if SelectSprite == 1 then
	-- 	obj.sprite = spriteAlt1
	-- elseif SelectSprite == 2 then
	-- 	obj.sprite = spriteAlt2
	-- elseif SelectSprite == 3 then
	-- 	obj.sprite = spriteAlt3
	-- end

end

function Asteroid:update(dt)

end

function Asteroid:draw()
	love.graphics.draw(self.sprite, self.x, self.y, self.rotation, self.width / self.sprite:getWidth(), self.height / self.sprite:getHeight(), self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
end
