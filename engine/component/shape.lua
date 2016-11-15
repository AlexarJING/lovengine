local shape = Class("shape")


function shape:init(go,data)
	self.ctype = "shape"
	self.go = go
	self.name = data.name or "unnamed "..self.ctype
	self.shapetype = data.shapetype
	self.color = data.color and {unpack(data.color)} or {255,255,255,255}
	self.drawtype = data.drawtype or "line"
	self.offx = data.offx or 0
	self.offy = data.offy or 0
	self.rot = data.rot or 0
	self.data = data
end

function shape:rectangle()
	local w = self.data.w
	local h = self.data.h
	love.graphics.rectangle(self.drawtype,-w/2+self.offx,-h/2+self.offy,w,h)

end

function shape:circle()
	local r = self.data.r
	love.graphics.circle(self.drawtype, self.offx, self.offy, r)
end

function shape:polygon()
	local verts = self.data.vertex
	love.graphics.polygon(self.drawtype, verts)
end

function shape:draw()
	love.graphics.setColor(self.color)
	self[self.shapetype](self)
end


return shape