--TEAM TWO THIRDS PRESENTS..
--MEGABIT MAN
--BY:
--DILLON MURRAY
--JONATHAN REYES
--RYAN LEVERENZ

require("AnAL")

function love.load()
    flag = false
    --local img = love.graphics.newImage("pic/AnalExplosion.png")--is img used? can we get a better name? Why? It's just Animation library for explosions and OHHHHH NVM
    --anim = newAnimation(img, 96, 96, 0.1, 0)                         -- create animation

    Grassy = love.graphics.newImage("pic/Grassyes2.jpg")              -- background image
    megaEquip = love.graphics.newImage( "pic/megaequip.png" )        -- player's mega equip image
    megaEquip2 = love.graphics.newImage( "pic/megaequip2.png" )        -- player's mega equip image
    enemy1Image = love.graphics.newImage( "pic/enemy1.png" )
    megaenemy1 = love.graphics.newImage( "pic/megaenemy1.png" )      -- enemy1 mega equip image
    enemy2Image = love.graphics.newImage( "pic/Plane06.gif" )
    lifeCount1 = love.graphics.newImage( "pic/1life.png" )
    lifeCount2 = love.graphics.newImage( "pic/2life.png" )
    lifeCount3 = love.graphics.newImage( "pic/3life.png" )
    lifePickup = love.graphics.newImage( "pic/lifePickup.png" )
    wallImage = love.graphics.newImage( "pic/brick.jpg")
    powerPickup = love.graphics.newImage( "pic/jHelm.png" )
    bossImage = love.graphics.newImage( "pic/boss.png")
    logoImage = love.graphics.newImage( "pic/logo.png" )
    titleMenu = love.graphics.newImage( "pic/title.png" )
    deathImage = love.graphics.newImage( "pic/death2.png" )
    small = love.graphics.newImage( "pic/small.png" )

    gameState = "title"
    titleImage = logoImage

    music = love.audio.newSource( "snd/boo.mp3" )        -- sound clip
    love.audio.setVolume( 0.7 )
    love.audio.play( music )

    floor1 = love.graphics.newImage("pic/floor1.png")
    floor2 = love.graphics.newImage("pic/floor2.png")
    pillar = love.graphics.newImage("pic/pillar.png")

    player = {                                                                                                                                               -- player table: contains base image and xy coords.
        image = love.graphics.newImage( "pic/player.png" ),
        position = { x = 0, y = 500 },
        x_velocity = 250,
        y_velocity = 0
    }
    player2 = {                                                                                                                                               -- player table: contains base image and xy coords.
        image = love.graphics.newImage( "pic/player2.png" ),
        position = { x = 0, y = 500 },
        x_velocity = 250,
        y_velocity = 0
    }




    player.on = true

    player.x = 0
    player.y = 500
    player.life = 3
    player.pUps = 1
    player.width = player.image:getWidth()/2
    player.height = player.image:getHeight()                 							--player has dimensions now
    player.bulletSpeed = 800
    player.bullets = {image = love.graphics.newImage( "pic/Bullet0.png")}

    powerUp = true
    pickUps  = {}
    jumpHeight = 1100
    gravity = 2000

    enemies = {}
    enemies1 = { }
    enemies2 = { }
    walls = {}

    Lasers = {}
    Lasers2 = {}
    thisLaser = {}
    bossLasers = {}

    pUps = {}

    pUpTime = 0

    enemyType = {}
    enemy1 = {}
    enemy2 = {}
    enemy3 = {}

    wall = {image = love.graphics.newImage( "pic/brick.jpg")}
    thispUp = {image = love.graphics.newImage( "pic/jHelm.png")}
    bossStage = {}
    boss = {}
    player.bulletSpeed = 800
    powerUp = true
    time = 0                                                         --clock that regulates when to increment score counter
    score = 0
    shotClock = 0
    jumpHeight = 1100
    gravity = 2000                                                   --faster falling
    numEnemies = 0
    numboss = 0
    lastGen = "enemy"
    bosskey = 0

    time = 0                                                         --clock that regulates when to increment score counter
    score = 0
    shotClock = 0
    titleTime = 0.0
    dtotal = 0														 -- for keeping track of time passed in love.update
    winW, winH = love.graphics.getWidth(), love.graphics.getHeight() -- for the sake of drawing images (window width and height)
    math.randomseed( os.time() )   									 -- initialize for random values
end
