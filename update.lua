function love.update( dt )
    if love.timer.getTime() - pUpTime > 10 then
        player2.on = false
    end

    if gameState == "title" then
        titleTime = titleTime + dt
        if titleTime <= 3 then
            titleImage = logoImage
        else
            titleImage = titleMenu
            score = 0
        end
    elseif gameState == "death" then
        titleTime = titleTime + dt
        if titleTime <= 3 then
            titleImage = deathImage
        else
            gameState = "title"
        end
    else

        time2 = love.timer.getTime()
        timedt= dt
        dtotal = dtotal + dt
        shotClock = shotClock + dt

        --anim:update(dt)                                                		  -- Updates the animation. (Enables frame changes)

        if gameIsPaused then
            return
        end
        if not gameIsPaused then
            time = time + 1                                                   --Start in game clock
        end

        if love.keyboard.isDown( " " ) and powerUp == false and player.position.y > -100 then                  -- spacebar to jump
            player.y_velocity = player.y_velocity + jumpHeight * timedt * 2
            player.position.y = player.position.y - jumpHeight * timedt
        end

        if love.keyboard.isDown( " " ) and powerUp == true and player.position.y > -100 then

            player.y_velocity = player.y_velocity + jumpHeight * dt * 2
            player.position.y = player.position.y - jumpHeight * dt

        elseif player.y_velocity ~= 0 then
            player.position.y = player.position.y - player.y_velocity * dt * 2 -- gravity
            player.y_velocity = player.y_velocity - gravity * dt * 2

            if player.position.y  < 500 then
                player.position.y = player.position.y + gravity * dt
            end

            if player.position.y >= 500 then
                player.y_velocity = 0
                player.position.y = 500
            end

            if player.position.y < -100 then
                player.position.y = -100
            end

        end

        if player.position.x > 800 then                                          -- stops player at edges of screen
            player.position.x = 800
        end
        if player.position.x < -50 then
            player.position.x = -50
        end

        if love.keyboard.isDown( "right" ) then
            player.position.x = player.position.x + (2 * player.x_velocity * dt)  -- move right continuously
        end
        if love.keyboard.isDown( "left" ) then
            player.position.x = player.position.x - (2 * player2.x_velocity * dt)  -- move left continuously
        end

        if player2.position.x  <= player.position.x then
            player2.position.x = player2.position.x + (0.2 * gravity * dt)  -- move right continuously
        end

        if player2.position.x  >= player.position.x then
            player2.position.x = player2.position.x - (0.2 * gravity * dt)  -- move right continuously
        end

        if player2.position.y  > player.position.y then
            player2.position.y = player2.position.y - (0.3 * gravity * dt)  -- move right continuously
        end

        if player2.position.y  < player.position.y then
            player2.position.y = player2.position.y + (0.3 * gravity * dt)  -- move right continuously
        end


        if dtotal >= 0 then
            enemyType = genEnemy()


            if enemyType == enemy1 or enemyType == enemy2 then
                table.insert( enemies, enemyType )   				        --Prepare for conflict!
            elseif enemyType == walls then
                tempy = math.random( 300,  800)
                for i = 1,5 do
                    local wall = {}
                    wall.x = 1300
                    wall.y = tempy - (i * 50)
                    wall.dx = 175
                    wall.ammo = 0
                    height = (wallImage:getHeight())*5
                    width = wallImage:getWidth()
                    table.insert(walls, wall)
                end

            elseif enemyType == pUp then
                table.insert( pickUps, pUp )
            end

            score = score + 5													-- score+1 every second
            if score >= 350 then
                dtotal = dtotal - 1
                bosskey = 1
            elseif score > 300 then
                dtotal = dtotal - 2
                bosskey = 0
            else
                dtotal = dtotal - 3
                bosskey = 0
            end
        end

        if bosskey == 1 and numboss == 0 then
            local thisBoss = {}
            thisBoss.x = 1200
            thisBoss.y = 500
            thisBoss.dx = 100
            thisBoss.ammo = 10
            thisBoss.health = 75
            thisBoss.width = 295
            thisBoss.height = 216
            thisBoss.y = 300
            thisBoss.dx = 100
            thisBoss.ammo = 10
            thisBoss.health = 75
            thisBoss.width = bossImage:getWidth()
            thisBoss.height = bossImage:getHeight()
            thisBoss.image = bossImage
            thisBoss.trackx = player.position.x
            thisBoss.tracky = player.position.y
            table.insert( bossStage, thisBoss)

            numboss = numboss + 1

        end

        local deleteBullet = {}                                          -- keeps track of which bullet collided
        local deleteenemy = {}                                           --keeps track of which enemy1 got shot
        local deleteLasers = {}
        local deleteLasers2 = {}
        local deleteboss = {}
        local deletepUps = {}
        local deletepickUps = {}

        for i, v in pairs(bossStage) do

            if v.x <= 400 then
                v.direction = 0
            elseif v.x >= 700 then
                v.direction = 1
            end

            if v.direction == 1 then
                v.x = v.x - (dt * v.dx)
            elseif v.direction == 0 then
                v.x = v.x + (dt * v.dx)
            end

            bosstracker = 0

            if v.ammo > 0 then --bossshotClock >= 0 and v.ammo > 0 then

                local thisLaser = {}
                thisLaser.x = v.x          --how far we should put the bullet
                thisLaser.y = v.y --+ v.height/2 --(enemyType.height) -- - 280) --how high we should put the bullet (adjustment to match with arm)
                thisLaser.dx = (0.5) * player.bulletSpeed
                thisLaser.ID = v.ID
                thisLaser.trackery = v.tracky
                thisLaser.trackerx = v.trackx
                thisLaser.tracker = math.atan2(v.y - v.tracky , v.x - v.trackx) * (dt) --    how high we should put the bullet (adjustment to match with arm)
                thisLaser.image = love.graphics.newImage( "pic/enemybullet.png")
                table.insert( bossLasers, thisLaser )
                v.ammo = v.ammo - 1
            end

            if v.x < -900 then                 --If Enemy is off screen to the left (ran past player)
                table.insert( deleteboss, i )						-- delete enemy when off screen
                numboss = numboss - 1
            end
        end



        for i, v in pairs(walls) do
            v.x = v.x - (dt * v.dx)         --Enemies constantly run TOWARDS the player

            if player.position.x > (v.x - 200) and (player.position.x < v.x - 20) and player.position.y > (v.y - 200) and player.position.y < (v.y + 30) then
                if score >= 10 then
                    score = score - 10                                                          --Placeholder for player's death (player dies by enemy contact)
                    --score = 0
                end
                --Placeholder for player's death (player dies by enemy contact)
                player.position.x = v.x - 200
            elseif player.position.x > (v.x) and (player.position.x < v.x + 20) and player.position.y > (v.y - 200) and player.position.y < (v.y + 100) then
                player.position.x = v.x + 20
            elseif player.position.x > (v.x - 100) and (player.position.x < v.x + 50) and player.position.y > (v.y + 50) and player.position.y < (v.y - 200) then
                player.position.y = v.y - 200
                player.position.x = v.x - 100
            end
        end

        for i, v in pairs(enemies) do
            v.position.x = v.position.x - (v.x_velocity * dt)         --Enemies constantly run TOWARDS the player

            tracker = 0
            if shotClock >= 1 and v.ammo > 0 then

                local thisLaser = {}
                thisLaser.x = v.position.x          --how far we should put the bullet
                thisLaser.y = v.position.y + v.height --(enemyType.height) -- - 280) --how high we should put the bullet (adjustment to match with arm)
                thisLaser.dx = (0.5) * player.bulletSpeed
                thisLaser.ID = v.ID
                thisLaser.trackery = v.tracky
                thisLaser.trackerx = v.trackx

                if thisLaser.ID == 1 then
                    music2 = love.audio.newSource( "snd/Fire.wav" , "static")        -- sound clip
                    music2:setVolume( 0.05 )
                    music2:setPitch(0.5) -- one octave lower
                    love.audio.play( music2 )
                    table.insert( Lasers, thisLaser )                 -- FIRE!
                elseif thisLaser.ID == 2 then
                    music3 = love.audio.newSource( "snd/Fire.wav" )        -- sound clip
                    music3:setVolume( 0.05 )
                    music3:setPitch(0.7) -- one octave lower
                    love.audio.play( music3 )
                    thisLaser.tracker = math.atan2(v.position.y - v.tracky , v.position.x - v.trackx) * (dt) --    how high we should put the bullet (adjustment to match with arm)
                    table.insert( Lasers2, thisLaser )
                end
                v.ammo = v.ammo - 1
            end

            if v.position.x < -900 then                 --If Enemy is off screen to the left (ran past player)
                table.insert( deleteenemy, i )						-- delete enemy when off screen
                numEnemies = numEnemies - 1
            end

            if v.ID == 1 and love.enemyCollision(deleteenemy, i, v, enemies) then

                if player.life >= 1 and player2.on == false then
                    player.life = player.life - 1
                elseif player.life < 1 then
                    love.death()
                elseif score >= 10 then
                    score = score - 10
                end

                table.insert(deleteenemy, i)
            elseif v.ID ==2 and love.CheckCollision(v.position.x,v.position.y,player.position.x,player.position.y, player.width, player.height) then
                if player.life >= 1 and player2.on == false then
                    player.life = player.life - 1
                elseif player.life < 1 then
                    love.death()
                elseif score >= 10 then
                    score = score - 10
                end

                table.insert(deleteenemy, i)
            end

        end

        for i, v in pairs( pickUps ) do
            v.x = v.x - (v.x_velocity * dt)
            if love.CheckCollision( v.x, v.y, player.position.x, player.position.y, player.width, player.height ) then
                if v.ID == 1 then
                    if player.pUps < 2 then
                        player.pUps = player.pUps + 1
                    end
                elseif v.ID == 2 and player.life < 3 then
                    player.life = player.life + 1
                elseif v.ID == 3 then
                    love.shrink(player.position.x, player.position.y)
                end
                table.insert( deletepickUps, i )
            end
        end

        for i, v in pairs(Lasers) do
            v.x = v.x - (v.dx * dt)          						--how far we should put the bullet

            if love.CheckCollision(v.x,v.y,player.position.x,player.position.y, player.width, player.height) then
                if player.life >= 1 then
                    player.life = player.life - 1
                end
                if player.life < 1 then
                    love.death()
                end

                table.insert(deleteLasers, i)
            end

            if v.x < -1000 then
                table.insert( deleteLasers, i )
            end
        end

        for i, v in pairs(Lasers2) do

            v.x = v.x - (v.dx * dt)          						--how far we should put the bullet

            if v.trackerx <= v.x then
                v.y = v.y - v.dx * v.tracker
            end

            if v.trackerx > v.x then
                v.y = v.y - v.dx * (v.tracker)
            end

            if love.CheckCollision(v.x,v.y,player.position.x,player.position.y, player.width, player.height) then
                if player.life >= 1 and player2.on == false then
                    player.life = player.life - 1
                elseif player.life < 1 then
                    love.death()
                elseif score >= 10 then
                    score = score - 10
                end
                table.insert(deleteLasers2, i)

            end

            if v.x < -1000 then
                --table.insert( deleteLasers2, i )
            end
        end

        for i,v in ipairs(player.bullets) do
            v.x = v.x + (v.dx * dt)   -- move them to the right

            -- mark shots that are not visible for removal
            if v.x > 1000 then
                table.insert(deleteBullet, i)
            end

            -- check for collision with enemies
            for ii, vv in pairs(enemies) do
                if love.CheckCollision(v.x,v.y,vv.position.x,vv.position.y,vv.width, vv.height) then
                    score = score + 100
                    table.insert(deleteenemy, ii) -- mark that enemy1 for removal
                    numEnemies = numEnemies - 1
                    table.insert(deleteBullet, i)  -- mark the shot to be removed
                end
            end

            for ii, vv in pairs(bossStage) do
                if love.CheckCollision(v.x,v.y,vv.x,vv.y,vv.width, vv.height) then
                    vv.health = vv.health - 1
                    if vv.health <= 0 then
                        score = score + 1000
                        table.insert(deleteboss, ii) -- mark that enemy1 for removal
                        numboss = numboss - 1
                    end
                    table.insert(deleteBullet, i)  -- mark the shot to be removed
                end
            end
        end

        if shotClock >= 1 then
            shotClock = shotClock - 1
        end


        love.clean(deleteenemy, enemies)
        love.clean(deleteBullet, player.bullets)
        love.clean(deleteLasers, Lasers)
        love.clean(deleteLasers2, Lasers2)
        love.clean(deleteboss, bossStage)
        love.clean(deletepUps, pUps)
        love.clean(deletepickUps, pickUps)

    end
end

