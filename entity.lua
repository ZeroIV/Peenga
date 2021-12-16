Entity = Object:extend()
window_width, window_height = love.graphics.getDimensions()

function Entity:new(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.xspeed = 0
    self.yspeed = 0
end

function Entity:update(dt)
    self.x = self.x + self.xspeed * dt
    self.y = self.y + self.yspeed * dt

    if self.y <= 0 then
        self.y = 0
        self.yspeed = -self.yspeed
    elseif self.y + self.height >= window_height then
        self.y = window_height - self.height
        self.yspeed = -self.yspeed
    end

end

function Entity:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end