--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1400, 900)

    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background-1400-900.png')
    sprites.redShip = love.graphics.newImage('sprites/red-ship30.png')
    sprites.blueShip = love.graphics.newImage('sprites/blue-ship30.png')

    wf = require 'libraries/windfield/windfield'
    world = wf.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

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

    playerOneUpdate(dt)
    playerTwoUpdate(dt)
end

--[[
    DRAW FUNCTION
--]]
function love.draw()
    world:draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprites.background, 0, 0)

    drawPlayerOne()
    drawPlayerTwo()
end

--[[
    KEYPRESSED FUNCTION
--]]
function love.keypressed(key)
    playerOneKeypressed(key)
    playerTwoKeypressed(key)
end

--[[
    HELPER FUNCTION
--]]
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end