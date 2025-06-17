-- An object to create a zombie
-- Zombies are controlled by a state machine.

local ZombieGraphicsHandler = {}
ZombieGraphicsHandler.__index = ZombieGraphicsHandler


function ZombieGraphicsHandler:new()
    local zombie_graphics_handler = {}
    setmetatable(zombie_graphics_handler, ZombieGraphicsHandler)
    return zombie_graphics_handler
end

function ZombieGraphicsHandler:update()
end

function ZombieGraphicsHandler:draw(x, y, size_x, size_y)
    love.graphics.rectangle("fill", x - size_x/2, y - size_y/2, size_x, size_y)
end

return ZombieGraphicsHandler
