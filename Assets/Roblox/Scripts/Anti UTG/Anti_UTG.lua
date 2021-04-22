--[[ FileName: Anti_UTG.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]

ServiceIndex = setmetatable({},
__index = function(self, callback)
   return game:GetService(callback)
end
})

Players = ServiceIndex.Players
RunService = ServiceIndex.RunService

--[[ Destroyer Function ]]

for i,v in pairs(Players:GetPlayers()) do
   v:FindFirstChildOfClass'PlayerGui':GetPropertyChangedSignal("ChildAdded"):Connect(function(item)
     RunService.Heartbeat:Wait(1 / 30)
      if item == v:FindFirstChildOfClass'PlayerGui':FindFirstChild'AccessUI' and item:IsA'ScreenGui' then
         item.ResetOnSpawn = true
         item:Destroy()
      end
   end
   for x, v2 in pairs(v:FindFirstChildOfClass'PlayerGui':GetChildren()) do
      if v2.Name == 'AccessUI' and v2:IsA'ScreenGui' then
         v2.ResetOnSpawn = true
         v2:Destroy()
      end
   end
end
