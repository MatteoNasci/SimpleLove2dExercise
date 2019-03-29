world = love.physics.newWorld(0, 50, true)
local palla = require("palla")
local utils = require("utils")
local gun = require('gun')
-- palla con joint, rettangolo a destra che si muove su e giu e che spara con spazio, avendo un effetto sulla palla
resources = {}
local pressedShoot = 0
function love.load()
    love.physics.setMeter(64)
    -- ground = utils.createStaticBox(world, 0, 600, 1000, 100, 0.9)
    -- resources.cash = love.graphics.newImage("cash.png")
    palla.addChains(world, 5, 50)
end

function love.update(dt)
    world:update(dt)
    gun.tick(dt)
    if love.keyboard.isDown("up") then
        gun.moveUp(dt)
    elseif love.keyboard.isDown("down") then 
        gun.moveDown(dt)
    end

    if love.keyboard.isDown("space") then --shoot
        pressedShoot = 1
    elseif pressedShoot == 1 then
        pressedShoot = 0
        gun.shoot()
    end
    -- palla.tick(dt)
end

function love.draw()
    -- love.graphics.rectangle("line", ground:getX(), ground:getY() - 50, 1000, 100)
    -- love.graphics.draw(resources.cash, 100, 100)
    -- love.graphics.print("Hello World", 300, 10)
    palla.draw()
    gun.draw()
end
