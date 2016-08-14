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
						{name = "pos" , ctype = "translate" , x = 0, y = 0 , z = 0, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "draw", ctype = "shape", shapetype = "rectangle" , x = 0 , y = 0 , w = 100 , h = 200 , color = {255,0,0,255},anchor="center"}
					},
					children = {
						"test3.go",
						"test4.go"
					}
				},
				{
					name = "test2.go",
					component = {
						{name = "pos" , ctype = "translate" , x = 300, y = 300 , z = 0, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "ani", ctype = "sprite", images = {} , offx = 0 , offy = 0 , z= 0 , tint = {0,255,0,255},anchor="center"}
					}
				},
			},
			factory = {
				{
					name = "test3.go",
					component = {
						{name = "pos" , ctype = "translate" , x = 0, y = 0 , z = 0, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "draw", ctype = "shape", shapetype = "rectangle" , x = 0 , y = 0 , w = 100 , h = 200 , color = {255,0,0,255},anchor="center"}
					}
					
				},
				{
					name = "test4.go",
					component = {
						{name = "pos" , ctype = "translate" , x = 0, y = 0 , z = 0, r = 0, sx = 1 , sy = 1 ,sx = 0 , sy = 0},
						{name = "draw", ctype = "shape", shapetype = "rectangle" , x = 0 , y = 0 , w = 100 , h = 200 , color = {255,0,0,255},anchor="center"}
					}
				},
			}
		}
	}
}

return project