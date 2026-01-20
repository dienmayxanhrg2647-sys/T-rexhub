-- 🦖 T-REXHUB | FULL HUB (CLEAN)
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

--------------------------------------------------
-- ANTI DUPLICATE
--------------------------------------------------
if game.CoreGui:FindFirstChild("TrexHub") then
    game.CoreGui.TrexHub:Destroy()
end

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TrexHub"

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 560, 0, 320)
main.Position = UDim2.new(0.5, -280, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- 🌈 RAINBOW BORDER
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3
local h = 0
RunService.RenderStepped:Connect(function()
	h = (h + 0.003) % 1
	stroke.Color = Color3.fromHSV(h,1,1)
end)

--------------------------------------------------
-- TOP BAR
--------------------------------------------------
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", top).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "🦖 T-REX HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,80,80)

--------------------------------------------------
-- TAB BUTTONS
--------------------------------------------------
local tabFrame = Instance.new("Frame", main)
tabFrame.Position = UDim2.new(0,0,0,45)
tabFrame.Size = UDim2.new(0,120,1,-45)
tabFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)

local function tabButton(text,y)
	local b = Instance.new("TextButton", tabFrame)
	b.Size = UDim2.new(1,-10,0,40)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local tabMain = tabButton("MAIN",10)
local tabFun  = tabButton("FUN",60)
local tabScript = tabButton("SCRIPT",110)

--------------------------------------------------
-- CONTENT FRAMES
--------------------------------------------------
local function content()
	local f = Instance.new("Frame", main)
	f.Position = UDim2.new(0,130,0,50)
	f.Size = UDim2.new(1,-140,1,-60)
	f.BackgroundTransparency = 1
	f.Visible = false
	return f
end

local mainTab = content()
local funTab = content()
local scriptTab = content()
mainTab.Visible = true

local function switch(tab)
	mainTab.Visible = false
	funTab.Visible = false
	scriptTab.Visible = false
	tab.Visible = true
end

tabMain.MouseButton1Click:Connect(function() switch(mainTab) end)
tabFun.MouseButton1Click:Connect(function() switch(funTab) end)
tabScript.MouseButton1Click:Connect(function() switch(scriptTab) end)

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------
local function makeBtn(parent,text,y)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0,200,0,40)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

--------------------------------------------------
-- MAIN TAB (SPEED)
--------------------------------------------------
local speed = 16
local maxSpeed = 300

local speedLabel = Instance.new("TextLabel", mainTab)
speedLabel.Size = UDim2.new(0,200,0,30)
speedLabel.Position = UDim2.new(0,10,0,10)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 14
speedLabel.Text = "Speed: 16"

local function setSpeed(v)
	speed = math.clamp(v,16,maxSpeed)
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = speed
	end
	speedLabel.Text = "Speed: "..speed
end

makeBtn(mainTab,"- SPEED",50).MouseButton1Click:Connect(function()
	setSpeed(speed-10)
end)

makeBtn(mainTab,"+ SPEED",100).MouseButton1Click:Connect(function()
	setSpeed(speed+10)
end)

--------------------------------------------------
-- FUN TAB
--------------------------------------------------
-- Infinite Jump
local infJump = false
makeBtn(funTab,"INFINITE JUMP",10).MouseButton1Click:Connect(function(b)
	infJump = not infJump
	b.Text = "INFINITE JUMP : "..(infJump and "ON" or "OFF")
end)

UIS.JumpRequest:Connect(function()
	if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- Noclip
local noclip = false
makeBtn(funTab,"NOCLIP",60).MouseButton1Click:Connect(function(b)
	noclip = not noclip
	b.Text = "NOCLIP : "..(noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _,v in pairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

--------------------------------------------------
-- SCRIPT TỔNG HỢP
--------------------------------------------------
makeBtn(scriptTab,"LOAD QUANTUM ONYX",10).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"
	))()
end)

makeBtn(scriptTab,"LOAD TEDDY HUB",60).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"
	))()
end)

--------------------------------------------------
-- TOGGLE BUTTON
--------------------------------------------------
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,15,0.5,-30)
toggle.Text = "RED"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(180,0,0)
toggle.Active = true
toggle.Draggable = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,12)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
