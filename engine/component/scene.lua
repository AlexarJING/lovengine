local scene = Class("scene")
local Go = require "engine/component/gameobject"

function scene:init(core,data)
	self.core = core
	self.name = data.name

	self.factory = {}
	for i,v in ipairs(data.factory) do
		self.factory[v.name] = v
	end

	self.entity = {}
	for i,v in ipairs(data.entity) do
		self[v.name] = Go(nil,self,v)
		table.insert(self.entity,self[v.name])
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

	self._draw = self.draw

	self.draw = function(...)
		self:drawOrder()
		self:_draw(...)
	end
end

function scene:addEntity(go)
	table.insert(self.entity, go)
end


function scene:drawOrder()
	table.sort( self.entity, 
		function(a,b)  
			return a.translate.z < b.translate.z
		end)
end

return scene