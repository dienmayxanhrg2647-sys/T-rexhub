-- [[ T-REX X OFFICIAL SYSTEM ]]
-- [[ NO OBFUSCATION - STABLE VERSION ]]

local _SAVED_FILE = "TrexX_Save.txt"
local _VALID_KEYS = {
    ["TrexX_V1"] = true,
    ["Admin_Trex"] = true
}

-- [[ MAIN SCRIPT LOADER ]]
local function _LAUNCH()
    getgenv().isPremium = true
    getgenv().IsVip = true
    
    -- Branding Fix (Rise -> T-Rex X)
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                    if v:IsA("TextLabel") or v:IsA("TextButton") then
                        if v.Text:find("Rise") then
                            v.Text = v.Text:gsub("Rise Auth", "T-Rex X"):gsub("Rise", "Wake")
                        end
                    end
                end
            end)
        end
    end)

    -- Fetching Original Script
    local success, content = pcall(function() 
        return game:HttpGet("https://rise-evo.xyz/apiv3/main.lua") 
    end)
    
    if success then
        local fixed = content:gsub("isPremium = false", "isPremium = true")
        loadstring(fixed)()
    end
end

-- [[ KEY INTERFACE ]]
local UI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Win = UI:CreateWindow({
    Title = "T-Rex X | Authentication",
    Author = "by thai"
})

local Tab = Win:Tab({Title = "Security", Icon = "lock"})

local UserInput = ""
Tab:Input({
    Title = "Enter Access Key",
    Placeholder = "TrexX_V1 or Admin_Trex",
    Callback = function(v) UserInput = v end
})

Tab:Button({
    Title = "Verify Access",
    Callback = function()
        if _VALID_KEYS[UserInput] then
            writefile(_SAVED_FILE, UserInput)
            UI:Notify({Title = "Success", Content = "Access Granted! Loading..."})
            Win:Destroy()
            _LAUNCH()
        else
            UI:Notify({Title = "Error", Content = "Invalid Key! Please check again."})
        end
    end
})

-- Nút xóa Key để đệ đổi Key khác
Tab:Button({
    Title = "Reset Saved Key",
    Callback = function()
        if isfile(_SAVED_FILE) then
            delfile(_SAVED_FILE)
            UI:Notify({Title = "System", Content = "Saved key has been removed."})
        end
    end
})

-- [[ AUTO-LOGIN ]]
if isfile(_SAVED_FILE) then
    local saved = readfile(_SAVED_FILE)
    if _VALID_KEYS[saved] then
        _LAUNCH()
        task.wait(0.2)
        Win:Destroy()
    end
end
