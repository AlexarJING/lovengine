local go = Class("Game Object")


function go:init(parent,scene,data)
	
	self.parent = parent
	self.scene = scene
	self.core = scene.core
	self.name = data.name
	self.component = {}


	self.shapes = {}
	self.sprites = {}

	for i,cdata in ipairs(data.component or {}) do
		local com 
		if cdata.ctype == "translate"  then
			self.translate = Translate(self,cdata)
		elseif cdata.ctype == "shape" then
			com = Shape(self,cdata)
			table.insert(self.shapes, com)
		elseif cdata.ctype == "sprite" then
			com = Sprite(self,cdata)
			table.insert(self.sprites, com)
		elseif cdata.ctype == "script" then
			com = Script(self,cdata)
			self.script = com
		end
		table.insert(self.component,com)
	end

	self.children = {}

	for i, childName in ipairs(data.children or {}) do
		local go = Go(self,self.scene,self.scene.factory[childName])
		self.scene:addEntity(go)
		go.translate:setParent(self)
	end

	self:setCallbacks()
end

local all_callbacks = {
	'keypressed', 'keyreleased', 
	'mousepressed', 'mousereleased','textinput',"textedited",
	'gamepadaxis', 'gamepadpressed',
	'gamepadreleased', 'joystickaxis', 'joystickhat',
	'joystickpressed', 'joystickreleased'
}

function go:setCallbacks()
	self.allcb= {}
	
	for _,callback in ipairs(all_callbacks) do
		self.allcb[callback] = {}

		for _,com in ipairs(self.component) do
			if com[callback] then
				table.insert(self.allcb[callback], com[callback])
			end
		end
		self[callback] = function(go,...)
			for i,cb in ipairs(self.allcb[callback]) do
				cb(go,...)
			end
			--[[
			for i,child in ipairs(self.children) do
				if child[callback] then child[callback](child,...) end
			end]]
		end
	end
end

function go:addComponent(com)
	if com.ctype == "translate"  then
		self.translate = com
	elseif com.ctype == "shape" then
		table.insert(self.shapes, com)
	elseif com.ctype == "sprite" then
		table.insert(self.sprites, com)
	elseif com.ctype == "script" then
		self.script = com
	end

	for _,callback in ipairs(all_callbacks) do	

		if com[callback] then
			table.insert(self.allcb[callback], com[callback])
		end	
	end
	table.insert(self.component,com)
end

function go:addChild(child)
	child.translate:setParent(self)
end

function go:update(dt)
	if self.script then self.script.update(self,dt) end

	for i,com in ipairs(self.component) do
		if com.update and com~= self.script then
			com:update(dt)
		end
	end

end


function go:draw()
	
	love.graphics.push()
	self.translate:apply()

	for i,v in ipairs(self.sprites) do
		v:draw()
	end
	for i,v in ipairs(self.shapes) do
		v:draw()
	end
	--[[
	for i,v in ipairs(self.children) do
		v:draw()
	end
]]
	love.graphics.pop()
end

return go