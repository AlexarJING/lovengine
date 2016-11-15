local box2d = Class ("box2d")


function box2d:init(go,data)
	self.ctype = "box2d"
	self.go = go
	self.core = go.core
	self.data = data
	self.name = data.name or "unnamed "..self.ctype
	self.special = true
	self.bound = data.bound or 0

	self.world = self.go.scene.world
	self.offx = data.offx or 0
	self.offy = data.offy or 0
	self.bodytype = data.bodytype or "dynamic"
	self.body = love.physics.newBody(self.world, 0, 0, self.bodytype)
end

function box2d:bind()
	self.body:setPosition(self.go.translate.x,self.go.translate.y)
	self.body:setAngle(self.go.translate.rotation)
	
	for _,shapeName in ipairs(self.data.shapes) do		
		for _,com in ipairs(self.go.shapes) do
			if shapeName == com.name then
				local shapetype = com.shapetype
				local shape
				if shapetype == "circle" then
					shape = love.physics.newCircleShape( 
						com.offx , com.offy, com.data.r)
				elseif shapetype == "rectangle" then
					shape = love.physics.newRectangleShape( 
						com.offx , com.offy, 
						com.data.w, com.data.h)
				elseif shapetype == "polygon" then
					shape = love.physics.newPolygonShape(com.data.vertex)
				end
				self.fixture = love.physics.newFixture(
					self.body, shape ,
					math.sqrt(self.go.translate.scaleX* self.go.translate.scaleY))
				self.fixture:setRestitution(self.bound)
				self.fixture:setUserData(self.go)
			end
		end
	end

end

function box2d:connect(go)
	if not go.box2d then return end
	love.physics.newWeldJoint(self.body, go.box2d.body, 0, 0, false)
end

function box2d:synchronize()
	
	local x , y  = self.body:getPosition()
	local r = self.body:getAngle()
	local translate = self.go.translate
	translate.x = x
	translate.y = y
	translate.rotation = r
end


return box2d