-- ship.lua

local Ship = {}

-- Initialization
function Ship:load()
    -- Position
    self.x = 100
    self.y = 50

    -- Velocity
    self.dx = 40
    self.dy = 60

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

    self.isMoving = false
end

-- Update Ship Logic
function Ship:update(dt)
    -- Rotation Controls
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.rotation = self.rotation + 5 * dt
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.rotation = self.rotation - 5 * dt
    end

    -- Forward Movement
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.dx = math.cos(self.rotation) * 100
        self.dy = math.sin(self.rotation) * 100

        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt

        self.isMoving = true
        if not self.soundMove:isPlaying() then
            self.soundMove:play()
        end

        self.sprite = self.spriteMoving
    else
        self.isMoving = false
        self.sprite = self.spriteNormal

        if self.soundMove:isPlaying() then
            self.soundMove:stop()
        end
    end
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
