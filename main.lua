local engine = require "engine"
local scene = engine.currentScene

local go = Go(nil, scene,{name = "test"})
go:addComponent(Translate(go,{x=500,y=300,scaleX=3,scaleY = 3}))
go:addComponent(Shape(go,{shapetype = "circle", r = 20}))
go:addComponent(Sprite(go,
	{name = "test",animationName = "anim", path = "res/anim.png", 
	fx = 9,fy = 9, 
	w = 14 , h = 14,
	gw = 18 ,gh = 18,
	lx = 87, ly = 55,
	}))
		
scene:addEntity(go)

local go2 = Go(go, scene, scene.factory["test3.go"])
go:addChild(go2)
scene:addEntity(go2)
