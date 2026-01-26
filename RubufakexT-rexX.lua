-- [[ 🦖 T-REX X | FULL DECOMPILED & FIX ALL ]] --

-- 🛡️ PHẦN 1: BỘ LỌC CHỐNG RESET & ANTI-TOOL LẠ (GIẢI MÃ & BẢO VỆ)
pcall(function()
    local lp = game.Players.LocalPlayer
    -- Chặn các Tool lạ tự ý xuất hiện làm Reset nhân vật
    lp.CharacterChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            task.wait()
            if child.Name:find("Mod") or child.Name:find("TV") or child.Name:find("Sub") then
                child:Destroy()
            end
        end
    end)

    -- Khóa Metatable: Chặn Kick, Chặn Reset, Chặn Ban
    local mt = getrawmetatable(game); setreadonly(mt, false); local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or (method == "FireServer" and (self.Name:find("Reset") or self.Name:find("Level"))) then 
            return nil 
        end
        return old(self, ...)
    end)
    hookfunction(lp.Kick, function() return nil end)
end)

-- 🚀 PHẦN 2: NẠP CODE ĐÃ GIẢI MÃ (FULL DECOMPILED)
-- Sư huynh dùng link Raw để lấy toàn bộ code gốc chưa qua mã hóa của bản V6
local success, rawCode = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/RUBU/refs/heads/main/RUBUV6.lua")
end)

if success then
    -- Đổi toàn bộ tên RUBU thành T-REX X
    local cleanedCode = rawCode:gsub("RUBU", "🦖 T-REX X"):gsub("Rubu", "T-REX X")
    
    -- Thực thi toàn bộ code đã giải mã
    local run, err = loadstring(cleanedCode)
    if run then
        run()
        print("🦖 T-REX X: Đã giải mã và nạp Full thành công!")
    else
        warn("Lỗi thực thi: " .. err)
    end
else
    -- Nếu link chính lỗi, nạp bản dự phòng của đệ
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dienmayxanhrg2647-sys/T-rexhub/refs/heads/main/RubufakexT-rexX.lua"))()
end

-- 🧹 PHẦN 3: DỌN RÁC HỆ THỐNG ĐỂ TREO MÁY KHÔNG LAG
task.spawn(function()
    while task.wait(60) do
        collectgarbage("collect")
    end
end)
