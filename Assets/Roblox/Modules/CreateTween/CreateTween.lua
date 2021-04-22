--[[ FileName: Create_Tween.lua ]]
--[[ Author: Godcat567 ]]

--[[
				USAGE: require(script:WaitForChild("Create_Tween"))

				@params :CreateNewTween(Joint or part, {Tween Data}, EasingStyle, EasingDirection, time, PlayOnCreation)

]]

--[[ Variable Definition ]]

local ServiceIndex = setmetatable({}, {
		__index = function(self, callback)
			return pcall(game.GetService, callback)
		end
})

local TweenIndex = {}
local TweenServ = ServiceIndex.TweenService

--[[ Function Definition ]]

function TweenIndex:CreateNewTween(Joint, TweenData, EasingStyle, EasingDirection, time, PlayOnCreation)
	local info = TweenInfo.new(
		time / 1,
		Enum.EasingStyle[EasingStyle],
		Enum.EasingDirection[EasingDirection],
		0,
		false,
		0
	)
	local tween = TweenServ:Create(Joint, info, TweenData)
	if(PlayOnCreation)then
		tween:Play()
	else
		return tween
	end
end

--[[ Return Data ]]

return TweenIndex

--[[ Module End ]]
