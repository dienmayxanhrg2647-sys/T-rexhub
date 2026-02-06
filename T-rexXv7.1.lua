-- [[ 🦖 T-REX X | VERSION 7.1 - WINDUI ULTIMATE ESP & HITBOX ]] --
-- Đạo chủ: Nguyen van thai | Status: NO KEY
-- Update: ESP Name, Distance + Red Hitbox

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [ 🛡️ BẢO VỆ ] --
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod():lower() == "kick" then return nil end
        return old(self, ...)
    end)
end)

-- [ 🎨 KHỞI TẠO ] --
local Window = WindUI:CreateWindow({
    Title = "T-rex X Hub v7.1 🔥",
    Icon = "solar:ghost-bold",
    Size = UDim2.fromOffset(580, 460)
})

-- [[ 📂 TABS ]] --
local TabBlox = Window:Tab({ Title = "Blox Fruit 🌊", Icon = "solar:water-bold" })
local TabDead = Window:Tab({ Title = "Dead Rails 💀", Icon = "solar:danger-bold" })
local Tab99 = Window:Tab({ Title = "99 Night 🌙", Icon = "solar:moon-bold" })
local TabBrain = Window:Tab({ Title = "Brainrot 🌪️", Icon = "solar:cyclone-bold" })
local TabTroNang = Window:Tab({ Title = "Trợ Năng ⚙️", Icon = "solar:accessibility-bold" })

-- [[ 1. BLOX FRUIT ]] --
TabBlox:Button({ Title = "WhiteX Beta", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))() end })
TabBlox:Button({ Title = "Apple Hub VIP", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))() end })
TabBlox:Button({ Title = "Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end })
TabBlox:Button({ Title = "Xeter Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end })

-- [[ 2. TRỢ NĂNG - UPDATE ESP & HITBOX ]] --

-- 1. ESP Tên, Khoảng cách & Hitbox Đỏ
TabTroNang:Toggle({
    Title = "Bật ESP & Hitbox Đỏ",
    Callback = function(v)
        getgenv().ESP_Hitbox = v
        task.spawn(function()
            while getgenv().ESP_Hitbox do
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = p.Character.HumanoidRootPart
                        
                        -- Tạo ESP (Tên + Khoảng cách)
                        if not hrp:FindFirstChild("TrexESP") then
                            local bg = Instance.new("BillboardGui", hrp)
                            bg.Name = "TrexESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.ExtentsOffset = Vector3.new(0, 3, 0)
                            local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.TextColor3 = Color3.fromRGB(255, 0, 0); tl.Font = Enum.Font.SourceSansBold; tl.TextSize = 14
                            
                            task.spawn(function()
                                while bg and bg.Parent and getgenv().ESP_Hitbox do
                                    pcall(function()
                                        local dist = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                                        tl.Text = p.Name .. " [" .. dist .. "m]"
                                    end)
                                    task.wait(0.1)
                                end
                                bg:Destroy()
                            end)
                        end
                        
                        -- Tạo Hitbox Đỏ
                        if not hrp:FindFirstChild("TrexHitbox") then
                            local box = Instance.new("SelectionBox", hrp)
                            box.Name = "TrexHitbox"; box.Adornee = p.Character; box.Color3 = Color3.fromRGB(255, 0, 0); box.Transparency = 0.5; box.LineThickness = 0.05
                            
                            task.spawn(function()
                                while box and box.Parent and getgenv().ESP_Hitbox do task.wait(0.5) end
                                if box then box:Destroy() end
                            end)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- 2. Nhảy vô hạn
TabTroNang:Toggle({
    Title = "Nhảy vô hạn",
    Callback = function(v)
        getgenv().InfJump = v
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if getgenv().InfJump then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
        end)
    end
})

-- 3. Noclip
TabTroNang:Toggle({
    Title = "Noclip (Xuyên tường)",
    Callback = function(v)
        getgenv().Noclip = v
        game:GetService("RunService").Stepped:Connect(function()
            if getgenv().Noclip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    end
})

-- 4. Sáng Map
TabTroNang:Toggle({
    Title = "Sáng Map",
    Callback = function(v)
        getgenv().FB = v
        task.spawn(function()
            while getgenv().FB do
                game:GetService("Lighting").Brightness = 2; game:GetService("Lighting").ClockTime = 14
                task.wait(1)
            end
        end)
    end
})

-- 5. Nhặt đồ 1 hit
TabTroNang:Toggle({
    Title = "Nhặt đồ 1 hit",
    Callback = function(v)
        getgenv().OneHitE = v
        game:GetService("ProximityPromptService").PromptShown:Connect(function(p)
            if getgenv().OneHitE then p.HoldDuration = 0 end
        end)
    end
})

-- 6. Fly v3
TabTroNang:Button({ Title = "Fly v3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end })

-- 7. Hop Server
TabTroNang:Button({
    Title = "Hop Server",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local Result = Http:JSONDecode(game:HttpGet(Api))
        for _, s in pairs(Result.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end
})

-- 8. Rejoin
TabTroNang:Button({ Title = "Rejoin", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end })

-- Các tab còn lại
TabDead:Button({ Title = "Null-Fire", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end })
Tab99:Button({ Title = "H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end })
Tab99:Button({ Title = "Vape Voidware", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end })
TabBrain:Button({ Title = "Escape Tsunami", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() end })

WindUI:Notify({ Title = "T-Rex X", Content = "Đã tích hợp ESP & Hitbox Đỏ!", Duration = 5 })
