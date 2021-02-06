--[[ FileName: ExecutionModule.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]

Players = game:GetService("Players")

--[[ Function Definition ]]

function Connect(Who)
   if not Who or not typeof(Who) == "Instance" or not Players:FindFirstChild(Who) then
    return error("Player Instance Doesn't Exist")
   end
    local cloned = script:GetChildren()[1]:Clone()
    if(cloned:FindFirstChild("Owner"):IsA'StringValue')then
        cloned:FindFirstChild("Owner").Value = Who.Name
    elseif(cloned:FindFirstChild("Owner"):IsA'ObjectValue')then
        cloned:FindFirstChild("Owner").Value = Who
    end
    cloned.Parent = Who:FindFirstChildOfClass'PlayerGui'
    cloned.Disabled = false
end

--[[ Return Core Definition ]]

return function(DataBase)
    local ActualOwner = nil;
    if(not DataBase)then
        return error("no table data was provided")
    end
    if(typeof(DataBase) ~= "table" and not ActualOwner and not DataBase.RunScript)then
        ActualOwner = nil
        return error("no owner was successfully found")
    else
        ActualOwner = DataBase.User[1]
    end
    if(typeof(ActualOwner) == "string") then
        for _,pr in pairs(Players:GetPlayers()) do
            if(pr.Name == ActualOwner)then
                ActualOwner = pr
                break;
            end
        end
    elseif(typeof(ActualOwner) == "number")then
        for _,pr in pairs(Players:GetPlayers()) do
            if(pr.UserId == ActualOwner)then
                ActualOwner = pr
                break;
            end
        end
    end
    if(not ActualOwner)then
        return
    end
    Connect(ActualOwner)
end
