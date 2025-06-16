-- An object to create a state for our zomboie
-- In the idle state, the zombie walks randomly.

local ZombieIdleState = {}
ZombieIdleState.__index = ZombieIdleState


function ZombieIdleState:new(zombie)
    local zombie_idle_state = {zombie = zombie}
    setmetatable(zombie_idle_state, ZombieIdleState)
    return zombie_idle_state
end

function ZombieIdleState:update(dt)
    self.zombie.x = self.zombie.x + self.zombie.speed * (math.random(1, 2) * 2 - 3) * dt
    self.zombie.y = self.zombie.y + self.zombie.speed * (math.random(1, 2) * 2 - 3) * dt
end

return ZombieIdleState
