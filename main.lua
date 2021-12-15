function love.load()
    Object = require 'classic'
    require 'game'
    require 'entity'
    require 'pad'
    require 'ball'
    require 'rightpad'
    require 'sound'
    
    love.window.setTitle('Peenga')
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end



