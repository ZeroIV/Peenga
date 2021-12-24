Win = Object:extend()

function Win:new()
    self.timer = 3
end

function Win:onWin(track)
    track:playSound()
end

function Win:setWinner(player)
    self.WINNER = player
end

function Win:update(dt)
    if self.timer > 0 then
        self.timer = self.timer - dt
        print(self.timer or 'shits dicked')
    end
end

function Win:draw()

    if (self.timer <= 0)  then
        if self.WINNER ~= nil then
            love.graphics.print('Winner:\n\nPlayer: ' .. self.WINNER .. '!', 200 , WINDOW_HEIGHT / 4, 0, 3,3)
        end
    end
end

