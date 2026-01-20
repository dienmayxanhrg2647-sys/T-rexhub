-- 🦖 T-REXHUB | FIXED + CLEAN
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ANTI DUP
if game.CoreGui:FindFirstChild("TrexHub") then
	game.CoreGui.TrexHub:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TrexHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,560,0,320)
main.Position = UDim2.new(0.5,-280,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- RAINBOW BORDER
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3
local h = 0
RunService.RenderStepped:Connect(function()
	h = (h + 0.003) % 1
	stroke.Color = Color3.fromHSV(h,1,1)
end)

-- TOP
local top = Instance.new("TextLabel", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(25,25,25)
top.Text = "🦖 T-REX HUB"
top.Font = Enum.Font.GothamBold
top.TextSize = 18
top.TextColor3 = Color3.fromRGB(255,80,80)
Instance.new("UICorner", top).CornerRadius = UDim.new(0,14)

-- TAB FRAME
local tabFrame = Instance.new("Frame", main)
tabFrame.Position = UDim2.new(0,0,0,45)
tabFrame.Size = UDim2.new(0,120,1,-45)
tabFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)

local function tabBtn(text,y)
	local b = Instance.new("TextButton", tabFrame)
	b.Size = UDim2.new(1,-10,0,40)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b)
	return b
end

local tabMain = tabBtn("MAIN",10)
local tabFun = tabBtn("FUN",60)
local tabScript = tabBtn("SCRIPT",110)

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

-- BUTTON MAKER
local function makeBtn(parent,text,y)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0,200,0,40)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Instance.new("UICorner", b)
	return b
end

-- SPEED
local speed = 16
local label = Instance.new("TextLabel", mainTab)
label.Size = UDim2.new(0,200,0,30)
label.Position = UDim2.new(0,10,0,10)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.GothamBold
label.Text = "Speed: 16"

local function setSpeed(v)
	speed = math.clamp(v,16,300)
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = speed
	end
	label.Text = "Speed: "..speed
end

makeBtn(mainTab,"- SPEED",50).MouseButton1Click:Connect(function()
	setSpeed(speed-10)
end)

makeBtn(mainTab,"+ SPEED",100).MouseButton1Click:Connect(function()
	setSpeed(speed+10)
end)

-- FUN
local infJump = false
local jumpBtn = makeBtn(funTab,"INFINITE JUMP : OFF",10)
jumpBtn.MouseButton1Click:Connect(function()
	infJump = not infJump
	jumpBtn.Text = "INFINITE JUMP : "..(infJump and "ON" or "OFF")
end)

UIS.JumpRequest:Connect(function()
	if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local noclip = false
local noclipBtn = makeBtn(funTab,"NOCLIP : OFF",60)
noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = "NOCLIP : "..(noclip and "ON" or "OFF")
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

-- TOGGLE
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
Instance.new("UICorner", toggle)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
