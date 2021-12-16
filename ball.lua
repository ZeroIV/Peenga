Ball = Entity:extend()
local ball_origin_x, ball_origin_y = love.graphics.getDimensions()

--defaults to basic ball if no image is supplied
function Ball:new(image)
    if image ~= nil then
        self.image = image
        width = self.image:getWidth()
        height = self.image:getHeight()
    else
        width = 15
        height = 15
    end

    Ball.super.new(self, ball_origin_x / 2 , ball_origin_y / 2, width, height)

--[[     if math.random(1, 2) == 1 then
        self.yspeed = 500
    else
        self.yspeed = -500
    end ]]
    self.yspeed = -500
    if math.random(1, 2) == 1 then
        self.xspeed = 400
    else
        self.xspeed = -400
    end

    self.timer = 1
end

function Ball:update(dt)

    if self.timer > 0 then
        self.timer = self.timer - dt
    else
        Ball.super.update(self, dt)
    end
end

function Ball:draw()
    if self.image ~= nil then
        love.graphics.draw(self.image,self.x,self.y, math.rad(0), 1, 1, self.width / 2, self.height / 2)
    else
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    end
end

function Ball:getPosition()
    x = self.x - self.width / 2
    return x
end

function Ball:getHeight()
    y = self.y - self.height / 2
    return y
end

function Ball:getSpeed()
    return self.yspeed
end

function Ball:bounce(e, sound)
    local left1 = self.x
    local right1 = self.x + self.width
    local top1 = self.y
    local bottom1 = self.y + self.height

    local left2 = e.x
    local right2 = e.x + e.width
    local top2 = e.y
    local bottom2 = e.y + e.height


    if left1 < right2 and right1 > left2 and top1 < bottom2 and bottom1 > top2 then
        self.xspeed = -self.xspeed
        -- if sound ~=nil then  --play sound when ball hits paddle
        --     sound:playSound()
        -- end
    end

    function Ball:getOutOfBounds()
        if self.x + self.width < 0  then
            return 'left'
        elseif self.x > ball_origin_x then
            return 'right'
        end
    end

end
