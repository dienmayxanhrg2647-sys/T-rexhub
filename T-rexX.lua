--==================================================
-- T-REX X | SINGLE TAB: BLOXFRUIT
--==================================================

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TrexXGui"
gui.Parent = plr:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,320,0,220)
main.Position = UDim2.new(0.5,-160,0.5,-110)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,8)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(170,0,0)
mainStroke.Thickness = 2

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,36)
title.BackgroundTransparency = 1
title.Text = "🦖 T-rex X"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,80,80)

-- CLOSE
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-34,0,3)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(170,0,0)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)
close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

-- TAB BAR (CHỈ 1 TAB)
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0,10,0,44)
tabBar.Size = UDim2.new(0,90,0,166)
tabBar.BackgroundTransparency = 1

local tabBlox = Instance.new("TextButton", tabBar)
tabBlox.Size = UDim2.new(1,0,0,36)
tabBlox.Position = UDim2.new(0,0,0,0)
tabBlox.Text = "Bloxfruit"
tabBlox.Font = Enum.Font.GothamBold
tabBlox.TextSize = 14
tabBlox.TextColor3 = Color3.new(1,1,1)
tabBlox.BackgroundColor3 = Color3.fromRGB(35,35,35)
tabBlox.BorderSizePixel = 0
Instance.new("UICorner", tabBlox).CornerRadius = UDim.new(0,6)

-- PAGE
local page = Instance.new("Frame", main)
page.Position = UDim2.new(0,110,0,44)
page.Size = UDim2.new(1,-120,1,-54)
page.BackgroundTransparency = 1

-- BUTTON MAKER
local function makeRunButton(text, y, callback)
	local b = Instance.new("TextButton", page)
	b.Size = UDim2.new(1,0,0,40)
	b.Position = UDim2.new(0,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	b.MouseButton1Click:Connect(callback)
	return b
end

-- BLOX FRUITS SCRIPTS
makeRunButton("Quantum Onyx", 0, function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"
	))()
end)

makeRunButton("Teddy Hub", 46, function()
	repeat task.wait() until game:IsLoaded() and Players.LocalPlayer
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"
	))()
end)

-- AVATAR TOGGLE (VUÔNG)
local toggle = Instance.new("ImageButton", gui)
toggle.Size = UDim2.new(0,50,0,50)
toggle.Position = UDim2.new(0,10,0.5,-25)
toggle.BackgroundColor3 = Color3.fromRGB(25,25,25)
toggle.BorderSizePixel = 0
toggle.Active = true
toggle.Draggable = true
toggle.AutoButtonColor = false
toggle.Image = "rbxassetid://94024280501791"
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,6)
local tStroke = Instance.new("UIStroke", toggle)
tStroke.Color = Color3.fromRGB(170,0,0)
tStroke.Thickness = 2

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
