-- T-REXHUB | FULL FIX VERSION
repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------
-- ANTI KICK
--------------------------------------------------
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
    local method = getnamecallmethod()
    if method == "Kick" then
        warn("AntiKick blocked")
        return
    end
    return old(self,...)
end)

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),Camera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),Camera.CFrame)
end)

--------------------------------------------------
-- FULLBRIGHT
--------------------------------------------------
local function FullBright(on)
    if on then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
    end
end
FullBright(true)

--------------------------------------------------
-- PLAYER MOD
--------------------------------------------------
local InfiniteJump = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJump then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

local Noclip = false
RunService.Stepped:Connect(function()
    if Noclip and Player.Character then
        for _,v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

--------------------------------------------------
-- ESP NÂNG CAO
--------------------------------------------------
local ESP = {Enabled=false,Boxes={},Texts={}}

local function ClearESP()
    for _,v in pairs(ESP.Boxes) do v:Remove() end
    for _,v in pairs(ESP.Texts) do v:Remove() end
    ESP.Boxes,ESP.Texts = {},{}
end

local function AddESP(plr)
    if plr==Player then return end
    local box = Drawing.new("Square")
    box.Thickness=2 box.Filled=false box.Color=Color3.fromRGB(255,80,80)

    local txt = Drawing.new("Text")
    txt.Size=13 txt.Center=true txt.Outline=true

    ESP.Boxes[plr]=box
    ESP.Texts[plr]=txt
end

for _,p in pairs(Players:GetPlayers()) do AddESP(p) end
Players.PlayerAdded:Connect(AddESP)
Players.PlayerRemoving:Connect(function(p)
    if ESP.Boxes[p] then ESP.Boxes[p]:Remove() ESP.Texts[p]:Remove() end
end)

RunService.RenderStepped:Connect(function()
    if not ESP.Enabled then ClearESP() return end
    for plr,box in pairs(ESP.Boxes) do
        local char=plr.Character
        local hrp=char and char:FindFirstChild("HumanoidRootPart")
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.Health>0 and plr.Team~=Player.Team then
            local pos,vis=Camera:WorldToViewportPoint(hrp.Position)
            if vis then
                local dist=(Camera.CFrame.Position-hrp.Position).Magnitude
                local size=math.clamp(3000/dist,30,120)
                box.Size=Vector2.new(size,size*1.5)
                box.Position=Vector2.new(pos.X-size/2,pos.Y-size/1.2)
                box.Visible=true

                local t=ESP.Texts[plr]
                t.Text=plr.Name.." ["..math.floor(dist).."]"
                t.Position=Vector2.new(pos.X,pos.Y-size)
                t.Visible=true
            end
        end
    end
end)

--------------------------------------------------
-- TAB SCRIPT (LOAD)  ⬅️ CHỈ THÊM 1 SCRIPT
--------------------------------------------------
local Scripts = {
    Quantum   = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua",
    Teddy     = "https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua",
    DeadRails = "https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader", -- 👈 THÊM
    Tsunami   = "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"
}

--------------------------------------------------
-- CÁCH GỌI SCRIPT
--------------------------------------------------
-- loadstring(game:HttpGet(Scripts.Quantum))()
-- loadstring(game:HttpGet(Scripts.Teddy))()
-- loadstring(game:HttpGet(Scripts.DeadRails))() -- 👈 NULL-FIRE / DEAD RAILS
-- loadstring(game:HttpGet(Scripts.Tsunami))()
