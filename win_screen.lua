Win = Object:extend()

function Win:new()
    self.timer1 = 3
    self.timer2 = 4
    self.winner = nil
    self.fireworks = Firework()
end

function Win:onWin(track)
    track:playSound()
end

function Win:setWinner(player)
    self.winner = player
end

function Win:update(dt)
    if self.timer1 > 0 then
        self.timer1 = self.timer1 - dt
    else
        self.fireworks:update(dt)
        self.timer2 = self.timer2 - dt
    end
end

function Win:draw()

    if (self.timer1 <= 0)  then
        if self.winner ~= nil then
            love.graphics.print('Winner:\n\nPlayer: ' .. self.winner .. '!', WINDOW_WIDTH / 2 - 100 , WINDOW_HEIGHT / 4, 0, 3, 3)
            self.fireworks:draw()
            if (self.timer2 <=0) then
                love.graphics.print('Press esc to exit the program', WINDOW_WIDTH / 4 , WINDOW_HEIGHT / 2 , 0, 2, 2)
            end
        end
    end
end

