-- A class to control our player character
-- TODO; set up controller support (right now, only dpad)

local PlayerController = {}
PlayerController.__index = PlayerController

--creation
function PlayerController:new(control_type, speed)
    local object = {
        control_type = control_type,
        speed = speed,
        acceleration = 1000
    }
    setmetatable(object, PlayerController)
    return object
end

--setter
function PlayerController:set_speed(speed_value)
    self.speed = speed_value
end

function PlayerController:set_control_type(control_type, joystick)
    self.control_type = control_type
end

--update
function PlayerController:update(dt, x, y, size_x, size_y, joystick)
    local move_function = {
        keyboard = PlayerController.move_with_keyboard,
        controller = PlayerController.move_with_controller
    }

    chosen_move_function = move_function[self.control_type]
    x, y = chosen_move_function(self, dt, x, y, joystick)
    x, y = self:check_position(x, y, size_x, size_y)
    return x, y
end

--movement functions
--movement with keyboard
function PlayerController:move_with_keyboard(dt, x,y, joystick)
    if love.keyboard.isDown("down") then
        y = y + self.speed * dt
    end
    if love.keyboard.isDown("up") then
        y = y - self.speed * dt
    end
    if love.keyboard.isDown("right") then
        x = x + self.speed * dt
    end
    if love.keyboard.isDown("left") then
        x = x - self.speed * dt
    end
    return x, y
end

-- movement with controller
function PlayerController:move_with_controller(dt, x,y, joystick)
    if not joystick then return x, y end
    if joystick:isGamepadDown("dpdown") then
        y = y + self.speed * dt
    end
    if joystick:isGamepadDown("dpup")then
        y = y - self.speed * dt
    end
    if joystick:isGamepadDown("dpright") then
        x = x + self.speed * dt
    end
    if joystick:isGamepadDown("dpleft")then
        x = x - self.speed * dt
    end
    return x, y
end

-- Check that player stays on screen
function PlayerController:check_position(x, y, size_x, size_y)
    x = math.min(math.max(size_x/2, x), love.graphics.getWidth() - size_x/2)
    y = math.min(math.max(size_y/2, y), love.graphics.getHeight() - size_y/2)
    return x, y
end

return PlayerController
