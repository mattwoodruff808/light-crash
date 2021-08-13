--[[
    PLAYER TWO VARIABLES
--]]
local p2StartX = 1322
local p2StartY = 802

playerTwo = world:newRectangleCollider(p2StartX, p2StartY, playerSizeX, playerSizeY, {collision_class = 'PlayerTwo'})
playerTwo:setFixedRotation(true)
playerTwo.x = 1335
playerTwo.y = 815
playerTwo.direction = "up"
-- playerTwo.directionUpDown = 1
-- playerTwo.directionLeftRight = 0
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


--[[
    PLAYER TWO UPDATE
--]]
function playerTwoUpdate(dt)
    if playerTwo.body then
        local px, py = playerTwo:getPosition()

        if playerTwo.direction == "right" then
            playerTwo.x = playerTwo.x + playerSpeed * dt
            playerTwo:setX(px + playerSpeed * dt)
        end
        if playerTwo.direction == "left" then
            playerTwo.x = playerTwo.x - playerSpeed * dt
            playerTwo:setX(px - playerSpeed * dt)
        end
        if playerTwo.direction == "up" then
            playerTwo.y = playerTwo.y - playerSpeed * dt
            playerTwo:setY(py - playerSpeed * dt)
        end
        if playerTwo.direction == "down" then
            playerTwo.y = playerTwo.y + playerSpeed * dt
            playerTwo:setY(py + playerSpeed * dt)
        end
    end

    if playerTwo:enter('Border') then
        destroyPlayerTwo()
    end

    if playerTwo:enter('Trail') then
        destroyPlayerTwo()
    end

    if playerTwo:enter('PlayerOne') then
        destroyPlayerTwo()
    end
end

--[[
    PLAYER TWO DRAW
--]]
function drawPlayerTwo()
    love.graphics.setColor(0.6, 0.6, 1)
    love.graphics.setLineWidth(8)

    if playerTwo.body then
        if playerTwo.direction == "right" then
            love.graphics.line(playerTwo.firstX, playerTwo.firstY, playerTwo.x - 15, playerTwo.y)
            if distanceBetween(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y) > 18 then
                local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.x - 15, playerTwo.y, {collision_class = 'Trail'})
                table.insert(playerTwo.lineColliders, lineCollider)
            end
        end
        if playerTwo.direction == "left" then
            love.graphics.line(playerTwo.firstX, playerTwo.firstY, playerTwo.x + 15, playerTwo.y)
            if distanceBetween(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y) > 18 then
                local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.x + 15, playerTwo.y, {collision_class = 'Trail'})
                table.insert(playerTwo.lineColliders, lineCollider)
            end
        end
        if playerTwo.direction == "up" then
            love.graphics.line(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y + 15)
            if distanceBetween(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y) > 18 then
                local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y + 15, {collision_class = 'Trail'})
                table.insert(playerTwo.lineColliders, lineCollider)
            end
        end
        if playerTwo.direction == "down" then
            love.graphics.line(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y - 15)
            if distanceBetween(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y) > 18 then
                local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.x, playerTwo.y - 15, {collision_class = 'Trail'})
                table.insert(playerTwo.lineColliders, lineCollider)
            end
        end

        for i = 1, #playerTwo.lines do
            local line = playerTwo.lines[i]

            love.graphics.line(line[1], line[2], line[3], line[4])
            love.graphics.circle("fill", line[3], line[4], 4)
        end

        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(1)
        love.graphics.draw(sprites.blueShip, playerTwo.x, playerTwo.y, playerTwo.radians, nil, nil, 15, 15)
    end

    -- love.graphics.print(#playerTwo.lineColliders, 1360, 30)
end

--[[
    PLAYER TWO KEYPRESSED
--]]
function playerTwoKeypressed(key)
    if playerTwo.body then
        if key == "right" and playerTwo.direction ~= "left" and playerTwo.rightOnce == false then
            playerTwo.direction = "right"
            -- playerTwo.directionLeftRight = -1
            playerTwo.radians = math.pi/2
            drawPlayerTwoLine()
            playerTwo.rightOnce = true
            playerTwo.leftOnce = false
            playerTwo.upOnce = false
            playerTwo.downOnce = false
            playerTwo.firstX = playerTwo.lastX
            playerTwo.firstY = playerTwo.lastY
        end
        if key == "left" and playerTwo.direction ~= "right" and playerTwo.leftOnce == false then
            playerTwo.direction = "left"
            -- playerTwo.directionLeftRight = 1
            playerTwo.radians = math.pi*3/2
            drawPlayerTwoLine()
            playerTwo.rightOnce = false
            playerTwo.leftOnce = true
            playerTwo.upOnce = false
            playerTwo.downOnce = false
            playerTwo.firstX = playerTwo.lastX
            playerTwo.firstY = playerTwo.lastY
        end
        if key == "up" and playerTwo.direction ~= "down" and playerTwo.upOnce == false then
            playerTwo.direction = "up"
            -- playerTwo.directionUpDown = 1
            playerTwo.radians = 0
            drawPlayerTwoLine()
            playerTwo.rightOnce = false
            playerTwo.leftOnce = false
            playerTwo.upOnce = true
            playerTwo.downOnce = false
            playerTwo.firstX = playerTwo.lastX
            playerTwo.firstY = playerTwo.lastY
        end
        if key == "down" and playerTwo.direction ~= "up" and playerTwo.downOnce == false then
            playerTwo.direction = "down"
            -- playerTwo.directionUpDown = -1
            playerTwo.radians = math.pi
            drawPlayerTwoLine()
            playerTwo.rightOnce = false
            playerTwo.leftOnce = false
            playerTwo.upOnce = false
            playerTwo.downOnce = true
            playerTwo.firstX = playerTwo.lastX
            playerTwo.firstY = playerTwo.lastY
        end
    end
end

--[[
    PLAYER TWO HELPERS
--]]
function drawPlayerTwoLine()
    if playerTwo.body then
        local px, py = playerTwo:getPosition()

        playerTwo.lastX = px
        playerTwo.lastY = py
    end

    local line = {playerTwo.firstX, playerTwo.firstY, playerTwo.lastX, playerTwo.lastY}
    table.insert(playerTwo.lines, line)

    -- NOTE: I am keeping this for now, because this might be easier on the CPU rates

    -- if playerTwo.direction == "right" then
    --     local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.lastX, playerTwo.lastY + (22 * playerTwo.directionUpDown), {collision_class = 'Trail'})
    --     table.insert(playerTwo.lineColliders, lineCollider)
    -- end
    -- if playerTwo.direction == "left" then
    --     local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.lastX, playerTwo.lastY + (22 * playerTwo.directionUpDown), {collision_class = 'Trail'})
    --     table.insert(playerTwo.lineColliders, lineCollider)
    -- end
    -- if playerTwo.direction == "up" then
    --     local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.lastX + (22 * playerTwo.directionLeftRight), playerTwo.lastY, {collision_class = 'Trail'})
    --     table.insert(playerTwo.lineColliders, lineCollider)
    -- end
    -- if playerTwo.direction == "down" then
    --     local lineCollider = world:newLineCollider(playerTwo.firstX, playerTwo.firstY, playerTwo.lastX + (22 * playerTwo.directionLeftRight), playerTwo.lastY, {collision_class = 'Trail'})
    --     table.insert(playerTwo.lineColliders, lineCollider)
    -- end
end

function destroyPlayerTwo()
    local i = #playerTwo.lines
    while i > -1 do
        if playerTwo.lines[i] ~= nil then
            playerTwo.lines[i] = nil
        end
        table.remove(playerTwo.lines, i)
        i = i - 1
    end

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