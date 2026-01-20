-- 🦖 T-REX HUB | FULL UNIVERSAL HUB
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
main.Size = UDim2.new(0, 600, 0, 360)
main.Position = UDim2.new(0.5, -300, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- 🌈 RAINBOW BORDER
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3
local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 0.003) % 1
	stroke.Color = Color3.fromHSV(hue,1,1)
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
title.Text = "🦖 T-REX HUB | UNIVERSAL"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,80,80)

--------------------------------------------------
-- TAB BUTTONS
--------------------------------------------------
local tabFrame = Instance.new("Frame", main)
tabFrame.Position = UDim2.new(0,0,0,45)
tabFrame.Size = UDim2.new(0,140,1,-45)
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

local tabMain   = tabButton("MAIN",10)
local tabFun    = tabButton("FUN",60)
local tabESP    = tabButton("ESP",110)
local tabScript = tabButton("SCRIPT",160)

--------------------------------------------------
-- CONTENT FRAMES
--------------------------------------------------
local function content()
	local f = Instance.new("Frame", main)
	f.Position = UDim2.new(0,150,0,50)
	f.Size = UDim2.new(1,-160,1,-60)
	f.BackgroundTransparency = 1
	f.Visible = false
	return f
end

local mainTab = content()
local funTab = content()
local espTab = content()
local scriptTab = content()
mainTab.Visible = true

local function switch(tab)
	mainTab.Visible = false
	funTab.Visible = false
	espTab.Visible = false
	scriptTab.Visible = false
	tab.Visible = true
end

tabMain.MouseButton1Click:Connect(function() switch(mainTab) end)
tabFun.MouseButton1Click:Connect(function() switch(funTab) end)
tabESP.MouseButton1Click:Connect(function() switch(espTab) end)
tabScript.MouseButton1Click:Connect(function() switch(scriptTab) end)

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------
local function makeBtn(parent,text,y)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0,220,0,40)
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
-- MAIN TAB (SPEED + FULLBRIGHT)
--------------------------------------------------
local speed = 16
local MAX_SPEED = 300

local speedLabel = Instance.new("TextLabel", mainTab)
speedLabel.Size = UDim2.new(0,220,0,30)
speedLabel.Position = UDim2.new(0,10,0,10)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 16"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 14

local function setSpeed(v)
	speed = math.clamp(v,16,MAX_SPEED)
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = speed
	end
	speedLabel.Text = "Speed: "..speed
end

makeBtn(mainTab,"- SPEED",50).MouseButton1Click:Connect(function()
	setSpeed(speed - 10)
end)

makeBtn(mainTab,"+ SPEED",100).MouseButton1Click:Connect(function()
	setSpeed(speed + 10)
end)

-- FULLBRIGHT
local fb = false
makeBtn(mainTab,"FULLBRIGHT : OFF",150).MouseButton1Click:Connect(function(b)
	fb = not fb
	b.Text = "FULLBRIGHT : "..(fb and "ON" or "OFF")
	game:GetService("Lighting").Brightness = fb and 5 or 1
	game:GetService("Lighting").ClockTime = fb and 14 or 12
end)

--------------------------------------------------
-- FUN TAB (INF JUMP + NOCLIP + SELF FLING)
--------------------------------------------------
-- INFINITE JUMP
local infJump = false
makeBtn(funTab,"INFINITE JUMP : OFF",10).MouseButton1Click:Connect(function(b)
	infJump = not infJump
	b.Text = "INFINITE JUMP : "..(infJump and "ON" or "OFF")
end)

UIS.JumpRequest:Connect(function()
	if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- NOCLIP
local noclip = false
makeBtn(funTab,"NOCLIP : OFF",60).MouseButton1Click:Connect(function(b)
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

-- SELF FLING (VUI)
local fling = false
makeBtn(funTab,"SELF FLING : OFF",110).MouseButton1Click:Connect(function(b)
	fling = not fling
	b.Text = "SELF FLING : "..(fling and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
	if fling and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.Velocity = Vector3.new(
			math.random(-300,300),
			300,
			math.random(-300,300)
		)
	end
end)

--------------------------------------------------
-- ESP TAB (VĨNH VIỄN)
--------------------------------------------------
local ESP_ON = false
local espFolder = Instance.new("Folder", gui)
espFolder.Name = "TREX_ESP"

local function clearESP()
	espFolder:ClearAllChildren()
end

local function createESP(plr)
	if plr == player then return end
	if not plr.Character then return end
	if not plr.Character:FindFirstChild("HumanoidRootPart") then return end

	local hl = Instance.new("Highlight")
	hl.Adornee = plr.Character
	hl.FillColor = Color3.fromRGB(255,0,0)
	hl.OutlineColor = Color3.fromRGB(255,255,255)
	hl.FillTransparency = 0.5
	hl.Parent = espFolder
end

local function refreshESP()
	clearESP()
	if not ESP_ON then return end
	for _,p in pairs(Players:GetPlayers()) do
		createESP(p)
	end
end

Players.PlayerAdded:Connect(refreshESP)
Players.PlayerRemoving:Connect(refreshESP)

makeBtn(espTab,"ESP : OFF",10).MouseButton1Click:Connect(function(b)
	ESP_ON = not ESP_ON
	b.Text = "ESP : "..(ESP_ON and "ON" or "OFF")
	refreshESP()
end)

--------------------------------------------------
-- SCRIPT TAB (TỔNG HỢP)
--------------------------------------------------
makeBtn(scriptTab,"Teddy Hub",10).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
end)

makeBtn(scriptTab,"Quantum Onyx",60).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
end)

makeBtn(scriptTab,"Escape Tsunami",110).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()
end)

makeBtn(scriptTab,"Night In Forest",160).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"))()
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
