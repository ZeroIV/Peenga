Pad = Entity:extend()

function Pad:new()
    Pad.super.new(self, 50 , 100, 10, 100)
    self.keyUp = 'up'
    self.keyDown = 'down'
end

function Pad:update(dt)
    if love.keyboard.isDown(self.keyUp) then
        self.yspeed = -400
    elseif love.keyboard.isDown(self.keyDown) then
        self.yspeed = 400
    else
        self.yspeed = 0
    end

    Pad.super.update(self, dt)
end