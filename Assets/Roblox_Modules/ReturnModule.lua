--[[ FileName: ReturnModule.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]

Players = game:service'Players'

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

--[[ Return Core ]]

return function(UserKey, User)
	if(typeof(UserKey) ~= "string" or typeof(UserKey) == "userdata" or not UserKey == "XALTML") then
		return error("Attempt to concatenate userdata as a string")
	end
	if(typeof(User) ~= "Instance" or not GetPlayerByName(tostring(User)) or not GetPlayerByUserId(tostring(User))) then
		return error("Player Doesn't Exist")
	end
end

--[[ Module End ]]
