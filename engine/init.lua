require "engine/util/util"
Class = require "engine/util/middleclass"
require "engine/util/tablesave"
Animation = require "engine/util/animation"
Translate = require "engine/component/translate"
Sprite = require "engine/component/sprite"
Shape = require "engine/component/shape"
Script = require "engine/component/script"
Go = require "engine/component/gameobject"
Scene = require "engine/component/scene"
Engine = require "engine/component/core"
Box2d = require "engine/component/box2d"
return function(datapath)
	return Engine(datapath)
end