--// T-REXHUB | FULL FIXED - NO JUMP POWER
repeat task.wait() until game:IsLoaded()

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------
plr.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), cam.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), cam.CFrame)
end)

--------------------------------------------------
-- ANTILAG
--------------------------------------------------
pcall(function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	Lighting.GlobalShadows = false
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Enabled = false
		end
	end
end)

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "T_REXHUB"
gui.ResetOnSpawn = false

-- Avatar T-REX đỏ (toggle menu)
local avatar = Instance.new("TextButton", gui)
avatar.Size = UDim2.new(0,60,0,60)
avatar.Position = UDim2.new(0,20,0.5,-30)
avatar.Text = "T-REX"
avatar.BackgroundColor3 = Color3.fromRGB(180,0,0)
avatar.TextColor3 = Color3.new(1,1,1)

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,330)
main.Position = UDim2.new(0.5,-260,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible = true
main.Active = true

avatar.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

--------------------------------------------------
-- DRAG (LUÔN KÉO ĐƯỢC)
--------------------------------------------------
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = main.Position
		i.Changed:Connect(function()
			if i.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

--------------------------------------------------
-- TABS
--------------------------------------------------
local tabs = {}

local function NewTab(name,x)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0,120,0,30)
	b.Position = UDim2.new(0,x,0,5)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = Color3.new(1,1,1)

	local f = Instance.new("Frame", main)
	f.Size = UDim2.new(1,-20,1,-50)
	f.Position = UDim2.new(0,10,0,40)
	f.Visible = false
	f.BackgroundTransparency = 1

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(tabs) do v.Visible = false end
		f.Visible = true
	end)

	table.insert(tabs,f)
	return f
end

local tabPlayer = NewTab("PLAYER",10)
local tabESP    = NewTab("ESP",140)
local tabFun    = NewTab("FUN",270)
local tabScript = NewTab("SCRIPT",400)
tabPlayer.Visible = true

--------------------------------------------------
-- TOGGLE BUTTON FUNC
--------------------------------------------------
local function Toggle(parent,y,text,callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0,200,0,35)
	btn.Position = UDim2.new(0,10,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.new(1,1,1)
	local state = false
	btn.Text = text.." [OFF]"

	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text.." ["..(state and "ON" or "OFF").."]"
		callback(state)
	end)
end

--------------------------------------------------
-- PLAYER (NO JUMP POWER)
--------------------------------------------------
local SpeedOn = false
local InfJump = false
local Noclip = false
local SpeedValue = 16

local speedText = Instance.new("TextLabel", tabPlayer)
speedText.Size = UDim2.new(0,200,0,30)
speedText.Position = UDim2.new(0,10,0,10)
speedText.TextColor3 = Color3.new(1,1,1)
speedText.Text = "Speed: 16"

local speedBox = Instance.new("TextBox", tabPlayer)
speedBox.Size = UDim2.new(0,100,0,30)
speedBox.Position = UDim2.new(0,10,0,50)
speedBox.Text = "16"
speedBox.ClearTextOnFocus = false

speedBox.FocusLost:Connect(function()
	local n = tonumber(speedBox.Text)
	if n then
		SpeedValue = math.clamp(n,1,200)
		speedText.Text = "Speed: "..SpeedValue
	end
end)

Toggle(tabPlayer,90,"Speed",function(v) SpeedOn = v end)
Toggle(tabPlayer,135,"Infinite Jump",function(v) InfJump = v end)
Toggle(tabPlayer,180,"Noclip",function(v) Noclip = v end)

RS.RenderStepped:Connect(function()
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = SpeedOn and SpeedValue or 16
	end
end)

UIS.JumpRequest:Connect(function()
	if InfJump and plr.Character then
		plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

RS.Stepped:Connect(function()
	if Noclip and plr.Character then
		for _,v in pairs(plr.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

--------------------------------------------------
-- FUN
--------------------------------------------------
local flingOn = false
Toggle(tabFun,10,"Fling",function(v) flingOn = v end)

RS.Heartbeat:Connect(function()
	if flingOn and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,180,0)
	end
end)

--------------------------------------------------
-- ESP (THẬT - MOBILE OK)
--------------------------------------------------
local ESPOn = false
local ESPFolder = Instance.new("Folder", gui)
ESPFolder.Name = "ESP"

Toggle(tabESP,10,"ESP",function(v)
	ESPOn = v
	for _,g in pairs(ESPFolder:GetChildren()) do g:Destroy() end
end)

RS.RenderStepped:Connect(function()
	if not ESPOn then return end
	if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end

	for _,p in pairs(Players:GetPlayers()) do
		if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			if not ESPFolder:FindFirstChild(p.Name) then
				local bb = Instance.new("BillboardGui", ESPFolder)
				bb.Name = p.Name
				bb.Adornee = p.Character.HumanoidRootPart
				bb.Size = UDim2.new(0,120,0,40)
				bb.AlwaysOnTop = true

				local txt = Instance.new("TextLabel", bb)
				txt.Size = UDim2.new(1,0,1,0)
				txt.BackgroundTransparency = 1
				txt.TextColor3 = Color3.new(1,0,0)
				txt.TextScaled = true
				txt.Font = Enum.Font.SourceSansBold
			end

			local dist = (plr.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
			ESPFolder[p.Name].TextLabel.Text = p.Name.." ["..math.floor(dist).."]"
		end
	end
end)

--------------------------------------------------
-- TAB SCRIPT
--------------------------------------------------
local scripts = {
	{"Quantum Onyx","https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"},
	{"Teddy Hub","https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"},
	{"Dead Rails","https://raw.githubusercontent.com/InfernusScripts/Null-Fire/main/Loader"},
	{"Escape Tsunami","https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"}
}

local y = 10
for _,s in pairs(scripts) do
	local b = Instance.new("TextButton", tabScript)
	b.Size = UDim2.new(0,240,0,40)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = s[1]
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.TextColor3 = Color3.new(1,1,1)

	b.MouseButton1Click:Connect(function()
		pcall(function()
			loadstring(game:HttpGet(s[2]))()
		end)
	end)
	y = y + 50
end

print("T-REXHUB | Loaded (NO JUMP POWER)")
