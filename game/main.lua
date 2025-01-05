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
	
	elseif GameState == "game" then

	end
end

function love.draw()
	if GameState == "menu" then
	
	elseif GameState == "game" then
		
	end
end
