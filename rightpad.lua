PadRight = Entity:extend()

function PadRight:new()
    PadRight.super.new(self, 50 , 100, 10, 100)
end

function PadRight:update(ballPosition, dt)
    if ballPosition < (self.y - self.height / 2) then
        self.yspeed = -500
    elseif ballPosition > (self.y + 15) then
        self.yspeed = 500
    else
        self.yspeed = 0
    end

    PadRight.super.update(self, dt)
end