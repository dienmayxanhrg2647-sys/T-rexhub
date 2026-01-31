-- [[ WAKE HUB x TEDDY SYSTEM ]] --

-- 1. Chờ game load hoàn tất để tránh crash
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- 2. Thiết lập cấu hình (Configs) cho Teddy trước khi chạy
getgenv().Configs = {
    ["Quest"] = {
        ["Evo Race V1"] = true,
        ["Evo Race V2"] = true,
        ["RGB Haki"] = true,
        ["Pull Lerver"] = true,
    },
    ["Sword"] = {
        "Dual-Headed Blade", "Smoke Admiral", "Wardens Sword", "Cutlass", 
        "Katana", "Dual Katana", "Triple Katana", "Iron Mace", "Saber", 
        "Pole (1st Form)", "Gravity Blade", "Longsword", "Rengoku", 
        "Midnight Blade", "Soul Cane", "Bisento", "Yama", "Tushita", 
        "Cursed Dual Katana",
    },
    ["Gun"] = {
        "Soul Guitar", "Kabucha", "Venom Bow", "Musket", "Flintlock", 
        "Refined Slingshot", "Magma Blaster", "Dual Flintlock", "Cannon", 
        "Bizarre Revolver", "Bazooka",
    },
    ["FPS Booster"] = false,
}

-- 3. Kích hoạt script Teddy (Sử dụng link gốc của họ)
task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/8cffffd967953fe7"))()
    end)
    if not success then
        warn("WAKE: Không thể kích hoạt Teddy dự phòng! Lỗi: " .. tostring(err))
    end
end)

-- 4. Tiếp tục chạy giao diện Wake Hub của đệ bên dưới
print("WAKE HUB: Teddy System Integrated!")
-- [Dán tiếp đoạn code Rayfield và chức năng của đệ ở đây...]
