-- [[ T-REX X WAKE - REBUILT FROM ANDEPZAI ]] --
-- No Key | No Banana | Pure Farming

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHub/refs/heads/main/MobileLib.lua"))()
local Window = Library:CreateWindow("🦖 T-REX X WAKE", "V1.0 - NO KEY")

local MainTab = Window:CreateTab("Main Farming")

-- [[ BIẾN ĐIỀU KHIỂN ]] --
_G.AutoFarm = false
_G.FastAttack = false

-- [[ CHỨC NĂNG FARM LEVEL CHUẨN ]] --
MainTab:CreateToggle("Auto Farm Level", function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            task.wait()
            pcall(function()
                local player = game.Players.LocalPlayer
                local level = player.Data.Level.Value
                
                -- Kiểm tra nhiệm vụ
                if not player.PlayerGui.Main.Quest.Visible then
                    -- Tự động nhận Quest (Sư huynh để ví dụ bãi đầu, đệ có thể thêm đủ 2800)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
                else
                    -- Đi săn quái nhiệm vụ
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            -- Teleport tới quái
                            player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                            
                            -- Cầm Võ (Melee)
                            for _, tool in pairs(player.Backpack:GetChildren()) do
                                if tool.ToolTip == "Melee" then
                                    player.Character.Humanoid:EquipTool(tool)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

-- [[ KILL AURA / FAST ATTACK ]] --
MainTab:CreateToggle("Super Fast Attack", function(state)
    _G.FastAttack = state
    task.spawn(function()
        while _G.FastAttack do
            task.wait()
            pcall(function()
                -- Sử dụng Framework của Blox Fruits để đánh không delay
                local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                local CombatFrameworkLib = getupvalue(CombatFramework, 2)
                CombatFrameworkLib.activeController:attack()
            end)
        end
    end)
end)

-- [[ THÔNG BÁO KHI LOAD ]] --
print("🦖 T-REX X WAKE: Script Loaded Successfully!")
