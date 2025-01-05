-- main.lua

local Ship = require("ship")

function love.load()
    -- Fonts
    Font = love.graphics.newImageFont("assets/Pixelfont.png",
        " abcdefghijklmnopqrstuvwxyz" ..
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
        "123456789.,!?-+/():;%&`'*#=[]\"")
    love.graphics.setFont(Font)

    DisplayText = ""
    GameState = "menu"

    -- Load the ship module
    Ship:load()
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
        -- Update the ship
        Ship:update(dt)

        -- Game Control
        if love.keyboard.isDown("escape") then
            love.event.quit()
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
        -- Draw the ship
        Ship:draw()
    end

    if DisplayText ~= "" then
        love.graphics.printf(DisplayText, 0, 50, 600, "center")
    end
end
