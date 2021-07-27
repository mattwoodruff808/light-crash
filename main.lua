--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1400, 900)

    lcFont = love.graphics.newFont('fonts/BalooChettan2-Regular.ttf', 40)

    sprites = {}
    sprites.menuLogo = love.graphics.newImage('sprites/light-crash-logo.png')
    sprites.playText = love.graphics.newImage('sprites/play-text.png')
    sprites.creditsText = love.graphics.newImage('sprites/credits-text.png')
    sprites.backBtn = love.graphics.newImage('sprites/back-button.png')
    sprites.background = love.graphics.newImage('sprites/background-1400-900.png')
    sprites.redShip = love.graphics.newImage('sprites/red-ship30.png')
    sprites.blueShip = love.graphics.newImage('sprites/blue-ship30.png')
    sprites.orangeShip = love.graphics.newImage('sprites/orange-ship30.png')
    sprites.cyanShip = love.graphics.newImage('sprites/cyan-ship30.png')

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

    require('menu')
    require('playerOne')
    require('playerTwo')
end

--[[
    UPDATE FUNCTION
--]]
function love.update(dt)
    world:update(dt)

    if gameState == "game" then
        playerOneUpdate(dt)
        playerTwoUpdate(dt)
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

        drawPlayerOne()
        drawPlayerTwo()
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
end

function love.mousepressed(x, y, button)
    menuMousepressed(x, y, button)
end

--[[
    HELPER FUNCTION
--]]
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end