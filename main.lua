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

    local playerSizeX = 25
    local playerSizeY = 25
    playerSpeed = 200

    local p1StartX = 502
    local p1StartY = 402

    playerOne = world:newRectangleCollider(p1StartX, p1StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerOne'})
    playerOne:setFixedRotation(true)
    playerOne.x = 515
    playerOne.y = 415
    playerOne.direction = "up"
    playerOne.directionUpDown = 1
    playerOne.directionLeftRight = 0
    playerOne.radians = 0
    playerOne.firstX = 515
    playerOne.firstY = 415
    playerOne.lastX = 0
    playerOne.lastY = 0
    playerOne.lines = {}
    playerOne.lineColliders = {}

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
    love.graphics.setLineWidth(8)

    if playerOne.direction == "right" then
        love.graphics.line(playerOne.firstX, playerOne.firstY, playerOne.x - 15, playerOne.y)
    end
    if playerOne.direction == "left" then
        love.graphics.line(playerOne.firstX, playerOne.firstY, playerOne.x + 15, playerOne.y)
    end
    if playerOne.direction == "up" then
        love.graphics.line(playerOne.firstX, playerOne.firstY, playerOne.x, playerOne.y + 15)
    end
    if playerOne.direction == "down" then
        love.graphics.line(playerOne.firstX, playerOne.firstY, playerOne.x, playerOne.y - 15)
    end

    for i = 1, #playerOne.lines do
        local line = playerOne.lines[i]

        love.graphics.line(line[1], line[2], line[3], line[4])
        love.graphics.circle("fill", line[3], line[4], 4)
    end

    love.graphics.setLineWidth(1)
    love.graphics.draw(sprites.redShip, playerOne.x, playerOne.y, playerOne.radians, nil, nil, 15, 15)
end

--[[
    KEYPRESSED FUNCTION
--]]
function love.keypressed(key)
    if key == "d" and playerOne.direction ~= "left" then
        playerOne.direction = "right"
        playerOne.directionLeftRight = -1
        playerOne.radians = math.pi/2
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "a" and playerOne.direction ~= "right" then
        playerOne.direction = "left"
        playerOne.directionLeftRight = 1
        playerOne.radians = math.pi*3/2
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "w" and playerOne.direction ~= "down" then
        playerOne.direction = "up"
        playerOne.directionUpDown = 1
        playerOne.radians = 0
        drawPlayerLine()
        playerOne.firstX = playerOne.lastX
        playerOne.firstY = playerOne.lastY
    end
    if key == "s" and playerOne.direction ~= "up" then
        playerOne.direction = "down"
        playerOne.directionUpDown = -1
        playerOne.radians = math.pi
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

    if playerOne.direction == "right" then
        local lineCollider = world:newLineCollider(playerOne.firstX, playerOne.firstY, playerOne.lastX, playerOne.lastY + (22 * playerOne.directionUpDown), {collision_class = 'Trail'})
        table.insert(playerOne.lineColliders, lineCollider)
    end
    if playerOne.direction == "left" then
        local lineCollider = world:newLineCollider(playerOne.firstX, playerOne.firstY, playerOne.lastX, playerOne.lastY + (22 * playerOne.directionUpDown), {collision_class = 'Trail'})
        table.insert(playerOne.lineColliders, lineCollider)
    end
    if playerOne.direction == "up" then
        local lineCollider = world:newLineCollider(playerOne.firstX, playerOne.firstY, playerOne.lastX + (22 * playerOne.directionLeftRight), playerOne.lastY, {collision_class = 'Trail'})
        table.insert(playerOne.lineColliders, lineCollider)
    end
    if playerOne.direction == "down" then
        local lineCollider = world:newLineCollider(playerOne.firstX, playerOne.firstY, playerOne.lastX + (22 * playerOne.directionLeftRight), playerOne.lastY, {collision_class = 'Trail'})
        table.insert(playerOne.lineColliders, lineCollider)
    end
end