--[[
love.graphics.draw(floor2,
x,0,	--xy
0,		--r
4,4,	--scale
0,0		--shearing
)
]]--

local floorSize = 100

require("list")

local flooring = {}
for x = 0, floorSize, 1 do
    flooring[x] = math.random(2)%2
end
local pillars = 0

local floorState = 0


function drawBackground(tick)
    love.graphics.draw(Grassy)
    pillars = (pillars + 0.25)%256
    for x = 0, 5,1 do
        love.graphics.draw(pillar,x*256 - pillars,0,0,4, ((800*17)/(128*16)),0,0)
    end
end

function drawFloor(tick)
    for x = 0, floorSize + 20, 1 do
        if flooring[x%floorSize] == 1 then
            love.graphics.draw(floor2,x*128 - floorState,736,0,4,4,0,0)
        else
            love.graphics.draw(floor1,x*128 - floorState,736,0,4,4,0,0)
        end
    end
    floorState = (floorState+4)%(floorSize*128)
end
