---by alexar, Class (Class= require "middleclass") is a need 
---用法：img保存动画的image对象 fx,fy,lx,ly 动画第一像素和最后一个像素位置不包含外框
---offx,offy 动画图片间距
---delay 动画延时 
---count 帧数,如缺省则取最大
---mode 0 循环 1 单次 2 回转
----1. ani=love.graphics.newAnimation(img,fx,fy,w,h,offx,offy,lx,ly,delay,count)
----2. ani:update(dt) 在update里加入
----3. love.graphics.draw(img,ani.frame) --画包含动画image,ani.frame是一个quad

local animation=Class("ani")


function animation:init(img,fx,fy,w,h,offx,offy,lx,ly,delay,count) 

	self.img=img
	local sw,sh= img:getDimensions()
	local index=0
	self.frames={}
	self.frameWidth = w
	self.frameHeight = h
	local stop
	for y=fy,ly,h+offy do
		for x=fx,lx,w+offx do
			local quad = love.graphics.newQuad(x, y, w, h, sw, sh)
			index=index+1
			self.frames[index]=quad
			if count and index+1>count then  stop=true ;break end
		end
		if stop then break end
	end
	self.maxFrame=index
	self.currentFrame=1
	self.mode=0 --0 for loop  1 for one time 2 for bounce
	self.isRev=false
	self.isPlay=true --0 for stop 1 for play 2 
	self.timer=0
	self.delay=delay
	self.frame=self.frames[self.currentFrame]
	return self
end


function animation:play()
	self.isPlay=true
end

function animation:stop()
	self.isPlay=false
end

function animation:update(dt)
	if self.isPlay then
		self.timer=self.timer+dt
		if self.timer>=self.delay then
			self.timer=0
			if self.isRev then
				self.currentFrame=self.currentFrame-1
				if self.currentFrame<1 then
					if self.mode==0 then
						self.currentFrame=self.maxFrame
					elseif self.mode==1 then
						self.currentFrame=1
						self.isPlay=false
					elseif self.mode==2 then
						self.currentFrame=1
						self.isRev=not self.isRev
					end
				end
			else
				self.currentFrame=self.currentFrame+1
				if self.currentFrame>self.maxFrame then
					if self.mode==0 then
						self.currentFrame=1
					elseif self.mode==1 then
						self.currentFrame=self.maxFrame
						self.isPlay=false
					elseif self.mode==2 then
						self.currentFrame=self.maxFrame
						self.isRev=not self.isRev
					end
				end
			end

		end
	end
	self.frame=self.frames[self.currentFrame]
end

function animation:draw(x,y,rot,scaleX,scaleY)
	x = x or 0
	y = y or 0
	rot = rot or 0 
	scaleX = scaleX or 1
	scaleY = scaleY or 1
	offx = offx or 0
	offy = offy or 0
	love.graphics.draw(self.img,self.frame, x, y,rot ,scaleX ,scaleY,self.frameWidth/2,self.frameHeight/2)
end

love.graphics.newAnimation=animation

return animation