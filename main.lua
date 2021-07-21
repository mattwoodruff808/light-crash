--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1400, 900)

    wf = require 'libraries/windfield/windfield'
    world = wf.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('PlayerOne')
    world:addCollisionClass('Trail')

    playerSizeX = 15
    playerSizeY = 15
    playerSpeed = 200

    local p1StartX = 500
    local p1StartY = 400

    playerOne = world:newRectangleCollider(p1StartX, p1StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerOne'})
    playerOne.x = 500
    playerOne.y = 400
    playerOne.direction = "up"
    playerOne.firstX = 507.5
    playerOne.firstY = 407.5
    playerOne.lastX = 0
    playerOne.lastY = 0
    playerOne.lines = {}

    playerTwo = {}
end

--[[
    UPDATE FUNCTION
--]]
function love.update(dt)
    world:update(dt)

    if playerOne.body then
        local px, py = playerOne:getPosition()

        if playerOne.direction == "right" then
            playerOne.x = playerOne.x + playerSpeed * dt
            playerOne:setX(px + playerSpeed * dt)
        end
        if playerOne.direction == "left" then
            playerOne.x = playerOne.x - playerSpeed * dt
            playerOne:setX(px - playerSpeed * dt)
        end
        if playerOne.direction == "up" then
            playerOne.y = playerOne.y - playerSpeed * dt
            playerOne:setY(py - playerSpeed * dt)
        end
        if playerOne.direction == "down" then
            playerOne.y = playerOne.y + playerSpeed * dt
            playerOne:setY(py + playerSpeed * dt)
        end  
    end
end

--[[
    DRAW FUNCTION
--]]
function love.draw()
    world:draw()

    love.graphics.setColor(1, 0.6, 0.6)
    love.graphics.setLineWidth(9)
    love.graphics.line(playerOne.firstX, playerOne.firstY, playerOne.x + 7.5, playerOne.y + 7.5)

    for i = 1, #playerOne.lines do
        local line = playerOne.lines[i]

        love.graphics.line(line[1], line[2], line[3], line[4])
        love.graphics.circle("fill", line[3], line[4], 4.5)
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", playerOne.x, playerOne.y, playerSizeX, playerSizeY)
end

--[[
    KEYPRESSED FUNCTION
--]]
function love.keypressed(key)
    if key == "d" and playerOne.direction ~= "left" then
        playerOne.direction = "right"
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "a" and playerOne.direction ~= "right" then
        playerOne.direction = "left"
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "w" and playerOne.direction ~= "down" then
        playerOne.direction = "up"
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "s" and playerOne.direction ~= "up" then
        playerOne.direction = "down"
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
end

--[[
    HELPER FUNCTIONS
--]]
function drawPlayerLine()
    local px, py = playerOne:getPosition()

    playerOne.lastX = px
    playerOne.lastY = py

    local line = {playerOne.firstX, playerOne.firstY, playerOne.lastX, playerOne.lastY}
    table.insert(playerOne.lines, line)
end