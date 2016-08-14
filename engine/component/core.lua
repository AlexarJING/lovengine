local engine = Class("engine")


local all_callbacks = {
	'draw', 'errhand', 'focus', 'keypressed', 'keyreleased', 'mousefocus',
	'mousepressed', 'mousereleased', 'quit', 'resize', 'textinput',"textedited",
	'threaderror', 'update', 'visible', 'gamepadaxis', 'gamepadpressed',
	'gamepadreleased', 'joystickadded', 'joystickaxis', 'joystickhat',
	'joystickpressed', 'joystickreleased', 'joystickremoved'
}


local _love = {}

function engine:init()
	self.data = require "data"
	self.scenes = {}
	for name, sceneData in pairs(self.data.scene) do
		self.scenes[name] = Scene(self,sceneData)
	end

	self.currentScene = self.data.entry
	self:setCallbacks()
	self.resource = {}
end

local newFunc= {
	image = love.graphics.newImage,
	font = love.graphics.newFont,
}


function engine:require(path,rType)
	if self.resource[path] then 
		return self.resource[path]
	else
		return newFunc[rType]
	end
end

function engine:setCallbacks()
	for i,event in ipairs(all_callbacks) do
		_love[event] = love[event]
		love[event] = function(...)
			local func = self.currentScene[event]
			if func then
				func(self.currentScene,...)
			end
			if _love[event] then _love[event](...) end
		end
	end

end

return engine