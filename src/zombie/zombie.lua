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
        graphics_handler = ZombieGraphicsHandler:new(),
        angle = 0,
        state = 1,
        dict_state = {
            "idle",
            "detect_human",
            "pursue_human",
            "attracted_by_other_zombie",
            "lost_human"
        },
    }
    setmetatable(zombie, Zombie)
    return zombie
end

function Zombie:compute_distance_from_player(x_player, y_player)
    return (self.y - y_player)^2 + (self.x - x1_player)^2
end

function Zombie:get_angle(x_player, y_player)
    return math.atan2(self.y - y_player, self.x - x1_player)
end

function Zombie:update(dt, x_player, y_player)
    local update_function = {
        Zombie.update_idle,
        Zombie.update_stun,
        Zombie.update_pursue_human,
        Zombie.update_go_towards_other_zombie,
        Zombie.update_run_in_direction
    }
    local chosen_update_function = update_function[self.state]
    chosen_update_function(self, x_player, y_player, dt)
    self.distance_from_player_square = self.compute_distance_from_player(x_player, y_player)
    self.state = self.update_state()
end

function Zombie:update_pursue_human(dt)
    self.x = self.x + self.speed_run * math.cos(self.angle) * dt
    self.y = self.y + self.speed_run * math.sin(self.angle) * dt
    self.angle = self.get_angle(x_player, y_player)
end

function Zombie:update_run_in_past_direction(dt)
    self.x = self.x + self.speed_run * math.cos(self.angle) * dt
    self.y = self.y + self.speed_run * math.sin(self.angle) * dt
end

function Zombie:draw()
    self.graphics_handler:draw(dt, self.state)
end

return Zombie