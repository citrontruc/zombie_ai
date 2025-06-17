-- Imports of our item
local Player = require("src.player.player")
local ZombieFactory = require("src.zombie.zombie_factory")

-- Variables info
local player_x = 100
local player_y = 100
local player_size_x = 20
local player_size_y = 20
local player_speed = 400

local zombie_x = 500
local zombie_y = 500
local zombie_size_x = 20
local zombie_size_y = 20
local zombie_speed = 100
local zombie_speed_run = 100
local zombie_distance_threshold = 300^2
local zombie_factory = ZombieFactory:new()

-- Change sizeof screen
love.window.setMode(1200, 800, flags)

-- Main methods
function love.load()
    player = Player:new(player_x, player_y, player_size_x, player_size_y, player_speed)
    zombie = zombie_factory:create_zombie(zombie_x, zombie_y, zombie_size_x, zombie_size_y, zombie_speed, zombie_speed_run, zombie_distance_threshold)
    -- Controls to take care of our controller
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    player:update(dt, joystick)
    zombie:update(dt, player.x, player.y)
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    player:draw()
    zombie:draw()
end


-- Methods to change control type.
-- If a controller is pressed, we change to detect controller input
function love.keypressed(key, scancode, isrepeat)
   player.player_controller:set_control_type("keyboard")
end

function love.gamepadpressed(joy, button)
    player.player_controller:set_control_type("controller", joystick)
end

function love.joystickadded(j)
    joystick = j  -- support hot-plugging controllers
end
