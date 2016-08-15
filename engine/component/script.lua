local script = Class ("script")


function script:init(go,data)
	self.go = go
	self.core = go.core
	self.name = data.name
	self.scr = require(data.path)
	
	for k,v in pairs(data) do
		self.scr[k] = v
	end

	for k,v in pairs(self.scr) do
		if type(v) == "function" then
			self[k] = function(...)
				v(...)
			end
		end
	end
end

return script