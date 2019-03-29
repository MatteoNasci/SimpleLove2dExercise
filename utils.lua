local utils = {}

function utils.createBody(world, startX, startY, bodyMode, restitution, shape)
    local body = love.physics.newBody(world, startX, startY, bodyMode)
    local fixture = love.physics.newFixture(body, shape, 1)
    fixture:setRestitution(restitution) -- zucchero sintattico, chiamo metodo di fixture su palla.fixture
    return body
end

function utils.createDynamicBody(world, startX, startY, restitution, shape)
    return utils.createBody(world, startX, startY, "dynamic", restitution, shape)
end
function utils.createKinematicBody(world, startX, startY, restitution, shape)
    return utils.createBody(world, startX, startY, "kinematic", restitution, shape)
end

function utils.createStaticBody(world, startX, startY, restitution, shape)
    return utils.createBody(world, startX, startY, "static", restitution, shape)
end

function utils.createStaticBox(world, startX, startY, width, height, restitution)
    local shape = love.physics.newRectangleShape(width, height)
    return utils.createStaticBody(world, startX, startY, restitution, shape)
end
function utils.createDynamicSphere(world, startX, startY, radius, restitution)
    local shape = love.physics.newCircleShape(radius)
    return utils.createDynamicBody(world, startX, startY, restitution, shape)
end

function utils.createKinematicSphere(world, startX, startY, radius, restitution)
    local shape = love.physics.newCircleShape(radius)
    return utils.createKinematicBody(world, startX, startY, restitution, shape), shape
end

return utils
