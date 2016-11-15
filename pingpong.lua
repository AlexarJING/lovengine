local project = {
	name = "pingpong",
	entry = "main",
	width = 1200,
	height = 800,
	scene = {
		["main"] = {
			gx = 0,
			gy = 0,
			meter = 64,
			entity = {
				{
					name = "border_up",
					component = {
						{ctype = "translate" , x = 400, y = 100 },
						{name = "rect", ctype = "shape", shapetype = "rectangle" , drawtype = "fill"  , w = 500 , h = 20 , color = {100,100,255,255}},
						{ name = "body", ctype = "box2d", shapes = {"rect"},bound = 1, bodytype = "static"},
					},
				},
				{
					name = "border_down",
					component = {
						{ctype = "translate" , x = 400, y = 500 },
						{name = "rect", ctype = "shape", shapetype = "rectangle" , drawtype = "fill" , w = 500 , h = 20 , color = {100,100,255,255}},
						{ name = "body", ctype = "box2d", shapes = {"rect"},bound = 1, bodytype = "static"},
					},
				},
				{
					name = "border_left",
					component = {
						{ctype = "translate" , x = 150, y = 300 },
						{name = "rect", ctype = "shape", shapetype = "rectangle" , drawtype = "fill" , w = 20 , h = 400 , color = {100,100,255,255}},
						{ name = "body", ctype = "box2d", shapes = {"rect"},bound = 1, bodytype = "static"},
					},
				},
				{
					name = "border_right",
					component = {
						{ctype = "translate" , x = 650, y = 300 },
						{name = "rect", ctype = "shape", shapetype = "rectangle" , drawtype = "fill" , w = 20 , h = 400 , color = {100,100,255,255}},
						{ name = "body", ctype = "box2d", shapes = {"rect"},bound = 1, bodytype = "static"},
					},
				},
				{
					name = "ball",
					component = {
						{ ctype = "translate" ,drawtype = "fill" , x = 400, y = 300 },
						{name = "circ", ctype = "shape", shapetype = "circle" , drawtype = "fill"  , r =30 , color = {250,100,205,255}},
						{name = "ball", ctype = "sprite", path = "res/ball.png" , imageName = "ball"},
						{name = "body", ctype = "box2d", shapes = {"circ"},bound =1}
					},
				},
				{
					name = "paddle_left",
					component = {
						{ ctype = "translate" ,drawtype = "fill" , x = 200, y = 300 },
						{ name = "p", ctype = "shape", shapetype = "rectangle" , drawtype = "fill"  , w = 10 , h = 100 , color = {100,250,205,255}},
						{ name = "body", ctype = "box2d", shapes = {"p"}, bodytype = "static",bound =1},
						{ ctype = "script" , path = "res/user.lua"}
					
					},
				},
				{
					name = "paddle_right",
					component = {
						{ ctype = "translate" ,drawtype = "fill" , x = 600, y = 300 },
						{ name = "p",ctype = "shape", shapetype = "rectangle" , drawtype = "fill"  , w = 10 , h = 100 , color = {100,250,205,255}},
						{name = "body", ctype = "box2d", shapes = {"p"}, bodytype = "static",bound =1},
						{ ctype = "script" , path = "res/ai.lua"}
					},
				},
			},
			factory = {
				
			}
		}
	}
}

return project