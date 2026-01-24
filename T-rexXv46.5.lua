-- [[ 🦖 T-REX X | VERSION 46.5 - FINAL ETERNITY ]] --
-- Tác giả: Nguyen van thai | Link: dienmayxanhrg2647-sys
-- Đặc tính: Sáng Map Vĩnh Viễn | Fix Anti-Cheat | No Key

-- [ 🛡️ HỆ THỐNG ANTI-CHEAT & ANTI-KICK ] --
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    -- Chống lại các lệnh Kick/Ban từ Server
    if method == "Kick" or method == "kick" or method == "BreakJoints" then 
        return nil 
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- [ 🧘 ANTI-AFK (CHỐNG VĂNG KHI TREO MÁY) ] --
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)

-- [ 🎨 KHỞI TẠO INTERFACE ] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "T-rex X v46.5 🔥 FINAL",
   LoadingTitle = "🦖 T-REX X HUB LOADING...",
   LoadingSubtitle = "By Nguyen van thai",
   ConfigurationSaving = {Enabled = true, FolderName = "TrexX_v465", FileName = "MainConfig"},
   KeySystem = false 
})

-- [[ 📂 TỔNG HỢP CÁC TAB ]] --
local TabBlox = Window:CreateTab("Blox Fruit", 4483362458)
local TabDead = Window:CreateTab("Dead Rails", 10728953210)
local Tab99 = Window:CreateTab("99 Night", 4483362458)
local TabBrain = Window:CreateTab("Brainrot 🌊", 7734068321)
local TabSys = Window:CreateTab("Hệ Thống", 4483345906)

--- [[ 1. TAB BLOX FRUIT ]] ---
TabBlox:CreateSection("⭐ Top Script Blox Fruit")
TabBlox:CreateButton({Name = "WhiteX Beta", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))() end})
TabBlox:CreateButton({Name = "Apple Hub Premium V2", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))() end})
TabBlox:CreateButton({Name = "Quantum Onyx", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end})
TabBlox:CreateButton({Name = "Teddy Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))() end})
TabBlox:CreateButton({Name = "Xeter Hub (Marines)", Callback = function() getgenv().Team = "Marines" loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end})

--- [[ 2. TAB DEAD RAILS ]] ---
TabDead:CreateSection("💀 Dead Rails Script")
TabDead:CreateButton({Name = "Null-Fire", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end})

--- [[ 3. TAB 99 NIGHT ]] ---
Tab99:CreateSection("🌙 Đêm 99 Scripts")
Tab99:CreateButton({Name = "H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end})
Tab99:CreateButton({Name = "Vape Voidware", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end})
Tab99:CreateButton({Name = "Fly & NoClip", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end})

--- [[ 4. TAB BRAINROT ]] ---
TabBrain:CreateSection("🌊 Brainrot Wave")
TabBrain:CreateButton({Name = "Escape Tsunami", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() end})

--- [[ 5. TAB HỆ THỐNG & SÁNG MAP ]] ---
TabSys:CreateSection("📊 Thông Số Server")
local LPing = TabSys:CreateLabel("Ping: ...")
local LPlas = TabSys:CreateLabel("Số Player: ...")
local LTime = TabSys:CreateLabel("Số giờ chơi: 00:00:00")

TabSys:CreateSection("🛠️ Công Cụ (Bật Hoài Không Tắt)")

-- Logic Sáng Map Vĩnh Viễn
getgenv().FullBright = false
TabSys:CreateToggle({
    Name = "Full Bright (Sáng Map Vĩnh Viễn 🔥)",
    CurrentValue = false,
    Flag = "ToggleBright",
    Callback = function(Value)
        getgenv().FullBright = Value
        task.spawn(function()
            while getgenv().FullBright do
                local L = game:GetService("Lighting")
                L.Brightness = 2
                L.ClockTime = 14
                L.FogEnd = 100000
                L.GlobalShadows = false
                L.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                task.wait(1) -- Duy trì ánh sáng liên tục mỗi giây
            end
        end)
    end
})

TabSys:CreateButton({Name = "Rejoin Server", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})
TabSys:CreateButton({Name = "Xóa Config Rayfield", Callback = function() Rayfield:Destroy() end})

-- [ 🔄 CẬP NHẬT THỜI GIAN THỰC ] --
local st = os.time()
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local p = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+"))
            LPing:Set("Ping: " .. (p or 0) .. " ms")
            LPlas:Set("Số Player: " .. #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers)
            local d = os.time() - st
            LTime:Set(string.format("Số giờ chơi: %02d:%02d:%02d", math.floor(d/3600), math.floor((d%3600)/60), d%60))
        end)
    end
end)

Rayfield:Notify({Title = "T-rex X v46.5", Content = "Đã kích hoạt nội công Thái Cực thành công!", Duration = 5})
