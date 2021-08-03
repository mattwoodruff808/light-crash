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
shipSelectPositions.three = {735, 260}
shipSelectPositions.four = {515, 365}
shipSelectPositions.five = {625, 365}
shipSelectPositions.six = {735, 365}

p1SelectTable = {}
p1SelectTable.position = 1
p1SelectTable.x = shipSelectPositions.one[1]
p1SelectTable.y = shipSelectPositions.one[2]
p1SelectTable.top = true

p2SelectTable = {}
p2SelectTable.position = 2
p2SelectTable.x = shipSelectPositions.two[1]
p2SelectTable.y = shipSelectPositions.two[2]
p2SelectTable.top = true

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

        if p1SelectTable.top == true then
            love.graphics.draw(sprites.p1Select, p1SelectTable.x, p1SelectTable.y)
        else
            love.graphics.draw(sprites.p1SelectBottom, p1SelectTable.x, p1SelectTable.y)
        end
        if p2SelectTable.top == true then
            love.graphics.draw(sprites.p2Select, p2SelectTable.x, p2SelectTable.y)
        else
            love.graphics.draw(sprites.p2SelectBottom, p2SelectTable.x, p2SelectTable.y)
        end
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

    if menuState == 2 or menuState == 3 then
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
                p1SelectTable.position = 1
                p1SelectTable.x = shipSelectPositions.one[1]
                p1SelectTable.y = shipSelectPositions.one[2]
                p1SelectTable.top = true

                p2SelectTable.position = 2
                p2SelectTable.x = shipSelectPositions.two[1]
                p2SelectTable.y = shipSelectPositions.two[2]
                p2SelectTable.top = true
                
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

