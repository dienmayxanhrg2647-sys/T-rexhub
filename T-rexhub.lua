-- T-REXHUB | FULL FIX MENU VERSION
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
-- AUTO FUNCTION
--------------------------------------------------
-- AntiKick
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt,false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self,...)
        if getnamecallmethod()=="Kick" then return end
        return old(self,...)
    end)
end)

-- AntiAFK
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),Camera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),Camera.CFrame)
end)

-- FullBright
Lighting.Brightness = 3
Lighting.ClockTime = 12
Lighting.FogEnd = 1e9

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", Player.PlayerGui)
gui.Name = "TREXHUB"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(420,300)
main.Position = UDim2.fromScale(0.3,0.3)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active, main.Draggable = true, true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "🦖 T-REX HUB | FULL FIX"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)

local tabFrame = Instance.new("Frame", main)
tabFrame.Position = UDim2.fromOffset(0,30)
tabFrame.Size = UDim2.fromOffset(120,270)
tabFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)

local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(120,30)
content.Size = UDim2.fromOffset(300,270)
content.BackgroundColor3 = Color3.fromRGB(30,30,30)

local function newButton(text,parent,y)
    local b = Instance.new("TextButton",parent)
    b.Size = UDim2.new(1,0,0,35)
    b.Position = UDim2.fromOffset(0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(50,50,50)
    b.TextColor3 = Color3.new(1,1,1)
    return b
end

--------------------------------------------------
-- PLAYER MOD
--------------------------------------------------
local infJump, noclip, esp = false,false,false

UIS.JumpRequest:Connect(function()
    if infJump and Player.Character then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

RunService.Stepped:Connect(function()
    if noclip and Player.Character then
        for _,v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
end)

--------------------------------------------------
-- ESP
--------------------------------------------------
local espDraw = {}
local function clearESP()
    for _,v in pairs(espDraw) do v:Remove() end
    espDraw={}
end

RunService.RenderStepped:Connect(function()
    clearESP()
    if not esp then return end
    for _,p in pairs(Players:GetPlayers()) do
        if p~=Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos,vis = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if vis then
                local t = Drawing.new("Text")
                t.Text = p.Name
                t.Position = Vector2.new(pos.X,pos.Y)
                t.Size = 13
                t.Color = Color3.fromRGB(255,80,80)
                t.Center = true
                espDraw[#espDraw+1]=t
            end
        end
    end
end)

--------------------------------------------------
-- TABS
--------------------------------------------------
local y=0
newButton("Player",tabFrame,y).MouseButton1Click:Connect(function()
    content:ClearAllChildren()
    local b1=newButton("Infinite Jump",content,10)
    b1.MouseButton1Click:Connect(function()
        infJump=not infJump
        b1.Text="Infinite Jump : "..(infJump and "ON" or "OFF")
    end)

    local b2=newButton("Noclip",content,50)
    b2.MouseButton1Click:Connect(function()
        noclip=not noclip
        b2.Text="Noclip : "..(noclip and "ON" or "OFF")
    end)

    local b3=newButton("ESP Player",content,90)
    b3.MouseButton1Click:Connect(function()
        esp=not esp
        b3.Text="ESP : "..(esp and "ON" or "OFF")
    end)
end)

newButton("Script",tabFrame,40).MouseButton1Click:Connect(function()
    content:ClearAllChildren()

    newButton("Quantum Hub",content,10).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
    end)

    newButton("Teddy Hub",content,50).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
    end)

    newButton("Dead Rails (Null Fire)",content,90).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
    end)

    newButton("Sống Thần Baranrot",content,130).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()
    end)
end)

-- OPEN TAB MẶC ĐỊNH
task.wait(0.1)
tabFrame:GetChildren()[1].MouseButton1Click:Fire()
