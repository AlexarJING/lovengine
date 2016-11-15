local scene = Class("scene")
local Go = require "engine/component/gameobject"

function scene:init(core,data)
	self.core = core
	self.name = data.name or "null"
	
	self:newWorld()

	self.factory = {}
	for i,v in ipairs(data.factory or {}) do
		self.factory[v.name] = v
	end

	self.entity = {}
	for i,v in ipairs(data.entity or {}) do
		self[v.name] = Go(self,v)
		table.insert(self.entity,self[v.name])
	end
	

	self:setCallbacks()
end


local all_callbacks = {
	'draw', 'keypressed', 'keyreleased', 
	'mousepressed', 'mousereleased','textinput',"textedited",
	'update',  'gamepadaxis', 'gamepadpressed',
	'gamepadreleased', 'joystickaxis', 'joystickhat',
	'joystickpressed', 'joystickreleased' ,"keydown"
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

	self._update = self.update
	self.update = function(...)
		self.physicUpdate(...)
		self._update(...)
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

function scene:physicUpdate(dt)
	if self.world then
		self.world:update(dt)
	end
end

local function beginContact(f1,f2,...)
	local go1 = f1:getUserData()
	local go2 = f2:getUserData()
	if go1.script and go1.script.beginContact then
		go1.script.beginContact(go1,go2,...)
	end
	if go2.script and go2.script.beginContact then
		go2.script.beginContact(go2,go1,...)
	end
end
local function endContact(f1,f2,...)
	local go1 = f1:getUserData()
	local go2 = f2:getUserData()
	if go1.script and go1.script.endContact then
		go1.script.endContact(go1,go2,...)
	end
	if go2.script and go2.script.endContact then
		go2.script.endContact(go2,go1,...)
	end
end
local function preSolve(f1,f2,...)
	local go1 = f1:getUserData()
	local go2 = f2:getUserData()
	if go1.script and go1.script.preSolve then
		go1.script.preSolve(go1,go2,...)
	end
	if go2.script and go2.script.preSolve then
		go2.script.preSolve(go2,go1,...)
	end
end
local function postSolve(f1,f2,...)
	local go1 = f1:getUserData()
	local go2 = f2:getUserData()
	if go1.script and go1.script.postSolve then
		go1.script.postSolve(go1,go2,...)
	end
	if go2.script and go2.script.postSolve then
		go2.script.postSolve(go2,go1,...)
	end
end
function scene:newWorld()
	love.physics.setMeter(self.meter or 64)
	self.world = love.physics.newWorld(self.gx or 0, self.gy or 0)
	self.world:setCallbacks( beginContact, endContact, preSolve, postSolve )
end


return scene