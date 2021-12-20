PadRight = Entity:extend()

function PadRight:new(difficulty)
    PadRight.super.new(self, 50 , WINDOW_HEIGHT / 2, 10, 100)
    
    SHORTDISTANCE = WINDOW_WIDTH * 0.25
    MEDIUMDISTANCE = WINDOW_WIDTH * 0.50
    LONGDISTANCE = WINDOW_WIDTH * 0.50

    if difficulty == 1 then
        BASESPEED = 500
    elseif difficulty == 2 then
        BASESPEED = 700
    else
        BASESPEED = 900
    end
end

function PadRight:update(ballHeight,ballPosition, ballSpeed, dt)

    local ballDistance = self.x - ballPosition
    local yballSpeed = ballSpeed
    HALFSPEED = BASESPEED / 2

    if ballDistance >= LONGDISTANCE then
        self.yspeed = 0

    elseif ballDistance >= MEDIUMDISTANCE then
        if yballSpeed < 0 then                              --ball moving up
            if ballHeight < (self.y - 15) then                   --higher than paddle
                self.yspeed = -HALFSPEED
            elseif ballHeight > (self.y + self.height + 15) then --lower than paddle
                self.yspeed = HALFSPEED
            end  
        elseif yballSpeed > 0 then                          --ball moving down
            if ballHeight < (self.y - 15) then                   --higher than paddle
                self.yspeed = -HALFSPEED
            elseif ballHeight > (self.y + self.height + 15) then --lower than paddle
                self.yspeed = HALFSPEED
            end
        end
    else --ballDistance <= SHORTDISTANCE
        if yballSpeed < 0 then                              --ball moving up
            if ballHeight < (self.y) then                   --higher than paddle
                self.yspeed = -BASESPEED
            elseif ballHeight > (self.y + self.height) then --lower than paddle
                self.yspeed = BASESPEED
            end    
        elseif yballSpeed > 0 then                          --ball moving down
            if ballHeight < (self.y - 15) then              --higher than paddle
                self.yspeed = -BASESPEED
            elseif ballHeight > (self.y + self.height + 15) then      --lower than paddle
                self.yspeed = BASESPEED
            end
        end
    end
    PadRight.super.update(self, dt)
end