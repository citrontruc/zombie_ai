-- An object to create a state for our zomboie
-- In the wait state, the zombie waits until the timer is at 1 second.

local ZombieWaitState = {}
ZombieWaitState.__index = ZombieWaitState


function ZombieWaitState:new(zombie)
    local zombie_wait_state = {zombie = zombie}
    setmetatable(zombie_wait_state, ZombieWaitState)
    return zombie_wait_state
end

function ZombieWaitState:update(dt)
    if self.zombie.timer >= 1 then return true end
    return false
end

return ZombieWaitState
