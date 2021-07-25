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
    if menuState == 1 or menuState == 2 or menuState == 3 then
        love.graphics.draw(sprites.menuLogo, 200, 50)
    end

    if menuState == 1 then
        love.graphics.setFont(otherTextFontSize)
        begin = love.graphics.printf("Play", 0, 450, love.graphics.getWidth(), "center")

        credits = love.graphics.printf("Credits", 0, 525, love.graphics.getWidth(), "center")
    end
end

--[[
    MENU MOUSEPRESSED
--]]
function menuMousepressed(x, y, button)
    -- For clicking on menu options
end