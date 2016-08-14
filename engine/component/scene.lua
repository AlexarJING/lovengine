local scene = Class("scene")
local Go = require "engine/component/gameobject"

function scene:init(core,data)
	self.core = core
	self.name = data.name
	self.entity = {}
	for i,v in ipairs(data.entity) do
		self[v.name] = Go(nil,self,v)
		self.entity[i] = self[v.id]
	end
	self.factory = {}
	for i,v in ipairs(data.factory) do
		self.factory[v.name] = v
	end

	self:setCallbacks()
end


local all_callbacks = {
	'draw', 'keypressed', 'keyreleased', 
	'mousepressed', 'mousereleased','textinput',"textedited",
	'update',  'gamepadaxis', 'gamepadpressed',
	'gamepadreleased', 'joystickaxis', 'joystickhat',
	'joystickpressed', 'joystickreleased'
}


function scene:setCallbacks()
	for i,event in ipairs(all_callbacks) do
		self[event] = function (self,...)
			for i,go in ipairs(self.entity) do
				if go[event] then
					go[event](go,...)
				end
			end
		end
	end
end


return scene