Sound = Object:extend()

function Sound:new(source)
	self.source = love.sound.newSoundData(source)
end

function Sound:playSound()
	sound = love.audio.newSource(self.source)
	sound:play()
end