-- An object to create a zombie
-- Zombies are controlled by a state machine.

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
        angle = 0,
        current_state = "idle",
        timer = 0,
        idle_coefficient_x = 0,
        idle_coefficient_y = 0,
        states = {}
    }
    setmetatable(zombie, Zombie)
    return zombie
end

function Zombie:set_state(state_key, state_object)
    self.states[state_key] = state_object
end

function Zombie:set_graphic_handler(graphics_handler)
    self.graphics_handler = graphics_handler
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

    -- Do update action from whichever state the zombie is in
    local reset_timer = self.states[self.current_state]:update(dt)
    self:check_for_walls()
    self:update_timer(dt, reset_timer)
    self.current_state = self:update_state(dt, reset_timer)
end

-- Check for walls
function Zombie:check_for_walls()
    self.x = math.min(math.max(self.size_x/2, self.x), love.graphics.getWidth() - self.size_x/2)
    self.y = math.min(math.max(self.size_y/2, self.y), love.graphics.getHeight() - self.size_y/2)
end
-- function to update zombie state
function Zombie:update_state(dt, reset_timer)
    -- If the player is close, we chase him
    if self.distance_from_player_square < self.distance_threshold then return "chase" end
    
    -- If we are idle, we continue until the timer runs out. Same for waiting
    if self.current_state == "idle" and not reset_timer then return "idle" end
    if self.current_state == "wait" and reset_timer then return "idle" end
    local choices = { -1, 0, 1 }
    self.idle_coefficient_x = choices[math.random(#choices)]
    self.idle_coefficient_y = choices[math.random(#choices)]
    return "wait"
end

function Zombie:update_timer(dt, reset_timer)
    if reset_timer then self.timer = 0 end
    self.timer = self.timer + dt
end

function Zombie:draw()
    self.graphics_handler:draw(self.x, self.y, self.size_x, self.size_y)
end

return Zombie
