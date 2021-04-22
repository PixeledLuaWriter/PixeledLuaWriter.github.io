--[[ FileName: MetaModule.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]

local Meta = {}
local MetaScripts = {}
local Players = game:service'Players'

--[[ Script Archiving ]]

for index, child in next, script:GetChildren() do
	MetaScripts[child.Name] = child:Clone();
	child:Destroy()
end

--[[ Function Definition ]]

function GetPlayerByName(User)
	for index, child in next, Players:GetPlayers() do
		if(child.Name == User) then
			return child
		end
	end
	return nil;
end

function GetPlayerByUserId(User)
	local success, callback = pcall(Players.GetNameFromUserIdAsync, Players, User)
	if success then
		return Players[callback]
	else
		error(callback) --pulls out the async error
	end
end

--[[ Metatable Settings ]]

setmetatable(Meta, {
	__index = function(self, index)
		local scripts = MetaScripts[index]
		if(scripts)then
			return function(ThePlayerItself)
				if typeof(ThePlayerItself) == "string" then
					local Player = GetPlayerByName(tostring(ThePlayerItself))
					if(Player and Player:FindFirstChildOfClass'PlayerGui')then
						scripts.Parent = Player:FindFirstChildOfClass'PlayerGui'
						scripts.Disabled = false
					end
				elseif typeof(ThePlayerItself) == "number" then
					local Player = GetPlayerByUserId(tostring(ThePlayerItself))
					if(Player and Player:FindFirstChildOfClass'PlayerGui')then
						scripts.Parent = Player:FindFirstChildOfClass'PlayerGui'
						scripts.Disabled = false
					end
				end
			end
		end
	end,
})

--[[ Return Core ]]

return Meta

--[[ Module End ]]
