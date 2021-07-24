--[[
    MENU VARIABLES
--]]
gameState = "menu"
-- gameState = "game"
menuFontSize = love.graphics.newFont(50)

--[[
    MENU UPDATE
--]]


--[[
    MENU DRAW
--]]
function drawMenu()
    love.graphics.setFont(menuFontSize)
    love.graphics.printf("Light Bois", 0, 300, love.graphics.getWidth(), "center")
end

--[[
    MENU KEYPRESSED
--]]