local gun = {}
local bullet = require("bullet")

local bullets = {}
gun.width = 100
gun.height = 10
gun.y = 0
gun.x = love.graphics.getWidth() - gun.width
gun.speed = 200
function gun.shoot()
    table.insert(bullets, bullet.new(world, gun.x, gun.y, -200, 0, 5))
end

function gun.moveUp(dt)
    gun.y = gun.y - gun.speed * dt
    if gun.y < 0 then
        gun.y = 0
    end
end
function gun.moveDown(dt)
    gun.y = gun.y + gun.speed * dt
    if gun.y + gun.height > love.graphics.getHeight() then
        gun.y = love.graphics.getHeight() - gun.height
    end
end

function gun.tick(dt)
    local indexes = {}
    for index, b in ipairs(bullets) do
        bullet.tick(dt, b)
        if not bullet.isAlive(b) then
            table.insert(indexes, index)
        end
    end
    for i = #indexes, 1, -1 do
        bullet.destroy(bullets[i])
        table.remove(bullets, i)
    end
end

function gun.draw()
    love.graphics.rectangle("fill", gun.x, gun.y, gun.width, gun.height)
    for index, b in ipairs(bullets) do
        bullet.draw(b)
    end
end

return gun