--[[
    MENU KEYPRESSED
--]]
function menuKeypressed(key)
    if menuState == 4 then

        --[[
            PLAYER 1 SHIP SELECT
        --]]

        -- P1 pos2 => right
        if key == "d" and p1SelectTable.position == 2 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.three[1]
            p1SelectTable.y = shipSelectPositions.three[2]
            p1SelectTable.position = 3
        end
        -- P1 pos1 => right
        if key == "d" and p1SelectTable.position == 1 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.two[1]
            p1SelectTable.y = shipSelectPositions.two[2]
            p1SelectTable.position = 2
        end
        -- P1 pos1 => down
        if key == "s" and p1SelectTable.position == 1 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.four[1]
            p1SelectTable.y = shipSelectPositions.four[2]
            p1SelectTable.position = 4
        end
        -- P1 pos2 => left
        if key == "a" and p1SelectTable.position == 2 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.one[1]
            p1SelectTable.y = shipSelectPositions.one[2]
            p1SelectTable.position = 1
        end
        -- P1 pos2 => down
        if key == "s" and p1SelectTable.position == 2 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.five[1]
            p1SelectTable.y = shipSelectPositions.five[2]
            p1SelectTable.position = 5
        end
        -- P1 pos3 => left
        if key == "a" and p1SelectTable.position == 3 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.two[1]
            p1SelectTable.y = shipSelectPositions.two[2]
            p1SelectTable.position = 2
        end
        -- P1 pos3 => down
        if key == "s" and p1SelectTable.position == 3 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.six[1]
            p1SelectTable.y = shipSelectPositions.six[2]
            p1SelectTable.position = 6
        end
        -- P1 pos4 => up
        if key == "w" and p1SelectTable.position == 4 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.one[1]
            p1SelectTable.y = shipSelectPositions.one[2]
            p1SelectTable.position = 1
        end
        -- P1 pos5 => right
        if key == "d" and p1SelectTable.position == 5 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.six[1]
            p1SelectTable.y = shipSelectPositions.six[2]
            p1SelectTable.position = 6
        end
        -- P1 pos4 => right
        if key == "d" and p1SelectTable.position == 4 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.five[1]
            p1SelectTable.y = shipSelectPositions.five[2]
            p1SelectTable.position = 5
        end
        -- P1 pos5 => left
        if key == "a" and p1SelectTable.position == 5 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.four[1]
            p1SelectTable.y = shipSelectPositions.four[2]
            p1SelectTable.position = 4
        end
        -- P1 pos5 => up
        if key == "w" and p1SelectTable.position == 5 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.two[1]
            p1SelectTable.y = shipSelectPositions.two[2]
            p1SelectTable.position = 2
        end
        -- P1 pos6 => left
        if key == "a" and p1SelectTable.position == 6 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.five[1]
            p1SelectTable.y = shipSelectPositions.five[2]
            p1SelectTable.position = 5
        end
        -- P1 pos6 => up
        if key == "w" and p1SelectTable.position == 6 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.three[1]
            p1SelectTable.y = shipSelectPositions.three[2]
            p1SelectTable.position = 3
        end

        --[[
            PLAYER 2 SHIP SELECT
        --]]

        -- P2 pos2 => right
        if key == "right" and p2SelectTable.position == 2 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.three[1]
            p2SelectTable.y = shipSelectPositions.three[2]
            p2SelectTable.position = 3
        end
        -- P2 pos1 => right
        if key == "right" and p2SelectTable.position == 1 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.two[1]
            p2SelectTable.y = shipSelectPositions.two[2]
            p2SelectTable.position = 2
        end
        -- P2 pos1 => down
        if key == "down" and p2SelectTable.position == 1 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.four[1]
            p2SelectTable.y = shipSelectPositions.four[2]
            p2SelectTable.position = 4
        end
        -- P2 pos2 => left
        if key == "left" and p2SelectTable.position == 2 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.one[1]
            p2SelectTable.y = shipSelectPositions.one[2]
            p2SelectTable.position = 1
        end
        -- P2 pos2 => down
        if key == "down" and p2SelectTable.position == 2 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.five[1]
            p2SelectTable.y = shipSelectPositions.five[2]
            p2SelectTable.position = 5
        end
        -- P2 pos3 => left
        if key == "left" and p2SelectTable.position == 3 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.two[1]
            p2SelectTable.y = shipSelectPositions.two[2]
            p2SelectTable.position = 2
        end
        -- P2 pos3 => down
        if key == "down" and p2SelectTable.position == 3 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.six[1]
            p2SelectTable.y = shipSelectPositions.six[2]
            p2SelectTable.position = 6
        end
        -- P2 pos4 => up
        if key == "up" and p2SelectTable.position == 4 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.one[1]
            p2SelectTable.y = shipSelectPositions.one[2]
            p2SelectTable.position = 1
        end
        -- P2 pos5 => right
        if key == "right" and p2SelectTable.position == 5 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.six[1]
            p2SelectTable.y = shipSelectPositions.six[2]
            p2SelectTable.position = 6
        end
        -- P2 pos4 => right
        if key == "right" and p2SelectTable.position == 4 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.five[1]
            p2SelectTable.y = shipSelectPositions.five[2]
            p2SelectTable.position = 5
        end
        -- P2 pos5 => left
        if key == "left" and p2SelectTable.position == 5 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.four[1]
            p2SelectTable.y = shipSelectPositions.four[2]
            p2SelectTable.position = 4
        end
        -- P1 pos5 => up
        if key == "up" and p2SelectTable.position == 5 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.two[1]
            p2SelectTable.y = shipSelectPositions.two[2]
            p2SelectTable.position = 2
        end
        -- P2 pos6 => left
        if key == "left" and p2SelectTable.position == 6 then
            p2SelectTable.top = false
            p2SelectTable.x = shipSelectPositions.five[1]
            p2SelectTable.y = shipSelectPositions.five[2]
            p2SelectTable.position = 5
        end
        -- P2 pos6 => up
        if key == "up" and p2SelectTable.position == 6 then
            p2SelectTable.top = true
            p2SelectTable.x = shipSelectPositions.three[1]
            p2SelectTable.y = shipSelectPositions.three[2]
            p2SelectTable.position = 3
        end
    end
end