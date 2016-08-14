local sprite = Class("sprite")


function sprite:init(go,data)
	self.go = go
	self.core = go.core
	self.name = data.name
	self.offx = data.offx
	self.offy = data.offy
	self.rot = data.rot

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
			data.offx,data.offy,
			data.lx,data.ly,
			data.delay,data.count)
		self.sType = "dynamic"
	else

	end
	self.image = data.imagename and love.graphics.newImage(data.imagename)
	self.animation = data.animationname and love.graphics.newAnimation() --img,fx,fy,w,h,offx,offy,lx,ly,delay,count
end

function sprite:update(dt)
	if self.animation then
		self.animation:update(dt)
	end
end


function sprite:draw()
	if self.animation then
		self.animation:draw(_,_,_,_,self.offx,self.offy)
	else
		love.graphics.draw(self.image, 0, 0, 0, 1, 1, self.w/2, self.h/2)
	end

end


return sprite 