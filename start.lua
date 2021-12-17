Start = Object:extend()

local startBalls = {}

window_width, window_height = love.graphics.getDimensions()

function Start:new(x)
    xMenuOrigin = window_width * 0.50
    yMenuOrigin = window_height * 0.75
    options = {[1] = "Start",[2] = "Quit"}

    for i = 1, x, 1 do
        startBalls[i] = Ball(ballImage)
        startBalls[i].x = math.random(10,window_width-10)
        startBalls[i].y = math.random(10,window_height-10)
        if math.random(1,2) == 2 then
            startBalls[i].xspeed = -400
        else
            startBalls[i].xspeed = 400
        end
        if math.random(1,2) == 2 then
            startBalls[i].yspeed = -400
        else
            startBalls[i].yspeed = 400
        end
        startBalls[i].timer = 0
    end
end

function Start:update(dt)
    for i, Ball in ipairs(startBalls) do
        Ball:update(dt)
        if startBalls[i].x <= 0 then
            startBalls[i].xspeed = -(startBalls[i].xspeed)
        elseif startBalls[i].x + startBalls[i].width >= window_width then
            startBalls[i].xspeed = -(startBalls[i].xspeed)
        end
    end
end

function Start:draw()
    for i, Ball in ipairs(startBalls) do
        Ball:draw()
    end
    love.graphics.print('Weega-Pong', window_width * 0.3 , 100, 0, 4,4)
    for i = 1, #options, 1 do
        love.graphics.print(options[i], xMenuOrigin, yMenuOrigin + (50 * (i-1)), 0 , 1, 1.5)
    end

end