--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1400, 900)

    credFont = love.graphics.newFont('fonts/BalooChettan2-Regular.ttf', 40)
    selFont = love.graphics.newFont('fonts/BalooChettan2-Regular.ttf', 25)

    sprites = {}
    sprites.menuLogo = love.graphics.newImage('sprites/light-crash-logo.png')
    sprites.playText = love.graphics.newImage('sprites/play-text.png')
    sprites.creditsText = love.graphics.newImage('sprites/credits-text.png')
    sprites.backBtn = love.graphics.newImage('sprites/back-button.png')
    sprites.classic = love.graphics.newImage('sprites/classic-mode.png')
    sprites.chooseShip = love.graphics.newImage('sprites/choose-ship.png')
    sprites.p1Select = love.graphics.newImage('sprites/p1-select.png')
    sprites.p1SelectBottom = love.graphics.newImage('sprites/p1-select-bottom.png')
    sprites.p2Select = love.graphics.newImage('sprites/p2-select.png')
    sprites.p2SelectBottom = love.graphics.newImage('sprites/p2-select-bottom.png')
    sprites.p1Text = love.graphics.newImage('sprites/p1-text.png')
    sprites.p2Text = love.graphics.newImage('sprites/p2-text.png')
    sprites.p1Keys = love.graphics.newImage('sprites/p1-keys.png')
    sprites.p2Keys = love.graphics.newImage('sprites/p2-keys.png')
    sprites.beginText = love.graphics.newImage('sprites/begin-text.png')
    sprites.background = love.graphics.newImage('sprites/background-1400-900.png')
    sprites.p1Wins = love.graphics.newImage('sprites/p1-wins.png')
    sprites.p2Wins = love.graphics.newImage('sprites/p2-wins.png')
    sprites.redShip = love.graphics.newImage('sprites/red-ship30.png')
    sprites.blueShip = love.graphics.newImage('sprites/blue-ship30.png')
    sprites.orangeShip = love.graphics.newImage('sprites/orange-ship30.png')
    sprites.cyanShip = love.graphics.newImage('sprites/cyan-ship30.png')
    sprites.greenShip = love.graphics.newImage('sprites/green-ship30.png')
    sprites.yellowShip = love.graphics.newImage('sprites/yellow-ship30.png')

    gameState = "menu"

    wf = require 'libraries/windfield/windfield'
    world = wf.newWorld(0, 0, false)
    -- world:setQueryDebugDrawing(true)

    world:addCollisionClass('Border')
    world:addCollisionClass('PlayerOne')
    world:addCollisionClass('PlayerTwo')
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

    require('menu')
    require('playerOne')
    require('playerTwo')
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
            playerTwoUpdate(dt)
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
        drawPlayerTwo()

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

function love.mousepressed(x, y, button)
    if gameState == "menu" then
        menuMousepressed(x, y, button)
    end
end

--[[
    HELPER FUNCTION
--]]
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end