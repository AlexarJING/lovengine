load = function(go)
	local ball = go.scene.ball
	local body = ball.box2d.body
	body:applyLinearImpulse(400,400)
end

keydown = function(go,key)
	local dt = love.timer.getDelta()
	if key == "w" then
		local x,y = go.box2d.body:getPosition()
		if y - dt*100 < 160 then y  = 160 + dt*100 end
		go.box2d.body:setPosition(x,y- dt*100 )
	elseif key == "s" then
		local x,y = go.box2d.body:getPosition()
		if y + dt*100 > 540 then y  = 540 + dt*100 end
		go.box2d.body:setPosition(x,y+dt*100 )
	end
end

