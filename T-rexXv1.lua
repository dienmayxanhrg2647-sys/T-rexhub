-- [[ 🦖 T-REX X HUB | VERSION 1.0 βᴇᴛᴀ - OFFICIAL SOURCE ]] --
-- Guiding Principle: No Key | English UI | God-Shield Anti-Ban

-- [ 1. LOAD CHECK ]
if not game:IsLoaded() then game.Loaded:Wait() end

-- [ 2. PROTECT SYSTEM (ANTI-KICK & BYPASS) ]
local function Protect()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    local oldIndex = mt.__index
    setreadonly(mt, false)

    -- Hook Kick method
    local oldKick
    oldKick = hookfunction(game:GetService("Players").LocalPlayer.Kick, function(self, ...)
        if not checkcaller() then return nil end
        return oldKick(self, ...)
    end)

    -- Namecall Bypass
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and (method == "Kick" or method == "kick" or method == "Destroy" and self == game:GetService("Players").LocalPlayer) then
            return nil
        end
        return oldNamecall(self, ...)
    end)

    -- Speed/Jump Detection Spoofing
    mt.__index = newcclosure(function(self, key)
        if not checkcaller() and self:IsA("Humanoid") then
            if key == "WalkSpeed" then return 16 end
            if key == "JumpPower" then return 50 end
        end
        return oldIndex(self, key)
    end)
    setreadonly(mt, true)
end
pcall(Protect)

-- [ 3. UI INITIALIZATION ]
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "T-rex X v1 βᴇᴛᴀ 🦖",
    Icon = "solar:shield-check-bold",
    Size = UDim2.fromOffset(580, 460)
})

-- Startup Notification
WindUI:Notify({
    Title = "System Status",
    Content = "Script is Ready!",
    Duration = 5
})

-- [ 4. TABS SETUP ]
local TabBlox = Window:Tab({ Title = "Blox Fruit", Icon = "solar:water-bold" })
local TabDead = Window:Tab({ Title = "Dead Rails", Icon = "solar:danger-bold" })
local Tab99 = Window:Tab({ Title = "99 Night", Icon = "solar:moon-bold" })
local TabBrain = Window:Tab({ Title = "Brainrot", Icon = "solar:cyclone-bold" })
local TabUtil = Window:Tab({ Title = "Accessibility", Icon = "solar:accessibility-bold" })

local function AddBtn(tab, name, url)
    tab:Button({ Title = name, Callback = function() loadstring(game:HttpGet(url))() end })
end

-- [ 5. GAME SCRIPTS ]
-- Blox Fruit
AddBtn(TabBlox, "Rise Hub [Key System]", "https://rise-evo.xyz/apiv3/main.lua")
AddBtn(TabBlox, "WhiteX Beta", "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua")
AddBtn(TabBlox, "Apple Hub VIP", "https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt")
AddBtn(TabBlox, "Quantum Onyx", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")
AddBtn(TabBlox, "Xeter Hub", "https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua")

-- Dead Rails
AddBtn(TabDead, "Null-Fire", "https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader")
AddBtn(TabDead, "Vape V4", "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua")

-- 99 Night
AddBtn(Tab99, "H4x Loader [Key System]", "https://H4xScripts.xyz/loader")
AddBtn(Tab99, "Vape Voidware", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua")

-- Brainrot
AddBtn(TabBrain, "Escape Tsunami", "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots")

-- [ 6. ACCESSIBILITY LOGIC ]
_G.FullBright = false
local function ApplyFullBright()
    if _G.FullBright then
        local L = game:GetService("Lighting")
        L.Brightness = 3; L.ClockTime = 14; L.FogEnd = 100000
        L.GlobalShadows = false; L.OutdoorAmbient = Color3.new(1,1,1); L.Ambient = Color3.new(1,1,1)
    end
end
game:GetService("Lighting").Changed:Connect(function() if _G.FullBright then ApplyFullBright() end end)

_G.ESP_Enabled = false
local function CreateESP(p)
    task.spawn(function()
        while _G.ESP_Enabled and p and p.Parent and p.Character do
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp and not hrp:FindFirstChild("TrexESP") then
                local bg = Instance.new("BillboardGui", hrp); bg.Name = "TrexESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.ExtentsOffset = Vector3.new(0, 3, 0)
                local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.TextColor3 = Color3.new(1, 0, 0); tl.Font = 3; tl.TextSize = 14
                task.spawn(function()
                    while bg.Parent and _G.ESP_Enabled do
                        local dist = (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and math.floor((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) or 0
                        tl.Text = p.DisplayName .. " [" .. dist .. "m]"; task.wait(0.3)
                    end
                    if bg then bg:Destroy() end
                end)
            end
            if not p.Character:FindFirstChild("TrexHitbox") then
                local box = Instance.new("SelectionBox", p.Character); box.Name = "TrexHitbox"; box.Adornee = p.Character; box.Color3 = Color3.new(1, 0, 0); box.LineThickness = 0.05; box.SurfaceTransparency = 0.7
            end
            task.wait(1)
        end
    end)
end

-- [ 7. UTILS TAB CONTENT ]
TabUtil:Toggle({
    Title = "Player ESP & Hitbox",
    Callback = function(s)
        _G.ESP_Enabled = s
        if s then for _, p in pairs(game:GetService("Players"):GetPlayers()) do if p ~= game:GetService("Players").LocalPlayer then CreateESP(p) end end end
    end
})

TabUtil:Toggle({
    Title = "Permanent Fullbright",
    Callback = function(s)
        _G.FullBright = s
        if s then ApplyFullBright() task.spawn(function() while _G.FullBright do ApplyFullBright(); task.wait(1) end end) end
    end
})

TabUtil:Toggle({ Title = "Infinite Jump", Callback = function(s) _G.InfJump = s end })
TabUtil:Toggle({ Title = "Noclip", Callback = function(s) _G.Noclip = s end })
TabUtil:Toggle({
    Title = "Fast Interact",
    Callback = function(s)
        _G.FastInteract = s
        game:GetService("ProximityPromptService").PromptShown:Connect(function(p) if _G.FastInteract then p.HoldDuration = 0 end end)
    end
})

TabUtil:Button({ Title = "Fly V3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end })
TabUtil:Button({ Title = "Server Hop", Callback = function() 
    local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in pairs(servers.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id) break end end
end })

TabUtil:Button({ Title = "Rejoin Server", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end })
TabUtil:Button({ Title = "Destroy Script", Color = Color3.fromHex("#FF4B4B"), Callback = function() Window:Destroy() end })

-- [ 8. MOVEMENT ENGINE ]
game:GetService("UserInputService").JumpRequest:Connect(function() 
    if _G.InfJump and game:GetService("Players").LocalPlayer.Character then 
        local h = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(3) end 
    end 
end)

game:GetService("RunService").Stepped:Connect(function() 
    if _G.Noclip and game:GetService("Players").LocalPlayer.Character then 
        for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do 
            if v:IsA("BasePart") then v.CanCollide = false end 
        end 
    end 
end)

WindUI:Notify({ Title = "T-Rex X", Content = "All Systems Online!", Duration = 3 })
