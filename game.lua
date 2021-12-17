Game = Object:extend()

function Game:new()
    ballImage = love.graphics.newImage('images/weega_smol.png')
    bonkSound = Sound('sounds/klonk.mp3')
    popSound = Sound('sounds/pop.mp3')

    --initialize start screen
    self.start = Start(10)

    --initialize paddles
    self.padLeft = Pad()
    self.padLeft.keyUp = 'w'
    self.padLeft.keyDown = 's'
    self.padRight = PadRight(1)
    self.padRight.x = 740

    --initialize game ball 
    self.ball = Ball(ballImage)
    self.gameStart = false
    self.scoreLeft = 0
    self.scoreRight = 0
end

function Game:update(dt)
    self.start:update(dt)
    if self.gameStart then
        self.padLeft:update(dt)
        self.padRight:update(self.ball:getHeight(), self.ball:getPosition(),self.ball:getSpeed() ,dt)
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
end

function Game:keypressed(key)
    if key == 'space' then
        self.gameStart = true
    elseif key == 'escape' then
        love.event.quit()
    end
end

function Game:draw()
    if not self.gameStart then
        self.start.draw()
    else
        self.padLeft:draw()
        self.padRight:draw()
        self.ball:draw()
    
        love.graphics.print(self.scoreLeft .. ' - ' .. self.scoreRight, 350, 20, 0, 4, 4)
    end
end