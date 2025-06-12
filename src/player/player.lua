-- An object to create a player character
-- This object can be moved by using the keyboard or a controller

-- An object to handle how we control the player and an object to handle graphics
local PlayerController = require("src.player.player_controller")
local PlayerGraphicsHandler = require("src.graphics.player_graphics_handler")

local Player = {}
Player.__index = Player


function Player:new(initial_x, initial_y, size_x, size_y, speed)
    local control_type = "keyboard"
    local player = {
        player_object = true,
        x = initial_x,
        y = initial_y,
        size_x = size_x,
        size_y = size_y,
        player_controller = PlayerController:new(control_type, speed),
        graphics_handler = PlayerGraphicsHandler:new(size_x, size_y),
        pushable_x = false,
        pushable_y = false
    }
    setmetatable(player, Player)
    return player
end

--Updates position using the player controller
function Player:update(dt, joystick)
    self.x, self.y = self.player_controller:update(dt, self.x, self.y, self.size_x, self.size_y, joystick)
    self.graphics_handler:update(self.x, self.y)
end

-- Player can't be moved by collisions.
function Player:collide_x(x)
end

function Player:collide_y(y)
end

-- Uses the graphic handler to draw the player on screen.
function Player:draw()
    self.graphics_handler:draw()
end

return Player
