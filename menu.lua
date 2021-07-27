--[[
    MENU VARIABLES
--]]
gameState = "menu"
-- gameState = "game"

menuState = 1

pointer = love.mouse.getSystemCursor('hand')

--[[
    MENU UPDATE
--]]


--[[
    MENU DRAW
--]]
function drawMenu()
    if menuState == 1 or menuState == 2 or menuState == 3 then
        love.graphics.draw(sprites.menuLogo, 215, 50)
    end

    local mx, my = love.mouse.getPosition()

    if menuState == 1 then
        love.graphics.draw(sprites.playText, 600, 500)

        love.graphics.draw(sprites.creditsText, 550, 625)

        -- Hovering over the Play button
        if mx > 600 and mx < 800 and my > 500 and my < 575 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.orangeShip, 600, 530, math.pi/2)
            love.graphics.draw(sprites.orangeShip, 798, 560, math.pi*3/2)
        else
            love.mouse.setCursor()
        end

        -- Hovering over the Credits button
        if mx > 550 and mx < 840 and my > 625 and my < 680 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.orangeShip, 540, 640, math.pi/2)
            love.graphics.draw(sprites.orangeShip, 855, 670, math.pi*3/2)
        end
    end

    if menuState == 2 or menuState == 3 then
        love.graphics.draw(sprites.backBtn, 100, 800)

        -- Hovering over the Back button
        if mx > 100 and mx < 215 and my > 800 and my < 840 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.cyanShip, 90, 805, math.pi/2)
        else
            love.mouse.setCursor()
        end
    end

    if menuState == 2 then
        love.graphics.setFont(lcFont)
        love.graphics.printf("Credits", 550, 400, 200, 'center')
        love.graphics.printf("Game, Art, Music created and designed by Matt Woodruff", 305, 500, 700, 'center')
    end

    if menuState == 3 then
        love.graphics.print("Play Success", 100, 100)
    end
end

--[[
    MENU MOUSEPRESSED
--]]
function menuMousepressed(x, y, button)
    if menuState == 1 then
        -- Clicking on Play button
        if x > 600 and x < 800 and y > 500 and y < 575 then
            if button == 1 then
                menuState = 3
                love.mouse.setCursor()
            end
        end

        -- Clicking on Credits button
        if x > 550 and x < 840 and y > 625 and y < 680 then
            if button == 1 then
                menuState = 2
                love.mouse.setCursor()
            end
        end
    end

    if menuState == 2 or menuState == 3 then
        if x > 100 and x < 215 and y > 800 and y < 840 then
            if button == 1 then
                menuState = 1
            end
        end
    end
end