function drawEndgame()
    local mx, my = love.mouse.getPosition();

    if winner == "Player One" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 200, 200, 1000, 500)
        love.graphics.draw(sprites.p1Wins, 400, 300)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("PLAY AGAIN", 400, 450)
        love.graphics.print("MAIN MENU", 800, 450)

        -- Hovering over the PLAY AGAIN button
        if mx > 400 and mx < 605 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.blueShip, 385, 465, math.pi/2)
        else
            love.mouse.setCursor()
        end

        -- Hovering over the MAIN MENU button
        if mx > 800 and mx < 1005 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.redShip, 785, 465, math.pi/2)
        end
    end

    if winner == "Player Two" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 200, 200, 1000, 500)
        love.graphics.draw(sprites.p2Wins, 400, 300)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("PLAY AGAIN", 400, 450)
        love.graphics.print("MAIN MENU", 800, 450)

        -- Hovering over the PLAY AGAIN button
        if mx > 400 and mx < 605 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.blueShip, 385, 465, math.pi/2)
        else
            love.mouse.setCursor()
        end

        -- Hovering over the MAIN MENU button
        if mx > 800 and mx < 1005 and my > 460 and my < 500 then
            love.mouse.setCursor(pointer)
            love.graphics.draw(sprites.redShip, 785, 465, math.pi/2)
        end
    end
end