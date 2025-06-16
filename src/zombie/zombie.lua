-- An object to create a zombie
-- Zombies are controlled by a state machine.

local ChaseState = require("src.zombie.states.zombie_chase_state")
local IdleState = require("src.zombie.states.zombie_idle_state")

local ZombieGraphicsHandler = require("src.graphics.zombie_graphics_handler")

local Zombie = {}
Zombie.__index = Zombie


function Zombie:new(initial_x, initial_y, size_x, size_y, speed, speed_run, distance_threshold)
    local zombie = {
        x = initial_x,
        y = initial_y,
        size_x = size_x,
        size_y = size_y,
        speed = speed,
        speed_run = speed_run,
        distance_from_player_square = (distance_threshold + 1)^2,
        distance_threshold = distance_threshold,
        graphics_handler = ZombieGraphicsHandler:new(initial_x, initial_y, size_x, size_y, speed),
        angle = 0,
        current_state = "idle",
        timer = 0,
        direction_idle_y = 1,
        direction_idle_x = 1,
    }
    states = {
        idle = IdleState:new(zombie),
        chase = ChaseState:new(zombie)
    }
    zombie.states = states
    setmetatable(zombie, Zombie)
    return zombie
end

-- function to compute relationship to player

function Zombie:compute_distance_from_player(player_x, player_y)
    return (self.y - player_y)^2 + (self.x - player_x)^2
end

function Zombie:get_angle(player_x, player_y)
    return math.atan2(player_y - self.y, player_x - self.x)
end

--function to update zombie
function Zombie:update(dt, player_x, player_y)
    -- Update variables
    self.distance_from_player_square = self:compute_distance_from_player(player_x, player_y)
    self.angle = self:get_angle(player_x, player_y)

    -- Update position, graphics and states
    self.states[self.current_state]:update(dt)
    self.graphics_handler:update(self.x, self.y)
    self.current_state = self:update_state(dt)
end

-- function to update zombie state
function Zombie:update_state(dt)
    if self.distance_from_player_square < self.distance_threshold then return "chase" end
    return "idle"
end

function Zombie:set_timer(dt)
    self.timer = self.timer + dt
end

function Zombie:draw()
    self.graphics_handler:draw()
end

return Zombie
