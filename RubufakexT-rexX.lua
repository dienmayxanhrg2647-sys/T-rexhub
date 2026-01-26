-- [[ 🦖 T-REX HUB | PHIÊN BẢN HỖ TRỢ DELTA VNG ]] --

-- 1. CHỈ CHẶN RESET (KHÔNG XOÁ TOOL CỦA DELTA VNG)
pcall(function()
    local mt = getrawmetatable(game); setreadonly(mt, false); local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- Chỉ chặn lệnh Reset nhân vật để tránh bị văng tool khi đang farm
        if method == "FireServer" and (self.Name:find("Reset") or self.Name:find("Level")) then 
            return nil 
        end
        return old(self, ...)
    end)
end)

-- 2. NẠP HUB CỦA ĐỆ (GIỮ NGUYÊN 100% CHỨC NĂNG)
loadstring(game:HttpGet("https://raw.githubusercontent.com/dienmayxanhrg2647-sys/T-rexhub/refs/heads/main/RubufakexT-rexX.lua"))()

print("🦖 T-REX HUB: Đã nạp! Chạy tốt trên Delta VNG (Dat Mod TV)")
