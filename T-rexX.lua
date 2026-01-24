-- [[ 🦖 T-REX X | MULTI-HUB FULL VERSION 2026 ]] --
-- Tác giả: Nguyen van thai
-- Link: https://raw.githubusercontent.com/dienmayxanhrg2647-sys/T-rexhub/refs/heads/main/T-rexX.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🦖 T-rex X | Multi-Hub Full",
   LoadingTitle = "Đang Khởi Chạy T-rex X...",
   LoadingSubtitle = "By Nguyen van thai",
   ConfigurationSaving = {Enabled = true, FolderName = "TrexX_Data", FileName = "MainConfig"},
   KeySystem = false 
})

-- [ THÔNG BÁO CHÀO HỎI ] --
Rayfield:Notify({
   Title = "🦖 T-Rex X chào", 
   Content = "Chào mừng bạn! Script đã load đầy đủ chức năng.",
   Duration = 5,
})

--- [[ TAB BLOX FRUIT ]] ---
local TabBlox = Window:CreateTab("🍍 Blox Fruit", 4483362458)
TabBlox:CreateSection("Script Hubs Tốt Nhất")
TabBlox:CreateButton({Name = "🔵 Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end})
TabBlox:CreateButton({Name = "🧸 Teddy Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))() end})
TabBlox:CreateButton({Name = "⚡ Luarmor Script (VIP)", Callback = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua"))() end})
TabBlox:CreateButton({Name = "🔥 Xeter Hub (Marines)", Callback = function() getgenv().Team = "Marines" loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end})

--- [[ TAB BARANROT ]] ---
local TabBaran = Window:CreateTab("🌊 Baranrot", 7734068321)
TabBaran:CreateSection("Siêu Phẩm Brainrot")
TabBaran:CreateButton({
    Name = "🌊 Escape Tsunami (Brainrot Edition)", 
    Callback = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() 
    end
})

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

TabSys:CreateSection("Hack Visuals")
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

TabSys:CreateSection("Tiện Ích Server (Fixed)")
TabSys:CreateButton({
    Name = "🚀 Đổi Server (Server Hop)",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local function Hop()
            local success, result = pcall(function()
                return Http:JSONDecode(game:HttpGet(Api))
            end)
            
            if success and result and result.data then
                for _, v in pairs(result.data) do
                    if v.playing < v.maxPlayers and v.id ~= game.JobId then
                        TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                        return
                    end
                end
            end
            Rayfield:Notify({Title = "Hệ Thống", Content = "Không tìm thấy server phù hợp, thử lại sau!", Duration = 3})
        end
        Hop()
    end,
})

TabSys:CreateButton({
    Name = "🔄 Vào Lại Server (Rejoin)", 
    Callback = function() 
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) 
    end
})

TabSys:CreateSection("Cài Đặt Menu")
TabSys:CreateKeybind({Name = "Phím Đóng/Mở Menu", CurrentKeybind = "LeftControl", Callback = function() end})

TabSys:CreateSection("Tác Giả")
TabSys:CreateLabel("By Nguyen van thai")

-- [ LOGIC CHẠY NGẦM ] --
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
