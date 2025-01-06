local Ship = {}

-- Initialization
function Ship:load()
    -- Position
    self.x = 100
    self.y = 50

    -- Velocity
    self.vx = 0
    self.vy = 0

    -- Acceleration
    self.acceleration = 100

    -- Deceleration (sliding effect)
    self.deceleration = 30

    -- Dimensions
    self.width = 20
    self.height = 10
    self.rotation = 0

    -- Sprites
    self.spriteNormal = love.graphics.newImage("assets/sprites/ship.png")
    self.spriteMoving = love.graphics.newImage("assets/sprites/shipmove.png")
    self.sprite = self.spriteNormal

    -- Sounds
    self.soundMove = love.audio.newSource("assets/sound/move.wav", "static")
	self.soundMove:setVolume(0) -- Set to 0 because its annoying

    self.isMoving = false
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
        
        self.vx = self.vx + math.cos(self.rotation) * self.acceleration * dt
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

    -- Deceleration
    if not self.isMoving then
        local speed = math.sqrt(self.vx^2 + self.vy^2) -- Current speed
        if speed > 0 then
            
            local decelerationAmount = self.deceleration * dt
            speed = math.max(0, speed - decelerationAmount)

            
            local directionX = self.vx / speed
            local directionY = self.vy / speed
            self.vx = directionX * speed
            self.vy = directionY * speed
        end
    end

    -- Update position
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

-- Draw Ship
function Ship:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.rotation,
        self.width / self.sprite:getWidth(),
        self.height / self.sprite:getHeight(),
        self.sprite:getWidth() / 2,
        self.sprite:getHeight() / 2)
end

return Ship
