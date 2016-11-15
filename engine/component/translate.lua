local translate = Class("translate")


function translate:init(go,data)
	self.ctype = "translate"
	self.name = data.name or "unnamed "..self.ctype
	self.go = go
	self.special = true
	
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
	
	if self.parent then
		ax = ax + self.parent.x
		ay = ay + self.parent.y
	end

	self.x= self.x - ax
  	self.y= self.y - ay
  	local xx=math.cos(rot) * self.x - math.sin(rot)* self.y
  	local yy=math.cos(rot) * self.y + math.sin(rot)* self.x
  	self.x = xx + ax
  	self.y = yy + ay
end

local function applyAll(obj)
	if obj.go.parent then
		applyAll(obj.go.parent.translate)
	end
	love.graphics.translate(obj.x, obj.y)
	love.graphics.rotate(obj.rotation)
	love.graphics.scale(obj.scaleX, obj.scaleY)
end


function translate:apply()
	applyAll(self)
end

function translate:setParent(go)
	self.parent = go.translate
end

return translate