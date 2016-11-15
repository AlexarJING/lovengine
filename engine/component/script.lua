local script = Class ("script")


function script:init(go,data)
	self.ctype = "script"
	self.go = go
	self.core = go.core
	self.name = data.name or "unnamed "..self.ctype
	self.special = true
	self.love = love
	self.print = print
	for k,v in pairs(data.parameter or {}) do
		self[k] = v
	end

	local func = loadstring(love.filesystem.read(data.path))
	setfenv(func, self)
	func()
	--pcall(self.load,self.go)
end

return script
