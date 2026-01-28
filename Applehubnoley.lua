-- [[ 🦖 T-REX X APPLEHUB | GOD MODE & NO KEY ]] --

-- 1. BỘ GIÁP TỐI THƯỢNG (ANTI-KICK, ANTI-CHEAT, ANTI-CHECK)
pcall(function()
    local mt = getrawmetatable(game); setreadonly(mt, false); local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- Chặn các hàm quét Cheat, Kick và Reset của Server
        if method == "Kick" or method == "OnTeleport" or (method == "FireServer" and (self.Name:find("Check") or self.Name:find("Cheat") or self.Name:find("Reset"))) then 
            return nil 
        end
        return old(self, ...)
    end)
    -- Chống bị Admin Kick trực tiếp
    hookfunction(game.Players.LocalPlayer.Kick, function() return nil end)
end)

-- 2. ANTI-AFK (TREO MÁY XUYÊN TẾT)
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- 3. NẠP RUỘT APPLEHUB PREMIUM V2 & BIẾN ĐỔI THÀNH T-REX (NO KEY)
local success, rawCode = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt")
end)

if success then
    -- Loại bỏ các đoạn check Key của AppleHub và đổi tên sang T-REX
    local finalCode = rawCode
        :gsub("getgenv().Key =", "--") -- Vô hiệu hóa dòng nhập Key
        :gsub("AppleHub", "🦖 T-REX X APPLE") -- Đổi tên cho ngầu
        :gsub("CheckKey", "function() return true end") -- Luôn luôn trả về đúng khi check key
    
    loadstring(finalCode)()
    print("🦖 T-REX: Đã nạp AppleHub Premium V2 - No Key - Anti AFK!")
else
    warn("⚠️ Không thể lấy code từ GitHub, đệ check lại link nhé!")
end
