local bullet = {}
local utils = require("utils")

function bullet.new(world, x, y, speedX, speedY, radius)
    b = {}
    b.body, b.shape = utils.createKinematicSphere(world, x, y, radius, 0)
    b.speedX = speedX
    b.speedY = speedY
    return b
end

function bullet.tick(dt, b)
    b.body:setX(b.body:getX() + b.speedX * dt)
    b.body:setY(b.body:getY() + b.speedY * dt)
end

function bullet.isAlive(b)
    return (b.body:getX() >= 0) and (b.body:getY() >= 0) and (b.body:getX() <= love.graphics.getWidth()) and
        (b.body:getY() <= love.graphics.getHeight())
end

function bullet.draw(b)
    love.graphics.circle("fill", b.body:getX(), b.body:getY(), b.shape:getRadius())
end

function bullet.destroy(b)
    b.body:destroy()
    b.shape = nil
    b.body = nil
    b.speedX = nil
    b.speedY = nil
end

return bullet
