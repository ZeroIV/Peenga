Game = Object:extend()

function Game:new()
    ballImage = love.graphics.newImage('images/weega_smol.png')
    bonkSound = Sound('sounds/klonk.mp3')
    popSound = Sound('sounds/pop.mp3')
    self.padLeft = Pad()
    self.padLeft.keyUp = 'w'
    self.padLeft.keyDown = 's'
    self.padRight = PadRight()
    self.padRight.x = 740
    self.ball = Ball(ballImage)

    self.scoreLeft = 0
    self.scoreRight = 0
end

function Game:update(dt)
    self.padLeft:update(dt)
    self.padRight:update(self.ball.y,dt)
    self.ball:update(dt)
    self.ball:bounce(self.padLeft, popSound)
    self.ball:bounce(self.padRight, popSound)

    
    local ball_status = self.ball:getOutOfBounds()

    if ball_status == 'left' then
        self.scoreRight = self.scoreRight + 1
        self.ball = Ball(ballImage)
        bonkSound:playSound()
    elseif ball_status == 'right' then
        self.scoreLeft = self.scoreLeft + 1
        self.ball = Ball(ballImage)
        bonkSound:playSound()
    end
end

function Game:draw()
    self.padLeft:draw()
    self.padRight:draw()
    self.ball:draw()

    love.graphics.print(self.scoreLeft .. ' - ' .. self.scoreRight, 350, 20, 0, 4, 4)
end