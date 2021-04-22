--[[ FileName: Anti_Quantom_Or_MrBean.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]
ServiceIndex = setmetatable({},{
__index = function(self, callback)
    return game:service(callback) or game:getService(callback) or game:GetService(callback)
end
})

Players = ServiceIndex.Players
Debris = ServiceIndex.Debris

--[[ Destroyer Functions ]]

for i,v in pairs(game:service'Players':GetPlayers()) do
        vx = v:FindFirstChildOfClass'PlayerGui':GetDescendants()
        for i,x in ipairs(vx) do
            if x:IsA'ScreenGui' and x.Name == "QuantomUI" then
                x.ResetOnSpawn = false
                x:Destroy()
                Debris:AddItem(x, 0)
            end
        end
        v:FindFirstChildOfClass'PlayerGui'.DescendantAdded:Connect(function(vx)
            if vx.Name == "QuantomUI" and vx:IsA'ScreenGui' then
                vx.ResetOnSpawn = false
                vx:Destroy()
                Debris:AddItem(vx, 0)
            end
        end)
    end
    for i,v in pairs(game:service'ReplicatedStorage':GetDescendants()) do
        if v.Name == "CommandActivate" and v:IsA'RemoteEvent' then
            Debris:AddItem(v, 0)
        end
    end
    _G.QUANTOM_ACTIVATE = nil
end
