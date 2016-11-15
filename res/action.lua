function update(go,dt)
	go.translate.rotation = go.translate.rotation + dt * test
end

function keypressed(go,key)
	if key == "space" then
		test = - test
	end
end
 