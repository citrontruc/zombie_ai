-- An object to create a zombie
-- Zombies are controlled by a state machine.

local ZombieGraphicsHandler = {}
ZombieGraphicsHandler.__index = ZombieGraphicsHandler


function ZombieGraphicsHandler:new(initial_x, initial_y, size_x, size_y, speed)
    local zombie_graphics_handler = {
    }
    setmetatable(zombie_graphics_handler, ZombieGraphicsHandler)
    return zombie_graphics_handler
end

function ZombieGraphicsHandler:update(dt, joystick)
end

function ZombieGraphicsHandler:draw()
end

return ZombieGraphicsHandler