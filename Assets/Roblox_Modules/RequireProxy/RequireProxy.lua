--[[ FileName: Require_Proxy.lua ]]
--[[ Author: Godcat567 ]]

--[[ Variable Definition ]]

local RequireProxyUserdata = newproxy(true)

--[[ Metatable Core Settings ]]

getmetatable(RequireProxyUserdata).__call = function(self, Asset)
    if typeof(Asset) == "number" and not typeof(Asset) == "Instance" then
       return require(tonumber(Asset))
    elseif typeof(Asset) == "Instance" and not typeof(Asset) == "number" then
       return require(Asset)
    end
end
getmetatable(RequireProxyUserdata).__metatable = "This Metatable Is Locked"

--[[ Return Core ]]

return RequireProxyUserdata;

--[[ Module End ]]
