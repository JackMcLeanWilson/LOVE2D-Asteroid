function love.load()

	-- Fonts
	Font = love.graphics.newImageFont("assets/Pixelfont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")

	love.graphics.setFont(Font)

	DisplayText = ""
	GameState = "menu"

	--Sprites 
	SpriteShip = love.graphics.newImage("assets/sprites/ship.png")
	ShipWidth = 20
	ShipHeight = 10
	ShipRotation = 0 -- In radians

	--Audio
	SoundMove = love.audio.newSource("assets/sound/move.wav", "static") --Loads into memory, DONT LOAD LARGE SOUNDS INTO MEMORY
	SoundShoot = love.audio.newSource("assets/sound/shoot.wav", "static")
	SoundBoom = love.audio.newSource("assets/sound/boom.wav", "static")

	-- Position
	ShipXPos = 100
	ShipYPos = 50

	-- Velocity
	ShipDX = 40
	ShipDY = 60

end

function love.update(dt)
	if GameState == "menu" then
		TitleText = "New Asteroid (Name TBD)"
		ControlText = "Up/W - Boost\nLeft/A - Turn Left\nRight/D - Turn Right\nEsc - Exit"
		DisplayText2 = "[] Press Space To Start! []"
		CopyrightText = "QuarkInAnarchy (c)\n MIT License"

		-- Menu Controls
		if love.keyboard.isDown("space") then -- Start Game 
			GameState = "game"
			DisplayText = ""
		end
		if love.keyboard.isDown("escape") then -- Leave Game
			love.event.quit()
		end
	elseif GameState == "game" then

		-- Ship Controls --

		-- Game Control
		if love.keyboard.isDown("escape") then --Leave Game
			love.event.quit()
		end

		--Rotation Control 
		if love.keyboard.isDown("d") or love.keyboard.isDown("right") then --Turn Right
			ShipRotation = ShipRotation + 5 * dt
		elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then -- Turn Left 
			ShipRotation = ShipRotation - 5 * dt
		end

		--Forward Movement
		if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
			ShipDX = math.cos(ShipRotation) * 100
			ShipDY = math.sin(ShipRotation) * 100

			ShipXPos = ShipXPos + ShipDX * dt
			ShipYPos = ShipYPos + ShipDY * dt
			if not SoundMove:isPlaying() then
				SoundMove:play()
			end
		end
	else
		if SoundMove:isPlaying() then
			SoundMove:stop()
		end
	end
end

function love.draw()
	if GameState == "menu" then
		love.graphics.printf(TitleText, 0, 50, 900, "center")
		love.graphics.printf(ControlText, 0, 250, 900, "center")
		love.graphics.printf(DisplayText2, 0, 400, 900, "center")
		love.graphics.printf(CopyrightText, 0, 800, 900, "center")
	elseif GameState == "game" then
		love.graphics.draw(SpriteShip, ShipXPos, ShipYPos, ShipRotation, ShipWidth / SpriteShip:getWidth(), ShipHeight / SpriteShip:getHeight(), SpriteShip:getWidth() / 2, SpriteShip:getHeight() / 2)
	end

	if DisplayText ~= "" then
		love.graphics.printf(DisplayText, 0, 50, 600, "center")
	end

end
