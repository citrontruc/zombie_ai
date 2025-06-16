-- An object to create a state for our zomboie
-- In the chase state, the zombie walks towards the player.

local ZombieChaseState = {}
ZombieChaseState.__index = ZombieChaseState


function ZombieChaseState:new(zombie)
    local zombie_chase_state = {zombie = zombie}
    setmetatable(zombie_chase_state, ZombieChaseState)
    return zombie_chase_state
end

function ZombieChaseState:update(dt)
    self.zombie.x = self.zombie.x + self.zombie.speed_run * math.cos(self.zombie.angle) * dt
    self.zombie.y = self.zombie.y + self.zombie.speed_run * math.sin(self.zombie.angle) * dt
end

return ZombieChaseState
