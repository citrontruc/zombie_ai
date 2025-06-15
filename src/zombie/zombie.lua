-- An object to create a zombie
-- Zombies are controlled by a state machine.

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
        state = 3,
        dict_state = {
            idle = 1,
            detect_human = 2,
            pursue_human = 3,
            attracted_by_other_zombie = 4,
            lost_human = 5
        },
        timer = 0
    }
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
    local update_function = {
        Zombie.update_idle,
        Zombie.update_stun,
        Zombie.update_pursue_human,
        Zombie.update_go_towards_other_zombie,
        Zombie.update_run_in_direction
    }
    local chosen_update_function = update_function[self.state]
    chosen_update_function(self, dt, player_x, player_y)
    self.distance_from_player_square = self:compute_distance_from_player(player_x, player_y)
    self.graphics_handler:update(self.x, self.y)
    self.state = self:update_state()
end

-- Movement functions
function Zombie:update_idle(dt)
    self.x = self.x + self.speed * (math.random(1, 2) * 2 - 3) * dt
    self.y = self.y + self.speed * (math.random(1, 2) * 2 - 3) * dt
end

function Zombie:update_pursue_human(dt, player_x, player_y)
    self.x = self.x + self.speed_run * math.cos(self.angle) * dt
    self.y = self.y + self.speed_run * math.sin(self.angle) * dt
    self.angle = self:get_angle(player_x, player_y)
end

function Zombie:update_run_in_past_direction(dt)
    self.x = self.x + self.speed_run * math.cos(self.angle) * dt
    self.y = self.y + self.speed_run * math.sin(self.angle) * dt
end

-- function to update zombie state
function Zombie:update_state(dt)
    if self.distance_from_player_square < self.distance_threshold then return 3 end
    return 1
end

function Zombie:set_timer(dt)
    self.timer = self.timer + dt
end

function Zombie:draw()
    self.graphics_handler:draw()
end

return Zombie