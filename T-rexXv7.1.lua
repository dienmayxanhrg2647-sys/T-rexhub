-- [[ 🦖 T-REX X | VERSION 7.0 - OFFICIAL FINAL ]] --
-- Đạo chủ: Nguyen van thai | Link: dienmayxanhrg2647-sys
-- Status: NO KEY | FULL FIX | ONE HIT E PICKUP INTEGRATED

-- [ 🛡️ HỆ THỐNG BẢO VỆ & ANTI-AFK ] --
local Success, Error = pcall(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

task.spawn(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)

-- [ 🎨 KHỞI TẠO RAYFIELD ] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "T-rex X Hub v7.0 🔥",
   LoadingTitle = "🦖 T-REX X CHÀO MỪNG BẠN",
   LoadingSubtitle = "By Nguyen van thai",
   ConfigurationSaving = {Enabled = true, FolderName = "TrexX_Final_Save"},
   KeySystem = false 
})

-- [[ 📂 HỆ THỐNG TABS CHUẨN ]] --
local TabBlox = Window:CreateTab("Blox Fruit 🌊", 4483362458)
local TabDead = Window:CreateTab("Dead Rails 💀", 10728953210)
local Tab99 = Window:CreateTab("99 Night 🌙", 4483362458)
local TabBrain = Window:CreateTab("Brainrot 🌪️", 7734068321)
local TabSys = Window:CreateTab("Hệ Thống ⚙️", 4483345906)

--- [[ 1. TAB BLOX FRUIT ]] ---
TabBlox:CreateSection("⭐ Script Farm VIP")
TabBlox:CreateButton({Name = "WhiteX Beta", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))() end})
TabBlox:CreateButton({Name = "Apple Hub VIP", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))() end})
TabBlox:CreateButton({Name = "Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end})
TabBlox:CreateButton({Name = "Xeter Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end})

--- [[ 2. TAB DEAD RAILS ]] ---
TabDead:CreateButton({Name = "Null-Fire", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end})

--- [[ 3. TAB 99 NIGHT ]] ---
Tab99:CreateButton({Name = "H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end})
Tab99:CreateButton({Name = "Vape Voidware", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end})

--- [[ 4. TAB BRAINROT ]] ---
TabBrain:CreateButton({Name = "Escape Tsunami", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() end})

--- [[ 5. TAB HỆ THỐNG - TRUNG TÂM ĐIỀU KHIỂN ]] ---
TabSys:CreateSection("📊 Thông Số Server")
local LTime = TabSys:CreateLabel("Thời gian chơi: 00:00:00")
local LPing = TabSys:CreateLabel("Ping: ...")
local LPlayer = TabSys:CreateLabel("Người chơi: ...")

TabSys:CreateSection("⚡ Tính Năng Nhặt Đồ Nhanh")
TabSys:CreateToggle({
    Name = "One Hit E Pickup (Bỏ thời gian giữ)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().OneHitE = Value
        if Value then
            -- Tối ưu hóa: Chỉ chạy khi bật
            game:GetService("ProximityPromptService").PromptShown:Connect(function(prompt)
                if getgenv().OneHitE then
                    prompt.HoldDuration = 0
                end
            end)
            Rayfield:Notify({Title = "Hệ Thống", Content = "Đã kích hoạt Nhặt đồ siêu tốc!", Duration = 2})
        end
    end
})

TabSys:CreateSection("👁️ Thần Nhãn (ESP Player)")
getgenv().ESP_Enabled = false
TabSys:CreateToggle({
    Name = "Bật ESP Tên & Khoảng Cách",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().ESP_Enabled = Value
        task.spawn(function()
            while getgenv().ESP_Enabled do
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = p.Character.HumanoidRootPart
                        if not hrp:FindFirstChild("TrexESP") then
                            local bg = Instance.new("BillboardGui", hrp)
                            bg.Name = "TrexESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.ExtentsOffset = Vector3.new(0, 3, 0)
                            local tl = Instance.new("TextLabel", bg); tl.BackgroundTransparency = 1; tl.Size = UDim2.new(1, 0, 1, 0); tl.TextColor3 = Color3.fromRGB(0, 255, 127); tl.Font = Enum.Font.SourceSansBold; tl.TextSize = 14
                            task.spawn(function()
                                while bg and bg.Parent do
                                    pcall(function()
                                        local d = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                                        tl.Text = p.Name .. " [" .. d .. " studs]"
                                    end)
                                    task.wait(0.2)
                                end
                            end)
                        end
                    end
                end
                task.wait(1)
            end
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("TrexESP") then
                    p.Character.HumanoidRootPart.TrexESP:Destroy()
                end
            end
        end)
    end
})

TabSys:CreateSection("☀️ Ánh Sáng Vĩnh Viễn")
getgenv().FullBrightForever = false
TabSys:CreateToggle({
    Name = "Kích Hoạt Sáng Map 🔥",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().FullBrightForever = Value
        task.spawn(function()
            while getgenv().FullBrightForever do
                local L = game:GetService("Lighting")
                L.Brightness = 2; L.ClockTime = 14; L.GlobalShadows = false; L.FogEnd = 9e9
                L.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                task.wait(0.1)
            end
        end)
    end
})

TabSys:CreateSection("🌐 Server Hop")
TabSys:CreateButton({
    Name = "Server Hop (Ngẫu nhiên)",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local Result = Http:JSONDecode(game:HttpGet(Api))
        for _, server in pairs(Result.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(game.PlaceId, server.id)
                break
            end
        end
    end
})

TabSys:CreateSection("🛠️ Tiện Ích Khác")
TabSys:CreateButton({Name = "Fly V3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end})
TabSys:CreateButton({Name = "Rejoin Server (Vào lại)", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})

-- [ 🔄 VÒNG LẶP CẬP NHẬT THÔNG SỐ ] --
local startTime = os.time()
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local diff = os.time() - startTime
            LTime:Set(string.format("Thời gian chơi: %02d:%02d:%02d", math.floor(diff/3600), math.floor((diff%3600)/60), diff%60))
            local p = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+"))
            LPing:Set("Ping: " .. (p or 0) .. " ms")
            LPlayer:Set("Người chơi: " .. #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers)
        end)
    end
end)

Rayfield:Notify({
    Title = "T-rex X v7.0 Hub",
    Content = "Chào mừng bạn đến với T-rex X!",
    Duration = 5,
    Image = 4483362458,
})
