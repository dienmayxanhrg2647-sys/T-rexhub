local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🦖 T-rex X | Multi-Hub Full",
   LoadingTitle = "Đang Khởi Chạy T-rex X...",
   LoadingSubtitle = "By dienmayxanhrg2647-sys",
   ConfigurationSaving = {Enabled = true, FolderName = "TrexX_Data", FileName = "MainConfig"},
   KeySystem = false -- Tắt hệ thống Key theo ý sư đệ
})

-- [ THÔNG BÁO TỔNG HỢP ] --
Rayfield:Notify({
   Title = "KÍCH HOẠT THÀNH CÔNG",
   Content = "Đã load: Blox Fruit, 99 Night, Dead Rails, ESP & System.",
   Duration = 5,
})

--- [[ TAB BLOX FRUIT ]] ---
local TabBlox = Window:CreateTab("🍍 Blox Fruit", 4483362458)
TabBlox:CreateSection("Script Hubs Tốt Nhất")
TabBlox:CreateButton({Name = "🔵 Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end})
TabBlox:CreateButton({Name = "🧸 Teddy Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))() end})
TabBlox:CreateButton({Name = "⚡ Luarmor Script (VIP)", Callback = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua"))() end})
TabBlox:CreateButton({Name = "🔥 Xeter Hub (Marines)", Callback = function() getgenv().Team = "Marines" loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end})

--- [[ TAB 99 NIGHT ]] ---
local TabNight = Window:CreateTab("🌙 99 Night", 4483362458)
TabNight:CreateButton({Name = "🛡️ H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end})
TabNight:CreateButton({Name = "🌲 Vape Voidware", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end})

--- [[ TAB DEAD RAILS ]] ---
local TabDead = Window:CreateTab("💀 Dead Rails", 4483362458)
TabDead:CreateButton({Name = "🔥 Null-Fire (InfernusScripts)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end})

--- [[ TAB HỆ THỐNG ]] ---
local TabSys = Window:CreateTab("⚙️ Hệ Thống", 4483345906)
TabSys:CreateSection("Thông Số Real-time")
local LPing = TabSys:CreateLabel("Ping: Đang tính...")
local LPlas = TabSys:CreateLabel("Người chơi: ...")
local LTime = TabSys:CreateLabel("Thời gian chơi: 00:00:00")

TabSys:CreateSection("Chức Năng ESP")
local ESP_Enabled = false
TabSys:CreateToggle({
   Name = "Bật ESP (Hiện Tên + Khoảng Cách)",
   CurrentValue = false,
   Callback = function(Value) 
      ESP_Enabled = Value 
      if not Value then
         for _, p in pairs(game.Players:GetPlayers()) do
            pcall(function() if p.Character.HumanoidRootPart:FindFirstChild("TrexESP") then p.Character.HumanoidRootPart.TrexESP:Destroy() end end)
         end
      end
   end,
})

TabSys:CreateSection("Tiện Ích Server")
TabSys:CreateButton({
    Name = "🚀 Đổi Server (Server Hop)",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local function NextServer()
            local Servers = Http:JSONDecode(game:HttpGet(Api)).data
            for i,v in pairs(Servers) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                end
            end
        end
        NextServer()
    end,
})
TabSys:CreateButton({Name = "🔄 Vào Lại Server (Rejoin)", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})

TabSys:CreateSection("Cài Đặt Menu")
TabSys:CreateKeybind({Name = "Phím Đóng/Mở Menu", CurrentKeybind = "LeftControl", Callback = function() end})
TabSys:CreateButton({Name = "🚪 Đóng Hub Hoàn Toàn", Callback = function() Rayfield:Destroy() end})

-- [ VÒNG LẶP HỆ THỐNG & ESP ] --
local start = os.time()
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local p = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+"))
            LPing:Set("Ping: " .. (p or 0) .. " ms")
            LPlas:Set("Người chơi: " .. #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers)
            local d = os.time() - start
            LTime:Set(string.format("Thời gian chơi: %02d:%02d:%02d", math.floor(d/3600), math.floor((d%3600)/60), d%60))
        end)
        
        if ESP_Enabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                pcall(function()
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        local myHrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                        if not hrp:FindFirstChild("TrexESP") then
                            local b = Instance.new("BillboardGui", hrp); b.Name = "TrexESP"; b.AlwaysOnTop = true; b.Size = UDim2.new(0, 100, 0, 30); b.ExtentsOffset = Vector3.new(0, 3, 0)
                            local l = Instance.new("TextLabel", b); l.BackgroundTransparency = 1; l.Size = UDim2.new(1, 0, 1, 0); l.TextColor3 = Color3.fromRGB(255, 50, 50); l.TextStrokeTransparency = 0; l.TextSize = 13; l.Font = Enum.Font.GothamBold
                        end
                        local dist = math.floor((myHrp.Position - hrp.Position).Magnitude)
                        hrp.TrexESP.TextLabel.Text = player.Name .. "\n[" .. dist .. "m]"
                    end
                end)
            end
        end
    end
end)
