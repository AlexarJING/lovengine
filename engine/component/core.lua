local engine = Class("engine")


local all_callbacks = {
	'draw', 'errhand', 'focus', 'keypressed', 'keyreleased', 'mousefocus',
	'mousepressed', 'mousereleased', 'quit', 'resize', 'textinput',"textedited",
	'threaderror', 'update', 'visible', 'gamepadaxis', 'gamepadpressed',
	'gamepadreleased', 'joystickadded', 'joystickaxis', 'joystickhat',
	'joystickpressed', 'joystickreleased', 'joystickremoved',"keydown"
}


local _love = {}

function engine:init(path)
	self.data = loadstring(love.filesystem.read(path))()
	love.window.setTitle(self.data.name or "untitled")
	success = love.window.setMode(self.data.width or 800,self.data.height or 600)

	self.resource = {}
	self.scenes = {}
	for name, sceneData in pairs(self.data.scene or {}) do
		self.scenes[name] = Scene(self,sceneData)
	end

	self.currentScene = self.scenes[self.data.entry] or {}
	

	self:setCallbacks()
end

local newFunc= {
	image = love.graphics.newImage,
	font = love.graphics.newFont,
}


function engine:require(path,rType)
	if self.resource[path] then 
		return self.resource[path]
	else
		self.resource[path] = newFunc[rType](path)
		return self.resource[path]
	end
end

function engine:setCallbacks()
	for i,event in ipairs(all_callbacks) do
		_love[event] = love[event]
		love[event] = function(...)
			local func = self.currentScene[event]
			--print(self.currentScene,event,func)
			if func then
				func(self.currentScene,...)
			end
			if _love[event] then _love[event](...) end
		end
	end

end

return engine