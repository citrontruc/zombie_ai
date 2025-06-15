-- An object to create a zombie
-- Zombies are controlled by a state machine.

local ZombieGraphicsHandler = {}
ZombieGraphicsHandler.__index = ZombieGraphicsHandler


function ZombieGraphicsHandler:new(initial_x, initial_y, size_x, size_y, speed)
    local zombie_graphics_handler = {
        size_x=size_x,
        size_y=size_y,
        x=initial_x,
        y=initial_y
    }
    setmetatable(zombie_graphics_handler, ZombieGraphicsHandler)
    return zombie_graphics_handler
end

function ZombieGraphicsHandler:update(x, y)
    self.x, self.y = x, y
end

function ZombieGraphicsHandler:draw()
    love.graphics.rectangle("fill", self.x - self.size_x/2, self.y - self.size_y/2, self.size_x, self.size_y)
end

return ZombieGraphicsHandler