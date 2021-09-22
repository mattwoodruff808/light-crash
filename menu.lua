--[[
    MENU VARIABLES
--]]
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
p1SelectTable.colorChosen = "red"

p2SelectTable = {}
p2SelectTable.position = 2
p2SelectTable.x = shipSelectPositions.two[1]
p2SelectTable.y = shipSelectPositions.two[2]
p2SelectTable.top = true
p2SelectTable.colorChosen = "blue"

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
        love.graphics.setFont(credFont)
        love.graphics.printf("Credits", 600, 400, 200, 'center')
        love.graphics.printf("Game, Art, Music created and designed by Matt Woodruff", 355, 500, 700, 'center')
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

        -- Ship Options Draw
        love.graphics.draw(sprites.redShip, 560, 300, nil, 2)
        love.graphics.draw(sprites.blueShip, 670, 300, nil, 2)
        love.graphics.draw(sprites.greenShip, 780, 300, nil, 2)
        love.graphics.draw(sprites.yellowShip, 560, 410, nil, 2)
        love.graphics.draw(sprites.cyanShip, 670, 410, nil, 2)
        love.graphics.draw(sprites.orangeShip, 780, 410, nil, 2)

        -- Player One Select Draw
        love.graphics.draw(sprites.p1Text, 75, 300)
        love.graphics.draw(sprites.p1Keys, 175, 400)
        love.graphics.setFont(selFont)
        love.graphics.printf("Ship Select/Movement", 150, 550, 250, "center")
        if p1SelectTable.top == true then
            love.graphics.draw(sprites.p1Select, p1SelectTable.x, p1SelectTable.y)
        else
            love.graphics.draw(sprites.p1SelectBottom, p1SelectTable.x, p1SelectTable.y)
        end
        
        -- Player Two Select Draw
        if computer == false then
            love.graphics.draw(sprites.p2Text, 930, 300)
            love.graphics.draw(sprites.p2Keys, 1030, 400)
            love.graphics.printf("Ship Select/Movement", 1005, 550, 250, "center")
            if p2SelectTable.top == true then
                love.graphics.draw(sprites.p2Select, p2SelectTable.x, p2SelectTable.y)
            else
                love.graphics.draw(sprites.p2SelectBottom, p2SelectTable.x, p2SelectTable.y)
            end
        end

        love.graphics.draw(sprites.beginText, 575, 650)

        -- Hovering over the Begin! button
        if mx > 575 and mx < 820 and my > 650 and my < 705 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.orangeShip, 555, 665, math.pi/2)
            love.graphics.draw(sprites.orangeShip, 835, 695, math.pi*3/2)
        end

        -- Computer Select Draw
        love.graphics.rectangle("line", 930, 800, 35, 35)
        love.graphics.printf("Computer Opponent", 980, 800, 250, "left")

        -- Hovering over the Computer checkbox
        if mx > 930 and mx < 965 and my > 800 and my < 835 then
            love.mouse.setCursor(pointer)
        end

        -- Selected Computer Draw
        if computer == true then
            love.graphics.draw(sprites.computerText, 950, 300)
            love.graphics.printf("Good Luck!", 1005, 400, 250, "center")
            love.graphics.printf("X", 833, 798, 230, "center")
            p2SelectTable.position = 0
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

        -- Clicking on the Begin! button
        if x > 575 and x < 820 and y > 650 and y < 705 then
            if button == 1 then
                gameState = "game"
                startTimer = 3
                love.mouse.setCursor()

                if computer == true then
                    local j = #playerTwo.lineColliders
                    while j > -1 do
                    if playerTwo.lineColliders[j] ~= nil then
                        playerTwo.lineColliders[j]:destroy()
                    end
                    table.remove(playerTwo.lineColliders, j)
                    j = j - 1
                    end
                    playerTwo:destroy()
                end
            end
        end

        -- Clicking on the Computer checkbox
        if x > 930 and x < 965 and y > 800 and y < 835 then
            if button == 1 then
                if computer == false then
                    computer = true
                else
                    computer = false
                end
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
        if key == "d" and p1SelectTable.position == 2 and p2SelectTable.position ~= 3 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.three[1]
            p1SelectTable.y = shipSelectPositions.three[2]
            p1SelectTable.position = 3
            p1SelectTable.colorChosen = "green"
        end
        -- P1 pos1 => right
        if key == "d" and p1SelectTable.position == 1 and p2SelectTable.position ~= 2 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.two[1]
            p1SelectTable.y = shipSelectPositions.two[2]
            p1SelectTable.position = 2
            p1SelectTable.colorChosen = "blue"
        end
        -- P1 pos1 => down
        if key == "s" and p1SelectTable.position == 1 and p2SelectTable.position ~= 4 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.four[1]
            p1SelectTable.y = shipSelectPositions.four[2]
            p1SelectTable.position = 4
            p1SelectTable.colorChosen = "yellow"
        end
        -- P1 pos2 => left
        if key == "a" and p1SelectTable.position == 2 and p2SelectTable.position ~= 1 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.one[1]
            p1SelectTable.y = shipSelectPositions.one[2]
            p1SelectTable.position = 1
            p1SelectTable.colorChosen = "red"
        end
        -- P1 pos2 => down
        if key == "s" and p1SelectTable.position == 2 and p2SelectTable.position ~= 5 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.five[1]
            p1SelectTable.y = shipSelectPositions.five[2]
            p1SelectTable.position = 5
            p1SelectTable.colorChosen = "cyan"
        end
        -- P1 pos3 => left
        if key == "a" and p1SelectTable.position == 3 and p2SelectTable.position ~= 2 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.two[1]
            p1SelectTable.y = shipSelectPositions.two[2]
            p1SelectTable.position = 2
            p1SelectTable.colorChosen = "blue"
        end
        -- P1 pos3 => down
        if key == "s" and p1SelectTable.position == 3 and p2SelectTable.position ~= 6 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.six[1]
            p1SelectTable.y = shipSelectPositions.six[2]
            p1SelectTable.position = 6
            p1SelectTable.colorChosen = "orange"
        end
        -- P1 pos4 => up
        if key == "w" and p1SelectTable.position == 4 and p2SelectTable.position ~= 1 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.one[1]
            p1SelectTable.y = shipSelectPositions.one[2]
            p1SelectTable.position = 1
            p1SelectTable.colorChosen = "red"
        end
        -- P1 pos5 => right
        if key == "d" and p1SelectTable.position == 5 and p2SelectTable.position ~= 6 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.six[1]
            p1SelectTable.y = shipSelectPositions.six[2]
            p1SelectTable.position = 6
            p1SelectTable.colorChosen = "orange"
        end
        -- P1 pos4 => right
        if key == "d" and p1SelectTable.position == 4 and p2SelectTable.position ~= 5 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.five[1]
            p1SelectTable.y = shipSelectPositions.five[2]
            p1SelectTable.position = 5
            p1SelectTable.colorChosen = "cyan"
        end
        -- P1 pos5 => left
        if key == "a" and p1SelectTable.position == 5 and p2SelectTable.position ~= 4 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.four[1]
            p1SelectTable.y = shipSelectPositions.four[2]
            p1SelectTable.position = 4
            p1SelectTable.colorChosen = "yellow"
        end
        -- P1 pos5 => up
        if key == "w" and p1SelectTable.position == 5 and p2SelectTable.position ~= 2 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.two[1]
            p1SelectTable.y = shipSelectPositions.two[2]
            p1SelectTable.position = 2
            p1SelectTable.colorChosen = "blue"
        end
        -- P1 pos6 => left
        if key == "a" and p1SelectTable.position == 6 and p2SelectTable.position ~= 5 then
            p1SelectTable.top = false
            p1SelectTable.x = shipSelectPositions.five[1]
            p1SelectTable.y = shipSelectPositions.five[2]
            p1SelectTable.position = 5
            p1SelectTable.colorChosen = "cyan"
        end
        -- P1 pos6 => up
        if key == "w" and p1SelectTable.position == 6 and p2SelectTable.position ~= 3 then
            p1SelectTable.top = true
            p1SelectTable.x = shipSelectPositions.three[1]
            p1SelectTable.y = shipSelectPositions.three[2]
            p1SelectTable.position = 3
            p1SelectTable.colorChosen = "green"
        end

        --[[
            PLAYER 2 SHIP SELECT
        --]]
        if computer == false then
            -- P2 pos2 => right
            if key == "right" and p2SelectTable.position == 2 and p1SelectTable.position ~= 3 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.three[1]
                p2SelectTable.y = shipSelectPositions.three[2]
                p2SelectTable.position = 3
                p2SelectTable.colorChosen = "green"
            end
            -- P2 pos1 => right
            if key == "right" and p2SelectTable.position == 1 and p1SelectTable.position ~= 2 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.two[1]
                p2SelectTable.y = shipSelectPositions.two[2]
                p2SelectTable.position = 2
                p2SelectTable.colorChosen = "blue"
            end
            -- P2 pos1 => down
            if key == "down" and p2SelectTable.position == 1 and p1SelectTable.position ~= 4 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.four[1]
                p2SelectTable.y = shipSelectPositions.four[2]
                p2SelectTable.position = 4
                p2SelectTable.colorChosen = "yellow"
            end
            -- P2 pos2 => left
            if key == "left" and p2SelectTable.position == 2 and p1SelectTable.position ~= 1 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.one[1]
                p2SelectTable.y = shipSelectPositions.one[2]
                p2SelectTable.position = 1
                p2SelectTable.colorChosen = "red"
            end
            -- P2 pos2 => down
            if key == "down" and p2SelectTable.position == 2 and p1SelectTable.position ~= 5 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.five[1]
                p2SelectTable.y = shipSelectPositions.five[2]
                p2SelectTable.position = 5
                p2SelectTable.colorChosen = "cyan"
            end
            -- P2 pos3 => left
            if key == "left" and p2SelectTable.position == 3 and p1SelectTable.position ~= 2 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.two[1]
                p2SelectTable.y = shipSelectPositions.two[2]
                p2SelectTable.position = 2
                p2SelectTable.colorChosen = "blue"
            end
            -- P2 pos3 => down
            if key == "down" and p2SelectTable.position == 3 and p1SelectTable.position ~= 6 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.six[1]
                p2SelectTable.y = shipSelectPositions.six[2]
                p2SelectTable.position = 6
                p2SelectTable.colorChosen = "orange"
            end
            -- P2 pos4 => up
            if key == "up" and p2SelectTable.position == 4 and p1SelectTable.position ~= 1 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.one[1]
                p2SelectTable.y = shipSelectPositions.one[2]
                p2SelectTable.position = 1
                p2SelectTable.colorChosen = "red"
            end
            -- P2 pos5 => right
            if key == "right" and p2SelectTable.position == 5 and p1SelectTable.position ~= 6 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.six[1]
                p2SelectTable.y = shipSelectPositions.six[2]
                p2SelectTable.position = 6
                p2SelectTable.colorChosen = "orange"
            end
            -- P2 pos4 => right
            if key == "right" and p2SelectTable.position == 4 and p1SelectTable.position ~= 5 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.five[1]
                p2SelectTable.y = shipSelectPositions.five[2]
                p2SelectTable.position = 5
                p2SelectTable.colorChosen = "cyan"
            end
            -- P2 pos5 => left
            if key == "left" and p2SelectTable.position == 5 and p1SelectTable.position ~= 4 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.four[1]
                p2SelectTable.y = shipSelectPositions.four[2]
                p2SelectTable.position = 4
                p2SelectTable.colorChosen = "yellow"
            end
            -- P1 pos5 => up
            if key == "up" and p2SelectTable.position == 5 and p1SelectTable.position ~= 2 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.two[1]
                p2SelectTable.y = shipSelectPositions.two[2]
                p2SelectTable.position = 2
                p2SelectTable.colorChosen = "blue"
            end
            -- P2 pos6 => left
            if key == "left" and p2SelectTable.position == 6 and p1SelectTable.position ~= 5 then
                p2SelectTable.top = false
                p2SelectTable.x = shipSelectPositions.five[1]
                p2SelectTable.y = shipSelectPositions.five[2]
                p2SelectTable.position = 5
                p2SelectTable.colorChosen = "cyan"
            end
            -- P2 pos6 => up
            if key == "up" and p2SelectTable.position == 6 and p1SelectTable.position ~= 3 then
                p2SelectTable.top = true
                p2SelectTable.x = shipSelectPositions.three[1]
                p2SelectTable.y = shipSelectPositions.three[2]
                p2SelectTable.position = 3
                p2SelectTable.colorChosen = "green"
            end
        end
    end
end