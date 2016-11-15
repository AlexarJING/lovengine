local project = {
	name = "test",
	--...othersetting
	entry = "test.scene",
	scene = {
		["test.scene"] = {
			entity = {
				{
					name = "test.go",
					component = {
						{name = "pos" , ctype = "translate" , x = 100, y = 200 , z = 0, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "rect", ctype = "shape", shapetype = "rectangle" , drawtype = "fill" ,x = 0 , y = 0 , w = 100 , h = 200 , color = {255,0,0,255},anchor="center"}
					},
					children = {
					}
				},
				{
					name = "test2.go",
					component = {
						{name = "pos" , ctype = "translate" ,drawtype = "fill" , x = 300, y = 300 , z = -1, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "ball", ctype = "sprite", path = "res/ball.png" , imageName = "ball", offx = 0 , offy = 0 , z= 0 , tint = {0,255,0,255},anchor="center"},
						{name = "roll", ctype = "script", path = "res/action.lua" , parameter ={test = 10}}
					},
					children = {
						"test3.go"
					}
				},
			},
			factory = {
				{
					name = "test3.go",
					component = {
						{name = "pos" , ctype = "translate" , x = 50, y = 50 , z = 0, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "draw", ctype = "shape", shapetype = "circle" , drawtype = "line" ,x = 0 , y = 0 ,r = 100, color = {255,0,255,255},anchor="center"}
					},
					children = {}
				},
			}
		}
	}
}

return project