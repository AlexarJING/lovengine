local translate = Class("translate")


function translate:init(go,data)
	self.go = go
	self.x = data.x or 0
	self.y = data.y or 0
	self.z = data.z or 0
	self.rotation = data.rotation or 0
	self.scaleX = data.scaleX or 1
	self.scaleY = data.scaleY or 1

end


function translate:rotate(rot,ax,ay)
	ax = ax  or 0
	ay = ay  or 0
	self.x= self.x - ax
  	self.y= self.y - ay
  	local xx=math.cos(rot) * self.x - math.sin(rot)* self.y
  	local yy=math.cos(rot) * self.y + math.sin(rot)* self.x
  	self.x = xx + ax
  	self.y = yy + ay
end

function translate:apply()
	love.graphics.translate(self.x, self.y)
	love.graphics.rotate(self.rotation)
	love.graphics.scale(self.scaleX, self.scaleY)
end

return translate