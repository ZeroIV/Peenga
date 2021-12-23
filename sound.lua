Sound = Object:extend()

function Sound:new(source, x)
	self.source = love.sound.newSoundData(source)
	self.sound = love.audio.newSource(self.source)

	if x then
		self.sound:setVolume(x)
	end
end

function Sound:playSound(loop)
	if loop then
		self.sound:setLooping(true)
	end
	self.sound:play()
end

function Sound:Volume(x)
	self.sound:setVolume(x)
end

function Sound:raiseVolume()
	local currentVolume = love.audio.getVolume()
	if currentVolume >= 0.9 then
		love.audio.setVolume(1)
	else
		love.audio.setVolume(currentVolume + 0.1)
	end
end

function Sound:lowerVolume()
	local currentVolume = love.audio.getVolume()
	if currentVolume < 0.1 then
		love.audio.setVolume(0)
	else
		love.audio.setVolume(currentVolume - 0.1)
	end
end

function Sound:stopSound()
	self.sound:stop()
end