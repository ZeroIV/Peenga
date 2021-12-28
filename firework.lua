Firework = Object:extend()

local particles = {}

function Firework:new()
    self:createParticles()
end

--particles for firework display
function Firework:createParticles()
    local max_particles = love.math.random(10, 30)
    local x = WINDOW_WIDTH / 2
    local y = WINDOW_HEIGHT + 10

    for i = 1, max_particles do
        particles[i] = Ball()
        particles[i].x = x
        particles[i].y = y
        particles[i].width = 5
        particles[i].height = 5
        particles[i].xspeed = love.math.randomNormal(200,0)
        particles[i].yspeed = love.math.randomNormal(100, 400)
    end
end

function Firework:update(dt)
    for k, particle in ipairs(particles) do
        particle:update(dt)
    end
end

function Firework:draw()
    for k, particle in ipairs(particles) do
            particle:draw()
    end
end