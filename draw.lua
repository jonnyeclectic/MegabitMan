require("environment")

function love.draw()
    --TODO: add environment draw functions. foreground, background, etc.

    --love.graphics.draw(Grassy)                                             --Draw background (And everything else, below)


    drawBackground()


    if gameState == "title" then
        love.graphics.draw( titleImage, 0, 0 )
    elseif gameState == "death" then
        love.graphics.draw( titleImage, 0, 0 )
        love.graphics.print( "At least you scored: "..score, 418, 435 )
    else
        drawBackground()

        love.graphics.print( "POWER UPS: "..player.pUps, 75, 40 )
        love.graphics.print( "SCORE: "..score, 800, 40 )
        love.graphics.print( "LIFE: ", 800, 65 )
        if player.life == 1 then
            love.graphics.draw( lifeCount1, 830, 60, 0, 0.3 )
        elseif player.life == 2 then
            love.graphics.draw( lifeCount2, 830, 60, 0, 0.3 )
        elseif player.life == 3 then
            love.graphics.draw( lifeCount3, 830, 60, 0, 0.3 )
        end

        for i, v in pairs( pickUps ) do
            if v.ID == 1 then
                love.graphics.draw( v.image, v.x, v.y, 0, 2 )
            elseif v.ID == 2 then
                love.graphics.draw( v.image, v.x, v.y )
            end
        end


        for i,v in ipairs(player.bullets) do
            v.x = v.x + (v.dx * timedt)
            for ii, vv in ipairs(enemies) do
                if love.CheckCollision(v.x,v.y,vv.position.x,vv.position.y,vv.width, vv.height) then
                    flag = true
                    animx = vv.position.x
                    animy = vv.position.y
                    time0 = love.timer.getTime()
                end
            end
        end

        if flag and time2 > (time0 - 1) then
            --anim:draw(animx+100, animy+100)         -- Draw the animation
        end



        love.graphics.draw( player.image, player.position.x, player.position.y, 0, 0.5 )
        if player2.on == true then
            --love.graphics.print( "TIME LEFT: "..(pUpTime - (love.timer.getTime() - pUpTime)), 75, 65 )
            love.graphics.draw( player2.image, player2.position.x, player2.position.y, 0, 0.5 )
            love.graphics.draw( megaEquip2, player2.position.x, player2.position.y, 0, 0.5 )
        end

        for i, v in pairs( enemies ) do
            love.graphics.draw( v.image, v.position.x, v.position.y )
        end

        for i, v in pairs( walls ) do
            love.graphics.draw( wall.image, v.x, v.y)
        end

        for i, v in pairs( bossStage ) do
            love.graphics.draw( v.image, v.x, v.y)
        end

        for i, v in ipairs(bossLasers) do
            love.graphics.draw(v.image, v.x, v.y, 0, 1)
        end

        for i, v in pairs( pUps ) do
            love.graphics.draw( thispUp.image, v.x, v.y)
        end


        for i, v in ipairs(player.bullets) do
            love.graphics.draw(player.bullets.image, v.x, v.y, 0, 1) -- player.position.x, player.position.y, 1)
        end

        for i, v in ipairs(Lasers) do
            --if v.ammo > 0 then
            if v.ID == 1 then
                love.graphics.draw(enemy1.Laser.image, v.x, v.y, 0, 1) -- enemy1.position.x, enemy1.position.y, 1)
            end
        end

        for i, v in ipairs(Lasers2) do
            if v.ID == 2 then
                love.graphics.draw(enemy2.Laser.image, v.x, v.y, 0, 1) -- enemy1.position.x, enemy1.position.y, 1)
            end
        end

        if powerUp == true then
            love.graphics.draw( megaEquip, player.position.x, player.position.y, 0, 0.5 )
            for i, v in pairs( enemies ) do
                if v.ID == 1 then
                    love.graphics.draw( megaenemy1, v.position.x, v.position.y )
                end
            end
        end

        drawFloor()
    end
end
