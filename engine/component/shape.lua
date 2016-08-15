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
	self[self.shapetype](self,data)
	
end

function shape:rectangle(data)
	local w = data.w
	local h = data.h
	self.width = w
	self.height = h
	self.canvas = love.graphics.newCanvas(w,h)
	love.graphics.setCanvas(self.canvas)
	love.graphics.setColor(self.color)
	love.graphics.rectangle(self.drawtype,0,0,w,h)
	love.graphics.setCanvas()
end

function shape:circle(data)
	local r = data.r
	local w = r*2
	local h = w
	self.width = w
	self.height = h
	self.canvas = love.graphics.newCanvas(w,h)
	love.graphics.setCanvas(self.canvas)
	love.graphics.setColor(self.color)
	love.graphics.circle(self.drawtype, r, r, r)
	love.graphics.setCanvas()

end


function shape:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.canvas, self.offx,self.offy,self.rot,1,1,self.width/2,self.height/2)
end


return shape