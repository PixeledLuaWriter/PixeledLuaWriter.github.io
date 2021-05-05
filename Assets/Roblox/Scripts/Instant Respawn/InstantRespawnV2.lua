--[[ FileName: InstantRespawnV2.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable  Definition ]]

Players = game:service'Players'
RunService = game:service'RunService'
Con1,Con2,Con3 = nil,nil,nil

--[[ Function/Connection Settings ]]

Con1 = Players.PlayerAdded:Connect(function(User)
    Con2 = User.CharacterAdded:Connect(function(UserChar)
        Con3 = UserChar:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
            User:LoadCharacter(true)
        end)
    end)
end)

--[[ Unbinding Function ]]

game:BindToClose(function()
    Con1:Disconnect()
    Con2:Disconnect()
    Con3:Disconnect()
end)
