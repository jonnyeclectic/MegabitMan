function love.clean(deleteThis, sourceObject)
    for i,v in ipairs(deleteThis) do                                      --Erase all enemies/bullets marked for death
        table.remove(sourceObject,v)
    end
end

function love.focus(f) gameIsPaused = not f end                           --Pauses game when user clicks off window

function love.quit()
    love.event.push("quit")
end

function love.death()
    gameState = "death"
    numEnemies = 0
    numboss = 0
    lastGen = "enemy"
    bosskey = 0
    time = 0
    --score = 0
    shotClock = 0
    titleTime = 0.0
    dtotal = 0
    flag = false
    player.on = true
    powerUp = true

    player.x = 0
    player.y = 500
    player.position.x = 0
    player.position.y = 500
    player2.position.x = 0
    player2.position.y = 500
    player.life = 3
    player.pUps = 1

    local deleteBullet = {}
    local deleteenemy = {}
    local deleteLasers = {}
    local deleteLasers2 = {}
    local deleteboss = {}
    local deletepickUps = {}
    local deletewalls = {}
    local deletebLaser = {}

    for i, v in pairs(bossStage) do
        bossStage[i] = nil
    end
    for i, v in pairs(enemies) do
        enemies[i] = nil
    end
    for i, v in pairs( pickUps ) do
        pickUps[i] = nil
    end
    for i, v in ipairs(Lasers) do
        Lasers[i] = nil
    end
    for i, v in ipairs(Lasers2) do
        Lasers2[i] = nil
    end
    for i,v in ipairs(player.bullets) do
        player.bullets[i] = nil
    end
    for i, v in pairs(walls) do
        walls[i] = nil
    end
    for i, v in ipairs(bossLasers) do
        bossLasers[i] = nil
    end
end

