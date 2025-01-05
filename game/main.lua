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

	--Audio
	SoundMove = love.audio.newSource("assets/sound/move.wav", "static") --Loads into memory, DONT LOAD LARGE SOUNDS INTO MEMORY
	SoundShoot = love.audio.newSource("assets/sound/shoot.wav", "static")
	SoundBoom = love.audio.newSource("assets/sound/boom.wav", "static")

	-- Position
	ShipXpos = 100
	ShipYpos = 50

	-- Velocity
	ShipDX = 40
	ShipDY = 60

end

function love.update()
	if GameState == "menu" then
		DisplayText = "New Asteroid (Name TBD)"
		ControlText = "Up/W - Boost\nLeft/A - Turn Left\nRight/D - Turn Right\nEsc - Exit"
		DisplayText2 = "Press Space To Start!"
		CopyrightText = "QuarkInAnarchy (c)\n MIT License"

		-- Menu Controls
		if love.keyboard.isDown("space") then
			GameState = "game"
			DisplayText = ""
		end
		if love.keyboard.isDown("escape") then
			love.event.quit()
		end
	elseif GameState == "game" then

	end
end

function love.draw()
	if GameState == "menu" then
		love.graphics.printf(DisplayText, 0, 50, 600, "center")
		love.graphics.printf(ControlText, 0, 150, 600, "center")
		love.graphics.printf(DisplayText2, 0, 300, 600, "center")
		love.graphics.printf(CopyrightText, 0, 500, 600, "center")
	elseif GameState == "game" then
		
	end
end
