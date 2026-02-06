-- [[ 🦖 T-REX X HUB | VERSION 7.2 - FINAL STABLE ]] --
-- Developed by: Nguyen van thai
-- Status: No Key | Auto Anti-Lag Enabled

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [ ⚡ AUTO ANTI-LAG SYSTEM ] --
local function OptimizeGame()
    local Terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0
    
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        elseif v:IsA("Explosion") then
            v.Visible = false
        end
    end
    game:GetService("Lighting").GlobalShadows = false
end
pcall(OptimizeGame)

-- [ 🛡️ CORE SERVICES ] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local ProximityPromptService = game:GetService("ProximityPromptService")

-- [ 🎨 WINDOW SETUP ] --
local Window = WindUI:CreateWindow({
    Title = "T-rex X Hub v7.2 🔥",
    Icon = "solar:ghost-bold",
    Size = UDim2.fromOffset(580, 460)
})

-- [ 📂 TABS ] --
local TabBlox = Window:Tab({ Title = "Blox Fruit", Icon = "solar:water-bold" })
local TabDead = Window:Tab({ Title = "Dead Rails", Icon = "solar:danger-bold" })
local Tab99 = Window:Tab({ Title = "99 Night", Icon = "solar:moon-bold" })
local TabBrain = Window:Tab({ Title = "Brainrot", Icon = "solar:cyclone-bold" })
local TabUtil = Window:Tab({ Title = "Accessibility", Icon = "solar:accessibility-bold" })

-- ==========================================
-- [[ 1. ACCESSIBILITY (TRỢ NĂNG - FIXED) ]] 
-- ==========================================

-- [ 1. ESP & RED HITBOX ] --
TabUtil:Toggle({
    Title = "Player ESP & Hitbox",
    Callback = function(state)
        _G.ESP_Enabled = state
        if not state then
            for _, p in pairs(Players:GetPlayers()) do
                pcall(function()
                    if p.Character.HumanoidRootPart:FindFirstChild("TrexESP") then p.Character.HumanoidRootPart.TrexESP:Destroy() end
                    if p.Character:FindFirstChild("TrexHitbox") then p.Character.TrexHitbox:Destroy() end
                end)
            end
        end
        task.spawn(function()
            while _G.ESP_Enabled do
                for _, p in pairs(Players:GetPlayers()) do
                    pcall(function()
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = p.Character.HumanoidRootPart
                            if not hrp:FindFirstChild("TrexESP") then
                                local bg = Instance.new("BillboardGui", hrp)
                                bg.Name = "TrexESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.ExtentsOffset = Vector3.new(0, 3, 0)
                                local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.TextColor3 = Color3.fromRGB(255, 0, 0); tl.Font = Enum.Font.SourceSansBold; tl.TextSize = 14
                                task.spawn(function()
                                    while bg and bg.Parent and _G.ESP_Enabled do
                                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                                        tl.Text = p.Name .. " [" .. dist .. "m]"; task.wait(0.2)
                                    end
                                end)
                            end
                            if not p.Character:FindFirstChild("TrexHitbox") then
                                local box = Instance.new("SelectionBox", p.Character)
                                box.Name = "TrexHitbox"; box.Adornee = p.Character; box.Color3 = Color3.fromRGB(255, 0, 0); box.LineThickness = 0.05; box.SurfaceTransparency = 0.7
                            end
                        end
                    end)
                end
                task.wait(1)
            end
        end)
    end
})

-- [ 2. INFINITE JUMP ] --
TabUtil:Toggle({
    Title = "Infinite Jump",
    Callback = function(state)
        _G.InfJump = state
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump then LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
        end)
    end
})

-- [ 3. NOCLIP ] --
TabUtil:Toggle({
    Title = "Noclip",
    Callback = function(state)
        _G.Noclip = state
        RunService.Stepped:Connect(function()
            if _G.Noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
})

-- [ 4. FULL BRIGHT (SUPER FIX) ] --
TabUtil:Toggle({
    Title = "Full Bright",
    Callback = function(state)
        _G.FullBright = state
        task.spawn(function()
            while _G.FullBright do
                pcall(function()
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                end)
                task.wait(0.5)
            end
        end)
    end
})

-- [ 5. FAST INTERACT (1-HIT E) ] --
TabUtil:Toggle({
    Title = "Fast Interact (1-Hit E)",
    Callback = function(state)
        _G.FastInteract = state
        if state then
            for _, p in pairs(game:GetDescendants()) do
                if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end
            end
            _G.PromptEvent = ProximityPromptService.PromptShown:Connect(function(p)
                p.HoldDuration = 0
            end)
        else
            if _G.PromptEvent then _G.PromptEvent:Disconnect() end
        end
    end
})

-- [ 6. FLY V3 ] --
TabUtil:Button({ Title = "Fly V3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end })

-- [ 7. SERVER HOP ] --
TabUtil:Button({
    Title = "Server Hop",
    Callback = function()
        local Http = game:GetService("HttpService")
        local api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local servers = Http:JSONDecode(game:HttpGet(api))
        for _, s in pairs(servers.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end
})

-- [ 8. REJOIN SERVER ] --
TabUtil:Button({ Title = "Rejoin Server", Callback = function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId) end })

-- ==========================================
-- [[ 2. GAME SCRIPTS ]] 
-- ==========================================
TabBlox:Button({ Title = "WhiteX Beta", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))() end })
TabBlox:Button({ Title = "Apple Hub VIP", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt")) end })
TabBlox:Button({ Title = "Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")) end })
TabBlox:Button({ Title = "Xeter Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua")) end })

TabDead:Button({ Title = "Null-Fire", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end })
Tab99:Button({ Title = "H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end })
TabBrain:Button({ Title = "Escape Tsunami", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() end })

-- [ SYSTEM ] --
TabUtil:Button({ Title = "Destroy Script", Color = Color3.fromHex("#FF4B4B"), Callback = function() Window:Destroy() end })

WindUI:Notify({ Title = "T-Rex X", Content = "Anti-Lag & Scripts Loaded!", Duration = 5 })
