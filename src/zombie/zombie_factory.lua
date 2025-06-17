-- An object to create zombie objects
-- The zombie factory handles the creation of all the components relative to zombies


local Zombie = require("src.zombie.zombie")

-- Graphic handler
local ZombieGraphicsHandler = require("src.graphics.zombie_graphics_handler")
local ImageItem = require("src.graphics.image_item")

-- States
local ChaseState = require("src.zombie.states.zombie_chase_state")
local IdleState = require("src.zombie.states.zombie_idle_state")
local WaitState = require("src.zombie.states.zombie_wait_state")

local ZombieFactory = {}
ZombieFactory.__index = ZombieFactory


function ZombieFactory:new()
    local zombie_factory = {}
    setmetatable(zombie_factory, ZombieFactory)
    return zombie_factory
end

function ZombieFactory:create_zombie(initial_x, initial_y, size_x, size_y, speed, speed_run, distance_threshold)
    local zombie = Zombie:new(initial_x, initial_y, size_x, size_y, speed, speed_run, distance_threshold)
    local zombie_graphics_handler = ZombieGraphicsHandler:new()
    local chase_state = ChaseState:new(zombie)
    local idle_state = IdleState:new(zombie)
    local wait_state = WaitState:new(zombie)
    
    zombie:set_graphic_handler(zombie_graphics_handler)
    zombie:set_state("chase", chase_state)
    zombie:set_state("idle", idle_state)
    zombie:set_state("wait", wait_state)
    return zombie
end

return ZombieFactory
