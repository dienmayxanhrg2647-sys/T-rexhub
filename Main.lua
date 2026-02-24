-- [[ T-REX X WAKE: GITHUB VERSION ]] --
-- No Key | Legit Engine | Architect Designed

local LP = game.Players.LocalPlayer
local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_

_G.TrexWake = {
    Enabled = true,
    Weapon = "Melee", -- Có thể đổi thành "Sword"
    AttackSpeed = 0.3 -- Kiểu Legit (không quá nhanh để tránh bị kick)
}

-- Hệ thống gom quái và đánh (Logical Loop)
local function StartLegitFarm()
    task.spawn(function()
        while _G.TrexWake.Enabled do
            task.wait()
            pcall(function()
                -- 1. Tìm quái phù hợp level (Data đã nạp ở các bản trước)
                -- 2. Trang bị vũ khí
                local Tool = LP.Backpack:FindFirstChild(_G.TrexWake.Weapon) or LP.Character:FindFirstChild(_G.TrexWake.Weapon)
                if Tool and not LP.Character:FindFirstChild(Tool.Name) then
                    LP.Character.Humanoid:EquipTool(Tool)
                end
                
                -- 3. Đánh kiểu Legit
                if LP.Character:FindFirstChildOfClass("Tool") then
                    CommF:InvokeServer("RegisterAttack", 1)
                    task.wait(_G.TrexWake.AttackSpeed)
                end
            end)
        end
    end)
end

-- Thông báo khi nạp code thành công từ GitHub
game.StarterGui:SetCore("SendNotification", {
    Title = "T-REX X WAKE 🦖",
    Text = "Căn cơ Đại Cát - Đã nạp code từ GitHub!",
    Duration = 5
})

StartLegitFarm()
