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

-- ==========================================
-- INFINITE JUMP - FIXED 100% WORKING
-- ==========================================
TabUtil:Toggle({ 
    Title = "Infinite Jump", 
    Callback = function(state)
        _G.InfiniteJumpEnabled = state
        
        if state then
            -- Kích hoạt Infinite Jump
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            
            -- Lưu trạng thái nhảy ban đầu
            local originalJumpPower = humanoid.JumpPower
            humanoid.JumpPower = 50 -- Tăng lực nhảy
            
            -- Tạo kết nối cho nhảy vô hạn
            _G.InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                if _G.InfiniteJumpEnabled then
                    -- Reset velocity để nhảy liên tục
                    if character:FindFirstChild("HumanoidRootPart") then
                        local root = character.HumanoidRootPart
                        local velocity = root.Velocity
                        root.Velocity = Vector3.new(velocity.X, 50, velocity.Z)
                    end
                end
            end)
            
            -- Phương pháp backup sử dụng UserInputService
            _G.BackupJumpConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == Enum.KeyCode.Space and _G.InfiniteJumpEnabled then
                    -- Force jump
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    
                    -- Tạo hiệu ứng nhảy liên tục
                    task.spawn(function()
                        for i = 1, 10 do
                            if not _G.InfiniteJumpEnabled then break end
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                local root = character.HumanoidRootPart
                                root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
                            end
                            task.wait(0.1)
                        end
                    end)
                end
            end)
            
            WindUI:Notify({
                Title = "Infinite Jump",
                Content = "Đã bật! Nhấn SPACE để nhảy vô hạn",
                Duration = 3
            })
            
        else
            -- Tắt Infinite Jump
            if _G.InfiniteJumpConnection then
                _G.InfiniteJumpConnection:Disconnect()
                _G.InfiniteJumpConnection = nil
            end
            if _G.BackupJumpConnection then
                _G.BackupJumpConnection:Disconnect()
                _G.BackupJumpConnection = nil
            end
            
            -- Khôi phục JumpPower
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = 50
            end
        end
    end
})

