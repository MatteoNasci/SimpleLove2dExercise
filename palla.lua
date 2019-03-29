local palla = {}
palla.startX = 100
palla.startY = 100
palla.speed = 10
palla.radius = 20
palla.drawmode = "line"

palla.jointBodies = {}

palla.body = love.physics.newBody(world, palla.startX, palla.startY, "dynamic")
palla.shape = love.physics.newCircleShape(palla.radius)
palla.fixture = love.physics.newFixture(palla.body, palla.shape, 1)
palla.fixture:setRestitution(0.9) -- zucchero sintattico, chiamo metodo di fixture su palla.fixture

function palla.tick(dt)
    -- palla.y = palla.y + palla.speed * dt
end
function palla.draw()
    love.graphics.circle(palla.drawmode, palla.body:getX(), palla.body:getY(), palla.shape:getRadius())
    local lastBody = palla.body
    for index, body in ipairs(palla.jointBodies) do
        if body ~= nil then
            love.graphics.line(body:getX(), body:getY(), lastBody:getX(), lastBody:getY())
            lastBody = body
        end
    end
end

function palla.addChains(world, chainCount, lenght)
    local lastBody = palla.body
    for i = 1, chainCount - 1 do
        local body = love.physics.newBody(world, lastBody:getX(), lastBody:getY() - lenght * i, "dynamic")
        table.insert(palla.jointBodies, body)
        love.physics.newRopeJoint(
            body,
            lastBody,
            body:getX(),
            body:getY(),
            lastBody:getX(),
            lastBody:getY(),
            lenght,
            false
        )
        lastBody = body
    end

    local staticbody = love.physics.newBody(world, lastBody:getX(), 0, "static")

    table.insert(palla.jointBodies, staticbody)

    love.physics.newRopeJoint(
        staticbody,
        lastBody,
        staticbody:getX(),
        staticbody:getY(),
        lastBody:getX(),
        lastBody:getY(),
        lenght,
        false
    )
end

return palla
