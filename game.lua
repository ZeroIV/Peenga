Game = Object:extend()

function Game:new()

    ballImage = love.graphics.newImage('images/weega_smol.png')
    bonkSound = Sound('sounds/klonk.mp3')
    popSound = Sound('sounds/pop.mp3')

    xMenuOrigin = (WINDOW_WIDTH / 2) - 50
    yMenuOrigin = WINDOW_HEIGHT / 2
    
    gameTitle = love.graphics.newText(gameFont, 'Weega-Pong')
    startOne = love.graphics.newText(gameFont,'1-player')
    startTwo = love.graphics.newText(gameFont,'2-players')
    menuQuit = love.graphics.newText(gameFont,'Quit')
    menuOptions = 
    {
        [1] = startOne,
        [2] = startTwo,
        [3] = menuQuit
    }

    --initialize start screen
    self.start = Start(10)
    self.userSelection = 1

    --initialize game ball 
    self.ball = Ball(ballImage)
    self.scoreLeft = 0
    self.scoreRight = 0

    --game should start
    self.startGame = false

end

--initializes game settings based on userSelection value
function Game:setOptions()
    self.padLeft = Pad()
    self.padLeft.keyUp = 'w'
    self.padLeft.keyDown = 's'

    if self.userSelection == 1 then
        self.padRight = PadRight(1)
        self.padRight.x = 740
    else
        self.padRight = Pad()
        self.padRight.x = 740
    end
end

function Game:update(dt)

    self.start:update(dt)

    if self.startGame then
        self.padLeft:update(dt)

        if self.userSelection == 1 then --right pad is program controlled
            self.padRight:update(self.ball:getHeight(), self.ball:getPosition(),self.ball:getSpeed(), dt)
        else
            self.padRight:update(dt)
        end

        self.ball:update(dt)
        self.ball:bounce(self.padLeft, popSound)
        self.ball:bounce(self.padRight, popSound)
        
        --track score
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

    if not self.startGame then

        if self.userSelection > 1 and (key == 'up' or key == 'w') then
            self.userSelection = self.userSelection - 1
        elseif self.userSelection < 3 and (key == 'down' or key == 's') then
            self.userSelection = self.userSelection + 1
        end

        if key == 'space' then
            if self.userSelection == 1 or self.userSelection == 2 then
                self:setOptions()
                self.startGame = true
            else
                love.event.quit()
            end
        end

    end

    --immediately exits the program
    if key == 'escape' then
        love.event.quit()
    end
end

function Game:draw()

    if not self.startGame then
        self.start.draw()
        love.graphics.draw(gameTitle, WINDOW_WIDTH * 0.35 , 100, 0, 3,3)

        for k, v in pairs(menuOptions) do
            love.graphics.draw(menuOptions[k], xMenuOrigin, yMenuOrigin + (50 * (k-1)), 0 , 3, 2)
        end

        --displays which option is currently selected
        if self.userSelection == 1 then
            love.graphics.rectangle('line', xMenuOrigin -10, yMenuOrigin, startOne:getWidth() * 3 + 20, startOne:getHeight() * 2 + 5)
        end
        if self.userSelection == 2 then
            love.graphics.rectangle('line', xMenuOrigin -10, yMenuOrigin + 50, startTwo:getWidth() * 3 + 20, startTwo:getHeight() * 2 + 5)
        end
        if self.userSelection == 3 then
            love.graphics.rectangle('line', xMenuOrigin -10, yMenuOrigin + 100, menuQuit:getWidth() * 3 + 20, menuQuit:getHeight() * 2 + 5)
        end

    else
        self.padLeft:draw()
        self.padRight:draw()
        self.ball:draw()
    
        love.graphics.print(self.scoreLeft .. ' - ' .. self.scoreRight, (WINDOW_WIDTH / 2 - 50), 20, 0, 3, 3)
    end
end