-- ==========================================
-- NOCLIP - FIXED
-- ==========================================
TabUtil:Toggle({ 
    Title = "Noclip", 
    Callback = function(state)
        _G.NoclipEnabled = state
        
        if state then
            -- Bật noclip
            _G.NoclipLoop = game:GetService("RunService").Stepped:Connect(function()
                if _G.NoclipEnabled and game.Players.LocalPlayer.Character then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "Noclip",
                Content = "Đã bật! Có thể đi xuyên tường",
                Duration = 3
            })
            
        else
            -- Tắt noclip
            if _G.NoclipLoop then
                _G.NoclipLoop:Disconnect()
                _G.NoclipLoop = nil
            end
            
            -- Khôi phục collision
            local player = game.Players.LocalPlayer
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

-- Full Bright
TabUtil:Toggle({
    Title = "Full Bright",
    Callback = function(state)
        _G.FullBright = state
        task.spawn(function()
            while _G.FullBright do
                pcall(function() 
                    game:GetService("Lighting").Brightness = 2
                    game:GetService("Lighting").ClockTime = 14
                    game:GetService("Lighting").GlobalShadows = false
                    game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                end)
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
            for _, p in pairs(game:GetDescendants()) do 
                if p:IsA("ProximityPrompt") then 
                    p.HoldDuration = 0 
                    p.MaxActivationDistance = 50 -- Tăng khoảng cách tương tác
                end 
            end
            _G.PromptEvent = game:GetService("ProximityPromptService").PromptShown:Connect(function(p) 
                p.HoldDuration = 0 
                p.MaxActivationDistance = 50
            end)
        else
            if _G.PromptEvent then 
                _G.PromptEvent:Disconnect() 
                _G.PromptEvent = nil
            end
        end
    end
})

-- Buttons
TabUtil:Button({ 
    Title = "Fly V3", 
    Callback = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() 
    end 
})

TabUtil:Button({ 
    Title = "Server Hop", 
    Callback = function()
        -- Server Hop Code
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        -- Lấy server IDs
        local servers = {}
        local req = HttpService:RequestAsync({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET"
        })
        
        if req.Success then
            local data = HttpService:JSONDecode(req.Body)
            for _, server in pairs(data.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    table.insert(servers, server.id)
                end
            end
            
            if #servers > 0 then
                local randomServer = servers[math.random(1, #servers)]
                TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer)
            else
                WindUI:Notify({ Title = "Server Hop", Content = "Không tìm thấy server nào!", Duration = 3 })
            end
        end
    end 
})

TabUtil:Button({ 
    Title = "Rejoin Server", 
    Callback = function() 
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) 
    end 
})

-- [ SYSTEM ] --
TabUtil:Button({ 
    Title = "Destroy Script", 
    Color = Color3.fromHex("#FF4B4B"), 
    Callback = function() 
        -- Dọn dẹp tất cả kết nối
        if _G.InfiniteJumpConnection then
            _G.InfiniteJumpConnection:Disconnect()
        end
        if _G.BackupJumpConnection then
            _G.BackupJumpConnection:Disconnect()
        end
        if _G.NoclipLoop then
            _G.NoclipLoop:Disconnect()
        end
        if _G.PromptEvent then
            _G.PromptEvent:Disconnect()
        end
        Window:Destroy() 
    end 
})

-- ==========================================
-- ALTERNATIVE INFINITE JUMP METHOD
-- (Thêm phương pháp dự phòng)
-- ==========================================
local function SetupInfiniteJump()
    -- Phương pháp 1: Sử dụng UserInputService
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.Space and _G.InfiniteJumpEnabled then
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character.Humanoid
                
                -- Nhảy ngay lập tức
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                
                -- Tạo lực nhảy liên tục
                task.spawn(function()
                    for i = 1, 5 do
                        if not _G.InfiniteJumpEnabled then break end
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local root = player.Character.HumanoidRootPart
                            root.Velocity = Vector3.new(root.Velocity.X, 75, root.Velocity.Z)
                        end
                        task.wait(0.08)
                    end
                end)
            end
        end
    end)
    
    -- Phương pháp 2: Luôn cho phép nhảy
    game:GetService("RunService").Heartbeat:Connect(function()
        if _G.InfiniteJumpEnabled then
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = 100
                player.Character.Humanoid.JumpHeight = 10
            end
        end
    end)
end

-- Khởi động Infinite Jump system
task.spawn(SetupInfiniteJump)

WindUI:Notify({ 
    Title = "T-Rex X Hub v7.2", 
    Content = "Script đã được khởi động thành công!\n✓ Infinite Jump hoạt động 100%\n✓ Nhấn SPACE để nhảy vô hạn\n✓ Tất cả tính năng đã sẵn sàng", 
    Duration = 5 
})

-- THÊM GHI CHÚ CHO NGƯỜI DÙNG
print("╔══════════════════════════════════════╗")
print("║     T-REX X HUB v7.2 - RESTORED      ║")
print("╠══════════════════════════════════════╣")
print("║ ✅ INFINITE JUMP:                    ║")
print("║   • Bật toggle 'Infinite Jump'       ║")
print("║   • Nhấn và GIỮ PHÍM SPACE           ║")
print("║   • Hoặc nhấn SPACE liên tục         ║")
print("║                                      ║")
print("║ ✅ NOCLIP:                           ║")
print("║   • Bật để đi xuyên tường            ║")
print("║   • Tắt để khôi phục va chạm         ║")
print("║                                      ║")
print("║ ✅ ESP: Xem người chơi + khoảng cách ║")
print("║ ✅ Full Bright: Sáng map             ║")
print("╚══════════════════════════════════════╝")
