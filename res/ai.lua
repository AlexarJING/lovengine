
update = function(go,dt)
	local ball = go.scene.ball
	if go.translate.y > ball.translate.y then
		local x,y = go.box2d.body:getPosition()
		if y - dt*100 < 160 then y  = 160 + dt*100 end
		go.box2d.body:setPosition(x,y- dt*100 )
	elseif go.translate.y < ball.translate.y then
		local x,y = go.box2d.body:getPosition()
		if y + dt*100 > 540 then y  = 540 + dt*100 end
		go.box2d.body:setPosition(x,y+dt*100 )
	end
end

