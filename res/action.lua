local action = {}

function action.update(go,dt)
	go.translate.rotation = go.translate.rotation + dt* action.test
end

function action.keypressed(go,key)
	if key == "space" then
		action.test = - action.test
	end
end
return action 