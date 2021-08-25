function drawEndgame()
    local mx, my = love.mouse.getPosition();

    if winner == "Player One" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 200, 200, 1000, 500)
        love.graphics.draw(sprites.p1Wins, 400, 300)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("PLAY AGAIN", 400, 450)
        love.graphics.print("MAIN MENU", 800, 450)

        -- Hovering over the PLAY AGAIN button
        if mx > 400 and mx < 605 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.blueShip, 385, 465, math.pi/2)
        else
            love.mouse.setCursor()
        end

        -- Hovering over the MAIN MENU button
        if mx > 800 and mx < 1005 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.redShip, 785, 465, math.pi/2)
        end
    end

    if winner == "Player Two" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 200, 200, 1000, 500)
        love.graphics.draw(sprites.p2Wins, 400, 300)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("PLAY AGAIN", 400, 450)
        love.graphics.print("MAIN MENU", 800, 450)

        -- Hovering over the PLAY AGAIN button
        if mx > 400 and mx < 605 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.blueShip, 385, 465, math.pi/2)
        else
            love.mouse.setCursor()
        end

        -- Hovering over the MAIN MENU button
        if mx > 800 and mx < 1005 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.redShip, 785, 465, math.pi/2)
        end
    end
end

function endgameMenuMousepressed(x, y, button)
    love.graphics.setColor(1, 1, 1)

    -- Clicking on the PLAY AGAIN button
    if x > 400 and x < 605 and y > 460 and y < 500 then
        if button == 1 then
            -- Destroy remaining Player
            if winner == "Player One" and playerOne.body then
                local j = #playerOne.lineColliders
                while j > -1 do
                    if playerOne.lineColliders[j] ~= nil then
                        playerOne.lineColliders[j]:destroy()
                    end
                    table.remove(playerOne.lineColliders, j)
                    j = j - 1
                end
                playerOne:destroy()
            end
            
            if winner == "Player Two" and playerTwo.body then
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

            -- Game variables reset
            playerSpeed = 200
            startTimer = 3
            winner = "None"

            -- Player One Reset
            local p1StartX = 52
            local p1StartY = 802
            playerOne = world:newRectangleCollider(p1StartX, p1StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerOne'})    playerOne:setFixedRotation(true)
            playerOne.x = 65
            playerOne.y = 815
            playerOne.direction = "up"
            playerOne.rightOnce = false
            playerOne.leftOnce = false
            playerOne.upOnce = true
            playerOne.downOnce = false
            playerOne.radians = 0
            playerOne.firstX = 65
            playerOne.firstY = 815
            playerOne.lastX = 0
            playerOne.lastY = 0
            playerOne.lines = {}
            playerOne.lineColliders = {}

            -- Player Two Reset
            local p2StartX = 1322
            local p2StartY = 802
            playerTwo = world:newRectangleCollider(p2StartX, p2StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerTwo'})
            playerTwo:setFixedRotation(true)
            playerTwo.x = 1335
            playerTwo.y = 815
            playerTwo.direction = "up"
            playerTwo.rightOnce = false
            playerTwo.leftOnce = false
            playerTwo.upOnce = true
            playerTwo.downOnce = false
            playerTwo.radians = 0
            playerTwo.firstX = 1335
            playerTwo.firstY = 815
            playerTwo.lastX = 0
            playerTwo.lastY = 0
            playerTwo.lines = {}
            playerTwo.lineColliders = {}
        end
    end

    -- Clicking on the MAIN MENU button
    if x > 800 and x < 1005 and y > 460 and y < 500 then
        if button == 1 then
            -- Changing back to the main menu
            gameState = "menu"
            menuState = 1

            -- Destroy remaining Player
            if winner == "Player One" and playerOne.body then
                local j = #playerOne.lineColliders
                while j > -1 do
                    if playerOne.lineColliders[j] ~= nil then
                        playerOne.lineColliders[j]:destroy()
                    end
                    table.remove(playerOne.lineColliders, j)
                    j = j - 1
                end
                playerOne:destroy()
            end
            
            if winner == "Player Two" and playerTwo.body then
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

            -- Game variables reset
            playerSpeed = 200
            startTimer = 3
            winner = "None"

            -- Player One Reset
            local p1StartX = 52
            local p1StartY = 802
            playerOne = world:newRectangleCollider(p1StartX, p1StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerOne'})    playerOne:setFixedRotation(true)
            playerOne.x = 65
            playerOne.y = 815
            playerOne.direction = "up"
            playerOne.rightOnce = false
            playerOne.leftOnce = false
            playerOne.upOnce = true
            playerOne.downOnce = false
            playerOne.radians = 0
            playerOne.firstX = 65
            playerOne.firstY = 815
            playerOne.lastX = 0
            playerOne.lastY = 0
            playerOne.lines = {}
            playerOne.lineColliders = {}

            -- Player Two Reset
            local p2StartX = 1322
            local p2StartY = 802
            playerTwo = world:newRectangleCollider(p2StartX, p2StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerTwo'})
            playerTwo:setFixedRotation(true)
            playerTwo.x = 1335
            playerTwo.y = 815
            playerTwo.direction = "up"
            playerTwo.rightOnce = false
            playerTwo.leftOnce = false
            playerTwo.upOnce = true
            playerTwo.downOnce = false
            playerTwo.radians = 0
            playerTwo.firstX = 1335
            playerTwo.firstY = 815
            playerTwo.lastX = 0
            playerTwo.lastY = 0
            playerTwo.lines = {}
            playerTwo.lineColliders = {}

            -- Ship Select Reset
            p1SelectTable.position = 1
            p1SelectTable.x = shipSelectPositions.one[1]
            p1SelectTable.y = shipSelectPositions.one[2]
            p1SelectTable.top = true
            p1SelectTable.colorChosen = "red"

            p2SelectTable.position = 2
            p2SelectTable.x = shipSelectPositions.two[1]
            p2SelectTable.y = shipSelectPositions.two[2]
            p2SelectTable.top = true
            p2SelectTable.colorChosen = "blue"
        end
    end
end