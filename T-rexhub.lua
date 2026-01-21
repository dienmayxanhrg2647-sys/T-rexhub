-- T-REXHUB | FULL FIX FINAL
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------
-- AUTO FULLBRIGHT
--------------------------------------------------
pcall(function()
    Lighting.Brightness = 3
    Lighting.ClockTime = 12
    Lighting.FogEnd = 1e6
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
-- ANTI KICK
--------------------------------------------------
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt,false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self,...)
        if getnamecallmethod() == "Kick" then
            return
        end
        return old(self,...)
    end)
end)

--------------------------------------------------
-- PLAYER MOD
--------------------------------------------------
local InfiniteJump = false
UIS.JumpRequest:Connect(function()
    if InfiniteJump and Player.Character then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

local Noclip = false
RunService.Stepped:Connect(function()
    if Noclip and Player.Character then
        for _,v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

--------------------------------------------------
-- ESP NÂNG CAO
--------------------------------------------------
local ESP = {Enabled=false,Box={},Text={}}

local function ClearESP()
    for _,v in pairs(ESP.Box) do pcall(function() v:Remove() end) end
    for _,v in pairs(ESP.Text) do pcall(function() v:Remove() end) end
    ESP.Box,ESP.Text = {},{}
end

local function AddESP(plr)
    if plr == Player then return end

    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.fromRGB(255,80,80)
    box.Filled = false
    box.Visible = false

    local txt = Drawing.new("Text")
    txt.Size = 13
    txt.Center = true
    txt.Outline = true
    txt.Visible = false

    ESP.Box[plr] = box
    ESP.Text[plr] = txt
end

for _,p in pairs(Players:GetPlayers()) do AddESP(p) end
Players.PlayerAdded:Connect(AddESP)
Players.PlayerRemoving:Connect(function(p)
    if ESP.Box[p] then ESP.Box[p]:Remove() ESP.Text[p]:Remove() end
end)

RunService.RenderStepped:Connect(function()
    if not ESP.Enabled then ClearESP() return end

    for plr,box in pairs(ESP.Box) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then
            local pos,vis = Camera:WorldToViewportPoint(hrp.Position)
            if vis then
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                local size = math.clamp(3000/dist,30,120)

                box.Size = Vector2.new(size,size*1.5)
                box.Position = Vector2.new(pos.X-size/2,pos.Y-size/1.2)
                box.Visible = true

                local t = ESP.Text[plr]
                t.Text = plr.Name.." ["..math.floor(dist).."]"
                t.Position = Vector2.new(pos.X,pos.Y-size)
                t.Visible = true
            end
        end
    end
end)

--------------------------------------------------
-- GUI MENU
--------------------------------------------------
local gui = Instance.new("ScreenGui", Player.PlayerGui)
gui.Name = "T_REXHUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,300)
main.Position = UDim2.new(0.5,-210,0.5,-150)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "🦖 T-REX HUB | FULL FIX"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)

--------------------------------------------------
-- BUTTON CREATOR
--------------------------------------------------
local function Button(text,y,callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.45,0,0,35)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.MouseButton1Click:Connect(callback)
    return b
end

--------------------------------------------------
-- MAIN TAB
--------------------------------------------------
Button("ESP : OFF",50,function(self)
    ESP.Enabled = not ESP.Enabled
    self.Text = ESP.Enabled and "ESP : ON" or "ESP : OFF"
end)

Button("Infinite Jump : OFF",95,function(self)
    InfiniteJump = not InfiniteJump
    self.Text = InfiniteJump and "Infinite Jump : ON" or "Infinite Jump : OFF"
end)

Button("Noclip : OFF",140,function(self)
    Noclip = not Noclip
    self.Text = Noclip and "Noclip : ON" or "Noclip : OFF"
end)

--------------------------------------------------
-- TAB SCRIPT (4 SCRIPT)
--------------------------------------------------
local Scripts = {
    ["Null-Fire"] = "https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader",
    ["Quantum"]   = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/main/QuantumOnyx.lua",
    ["Teddy Hub"] = "https://raw.githubusercontent.com/Teddyseetink/Haidepzai/main/TeddyHub.lua",
    ["Tsunami"]   = "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"
}

local loaded = {}

local function LoadScript(name)
    if loaded[name] then return end
    loaded[name] = true
    pcall(function()
        loadstring(game:HttpGet(Scripts[name]))()
    end)
end

local y = 185
for name,_ in pairs(Scripts) do
    Button("Load "..name,y,function()
        LoadScript(name)
    end)
    y = y + 45
end
