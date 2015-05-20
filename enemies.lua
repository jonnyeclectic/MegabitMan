function genEnemy()
    numEnemies = numEnemies + 1 								          -- Keeping track of enemies

    temp = math.random( 0, 17 )

    if temp <= 4 then
        enemy1 = {
            position = { x = math.random( 1050,  1300), y = 500 },
            x_velocity = 250,
            ID = 1,
            height = enemy1Image:getHeight(),
            width = enemy1Image:getWidth(),

            image = love.graphics.newImage( "pic/enemy1.png" ),

            ammo = 1,
            trackx = player.position.x,
            tracky = player.position.y,
            Laser = {image = love.graphics.newImage( "pic/redLaserRay.png")},
        }
        lastGen = "enemy"

        return enemy1
    elseif temp > 4 and temp <= 12 then
        enemy2 = {
            position = { x = math.random( 1050,  1300), y = math.random( 0, 500 ) },
            x_velocity = 100,
            ID = 2,

            image = enemy2Image,
            width = enemy2Image:getWidth(),
            height = enemy2Image:getHeight() ,           --gave enemies an Identification Number and dimensions

            ammo = 10,
            trackx = player.position.x,
            tracky = player.position.y,
            Laser = {image = love.graphics.newImage( "pic/enemybullet.png")},
        }

        lastGen = "enemy"
        return enemy2
    elseif temp > 12  and temp <= 14 then
        lastGen = "wall"
        return walls
    elseif temp > 14 and temp <= 17 then
        if lastGen == "pickUp" then
            return genEnemy()
        else
            pUp = {
                x_velocity = 200,
                x = math.random( 1050, 1300 ),
                y = 600,
                image = powerPickup,
                ID = 1, 									-- signifies powerUp
                height = powerPickup:getHeight(),
                width = powerPickup:getWidth()
            }
            lastGen = "pickUp"
            return pUp
        end
    elseif temp > 17 and temp <= 20 then
        if lastGen == "pickUp" then
            return genEnemy()
        else
            pUp = {
                x_velocity = 200,
                x = math.random( 1050, 1300 ),
                y = 600,
                image = lifePickup,
                ID = 2, 									-- signifies lifeUp
                height = lifePickup:getHeight(),
                width = lifePickup:getWidth()
            }
            lastGen = "pickUp"
            return pUp
        end

    end
end

function genBoss()
    return boss
end
