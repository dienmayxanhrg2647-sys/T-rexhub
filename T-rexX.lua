-- ===============================
-- 🦖 T-rex X Hub | Full Menu
-- ===============================

repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- ===============================
-- GUI
-- ===============================
local gui = Instance.new("ScreenGui")
gui.Name = "TRexXHub"
gui.Parent = lp:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- ===============================
-- Toggle Button (Avatar)
-- ===============================
local toggle = Instance.new("ImageButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,20,0.5,-30)
toggle.Image = "rbxassetid://94024280501791" -- avatar ID
toggle.BackgroundColor3 = Color3.fromRGB(255,200,220)
toggle.BorderSizePixel = 0
toggle.AutoButtonColor = true
Instance.new("UICorner",toggle).CornerRadius = UDim.new(0,10)

-- ===============================
-- Main Frame
-- ===============================
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,320,0,260)
main.Position = UDim2.new(0.5,-160,0.5,-130)
main.BackgroundColor3 = Color3.fromRGB(255,235,245)
main.Visible = false
main.BorderSizePixel = 0
Instance.new("UICorner",main).CornerRadius = UDim.new(0,12)

-- Drag
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = main.Position
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
UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Toggle menu
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- ===============================
-- Title
-- ===============================
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.Text = "🦖 T-rex X Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(80,40,60)
title.BackgroundTransparency = 1

-- ===============================
-- Tabs
-- ===============================
local tabs = Instance.new("Frame", main)
tabs.Position = UDim2.new(0,10,0,50)
tabs.Size = UDim2.new(0,90,0,200)
tabs.BackgroundTransparency = 1

local pages = Instance.new("Frame", main)
pages.Position = UDim2.new(0,110,0,50)
pages.Size = UDim2.new(0,200,0,200)
pages.BackgroundTransparency = 1

local function newPage()
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1,0,1,0)
	f.Visible = false
	f.BackgroundTransparency = 1
	f.Parent = pages
	return f
end

local function tabBtn(text, y, page)
	local b = Instance.new("TextButton", tabs)
	b.Size = UDim2.new(1,0,0,40)
	b.Position = UDim2.new(0,0,0,y)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.BackgroundColor3 = Color3.fromRGB(255,200,220)
	b.BorderSizePixel = 0
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(pages:GetChildren()) do
			v.Visible = false
		end
		page.Visible = true
	end)
end

-- ===============================
-- Pages
-- ===============================
local home = newPage()
home.Visible = true

local bloxfruit = newPage()

tabBtn("Home", 0, home)
tabBtn("BloxFruit", 45, bloxfruit)

-- ===============================
-- Home content
-- ===============================
local htxt = Instance.new("TextLabel", home)
htxt.Size = UDim2.new(1,0,1,0)
htxt.TextWrapped = true
htxt.Text = "Welcome to T-rex X Hub 🦖\nMenu kéo được, bật tắt bằng avatar."
htxt.Font = Enum.Font.Gotham
htxt.TextSize = 14
htxt.BackgroundTransparency = 1
htxt.TextColor3 = Color3.fromRGB(60,60,60)

-- ===============================
-- BloxFruit Buttons
-- ===============================
local function bfButton(text, y, callback)
	local b = Instance.new("TextButton", bloxfruit)
	b.Size = UDim2.new(1,0,0,40)
	b.Position = UDim2.new(0,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.BackgroundColor3 = Color3.fromRGB(200,220,255)
	b.BorderSizePixel = 0
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	b.MouseButton1Click:Connect(callback)
end

bfButton("Quantum Onyx", 0, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
end)

bfButton("Teddy Hub", 50, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TeddyHub.lua"))()
end)

bfButton("CatHub", 100, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Rizeniii/dex/refs/heads/main/CatHub"))()
end)

bfButton("BF Beta", 150, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))()
end)
