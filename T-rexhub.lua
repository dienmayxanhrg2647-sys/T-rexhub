-- T-REXHUB | FINAL FIX VERSION
repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------
-- ANTI KICK
--------------------------------------------------
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt,false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self,...)
        if getnamecallmethod()=="Kick" then
            warn("[T-REXHUB] AntiKick blocked")
            return
        end
        return old(self,...)
    end)
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
Lighting.Brightness = 3
Lighting.ClockTime = 12
Lighting.FogEnd = 1e9

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui",Player.PlayerGui)
gui.Name = "T_REXHUB"
gui.ResetOnSpawn = false

local main = Instance.new("Frame",gui)
main.Size = UDim2.fromOffset(420,280)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "🦖 T-REXHUB | FINAL"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------
local function Button(text,pos,callback)
    local b = Instance.new("TextButton",main)
    b.Size = UDim2.fromOffset(180,40)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(50,50,50)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.SourceSans
    b.TextSize = 16
    b.MouseButton1Click:Connect(callback)
    return b
end

--------------------------------------------------
-- STATES
--------------------------------------------------
local ESP_ON = false
local IJ_ON = false
local NOCLIP_ON = false

--------------------------------------------------
-- ESP
--------------------------------------------------
local ESP = {}

local function ClearESP()
    for _,v in pairs(ESP) do
        if v.Box then v.Box:Remove() end
        if v.Text then v.Text:Remove() end
    end
    ESP={}
end

RunService.RenderStepped:Connect(function()
    if not ESP_ON then ClearESP() return end

    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if not ESP[plr] then
                ESP[plr]={
                    Box = Drawing.new("Square"),
                    Text = Drawing.new("Text")
                }
                ESP[plr].Box.Thickness=2
                ESP[plr].Box.Filled=false
                ESP[plr].Box.Color=Color3.fromRGB(255,80,80)
                ESP[plr].Text.Size=13
                ESP[plr].Text.Center=true
                ESP[plr].Text.Outline=true
            end

            local hrp = plr.Character.HumanoidRootPart
            local pos,vis = Camera:WorldToViewportPoint(hrp.Position)
            if vis then
                local dist = (Camera.CFrame.Position-hrp.Position).Magnitude
                local size = math.clamp(3000/dist,30,120)

                ESP[plr].Box.Size = Vector2.new(size,size*1.5)
                ESP[plr].Box.Position = Vector2.new(pos.X-size/2,pos.Y-size/1.2)
                ESP[plr].Box.Visible = true

                ESP[plr].Text.Text = plr.Name.." ["..math.floor(dist).."]"
                ESP[plr].Text.Position = Vector2.new(pos.X,pos.Y-size)
                ESP[plr].Text.Visible = true
            end
        end
    end
end)

--------------------------------------------------
-- INFINITE JUMP
--------------------------------------------------
UIS.JumpRequest:Connect(function()
    if IJ_ON and Player.Character then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

--------------------------------------------------
-- NOCLIP
--------------------------------------------------
RunService.Stepped:Connect(function()
    if NOCLIP_ON and Player.Character then
        for _,v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide=false
            end
        end
    end
end)

--------------------------------------------------
-- BUTTONS
--------------------------------------------------
Button("ESP : OFF",UDim2.fromOffset(20,60),function(self)
    ESP_ON = not ESP_ON
    self.Text = "ESP : "..(ESP_ON and "ON" or "OFF")
end)

Button("Infinite Jump",UDim2.fromOffset(20,110),function()
    IJ_ON = not IJ_ON
end)

Button("Noclip",UDim2.fromOffset(20,160),function()
    NOCLIP_ON = not NOCLIP_ON
end)

--------------------------------------------------
-- TAB SCRIPT
--------------------------------------------------
Button("Quantum Hub",UDim2.fromOffset(220,60),function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/main/QuantumOnyx.lua"))()
end)

Button("Teddy Hub",UDim2.fromOffset(220,110),function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/main/TeddyHub.lua"))()
end)

Button("Dead Rails (Null Fire)",UDim2.fromOffset(220,160),function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
end)

--------------------------------------------------
print("[T-REXHUB] Loaded successfully")
