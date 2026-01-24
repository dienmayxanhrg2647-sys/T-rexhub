local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🦖 T-rex X | Multi-Hub",
   LoadingTitle = "T-rex X System Loading...",
   LoadingSubtitle = "Đã thêm Dead Rails cho sư đệ!",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TrexX_Data",
      FileName = "MainConfig"
   },
   KeySystem = false 
})

--- [ TAB BLOX FRUIT ] ---
local TabBlox = Window:CreateTab("🍍 Blox Fruit", 4483362458)
TabBlox:CreateSection("Script Hubs Tổng Hợp")

TabBlox:CreateButton({
   Name = "🔵 Kích hoạt Quantum Onyx",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
   end,
})

TabBlox:CreateButton({
   Name = "🧸 Kích hoạt Teddy Hub",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
   end,
})

TabBlox:CreateButton({
   Name = "⚡ Kích hoạt Luarmor Script",
   Callback = function()
       loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua"))()
   end,
})

TabBlox:CreateButton({
   Name = "🔥 Kích hoạt Xeter Hub (Marines)",
   Callback = function()
       getgenv().Version = "V4"
       getgenv().Team = "Marines"
       loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))()
   end,
})

--- [ TAB 99 NIGHT ] ---
local TabNight = Window:CreateTab("🌙 99 Night", 4483362458)
TabNight:CreateSection("Script 99 Night")

TabNight:CreateButton({
   Name = "🛡️ Kích hoạt H4x Loader (VIP)",
   Callback = function()
       loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))()
   end,
})

TabNight:CreateButton({
   Name = "🌲 Kích hoạt Vape Voidware",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
   end,
})

--- [ TAB DEAD RAILS ] ---
local TabDead = Window:CreateTab("💀 Dead Rails", 4483362458)
TabDead:CreateSection("Script Dead Rails")

TabDead:CreateButton({
   Name = "🔥 Kích hoạt Null-Fire (Infernus)",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
   end,
})

--- [ TAB HỆ THỐNG ] ---
local TabSys = Window:CreateTab("⚙️ Hệ Thống", 4483345906)
TabSys:CreateSection("Cài Đặt Menu")

TabSys:CreateKeybind({
   Name = "Phím Đóng/Mở Menu",
   CurrentKeybind = "LeftControl",
   HoldToInteract = false,
   Flag = "Keybind1", 
   Callback = function(Keybind) end,
})

TabSys:CreateButton({
   Name = "🚪 Đóng Hub Hoàn Toàn",
   Callback = function()
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Cập Nhật T-rex X",
   Content = "Đã thêm Tab Dead Rails thành công!",
   Duration = 5,
})
