-- [[ T-REX X WAKE - POWERED BY ANDEPZAI ]] --
-- Bản quyền thuộc về T-Rex X Wake

repeat task.wait() until game:IsLoaded()

-- 1. Bật Siêu Anti-Lag (Hệ thống Banana của đệ)
task.spawn(function()
    print("T-Rex X Wake: Loading Anti-Lag...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dienmayxanhrg2647-sys/T-rexhub/refs/heads/main/Banana%20fake%20free"))()
end)

-- 2. Thông báo khởi động uy tín
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🦖 T-REX X WAKE",
    Text = "Đang tích hợp hệ thống AnDepZai Hub Beta...",
    Duration = 5
})

-- 3. Bật Script AnDepZai Hub Beta (Cái ruột đệ chọn)
task.wait(1) -- Chờ 1 giây để Anti-Lag chạy trước cho mượt
print("T-Rex X Wake: Injecting Core Script...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubBeta.lua"))()

-- 4. Ghi chú cho bản thân (Sư huynh lồng vào code luôn)
-- Logic: Sử dụng sức mạnh của AnDepZai trên nền tảng Anti-Lag của T-Rex
