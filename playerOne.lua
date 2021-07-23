--[[
    PLAYER ONE VARIABLES
--]]
-- local p1StartX = 502
-- local p1StartY = 402
local p1StartX = 52
local p1StartY = 802

playerOne = world:newRectangleCollider(p1StartX, p1StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerOne'})    playerOne:setFixedRotation(true)
-- playerOne.x = 515
-- playerOne.y = 415
playerOne.x = 65
playerOne.y = 815
playerOne.direction = "up"
playerOne.directionUpDown = 1
playerOne.directionLeftRight = 0
playerOne.rightOnce = false
playerOne.leftOnce = false
playerOne.upOnce = true
playerOne.downOnce = false
playerOne.radians = 0
-- playerOne.firstX = 515
-- playerOne.firstY = 415
playerOne.firstX = 65
playerOne.firstY = 815
playerOne.lastX = 0
playerOne.lastY = 0
playerOne.lines = {}
playerOne.lineColliders = {}

--[[
    PLAYER ONE UPDATE
--]]
function playerOneUpdate(dt)
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

    if playerOne:enter('Trail') then
        destroyPlayerOne()
    end

    if playerOne:enter('PlayerTwo') then
        destroyPlayerOne()
    end
end

--[[
    PLAYER ONE DRAW
--]]
function drawPlayerOne()
    love.graphics.setColor(1, 0.6, 0.6)
    love.graphics.setLineWidth(8)

    if playerOne.body then
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

    love.graphics.print(#playerOne.lineColliders, 30, 30)
end

--[[
    PLAYER ONE KEYPRESSED
--]]
function playerOneKeypressed(key)
    if playerOne.body then
        if key == "d" and playerOne.direction ~= "left" and playerOne.rightOnce == false then
            playerOne.direction = "right"
            playerOne.directionLeftRight = -1
            playerOne.radians = math.pi/2
            drawPlayerOneLine()
            playerOne.rightOnce = true
            playerOne.leftOnce = false
            playerOne.upOnce = false
            playerOne.downOnce = false
            playerOne.firstX = playerOne.lastX
            playerOne.firstY = playerOne.lastY
        end
        if key == "a" and playerOne.direction ~= "right" and playerOne.leftOnce == false then
            playerOne.direction = "left"
            playerOne.directionLeftRight = 1
            playerOne.radians = math.pi*3/2
            drawPlayerOneLine()
            playerOne.rightOnce = false
            playerOne.leftOnce = true
            playerOne.upOnce = false
            playerOne.downOnce = false
            playerOne.firstX = playerOne.lastX
            playerOne.firstY = playerOne.lastY
        end
        if key == "w" and playerOne.direction ~= "down" and playerOne.upOnce == false then
            playerOne.direction = "up"
            playerOne.directionUpDown = 1
            playerOne.radians = 0
            drawPlayerOneLine()
            playerOne.rightOnce = false
            playerOne.leftOnce = false
            playerOne.upOnce = true
            playerOne.downOnce = false
            playerOne.firstX = playerOne.lastX
            playerOne.firstY = playerOne.lastY
        end
        if key == "s" and playerOne.direction ~= "up" and playerOne.downOnce == false then
            playerOne.direction = "down"
            playerOne.directionUpDown = -1
            playerOne.radians = math.pi
            drawPlayerOneLine()
            playerOne.rightOnce = false
            playerOne.leftOnce = false
            playerOne.upOnce = false
            playerOne.downOnce = true
            playerOne.firstX = playerOne.lastX
            playerOne.firstY = playerOne.lastY
        end
    end
end

--[[
    PLAYER ONE HELPERS
--]]
function drawPlayerOneLine()
    if playerOne.body then
        local px, py = playerOne:getPosition()

        playerOne.lastX = px
        playerOne.lastY = py
    end

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

function destroyPlayerOne()
    local i = #playerOne.lines
    while i > -1 do
        if playerOne.lines[i] ~= nil then
            playerOne.lines[i] = nil
        end
        table.remove(playerOne.lines, i)
        i = i - 1
    end

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