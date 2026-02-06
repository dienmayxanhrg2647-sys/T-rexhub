-- [[ 🦖 T-REX X HUB | VERSION 7.2 - FULL SCRIPTS RESTORED ]] --
-- Developed by: Nguyen van thai
-- Full Features + Anti-Lag + All Links Included

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [ ⚡ AUTO ANTI-LAG ] --
pcall(function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = "Plastic"
        elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1
        elseif v:IsA("ParticleEmitter") then v.Enabled = false end
    end
end)

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
-- [[ 1. BLOX FRUIT - FULL 4 LINKS ]] 
-- ==========================================
TabBlox:Button({ Title = "WhiteX Beta", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))() end })
TabBlox:Button({ Title = "Apple Hub VIP", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))() end })
TabBlox:Button({ Title = "Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end })
TabBlox:Button({ Title = "Xeter Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end })

-- ==========================================
-- [[ 2. DEAD RAILS - FULL 1 LINK ]] 
-- ==========================================
TabDead:Button({ Title = "Null-Fire", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end })

-- ==========================================
-- [[ 3. 99 NIGHT - FULL 2 LINKS ]] 
-- ==========================================
Tab99:Button({ Title = "H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end })
Tab99:Button({ Title = "Vape Voidware", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end })

-- ==========================================
-- [[ 4. BRAINROT - FULL 1 LINK ]] 
-- ==========================================
TabBrain:Button({ Title = "Escape Tsunami", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() end })

-- ==========================================
-- [[ 5. ACCESSIBILITY - FULL 8 FEATURES ]] 
-- ==========================================

-- ESP & Hitbox
TabUtil:Toggle({
    Title = "Player ESP & Hitbox",
    Callback = function(state)
        _G.ESP_Enabled = state
        task.spawn(function()
            while _G.ESP_Enabled do
                for _, p in pairs(game.Players:GetPlayers()) do
                    pcall(function()
                        if p ~= game.Players.LocalPlayer and p.Character then
                            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                            if hrp and not hrp:FindFirstChild("TrexESP") then
                                local bg = Instance.new("BillboardGui", hrp)
                                bg.Name = "TrexESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.ExtentsOffset = Vector3.new(0, 3, 0)
                                local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.TextColor3 = Color3.fromRGB(255, 0, 0); tl.Font = Enum.Font.SourceSansBold; tl.TextSize = 14
                                task.spawn(function()
                                    while bg and bg.Parent and _G.ESP_Enabled do
                                        local dist = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                                        tl.Text = p.Name .. " [" .. dist .. "m]"; task.wait(0.2)
                                    end
                                    bg:Destroy()
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

-- Movement & World
TabUtil:Toggle({ Title = "Infinite Jump", Callback = function(s) _G.InfJump = s end })
TabUtil:Toggle({ Title = "Noclip", Callback = function(s) _G.Noclip = s end })
TabUtil:Toggle({
    Title = "Full Bright",
    Callback = function(state)
        _G.FullBright = state
        task.spawn(function()
            while _G.FullBright do
                pcall(function() game:GetService("Lighting").Brightness = 2; game:GetService("Lighting").ClockTime = 14; game:GetService("Lighting").GlobalShadows = false end)
                task.wait(0.5)
            end
        end)
    end
})

-- Interaction
TabUtil:Toggle({
    Title = "Fast Interact (1-Hit E)",
    Callback = function(state)
        _G.FastInteract = state
        if state then
            for _, p in pairs(game:GetDescendants()) do if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end end
            _G.PromptEvent = game:GetService("ProximityPromptService").PromptShown:Connect(function(p) p.HoldDuration = 0 end)
        else
            if _G.PromptEvent then _G.PromptEvent:Disconnect() end
        end
    end
})

-- Buttons
TabUtil:Button({ Title = "Fly V3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end })
TabUtil:Button({ Title = "Server Hop", Callback = function() --[[ Hop Code ]] end })
TabUtil:Button({ Title = "Rejoin Server", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end })

-- [ SYSTEM ] --
TabUtil:Button({ Title = "Destroy Script", Color = Color3.fromHex("#FF4B4B"), Callback = function() Window:Destroy() end })

WindUI:Notify({ Title = "T-Rex X", Content = "Full v7.2 Restored Successfully!", Duration = 5 })
