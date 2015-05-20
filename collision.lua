function love.CheckCollision(bulletX,bulletY,enemyX,enemyY,enemyWidth, enemyHeight)
    local enemyW, enemyH = enemyX + enemyWidth, enemyY + enemyHeight

    return bulletX > enemyX and bulletX < enemyW and bulletY <= enemyY + 200 and bulletY >= enemyY

end

function love.enemyCollision(deleteThis, index, enemy, enemies)
    if player.position.x - player.width > (enemy.position.x - enemy.width) and player.position.x < (enemy.position.x + enemy.width/2) and player.position.y > (enemy.position.y - enemy.height/2) and player.position.y <= (enemy.position.y + enemy.height/2) then
        if (player.position.y - player.height) < enemy.position.y - enemy.height and player.position.y <= 505 then
            -- score = 0                                                 --Add to the score
            --table.insert(deleteThis, index)                              --Store the index (ID) of the enemy that got shot
            --love.clean(deleteThis, enemies)
            return true
        end
    end

end
