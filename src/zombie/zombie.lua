-- An object to create a zombie
-- Zombies are controlled by a state machine.

local ZombieGraphicsHandler = require("src.graphics.zombie_graphics_handler")

local Zombie = {}
Zombie.__index = Zombie


function Zombie:new(initial_x, initial_y, size_x, size_y, speed)
    local zombie = {
    }
    setmetatable(zombie, Zombie)
    return zombie
end

function Zombie:update(dt, joystick)
end

function Zombie:draw()
end

return Zombie