--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1400, 900)

    credFont = love.graphics.newFont('fonts/BalooChettan2-Regular.ttf', 40)
    selFont = love.graphics.newFont('fonts/BalooChettan2-Regular.ttf', 25)

    gameState = "menu"

    wf = require 'libraries/windfield/windfield'
    world = wf.newWorld(0, 0, false)
    -- world:setQueryDebugDrawing(true)

    world:addCollisionClass('Border')
    world:addCollisionClass('PlayerOne')
    world:addCollisionClass('PlayerTwo')
    world:addCollisionClass('Computer')
    world:addCollisionClass('Trail')

    topBorder = world:newRectangleCollider(0, 0, 1400, 20, {collision_class = 'Border'})
    topBorder:setType('static')
    rightBorder = world:newRectangleCollider(1380, 20, 20, 880, {collision_class = 'Border'})
    rightBorder:setType('static')
    bottomBorder = world:newRectangleCollider(0, 880, 1380, 20, {collision_class = 'Border'})
    bottomBorder:setType('static')
    leftBorder = world:newRectangleCollider(0, 20, 20, 860, {collision_class = 'Border'})
    leftBorder:setType('static')
    
    playerSizeX = 25
    playerSizeY = 25
    playerSpeed = 200

    startTimer = 0
    winner = "None"
    computer = false

    require('sprites')
    require('menu')
    require('playerOne')
    require('playerTwo')
    require('computer')
    require('endgameMenu')
end

--[[
    UPDATE FUNCTION
--]]
function love.update(dt)
    world:update(dt)

    if gameState == "game" then
        if startTimer > 0 then
            startTimer = startTimer - dt
        end
            
        if startTimer <= 0 then  
            startTimer = 0
            playerOneUpdate(dt)

            if computer == true then
                computerUpdate(dt)
            else
                playerTwoUpdate(dt)
            end
        end
    end
end

--[[
    DRAW FUNCTION
--]]
function love.draw()
    -- world:draw()

    if gameState == "menu" then
        drawMenu()
    end

    if gameState == "game" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(sprites.background, 0, 0)

        if startTimer > 0 then
            love.graphics.setFont(credFont)
            love.graphics.print(math.ceil(startTimer), 700, 450)
        end

        drawPlayerOne()

        if computer == true then
            drawComputer()
        else
            drawPlayerTwo()
        end

        drawEndgame()
    end
end

--[[
    KEYPRESSED FUNCTION
--]]
function love.keypressed(key)
    if gameState == "game" then
        playerOneKeypressed(key)
        playerTwoKeypressed(key)
    end

    if gameState == "menu" then
        menuKeypressed(key)
    end
end

--[[
    MOUSEPRESSED FUNCTION
--]]
function love.mousepressed(x, y, button)
    if gameState == "menu" then
        menuMousepressed(x, y, button)
    end

    if (gameState == "game" and winner == "Player One") or (gameState == "game" and winner == "Player Two") then
        endgameMenuMousepressed(x, y, button)
    end
end

--[[
    HELPER FUNCTION
--]]
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end