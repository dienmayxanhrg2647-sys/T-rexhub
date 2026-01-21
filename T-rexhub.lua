--// T-REXHUB | FULL FIX | KEY SYSTEM
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------
-- AUTO FUNCTION (LUÔN BẬT)
--------------------------------------------------
-- Anti AFK
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),Camera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),Camera.CFrame)
end)

-- Anti Kick
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
    if getnamecallmethod()=="Kick" then
        return
    end
    return old(self,...)
end)

-- FullBright
Lighting.Brightness = 3
Lighting.ClockTime = 12
Lighting.FogEnd = 1e6

--------------------------------------------------
-- KEY SYSTEM
--------------------------------------------------
local KEY = "TREX-2026"
local Unlocked = false

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui",Player.PlayerGui)
gui.Name = "TREXHUB"

local KeyFrame = Instance.new("Frame",gui)
KeyFrame.Size = UDim2.fromScale(0.25,0.2)
KeyFrame.Position = UDim2.fromScale(0.38,0.35)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyFrame.BorderSizePixel = 0

local KeyBox = Instance.new("TextBox",KeyFrame)
KeyBox.Size = UDim2.fromScale(0.8,0.3)
KeyBox.Position = UDim2.fromScale(0.1,0.25)
KeyBox.PlaceholderText = "Nhập KEY"
KeyBox.Text = ""
KeyBox.TextScaled = true
KeyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
KeyBox.TextColor3 = Color3.new(1,1,1)

local KeyBtn = Instance.new("TextButton",KeyFrame)
KeyBtn.Size = UDim2.fromScale(0.5,0.25)
KeyBtn.Position = UDim2.fromScale(0.25,0.6)
KeyBtn.Text = "UNLOCK"
KeyBtn.TextScaled = true
KeyBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
KeyBtn.TextColor3 = Color3.new(1,1,1)

--------------------------------------------------
-- MAIN MENU
--------------------------------------------------
local Menu = Instance.new("Frame",gui)
Menu.Size = UDim2.fromScale(0.35,0.45)
Menu.Position = UDim2.fromScale(0.32,0.25)
Menu.BackgroundColor3 = Color3.fromRGB(25,25,25)
Menu.Visible = false

local Title = Instance.new("TextLabel",Menu)
Title.Size = UDim2.fromScale(1,0.12)
Title.Text = "🦖 T-REX HUB"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)

--------------------------------------------------
-- STATES
--------------------------------------------------
local InfiniteJump = false
local Noclip = false
local ESP = false

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------
local function Button(text,pos,callback)
    local b = Instance.new("TextButton",Menu)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Position = UDim2.fromScale(0.05,pos)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback)
    return b
end

--------------------------------------------------
-- BUTTONS
--------------------------------------------------
Button("Infinite Jump",0.15,function()
    InfiniteJump = not InfiniteJump
end)

Button("Noclip",0.27,function()
    Noclip = not Noclip
end)

Button("ESP Player",0.39,function()
    ESP = not ESP
end)

Button("Quantum Hub",0.55,function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
end)

Button("Teddy Hub",0.67,function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
end)

Button("Null Fire",0.79,function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"))()
end)

--------------------------------------------------
-- FUNCTIONS
--------------------------------------------------
UserInputService.JumpRequest:Connect(function()
    if InfiniteJump then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

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
-- KEY CHECK
--------------------------------------------------
KeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == KEY then
        KeyFrame.Visible = false
        Menu.Visible = true
        Unlocked = true
    else
        KeyBox.Text = "SAI KEY"
    end
end)

--------------------------------------------------
-- TOGGLE MENU (RightCtrl)
--------------------------------------------------
UserInputService.InputBegan:Connect(function(i,g)
    if not g and i.KeyCode == Enum.KeyCode.RightControl and Unlocked then
        Menu.Visible = not Menu.Visible
    end
end)
