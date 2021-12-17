function love.load()
    Object = require 'classic'
    require 'game'
    require 'start'
    require 'entity'
    require 'pad'
    require 'ball'
    require 'rightpad'
    require 'sound'
    
    love.window.setTitle('Weega-Pong')
    gameFont = love.graphics.newFont('fonts/ka1.ttf', 10)
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



