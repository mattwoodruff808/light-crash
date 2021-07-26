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
        love.graphics.draw(sprites.playText, 600, 400)

        love.graphics.draw(sprites.creditsText, 550, 525)
    end
end

--[[
    MENU MOUSEPRESSED
--]]
function menuMousepressed(x, y, button)
    -- For clicking on menu options
end