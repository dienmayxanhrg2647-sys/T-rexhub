-- [[ 🦖 T-REX X: RUBU V6 + ANTI-RESET + ANTI-BAN ]] --

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- 1. SIÊU GIÁP: ANTI-KICK, ANTI-BAN & ANTI-RESET LEVEL
local function ActivateSuperArmor()
    pcall(function()
        local mt = getrawmetatable(game); setreadonly(mt, false); local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            -- Chặn Kick, Chặn Teleport Detect, Chặn Reset Level/Stats từ Server
            if method == "Kick" or method == "OnTeleport" or method == "SetAttribute" or method == "FireServer" and self.Name == "Remotes" then
                return nil 
            end
            return old(self, ...)
        end)
        -- Khóa hàm Kick trực tiếp
        hookfunction(game.Players.LocalPlayer.Kick, function() return nil end)
    end)
    print("🛡️ GIÁP T-REX: ANTI-BAN & ANTI-RESET ON!")
end
ActivateSuperArmor()

-- 2. HỆ THỐNG LƯU CODE & LOAD SCRIPT (CHỐNG NGỦM)
local MainLink = "https://raw.githubusercontent.com/Teddyseetink/RUBU/refs/heads/main/RUBUV6.lua"
local BackupLink = "https://raw.githubusercontent.com/dienmayxanhrg2647-sys/T-rexhub/refs/heads/main/Redhubfake.lua"

task.spawn(function()
    local success, code = pcall(function() return game:HttpGet(MainLink) end)
    
    if success and code ~= "" then
        -- Nạp bản RUBU và đổi tên thương hiệu
        loadstring(code:gsub("RUBU", "🦖 T-REX X"):gsub("Rubu", "T-REX X"))()
    else
        -- Nếu RUBU ngủm, tự động nạp bản dự phòng của đệ
        warn("⚠️ RUBU NGỦM! ĐANG NẠP BẢN DỰ PHÒNG...")
        loadstring(game:HttpGet(BackupLink))()
    end
end)

-- 3. ANTI-DETECTION (TÀNG HÌNH TRƯỚC ADMIN)
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            -- Tự động dọn dẹp các Flag bị cắm trên nhân vật
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("RemoteEvent") then
                char.RemoteEvent:Destroy()
            end
        end)
    end
end)
