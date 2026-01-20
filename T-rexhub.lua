-- 🦖 T-REX HUB | UNIVERSAL CLIENT HUB
-- Made for learning & fun | Client-side only

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
main.Size = UDim2.new(0,560,0,330)
main.Position = UDim2.new(0.5,-280,0.5,-165)
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
title.Text = "🦖 T-REX HUB | CLIENT HUB"
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
local tabFun = tabButton("FUN",60)
local tabESP = tabButton("ESP",110)
local tabScript = tabButton("SCRIPT",160)

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
-- MAIN TAB (SPEED)
--------------------------------------------------
local speed = 16
local maxSpeed = 300

local speedLabel = Instance.new("TextLabel", mainTab)
speedLabel.Size = UDim2.new(0,220,0,30)
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
makeBtn(funTab,"INFINITE JUMP : OFF",10).MouseButton1Click:Connect(function(b)
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

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
	vu:Button2Down(Vector2.new(0,0),camera.CFrame)
	task.wait(1)
	vu:Button2Up(Vector2.new(0,0),camera.CFrame)
end)

--------------------------------------------------
-- ESP TAB
--------------------------------------------------
local espEnabled = false
local espObjects = {}

local function clearESP()
	for _,v in pairs(espObjects) do
		if v then v:Destroy() end
	end
	espObjects = {}
end

local function createESP(plr)
	if plr == player then return end
	if not plr.Character then return end
	local head = plr.Character:FindFirstChild("Head")
	if not head then return end

	local bill = Instance.new("BillboardGui", head)
	bill.Size = UDim2.new(0,100,0,40)
	bill.AlwaysOnTop = true

	local txt = Instance.new("TextLabel", bill)
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = plr.Name
	txt.TextColor3 = Color3.new(1,0,0)
	txt.Font = Enum.Font.GothamBold
	txt.TextSize = 14

	table.insert(espObjects,bill)
end

makeBtn(espTab,"ESP PLAYER : OFF",10).MouseButton1Click:Connect(function(b)
	espEnabled = not espEnabled
	b.Text = "ESP PLAYER : "..(espEnabled and "ON" or "OFF")
	clearESP()
	if espEnabled then
		for _,plr in pairs(Players:GetPlayers()) do
			createESP(plr)
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)
	if espEnabled then
		plr.CharacterAdded:Wait()
		createESP(plr)
	end
end)

--------------------------------------------------
-- SCRIPT TAB
--------------------------------------------------
makeBtn(scriptTab,"LOAD QUANTUM ONYX",10).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
end)

makeBtn(scriptTab,"LOAD TEDDY HUB",60).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
end)

--------------------------------------------------
-- ANTI KICK (CLIENT)
--------------------------------------------------
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
	local args = {...}
	if tostring(self) == "Kick" then
		return
	end
	return old(self,...)
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
