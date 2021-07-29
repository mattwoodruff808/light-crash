--[[
    MENU VARIABLES
--]]
gameState = "menu"
-- gameState = "game"

menuState = 1

pointer = love.mouse.getSystemCursor('hand')

shipSelectPositions = {}
shipSelectPositions.one = {515, 260}
shipSelectPositions.two = {625, 260}
shipSelectPositions.three = { 260}
shipSelectPositions.four = { 365}
shipSelectPositions.five = { 365}
shipSelectPositions.six = { 365}

p1SelectTable = {}
p1SelectTable.position = "top"
p1SelectTable.x = 515
p1SelectTable.y = 260

p2SelectTable = {}
p2SelectTable.position = "top"
p2SelectTable.x = 625
p2SelectTable.y = 260

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

    if menuState == 2 or menuState == 3 or menuState == 4 then
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
        love.graphics.draw(sprites.classic, 550, 450)

        -- Hovering over the Classic button
        if mx > 550 and mx < 850 and my > 450 and my < 505 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.orangeShip, 540, 465, math.pi/2)
            love.graphics.draw(sprites.orangeShip, 855, 495, math.pi*3/2)
        end
    end

    if menuState == 4 then
        love.graphics.draw(sprites.chooseShip, 220, 50)

        love.graphics.draw(sprites.redShip, 560, 300, nil, 2)
        love.graphics.draw(sprites.blueShip, 670, 300, nil, 2)
        love.graphics.draw(sprites.greenShip, 780, 300, nil, 2)
        love.graphics.draw(sprites.yellowShip, 560, 410, nil, 2)
        love.graphics.draw(sprites.cyanShip, 670, 410, nil, 2)
        love.graphics.draw(sprites.orangeShip, 780, 410, nil, 2)

        love.graphics.draw(sprites.p1Select, p1SelectTable.x, p1SelectTable.y)
        love.graphics.draw(sprites.p2Select, p2SelectTable.x, p2SelectTable.y)
    end
end

--[[
    MENU MOUSEPRESSED
--]]
function menuMousepressed(x, y, button)
    if menuState == 1 then
        -- Clicking on Play button
        if x > 600 and x < 800 and y > 505 and y < 575 then
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

    if menuState == 2 or menuState == 3 or menuState == 4 then
        -- Clicking on the Back button
        if x > 100 and x < 215 and y > 800 and y < 840 then
            if button == 1 then
                menuState = 1
            end
        end
    end

    if menuState == 4 then
        -- Clicking on the Back button
        if x > 100 and x < 215 and y > 800 and y < 840 then
            if button == 1 then
                menuState = 3
            end
        end
    end

    if menuState == 3 then
        -- Clicking on the Classic button
        if x > 550 and x < 850 and y > 450 and y < 505 then
            if button == 1 then
                menuState = 4
                love.mouse.setCursor()
            end
        end
    end
end