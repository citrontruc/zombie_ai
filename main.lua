
-- Imports of our item
local Player = require("src.player.player")

-- Variables info
local test = ""

-- Change sizeof screen
love.window.setMode(1200, 800, flags)

-- Main methods
function love.load()
    -- We create a player and a grid that will store all of our objects

    -- Controls to take care of our controller
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    player:update(dt, joystick)
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    player:draw()
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
