--[[
    LOAD FUNCTION
--]]
function love.load()
    love.window.setMode(1000, 800)

    wf = require 'libraries/windfield/windfield'
    world = wf.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('PlayerOne')

    playerSizeX = 15
    playerSizeY = 15

    p1StartX = 500
    p1StartY = 400

    playerOne = world:newRectangleCollider(p1StartX, p1StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerOne'})
    playerOne.x = 500
    playerOne.y = 400
    playerOne.speed = 200
    playerOne.direction = "up"
    playerOne.firstX = 507.5
    playerOne.firstY = 407.5
    playerOne.lastX = 0
    playerOne.lastY = 0

    playerOneLines = {}

    playerTwo = {}
end

--[[
    UPDATE FUNCTION
--]]
function love.update(dt)
    world:update(dt)

    if playerOne.body then
        local px, py = playerOne:getPosition()

        if love.keyboard.isDown("d") then
            playerOne.direction = "right"
        elseif love.keyboard.isDown("a") then
            playerOne.direction = "left"
        elseif love.keyboard.isDown("w") then
            playerOne.direction = "up"
        elseif love.keyboard.isDown("s") then
            playerOne.direction = "down"
        end

        if playerOne.direction == "right" then
            playerOne.x = playerOne.x + playerOne.speed * dt
            playerOne:setX(px + playerOne.speed * dt)
        end
        if playerOne.direction == "left" then
            playerOne.x = playerOne.x - playerOne.speed * dt
            playerOne:setX(px - playerOne.speed * dt)
        end
        if playerOne.direction == "up" then
            playerOne.y = playerOne.y - playerOne.speed * dt
            playerOne:setY(py - playerOne.speed * dt)
        end
        if playerOne.direction == "down" then
            playerOne.y = playerOne.y + playerOne.speed * dt
            playerOne:setY(py + playerOne.speed * dt)
        end

        
    end
end

--[[
    DRAW FUNCTION
--]]
function love.draw()
    world:draw()

    love.graphics.setColor(1, 0.6, 0.6)
    love.graphics.setLineWidth(4)
    love.graphics.line(playerOne.firstX, playerOne.firstY, playerOne.x + 7.5, playerOne.y + 7.5)

    for i = 1, #playerOneLines do
        local line = playerOneLines[i]

        love.graphics.setLineWidth(4)
        love.graphics.line(playerOneLines[i][1], playerOneLines[i][2], playerOneLines[i][3], playerOneLines[i][4])
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", playerOne.x, playerOne.y, playerSizeX, playerSizeY)
end

--[[
    KEYPRESSED FUNCTION
--]]
function love.keypressed(key)
    if key == "d" then
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "a" then
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "w" then
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "s" then
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
    table.insert(playerOneLines, line)
end