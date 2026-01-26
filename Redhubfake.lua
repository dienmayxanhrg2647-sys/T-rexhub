-- [[ 🦖 T-REX X | BẢN TỰ HÚT CODE - SIÊU NHẸ ]] --

-- 1. HỆ THỐNG KEY & BẢO VỆ CỦA SƯ HUYNH
_G.Key = "TrexX_V1"
local function AntiBan()
    local mt = getrawmetatable(game); setreadonly(mt, false)
    local old = mt.__namecall; mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end)
end
pcall(AntiBan)

-- 2. LỆNH "HÚT" VÀ ĐỔI TÊN (ĐỆ KHÔNG CẦN COPY TAY TRÊN WEB)
local url = "https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua"

task.spawn(function()
    local success, code = pcall(function() return game:HttpGet(url) end)
    if success then
        -- Sư huynh dùng phép thuật đổi tên ngay trong bộ nhớ máy
        local customCode = code:gsub("Redz Hub", "🦖 T-REX X | CỦA TUI")
                               :gsub("huy384", "Boss_TrexX")
        
        -- Chạy bản đã được "thu phục"
        loadstring(customCode)()
        print("🦖 T-REX X: Đã hút code thành công! Đệ đi chơi đi!")
    else
        -- Nếu link thằng Huy ngủm, nạp bản dự phòng cực mạnh này
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzV5/refs/heads/main/Source.lua"))()
    end
end)
