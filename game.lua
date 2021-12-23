Game = Object:extend()

WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

function Game:new()

    ballImage = love.graphics.newImage('images/weega_smol.png')
    bonkSound = Sound('sounds/klonk.mp3', 0.5)
    popSound = Sound('sounds/pop.mp3', 0.5)
    menuMusic = Sound('sounds/Space-Cat.mp3', 0.5)
    menuMusic:playSound(true)
    
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

    --has user made a selection?
    self.startGame = false

    self.buffer = 0
end

--initializes game settings based on userSelection value
function Game:setOptions()
    self.padLeft = Pad()
    self.padLeft.keyUp = 'w'
    self.padLeft.keyDown = 's'

    if self.userSelection == 1 then
        self.padRight = Pad_Brain(1)
    else
        self.padRight = Pad()
        self.padRight.x = 740
    end
    menuMusic:stopSound()
end

function Game:update(dt)

    self.start:update(dt)

    if self.startGame then
        self.padLeft:update(dt)

        if self.userSelection == 1 then --right pad is program controlled
            self.padRight:update(self.ball:getXCoordinate(), self.ball:getYCoordinate(), self.ball:getYSpeed(), dt)
        else
            self.padRight:update(dt)
        end

        self.ball:update(dt)

        --buffer is used to prevent instances where the ball would "stick" to a pad
        --prevents further bounces from occuring in a short period of time
        if self.buffer <= 0 then
            if (self.ball:bounce(self.padLeft, popSound) or self.ball:bounce(self.padRight, popSound)) then
                self.buffer = 1
            end
        elseif self.buffer > 0 then
            self.buffer = self.buffer - dt
        end

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

    if key == 'kp+' then
        Sound:raiseVolume()
    elseif key == 'kp-' then
        Sound:lowerVolume()
    end

    if not self.startGame then

        if self.userSelection > 1 and (key == 'up' or key == 'w') then
            self.userSelection = self.userSelection - 1
        elseif self.userSelection < 3 and (key == 'down' or key == 's') then
            self.userSelection = self.userSelection + 1
        end

        if key == 'space' or key == 'return' then
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
        local xMenuOrigin = (WINDOW_WIDTH * 0.35)
        local yMenuOrigin = WINDOW_HEIGHT / 2
        local ymenuItemOffset = 50
        local xBorder = 10

        love.graphics.draw(gameTitle, xMenuOrigin , 100, 0, 3,3)

        for k, v in pairs(menuOptions) do
            love.graphics.draw(menuOptions[k], xMenuOrigin, yMenuOrigin + (ymenuItemOffset * (k-1)), 0 , 3, 2)
        end

        --displays which item is currently selected
        if self.userSelection == 1 then
            love.graphics.rectangle('line', xMenuOrigin - xBorder, yMenuOrigin, startOne:getWidth() * 3 + (xBorder * 2), startOne:getHeight() * 2 + 5)
        end
        if self.userSelection == 2 then
            love.graphics.rectangle('line', xMenuOrigin - xBorder, yMenuOrigin + ymenuItemOffset, startTwo:getWidth() * 3 + (xBorder * 2), startTwo:getHeight() * 2 + 5)
        end
        if self.userSelection == 3 then
            love.graphics.rectangle('line', xMenuOrigin - xBorder, yMenuOrigin + ymenuItemOffset * 2, menuQuit:getWidth() * 3 + (xBorder * 2), menuQuit:getHeight() * 2 + 5)
        end

        love.graphics.print('Music:"Space-Cat" by WaxTerk on Newgrounds.com', 10, 580, 0, 1, 1)
    else
        self.padLeft:draw()
        self.padRight:draw()
        self.ball:draw()
    
        love.graphics.print(self.scoreLeft .. ' - ' .. self.scoreRight, (WINDOW_WIDTH / 2 - 50), 20, 0, 3, 3)
    end
end