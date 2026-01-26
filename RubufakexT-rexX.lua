-- [[ 🦖 T-REX X | BẢN FULL FIX - KHÔNG KEY - CHỐNG RESET ]] --

-- 1. ĐỢI GAME ỔN ĐỊNH (TRÁNH LỖI RESET TOOL)
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(2) -- Nghỉ 2 giây để tool load xong hoàn toàn

-- 2. SIÊU GIÁP TITAN (CHẶN KICK, CHẶN RESET LEVEL, CHẶN RESET CHARACTER)
pcall(function()
    local mt = getrawmetatable(game); setreadonly(mt, false); local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- Chặn đứng lệnh Reset và Kick từ Server
        if method == "Kick" or method == "OnTeleport" or (method == "FireServer" and (self.Name:find("Level") or self.Name:find("Reset"))) then 
            return nil 
        end
        return old(self, ...)
    end)
    -- Khóa hàm Kick trực tiếp để bất tử
    hookfunction(game.Players.LocalPlayer.Kick, function() return nil end)
end)

-- 3. NẠP RUỘT SCRIPT TỪ LINK CỦA ĐỆ (KHÔNG KEY)
local success, code = pcall(function() 
    return game:HttpGet("https://raw.githubusercontent.com/dienmayxanhrg2647-sys/T-rexhub/refs/heads/main/Rubuxt-rexX.lua") 
end)

if success then
    -- Tự động đổi tên sang T-REX X cho đẹp
    local finalCode = code:gsub("RUBU", "🦖 T-REX X"):gsub("Rubu", "T-REX X")
    loadstring(finalCode)()
    print("🦖 T-REX X: Đã nạp thành công - Không Key - Đệ đi chơi vui vẻ!")
else
    warn("⚠️ Không lấy được code từ GitHub, đệ check mạng nhé!")
end

-- 4. TỰ ĐỘNG DỌN RÁC (GIẢM LAG KHI TREO MÁY)
task.spawn(function()
    while task.wait(60) do
        collectgarbage("collect")
    end
end)
