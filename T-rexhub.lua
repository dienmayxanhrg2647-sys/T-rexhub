-- 🦖 T-REX HUB v2 | CLEAN - FIXED - ALL GAMES
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

--------------------------------------------------
-- ANTI DUPLICATE
--------------------------------------------------
if game.CoreGui:FindFirstChild("TrexHubV2") then
	game.CoreGui.TrexHubV2:Destroy()
end

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TrexHubV2"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 360)
main.Position = UDim2.new(0.5,-300,0.5,-180)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- 🌈 Rainbow Border
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3
local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 0.002) % 1
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
title.Text = "🦖 T-REX HUB v2"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,80,80)

--------------------------------------------------
-- TAB BUTTONS
--------------------------------------------------
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0,0,0,45)
tabBar.Size = UDim2.new(0,130,1,-45)
tabBar.BackgroundColor3 = Color3.fromRGB(22,22,22)

local function tabBtn(txt,y)
	local b = Instance.new("TextButton", tabBar)
	b.Size = UDim2.new(1,-10,0,40)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local tMain   = tabBtn("MAIN",10)
local tFun    = tabBtn("FUN",60)
local tScript = tabBtn("SCRIPT",110)

--------------------------------------------------
-- CONTENT FRAMES
--------------------------------------------------
local function content()
	local f = Instance.new("Frame", main)
	f.Position = UDim2.new(0,140,0,55)
	f.Size = UDim2.new(1,-150,1,-65)
	f.BackgroundTransparency = 1
	f.Visible = false
	return f
end

local cMain   = content()
local cFun    = content()
local cScript = content()
cMain.Visible = true

local function show(tab)
	cMain.Visible=false
	cFun.Visible=false
	cScript.Visible=false
	tab.Visible=true
end
tMain.MouseButton1Click:Connect(function() show(cMain) end)
tFun.MouseButton1Click:Connect(function() show(cFun) end)
tScript.MouseButton1Click:Connect(function() show(cScript) end)

--------------------------------------------------
-- UI BUTTON MAKER
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
-- MAIN TAB
--------------------------------------------------
-- SPEED
local speed = 16
local maxSpeed = 300

local spLabel = Instance.new("TextLabel", cMain)
spLabel.Size = UDim2.new(0,220,0,30)
spLabel.Position = UDim2.new(0,10,0,5)
spLabel.BackgroundTransparency = 1
spLabel.TextColor3 = Color3.new(1,1,1)
spLabel.Font = Enum.Font.GothamBold
spLabel.TextSize = 14
spLabel.Text = "Speed: 16"

local function setSpeed(v)
	speed = math.clamp(v,16,maxSpeed)
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = speed
	end
	spLabel.Text = "Speed: "..speed
end

makeBtn(cMain,"- SPEED",40).MouseButton1Click:Connect(function()
	setSpeed(speed-10)
end)
makeBtn(cMain,"+ SPEED",90).MouseButton1Click:Connect(function()
	setSpeed(speed+10)
end)

--------------------------------------------------
-- FUN TAB
--------------------------------------------------
-- INFINITE JUMP
local infJump = false
local bInf = makeBtn(cFun,"INFINITE JUMP : OFF",10)
bInf.MouseButton1Click:Connect(function()
	infJump = not infJump
	bInf.Text = "INFINITE JUMP : "..(infJump and "ON" or "OFF")
end)

UIS.JumpRequest:Connect(function()
	if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- NOCLIP
local noclip = false
local bNc = makeBtn(cFun,"NOCLIP : OFF",60)
bNc.MouseButton1Click:Connect(function()
	noclip = not noclip
	bNc.Text = "NOCLIP : "..(noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _,v in ipairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide=false end
		end
	end
end)

-- FLING SELF
local fling=false
local bF = makeBtn(cFun,"FLING SELF : OFF",110)
bF.MouseButton1Click:Connect(function()
	fling=not fling
	bF.Text="FLING SELF : "..(fling and "ON" or "OFF")
	if fling and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		task.spawn(function()
			while fling do
				local hrp = player.Character.HumanoidRootPart
				hrp.Velocity = Vector3.new(0,300,0)
				task.wait(0.2)
			end
		end)
	end
end)

--------------------------------------------------
-- SYSTEM FEATURES (GLOBAL)
--------------------------------------------------
-- FULLBRIGHT
local fullbright=false
local old = {Brightness=Lighting.Brightness, ClockTime=Lighting.ClockTime, FogEnd=Lighting.FogEnd}

local function setFB(on)
	fullbright=on
	if on then
		Lighting.Brightness=3
		Lighting.ClockTime=12
		Lighting.FogEnd=1e9
	else
		for k,v in pairs(old) do Lighting[k]=v end
	end
end

local bFB = makeBtn(cMain,"FULLBRIGHT : OFF",140)
bFB.MouseButton1Click:Connect(function()
	setFB(not fullbright)
	bFB.Text="FULLBRIGHT : "..(fullbright and "ON" or "OFF")
end)

-- ANTI AFK
local antiAFK=false
local bAFK = makeBtn(cMain,"ANTI AFK : OFF",190)
bAFK.MouseButton1Click:Connect(function()
	antiAFK=not antiAFK
	bAFK.Text="ANTI AFK : "..(antiAFK and "ON" or "OFF")
end)

player.Idled:Connect(function()
	if antiAFK then
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

-- ANTI KICK (CLIENT)
local antiKick=true
local mt=getrawmetatable(game)
setreadonly(mt,false)
local oldNamecall=mt.__namecall
mt.__namecall=newcclosure(function(self,...)
	local m=getnamecallmethod()
	if antiKick and m=="Kick" then
		return
	end
	return oldNamecall(self,...)
end)
setreadonly(mt,true)

--------------------------------------------------
-- ESP PLAYER
--------------------------------------------------
local esp=false
local espCons={}

local function clearESP()
	for _,v in pairs(espCons) do pcall(function() v:Destroy() end) end
	espCons={}
end

local function addESP(plr)
	if plr==player then return end
	local box=Instance.new("BoxHandleAdornment")
	box.Adornee=nil
	box.AlwaysOnTop=true
	box.Size=Vector3.new(4,6,1)
	box.Color3=Color3.fromRGB(255,0,0)
	box.Transparency=0.5
	box.ZIndex=10
	box.Parent=gui

	local con
	con=RunService.RenderStepped:Connect(function()
		if not esp or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
			box.Adornee=nil
			return
		end
		box.Adornee=plr.Character.HumanoidRootPart
	end)
	table.insert(espCons,box)
	table.insert(espCons,con)
end

local bESP = makeBtn(cMain,"ESP PLAYER : OFF",240)
bESP.MouseButton1Click:Connect(function()
	esp=not esp
	bESP.Text="ESP PLAYER : "..(esp and "ON" or "OFF")
	clearESP()
	if esp then
		for _,p in ipairs(Players:GetPlayers()) do addESP(p) end
	end
end)

Players.PlayerAdded:Connect(function(p)
	if esp then addESP(p) end
end)

--------------------------------------------------
-- SCRIPT TAB (TỔNG HỢP)
--------------------------------------------------
makeBtn(cScript,"Quantum Onyx",10).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
end)

makeBtn(cScript,"Teddy Hub",60).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
end)

makeBtn(cScript,"Escape Tsunami",110).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots"))()
end)

--------------------------------------------------
-- TOGGLE BUTTON
--------------------------------------------------
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,15,0.5,-30)
toggle.Text = "TREX"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(180,0,0)
toggle.Active=true
toggle.Draggable=true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,12)

toggle.MouseButton1Click:Connect(function()
	main.Visible=not main.Visible
end)
