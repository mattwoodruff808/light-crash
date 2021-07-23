--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1400, 900)

    sprites = {}
    sprites.redShip = love.graphics.newImage('sprites/red-ship30.png')

    wf = require 'libraries/windfield/windfield'
    world = wf.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('PlayerOne')
    world:addCollisionClass('Trail')
    
    playerSizeX = 25
    playerSizeY = 25
    playerSpeed = 200

    require('playerOne')
end

--[[
    UPDATE FUNCTION
--]]
function love.update(dt)
    world:update(dt)

    playerOneUpdate(dt)
end

--[[
    DRAW FUNCTION
--]]
function love.draw()
    world:draw()

    drawPlayerOne()
end

--[[
    KEYPRESSED FUNCTION
--]]
function love.keypressed(key)
    playerOneKeypressed(key)
end