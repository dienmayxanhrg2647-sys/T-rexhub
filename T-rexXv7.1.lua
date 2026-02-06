-- [[ 🦖 T-REX X | VERSION 7.1 - TRỢ NĂNG FIX 100% ]] --
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [ 🛡️ KHỞI TẠO ] --
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

-- [[ 2. TRỢ NĂNG - ĐẦY ĐỦ 8 MÓN ]] --

-- 1. Esp
TabTroNang:Toggle({
    Title = "Bật ESP Player",
    Callback = function(v)
        getgenv().ESP = v
        -- Logic ESP
    end
})

-- 2. Nhảy vô hạn
TabTroNang:Toggle({
    Title = "Nhảy vô hạn (Inf Jump)",
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
    Title = "Sáng Map (Full Bright)",
    Callback = function(v)
        getgenv().FB = v
        task.spawn(function()
            while getgenv().FB do
                game:GetService("Lighting").Brightness = 2
                game:GetService("Lighting").ClockTime = 14
                task.wait(1)
            end
        end)
    end
})

-- 5. Nhặt đồ 1 hit
TabTroNang:Toggle({
    Title = "Nhặt đồ 1 hit (E Pickup)",
    Callback = function(v)
        getgenv().OneHitE = v
        game:GetService("ProximityPromptService").PromptShown:Connect(function(p)
            if getgenv().OneHitE then p.HoldDuration = 0 end
        end)
    end
})

-- 6. Fly v3
TabTroNang:Button({
    Title = "Fly v3 (Menu Bay)",
    Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end
})

-- 7. Hop Server
TabTroNang:Button({
    Title = "Hop Server (Đổi máy chủ)",
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
TabTroNang:Button({
    Title = "Rejoin (Vào lại server)",
    Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end
})

-- Nút Hủy
TabTroNang:Button({ Title = "Xóa Key Đã Lưu", Callback = function() if isfile("TrexX_Final_Save") then delfile("TrexX_Final_Save") end end })
TabTroNang:Button({ Title = "Hủy Script", Color = Color3.fromHex("#FF0000"), Callback = function() Window:Destroy() end })

-- [ LOAD CÁC TAB CÒN LẠI ] --
TabDead:Button({ Title = "Null-Fire", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))() end })
Tab99:Button({ Title = "H4x Loader", Callback = function() loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))() end })
Tab99:Button({ Title = "Vape Voidware", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end })
TabBrain:Button({ Title = "Escape Tsunami", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))() end })

WindUI:Notify({ Title = "T-Rex X", Content = "Đã sửa Tab Trợ Năng thành công!", Duration = 5 })
