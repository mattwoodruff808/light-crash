--[[
    MENU VARIABLES
--]]
gameState = "menu"
-- gameState = "game"

menuState = 1

otherTextFontSize = love.graphics.newFont(40)

--[[
    MENU UPDATE
--]]


--[[
    MENU DRAW
--]]
function drawMenu()
    love.graphics.draw(sprites.menuLogo, 200, 50)

    if menuState == 1 then
        love.graphics.setFont(otherTextFontSize)
        begin = love.graphics.printf("Begin", 0, 450, love.graphics.getWidth(), "center")

        credits = love.graphics.printf("Credits", 0, 525, love.graphics.getWidth(), "center")
    end
end

--[[
    MENU MOUSEPRESSED
--]]
function menuMousepressed(x, y, button)
    
end