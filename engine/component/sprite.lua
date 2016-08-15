local sprite = Class("sprite")


function sprite:init(go,data)
	self.ctype = "sprite"
	self.go = go
	self.core = go.core
	self.name = data.name or "unnamed "..self.ctype
	self.offx = data.offx or 0
	self.offy = data.offy or 0
	self.rot = data.rot
	self.tint = data.tint and {unpack(data.tint)} or {255,255,255,255}

	if data.imageName then
		self.image = self.core:require(data.path,"image")
		self.w = self.image:getWidth()
		self.h = self.image:getHeight()
		self.sType = "static"
	elseif data.animationName then
		self.image = self.core:require(data.path,"image")
		self.animation = love.graphics.newAnimation(
			self.image,
			data.fx,data.fy,
			data.w,data.h,
			data.gw,data.gh,
			data.lx,data.ly,
			data.delay or 0.1, data.count)
		self.sType = "dynamic"
	else

	end

end

function sprite:update(dt)
	if self.animation then
		self.animation:update(dt)
	end
end


function sprite:draw()
	love.graphics.setColor(self.tint)
	if self.animation then
		self.animation:draw()
	else
		love.graphics.draw(self.image, 0, 0, 0, 1, 1, self.w/2, self.h/2)
	end

end


return sprite 