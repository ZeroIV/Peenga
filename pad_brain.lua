Pad_Brain = Entity:extend()

function Pad_Brain:new()
    Pad_Brain.super.new(self, 740 , WINDOW_HEIGHT / 2, 10, 100)
    
    MEDIUMDISTANCE = WINDOW_WIDTH / 2 - 95

    BASESPEED = 500
end

function Pad_Brain:update(ballXCoordinate, ballYCoordinate, ballYSpeed, dt)

    local ball_distance = self.x - ballXCoordinate
    local ball_vertical_speed = ballYSpeed
    local dead_zone_val = 15

    if ball_distance >= MEDIUMDISTANCE then
        self.yspeed = 0
    elseif ball_distance < MEDIUMDISTANCE then
                                        --ball moving up
        if ball_vertical_speed < 0 then
            if ballYCoordinate < (self.y + dead_zone_val) then
                self.yspeed = -BASESPEED
            elseif ballYCoordinate > (self.y + self.height - dead_zone_val) then
                self.yspeed = BASESPEED
            end
        elseif ball_vertical_speed > 0 then --ball moving down
            if ballYCoordinate < (self.y - dead_zone_val) then
                self.yspeed = -BASESPEED
            elseif ballYCoordinate > (self.y + self.height + dead_zone_val) then
                self.yspeed = BASESPEED
            end
        end
    end

    Pad_Brain.super.update(self, dt)
end