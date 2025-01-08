local Ship = {}

local Laser = require("laser")
Ship.lasers = {}

-- Initialization
function Ship:load()
    -- Position
    self.x = 100
    self.y = 50

    -- Velocity
    self.vx = 0
    self.vy = 0

	self.speed = 0

    -- Acceleration
    self.acceleration = 100
    self.deceleration = 50

    -- Dimensions
    self.width = 20
    self.height = 10
    self.rotation = 0

	--Weapons
	self.shootCooldown = 0

    -- Sprites
    self.spriteNormal = love.graphics.newImage("assets/sprites/ship.png")
    self.spriteMoving = love.graphics.newImage("assets/sprites/shipmove.png")
    self.sprite = self.spriteNormal

    -- Sounds
    self.soundMove = love.audio.newSource("assets/sound/move.wav", "static")
	self.soundMove:setVolume(0) -- Set to 0 because its annoying
	self.soundShoot = love.audio.newSource("assets/sound/shoot.wav", "static")
	self.soundShoot:setVolume(0.2)

    self.isMoving = false
end

function Ship:shoot()
    local laser = Laser:new(self.x, self.y, self.rotation)
    table.insert(self.lasers, laser)
	self.soundShoot:play()
end

function Ship:update(dt)
    -- Rotation Controls
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.rotation = self.rotation + 5 * dt
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.rotation = self.rotation - 5 * dt
    end

    -- Boost Controls
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.vx = self.vx + math.cos(self.rotation) * self.acceleration * dt -- Determines velocity based on current rotation taking into account acceleration
        self.vy = self.vy + math.sin(self.rotation) * self.acceleration * dt

        self.isMoving = true
        self.sprite = self.spriteMoving

        if not self.soundMove:isPlaying() then
            self.soundMove:play()
        end
    else
        self.isMoving = false
        self.sprite = self.spriteNormal

        if self.soundMove:isPlaying() then
            self.soundMove:stop()
        end
    end

	-- Shoot Controls
	if love.keyboard.isDown("space") and self.shootCooldown == 0 then
		self:shoot()
		self.shootCooldown = 1
	end

	-- Laser Update
	self.shootCooldown = math.max(0, self.shootCooldown - dt)

	for i = #self.lasers, 1, -1 do -- Use #self.lasers to get the length of the table
		local laser = self.lasers[i]
		laser:update(dt)
	
		if laser.isGone then
			table.remove(self.lasers, i)
		end
	end

    -- Deceleration
    if not self.isMoving then
        local currentSpeed = math.sqrt(self.vx^2 + self.vy^2) -- Calculates speed based of pythagoras therom
        if currentSpeed > 0 then
            
            local friction = self.deceleration * dt
            local newSpeed = math.max(0, currentSpeed - friction) --Choses highest speed between 0 and friction calculation to ensure no negative speed

            self.vx = (self.vx / currentSpeed) * newSpeed
            self.vy = (self.vy / currentSpeed) * newSpeed
        end
    end

    -- Update position
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    -- Loop Ship
    if self.x > (love.graphics.getWidth() + 10) then
        self.x = -5
    elseif self.x < -10 then
        self.x = love.graphics.getWidth() + 5
    end

    if self.y > (love.graphics.getHeight() + 10) then
        self.y = -5
    elseif self.y < -10 then
        self.y = love.graphics.getHeight() + 5
    end
end


-- Draw Ship
function Ship:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.rotation, self.width / self.sprite:getWidth(), self.height / self.sprite:getHeight(), self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)

	for _, laser in ipairs(self.lasers) do
		laser:draw()
	end
end

return Ship
