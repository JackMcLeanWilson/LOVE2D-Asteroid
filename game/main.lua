local Ship = require("ship")
local moonshine = require("moonshine")
local crtEffect
local scanlines

function love.load()
    -- Fonts
    Font = love.graphics.newImageFont("assets/Pixelfont.png",
        " abcdefghijklmnopqrstuvwxyz" ..
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
        "123456789.,!?-+/():;%&`'*#=[]\"")
    love.graphics.setFont(Font)

    -- Shaders
    crtEffect = moonshine(moonshine.effects.crt)
    scanlines = moonshine(moonshine.effects.scanlines)

    DisplayText = ""
    GameState = "menu"

    -- Load modules
    Ship:load()
end

function love.update(dt)
    if GameState == "menu" then
        TitleText = "Impact Event"
        ControlText = "Up/W - Boost\nLeft/A - Turn Left\nRight/D - Turn Right\nSpace - Shoot\nEsc - Exit"
        DisplayText2 = "[] Press Enter To Start! []"
        CopyrightText = "QuarkInAnarchy (c) 2024-2025\n MIT License"

        -- Menu Controls
        if love.keyboard.isDown("return") then -- Start Game 
            GameState = "game"
            DisplayText = "Test"
        end
        if love.keyboard.isDown("escape") then -- Leave Game
            love.event.quit()
        end
    elseif GameState == "game" then
        -- Update ship 
        Ship:update(dt)

        -- Game Control
        if love.keyboard.isDown("escape") then
            love.event.quit()
        end
    end
end

function love.draw()
    -- Apply CRT & scanlines shaders to entire screen
    crtEffect(function()
        scanlines(function()
            -- Background
            love.graphics.setColor(0.1, 0.1, 0.1)
            love.graphics.rectangle("fill", 0, 0, 900, 900)

            love.graphics.setColor(1, 1, 1)
            
            if GameState == "menu" then
                love.graphics.printf(TitleText, 0, 50, 900, "center")
                love.graphics.printf(ControlText, 0, 250, 900, "center")
                love.graphics.printf(DisplayText2, 0, 400, 900, "center")
                love.graphics.printf(CopyrightText, 0, 800, 900, "center")
            elseif GameState == "game" then
                Ship:draw()
            end

            if DisplayText ~= "" then
                love.graphics.printf(DisplayText, 0, 50, 900, "center")
            end
        end)
    end)
end
