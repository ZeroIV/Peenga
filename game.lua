Game = Object:extend()

WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
local score_to_win = 1

function Game:new()
    self.scoreSounds = { 
        [1] = Sound('sounds/score/geeg_noice.mp3'),
        [2] = Sound('sounds/score/geeg_ohoho.mp3'),
        [3] = Sound('sounds/score/geeg_sick-nasty.mp3'),
        [4] = Sound('sounds/bounce/geeg_extreme-uhoh.mp3') }

    self.bounceSounds = { 
        [1] = Sound('sounds/bounce/geeg_oah.mp3', 0.75),
        [2] = Sound('sounds/bounce/geeg_extreme-ooh.mp3', 0.75),
        [3] = Sound('sounds/bounce/geeg_augh.mp3', 0.75) }

    self.winTrack = Sound('sounds/win/geeg_win-cream-mix.mp3')
    
    menuMusic:playSound(true)

    gameTitle = love.graphics.newText(gameFont, 'Weega-Pong')
    startOne = love.graphics.newText(gameFont,'1-player')
    startTwo = love.graphics.newText(gameFont,'2-players')
    menuQuit = love.graphics.newText(gameFont,'Quit')
    currentVolumeText = love.graphics.newText(gameFont,
                            string.format('Volume %d', love.audio.getVolume() * 100))
    menuOptions = 
    {
        [1] = startOne,
        [2] = startTwo,
        [3] = menuQuit,
    }

    self.max_selections = #menuOptions

    --should game start?
    self.startGame = false

    --initialize start screen
    --specifing the number of background images to generate
    self.start = Start(10)
    self.userSelection = 1

    --initialize game ball
    self.ball = Ball(ballImage)
    self.scoreLeft = 0
    self.scoreRight = 0
    self.buffer = 0

    --initialize win screen
    self.winScreen = Win()
    self.winner = 0
end

--initializes game settings based on userSelection value
function Game:setOptions()
    self.padLeft = Pad()
    self.padLeft.keyUp = 'w'
    self.padLeft.keyDown = 's'

    if self.userSelection == 1 then
        self.padRight = Pad_Brain()
    else
        self.padRight = Pad()
        self.padRight.x = 740
    end
    menuMusic:stopSound()
end

function Game:keypressed(key)

    --adjust master volume
    if key == 'kp+' then
        Sound:raiseVolume()
        currentVolumeText:set(string.format('Volume %d', love.audio.getVolume()* 100))
    elseif key == 'kp-' then
        Sound:lowerVolume()
        currentVolumeText:set(string.format('Volume %d', love.audio.getVolume() * 100))
    end

    if not self.startGame then

        if self.userSelection > 1 and (key == 'up' or key == 'w') then
            self.userSelection = self.userSelection - 1
        elseif self.userSelection < self.max_selections and (key == 'down' or key == 's') then
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

function Game:onScore(track)
    --check for a winner
    if self.scoreLeft == score_to_win then
        self.winScreen:setWinner(1)
        self.winScreen:onWin(self.winTrack)
        return
    elseif self.scoreRight == score_to_win then
        self.winScreen:setWinner(2)
        self.winScreen:onWin(self.winTrack)
        return
    end   
    --plays the supplied sound track. otherwise plays one randomly
    if not track then
        local i = math.random(#self.scoreSounds - 1)
        self.scoreSounds[i]:playSound()
    else
        track:playSound()
    end
end

function Game:update(dt)

    self.start:update(dt)
    if self.startGame then
        if self.scoreLeft < score_to_win and self.scoreRight < score_to_win then

            self.padLeft:update(dt)

            if self.userSelection == 1 then --right pad is program controlled
                self.padRight:update(self.ball:getXCoordinate(), self.ball:getYCoordinate(), self.ball:getYSpeed(), dt)
            else
                self.padRight:update(dt)
            end

            self.ball:update(dt)

            --buffer is used to prevent a bug where the ball would "stick" to a pad
            --prevents further bounces from occuring in a short period of time
            if self.buffer <= 0 then
                if (self.ball:bounce(self.padLeft, self.bounceSounds) or self.ball:bounce(self.padRight, self.bounceSounds)) then
                    self.buffer = 3
                end
            elseif self.buffer > 0 then
                self.buffer = self.buffer - 1
            end

            --track score
            local ball_status = self.ball:getOutOfBounds()

            if ball_status == 'left' then
                self.scoreRight = self.scoreRight + 1
                self.ball = Ball(ballImage)
                self:onScore(self.scoreSounds[4])
            elseif ball_status == 'right' then
                self.scoreLeft = self.scoreLeft + 1
                self.ball = Ball(ballImage)
                self:onScore()
            end
        else
            self.winScreen:update(dt)
        end
    end
end

function Game:draw()

    if not self.startGame then

        local xMenuOrigin = (WINDOW_WIDTH * 0.35)
        local yMenuOrigin = WINDOW_HEIGHT / 2
        local ymenuItemOffset = 50
        local xBorder = 10

        self.start.draw()

        love.graphics.draw(gameTitle, xMenuOrigin , 100, 0, 3,3)

        for k, v in pairs(menuOptions) do
            love.graphics.draw(menuOptions[k], xMenuOrigin, yMenuOrigin + (ymenuItemOffset * (k-1)), 0 , 3, 2)
        end

        --indicates which item is selected
        if self.userSelection == 1 then
            love.graphics.rectangle('line', xMenuOrigin - xBorder, yMenuOrigin, startOne:getWidth() * 3 + (xBorder * 2), startOne:getHeight() * 2 + 5)
        end
        if self.userSelection == 2 then
            love.graphics.rectangle('line', xMenuOrigin - xBorder, yMenuOrigin + ymenuItemOffset, startTwo:getWidth() * 3 + (xBorder * 2), startTwo:getHeight() * 2 + 5)
        end
        if self.userSelection == 3 then
            love.graphics.rectangle('line', xMenuOrigin - xBorder, yMenuOrigin + ymenuItemOffset * 2, menuQuit:getWidth() * 3 + (xBorder * 2), menuQuit:getHeight() * 2 + 5)
        end

        love.graphics.print('Music:"Space-Cat" by WaxTerk on Newgrounds.com', 10, WINDOW_HEIGHT - 20, 0, 1, 1)
        love.graphics.draw(currentVolumeText, WINDOW_WIDTH -100, WINDOW_HEIGHT - 20, 0, 1, 1)
    else
        if self.scoreLeft < score_to_win and self.scoreRight < score_to_win then          
            self.padLeft:draw()
            self.padRight:draw()
            self.ball:draw()

            love.graphics.print(self.scoreLeft .. ' - ' .. self.scoreRight, (WINDOW_WIDTH / 2 - 50), 20, 0, 3, 3)
        else
            self.winScreen:draw()
        end
    end
end