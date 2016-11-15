require "engine"("pingpong.lua")


--[[
------------------------------for dynamic-------------------------
local scene = engine.currentScene
local go = Go(scene,{name = "test"})
go:addComponent(Translate(go,{x=500,y=300,scaleX=3,scaleY = 3}))
go:addComponent(Shape(go,{name = "rectangle",shapetype = "rectangle", w = 10 , h = 10}))
go:addComponent(Sprite(go,
	{name = "test",animationName = "anim", path = "res/anim.png", 
	fx = 9,fy = 9, 
	w = 14 , h = 14,
	gw = 18 ,gh = 18,
	lx = 87, ly = 55,
	}))
go:addComponent(Box2d(go,{shapes={"rectangle"}}))
scene:addEntity(go)
go.box2d.body:applyLinearImpulse(80,-90)
go.box2d.body:applyAngularImpulse(5)

local scene = engine.currentScene
local go2 = Go(scene,{name = "test2"})
go2:addComponent(Translate(go2,{x=400,y=400,scaleX=3,scaleY = 3}))
go2:addComponent(Shape(go2,{name = "circ",shapetype = "circle", r = 8}))
go2:addComponent(Sprite(go2,
	{name = "test",animationName = "anim", path = "res/anim.png", 
	fx = 9,fy = 9, 
	w = 14 , h = 14,
	gw = 18 ,gh = 18,
	lx = 87, ly = 55,
	}))
go2:addComponent(Box2d(go2,{shapes={"circ"}}))
scene:addEntity(go2)

go.box2d:connect(go2)

local go2 = Go(go, scene, scene.factory["test3.go"])
go:addChild(go2)
scene:addEntity(go2)

local go3 = Go(scene,{name = "test3"})
go3:addComponent(Translate(go3,{x=1000,y=600,scaleX=1,scaleY = 1}))
go3:addComponent(Shape(go3,{name = "circ",shapetype = "circle", r = 100 ,drawtype = "fill"}))
go3:addComponent(Box2d(go3,{shapes={"circ"},bodytype="static"}))
scene:addEntity(go3)
------------------------------------------------------------------------]]

----ping pong---------
