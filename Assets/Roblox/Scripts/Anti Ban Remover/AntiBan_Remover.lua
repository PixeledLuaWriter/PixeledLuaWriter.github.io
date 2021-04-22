--[[ FileName: AntiBan_HiddenScript_Destroyer.lua]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]

Players = game:service'Players'
RunService = game:service'RunService'
StarterGui = game:service'StarterGui'

--[[ Destroyer Function ]]

for i,v in ipairs(Players:GetPlayers()) do
	v:FindFirstChildOfClass'PlayerGui':GetPropertyChangedSignal("ChildAdded"):Connect(function(item)
	RunService.Heartbeat:Wait(1 / 30) --Server's Wait Time Per 1/30th of a Frame
		if item == v:FindFirstChildOfClass'PlayerGui':FindFirstChild'HiddenScript' and item:IsA'LocalScript' and not item:IsA'ScreenGui' then
			item.Disabled = true
			item:Destroy()
		end
	end)
	for i2, v2 in ipairs(v:FindFirstChildOfClass'PlayerGui':GetChildren()) do
		if v2.Name == "HiddenScript" and v2:IsA'LocalScript' and not v2:IsA'ScreenGui' then
			v2.Disabled = true
			v2:Destroy()
		end
	end
end
for i,v in ipairs(StarterGui:GetChildren()) do
	if v.Name == "HiddenScript" and v:IsA'LocalScript' and not v:IsA'ScreenGui' then
		v.Disabled = true
		v:Destroy()
	end
end
StarterGui:GetPropertyChangedSignal("ChildAdded"):Connect(function(item)
RunService.Heartbeat:Wait(1 / 30) --Server's Wait Time Per 1/30th Of A Frame
	if item == StarterGui:FindFirstChild'HiddenScript' and item:IsA'LocalScript' and not item:IsA'ScreenGui' then
		item.Disabled = true
		item:Destroy()
	end
end)
