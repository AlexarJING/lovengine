local shape = Clas("shape")


function shape:init(go,data)
	self.shapetype = data.shapetype 
	self[self.shapetype](data)
	self.offx = data.offx or 0
	self.offy = data.offy or 0
	self.rot = data.rot or 0
	self.drawtype = data.drawtype
	self.color = {unpack(data.color)}
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
	love.graphics.rectangle(self.drawtype,0,0,w,h)
	love.graphics.circle(self.drawtype, r, r, r)
	love.graphics.setCanvas()

end


function shape:draw()
	love.graphics.draw(self.canvas, self.offx,self.offy,self.rot,1,1,self.width/2,self.height/2)
end


return shape