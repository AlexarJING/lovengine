local go = Class("Game Object")


function go:init(parent,scene,data)
	self.parent = parent
	self.scene = scene
	self.core = scene.core
	self.name = data.name
	self.component = {}


	self.shapes = {}
	self.sprites = {}

	for i,cdata in ipairs(data.component) do
		local com 
		if cdata.ctype == "translate"  then
			self.translate = Translate(cdata)
		elseif cdata.ctype == "shape" then
			com = Shape(cdata)
			table.insert(self.shapes, com)
		elseif cdata.ctype == "sprite" then
			com = Sprite(cdata)
			table.insert(self.sprites, com)
		elseif cdata.ctype == "script" then
			com = Script(cdata)
			self.script = com
		end
		self.component[i] = com
	end

	self.children = {}

	for i, cdata in ipairs(data.children) do
		self.children[i] =  Go(self.scene,cdata)
	end
end


function go:update(dt)
	for i,com in ipairs(self.component) do
		if com.update then
			com:update(dt)
		end
	end

	for i,child in ipairs(self.children) do
		child:update(dt)
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

	for i,v in ipairs(self.children) do
		v:draw()
	end

	love.graphics.pop()
end

return go