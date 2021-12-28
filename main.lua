function love.load()
    Object = require 'classic'
    require 'game'
    require 'entity'
    require 'start_screen'
    require 'win_screen'
    require 'firework'
    require 'pad'
    require 'ball'
    require 'pad_brain'
    require 'sound'
    
    love.window.setTitle('Weega-Pong')
    gameFont = love.graphics.newFont('fonts/ka1.ttf', 10)

    ballImage = love.graphics.newImage('images/weega_smol.png')

    menuMusic = Sound('sounds/music/Space-Cat.mp3', 0.5)
    love.audio.setVolume(0.5)

    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.keypressed(key)
    game:keypressed(key)
end

function love.draw()
    love.graphics.setFont(gameFont)
    game:draw()
end



