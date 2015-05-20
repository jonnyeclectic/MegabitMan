--TEAM TWO THIRDS PRESENTS..
--MEGABIT MAN
--BY:
--DILLON MURRAY
--JONATHAN REYES
--RYAN LEVERENZ


require("AnAL")


function love.keypressed( key )                                      -- just to mess with powerup changes
    if player2.on == false and key == "up" then                         -- powerUp is "up" now
        if player.pUps > 0 then
            powerUp = true
            player.pUps = player.pUps - 1
            pUpTime = love.timer.getTime()
            player2.on = true
            player2.position.x = player.position.x
        end


    elseif key == "up" then
        --player.image = small
        powerUp = false
        player2.on = false
    end

    if key =="escape" then
        love.quit()
    end

    if key == " " and powerUp == false and player.y_velocity == 0 then
        player.y_velocity = jumpHeight
    end

    if key == " " then
        if gameState == "title" then
            gameState = "play"
        elseif powerUp == false and player.y_velocity == 0 then
            player.y_velocity = jumpHeight
        end
    end

    if key == "down" and powerUp == true then                        -- if firing and able to fire
        local thisBullet = {}
        thisBullet.x = (player.position.x) + (player.width/2)            -- how far we should put the bullet
        thisBullet.y = (player.position.y) - (player.height/2 - 400)   -- how high we should put the bullet (adjustment to match with arm)
        thisBullet.dx = player.bulletSpeed
        table.insert(player.bullets, thisBullet)                     -- FIRE!
        music2 = love.audio.newSource( "snd/Boom.wav" , "static")        -- sound clip
        music2:setVolume( 1. )
        music2:seek( 0.9, "seconds")
        --music2:setPitch(0.5) -- one octave lower
        love.audio.play( music2 )
        if player2.on == true then
            local thisBullet = {}
            thisBullet.x = (player2.position.x) + player.width/2            -- how far we should put the bullet
            thisBullet.y = (player2.position.y) - (player.height/2 -400 )   -- how high we should put the bullet (adjustment to match with arm)
            thisBullet.dx = player.bulletSpeed
            table.insert(player.bullets, thisBullet)                     -- FIRE!
        end

    end
end
