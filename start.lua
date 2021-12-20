Start = Object:extend()

--container for start screen background objects
local start_Balls = {}

function Start:new(x)

    --populate container with ball entities
    for i = 1, x, 1 do
        start_Balls[i] = Ball(ballImage)
        start_Balls[i].x = math.random(10,WINDOW_WIDTH-10)
        start_Balls[i].y = math.random(10,WINDOW_HEIGHT-10)
        if math.random(1,2) == 2 then
            start_Balls[i].xspeed = -400
        else
            start_Balls[i].xspeed = 400
        end
        if math.random(1,2) == 2 then
            start_Balls[i].yspeed = -400
        else
            start_Balls[i].yspeed = 400
        end
        start_Balls[i].timer = 0
    end
end

function Start:update(dt)
    
    for i, Ball in ipairs(start_Balls) do
        Ball:update(dt)
        if start_Balls[i].x <= 0 then
            start_Balls[i].xspeed = -(start_Balls[i].xspeed)
        elseif start_Balls[i].x + start_Balls[i].width >= WINDOW_WIDTH then
            start_Balls[i].xspeed = -(start_Balls[i].xspeed)
        end
    end

end

-- function Start:keypressed(key)
--     local i = 1
--     if key == 'up' and i > 1 then
--         i = i - 1
--     elseif key == 'down' and i < 2 then
--         i = i + 1
--     end
--     self.user_Selection = i
-- end

function Start:draw()

    for i, Ball in ipairs(start_Balls) do
        Ball:draw()
    end

end