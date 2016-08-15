function table.save(tab,name,ifCopyFunction)
	name=name or "default"
	local tableList= {{name="root",tab=tab}} --to protect loop
	local output="local "..name.."=\n"
	local function ergodic(target,time)
		time=time+1
		output=output.."{\n"
		for k,v in pairs(target) do
			output=output .. string.rep("\t",time)
			local name = ""
			if type(k)=="number" then
				name="["..k.."]"
			elseif type(k)=="string" then
				name="[\""..k.."\"]"
			end 
			if type(v)=="table" then
				output=output .. name .."="
				local checkRepeat,repeatTab
				for _,p in ipairs(tableList) do
					if v==p.tab then
						checkRepeat=true
						repeatTab = p
						break
					end
				end
				if checkRepeat then
					output=output.."table->"..repeatTab.name..",\n"
				else
					table.insert(tableList,{name=name,tab=v})
					ergodic(v,time)
					output=output .. string.rep("\t",time)
					output=output.."},\n"
				end
			elseif type(v)=="string" then
				if string.find(v,"\n") then
					output=output.. name .."=[["..v.."]],\n"
				else
					output=output.. name .."=\""..v.."\",\n"
				end
				
			elseif type(v)=="number" or type(v)=="boolean" then
					output=output..name.."="..tostring(v)..",\n"
			elseif type(v)=="function" and ifCopyFunction then
				output=output .. name .."= loadstring(\""..string.dump(v).."\")(),\n"			
			
			end
		end
	end
	ergodic(tab,0)
	output=output.."}\nreturn "..name
	--print(output)
	return output 
end