-- [[ 🦖 T-REX X | VERSION 6.5 - THÁI CỰC ĐỊNH CÀN KHÔN ]] --
-- Bản Quyền: Nguyen van thai | Link: dienmayxanhrg2647-sys
-- Fix 100% | Anti-Cheat Vô Vi | No Key | Full All Hubs

local _S,_E=pcall(function()
    -- [ 🛡️ THÁI CỰC HỘ THÂN - ANTI KICK & BYPASS ] --
    local m=getrawmetatable(game)
    local o=m.__namecall 
    local i=m.__index 
    setreadonly(m,false)
    m.__namecall=newcclosure(function(s,...)
        local d=getnamecallmethod()
        if d=="\75\105\99\107" or d=="\107\105\99\107" or d=="\66\114\101\97\107\74\111\105\110\116\115" then 
            return nil 
        end 
        return o(s,...)
    end)
    m.__index=newcclosure(function(t,k)
        if k=="\87\97\108\107\83\112\101\101\100" or k=="\74\117\109\112\80\111\119\101\114" then 
            return 16 
        end 
        return i(t,k)
    end)
    setreadonly(m,true)
end)

-- [ 🧘 ĐỊNH TÂM PHÁP - ANTI AFK ] --
task.spawn(function()
    local v=game:GetService("\86\105\114\116\117\97\108\85\115\101\114")
    game:GetService("\80\108\97\121\101\114\115").LocalPlayer.Idled:Connect(function()
        v:CaptureController()
        v:ClickButton2(Vector2.new())
    end)
end)

-- [ 🎨 KHỞI TẠO CÀN KHÔN MENU ] --
local _1=loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\115\105\114\105\117\115\46\109\101\110\117\47\114\97\121\102\105\101\108\100"))()
local _2=_1:CreateWindow({
    Name="T-rex X v6.5 🔥 THÁI CỰC",
    LoadingTitle="🦖 T-REX X | ĐỊNH CÀN KHÔN",
    LoadingSubtitle="By Nguyen van thai",
    ConfigurationSaving={Enabled=true,FolderName="TrexX_v65",FileName="Main"},
    KeySystem=false
})

-- [[ CÁC PHÂN ĐÀ (TABS) ]] --
local _B=_2:CreateTab("Blox Fruit",4483362458)
local _D=_2:CreateTab("Dead Rails",10728953210)
local _9=_2:CreateTab("99 Night",4483362458)
local _W=_2:CreateTab("Brainrot 🌊",7734068321)
local _S=_2:CreateTab("Hệ Thống",4483345906)

--- [[ BLOX FRUIT CHƯƠNG ]] ---
_B:CreateSection("🌟 Script Hubs VIP")
_B:CreateButton({Name="WhiteX Beta",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))()end})
_B:CreateButton({Name="Apple Hub VIP",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))()end})
_B:CreateButton({Name="Quantum Onyx",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()end})
_B:CreateButton({Name="Teddy Hub",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()end})

--- [[ DEAD RAILS & 99 NIGHT ]] ---
_D:CreateButton({Name="Null-Fire (Dead Rails)",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()end})
_9:CreateButton({Name="H4x Loader (99 Night)",Callback=function()loadstring(game:HttpGet("https://H4xScripts.xyz/loader"))()end})

--- [[ BRAINROT CHƯƠNG ]] ---
_W:CreateButton({Name="Escape Tsunami",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()end})

--- [[ HỆ THỐNG CHƯƠNG ]] ---
local _P=_S:CreateLabel("Ping: ...")
local _L=_S:CreateLabel("Số Player: ...")
local _T=_S:CreateLabel("Thời gian: 00:00:00")

_S:CreateSection("🛠️ Võ Học Tiện Ích")
_S:CreateButton({Name="Định Càn Khôn (Sáng Map)",Callback=function()
    local L=game:GetService("Lighting")
    L.Brightness=2 L.ClockTime=14 L.GlobalShadows=false L.OutdoorAmbient=Color3.fromRGB(128,128,128)
end})
_S:CreateButton({Name="Khinh Công (Fly V3)",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()end})
_S:CreateButton({Name="Hồi Gia (Rejoin)",Callback=function()game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId)end})

-- [ 🔄 VÒNG LẶP NỘI CÔNG ] --
local _st=os.time()
task.spawn(function()
    while task.wait(1) do 
        pcall(function()
            local p=tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+"))
            _P:Set("Ping: "..(p or 0).." ms")
            _L:Set("Player: "..#game.Players:GetPlayers().."/"..game.Players.MaxPlayers)
            local d=os.time()-_st 
            _T:Set(string.format("Tọa thiền: %02d:%02d:%02d",math.floor(d/3600),math.floor((d%3600)/60),d%60))
        end)
    end 
end)
