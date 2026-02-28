-- =============================================
--   JJS Script Hub | Jujutsu Shenanigans
--   Executor: Delta / Arceus X
--   Server riêng | Không dùng public server
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- =============================================
-- CONFIG
-- =============================================
local Config = {
    ESPEnabled = false,
    AimEnabled = false,
    AimKey = Enum.KeyCode.Q,
    AimFOV = 200,
    InfiniteStamina = false,
    AutoBlock = false,
    SpeedEnabled = false,
    SpeedValue = 32,
    NoKB = false,
    GodMode = false,
}

-- =============================================
-- GUI SETUP
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JJSHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Chống bị xóa
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game.CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = game.CoreGui
end

-- =============================================
-- MAIN FRAME
-- =============================================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 420, 0, 480)
Main.Position = UDim2.new(0.5, -210, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

-- Viền gradient
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 1
Stroke.Color = Color3.fromRGB(80, 60, 180)
Stroke.Transparency = 0.4

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.new(0, -20, 0, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49,49,450,450)
Shadow.ZIndex = -1
Shadow.Parent = Main

-- =============================================
-- TOPBAR
-- =============================================
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 44)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 14, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

-- Fix corner bottom of topbar
local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 14)
TopBarFix.Position = UDim2.new(0, 0, 1, -14)
TopBarFix.BackgroundColor3 = Color3.fromRGB(18, 14, 30)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -110, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡  JJS Hub"
TitleLabel.TextColor3 = Color3.fromRGB(230, 220, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local SubLabel = Instance.new("TextLabel")
SubLabel.Size = UDim2.new(0, 200, 1, 0)
SubLabel.Position = UDim2.new(0, 120, 0, 0)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Jujutsu Shenanigans"
SubLabel.TextColor3 = Color3.fromRGB(120, 100, 180)
SubLabel.TextSize = 11
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.Parent = TopBar

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.fromRGB(200,200,200)
MinBtn.TextSize = 13
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TopBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)

local minimized = false
local ContentFrame -- sẽ define bên dưới

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Main:TweenSize(UDim2.new(0, 420, 0, 44), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
    else
        Main:TweenSize(UDim2.new(0, 420, 0, 480), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
    end
end)

-- Drag
local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- =============================================
-- TAB BAR
-- =============================================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 36)
TabBar.Position = UDim2.new(0, 0, 0, 44)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
TabBar.BorderSizePixel = 0
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.Padding = UDim.new(0, 2)

local UIPadding = Instance.new("UIPadding", TabBar)
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 6)

local tabs = {"Combat", "Visual", "Utility", "Player"}
local tabBtns = {}
local tabFrames = {}
local activeTab = nil

-- =============================================
-- CONTENT AREA
-- =============================================
ContentFrame = Instance.new("Frame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = Main

-- =============================================
-- HELPER: Tạo Tab
-- =============================================
local function createTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(30, 22, 50)
    btn.BackgroundTransparency = 1
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(120, 110, 150)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 3
    frame.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = false
    frame.Parent = ContentFrame

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local pad = Instance.new("UIPadding", frame)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 10)

    tabBtns[name] = btn
    tabFrames[name] = frame

    btn.MouseButton1Click:Connect(function()
        for n, b in pairs(tabBtns) do
            b.BackgroundTransparency = 1
            b.TextColor3 = Color3.fromRGB(120, 110, 150)
        end
        for n, f in pairs(tabFrames) do
            f.Visible = false
        end
        btn.BackgroundTransparency = 0
        btn.TextColor3 = Color3.fromRGB(220, 210, 255)
        frame.Visible = true
        activeTab = name
    end)

    return frame
end

-- =============================================
-- HELPER: Toggle Switch
-- =============================================
local function createToggle(parent, labelText, configKey, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 44)
    row.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
    row.BorderSizePixel = 0
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(210, 200, 240)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 40, 0, 22)
    toggleBg.Position = UDim2.new(1, -52, 0.5, -11)
    toggleBg.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = row
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 16, 0, 16)
    toggleDot.Position = UDim2.new(0, 3, 0.5, -8)
    toggleDot.BackgroundColor3 = Color3.fromRGB(140, 130, 170)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBg
    Instance.new("UICorner", toggleDot).CornerRadius = UDim.new(1, 0)

    local state = Config[configKey] or false

    local function updateVisual()
        local goal = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local colorBg = state and Color3.fromRGB(90, 60, 200) or Color3.fromRGB(40, 35, 60)
        local colorDot = state and Color3.fromRGB(220, 210, 255) or Color3.fromRGB(140, 130, 170)
        TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = goal, BackgroundColor3 = colorDot}):Play()
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = colorBg}):Play()
    end

    updateVisual()

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = row

    btn.MouseButton1Click:Connect(function()
        state = not state
        Config[configKey] = state
        updateVisual()
        if callback then callback(state) end
    end)

    return row
end

-- =============================================
-- HELPER: Slider
-- =============================================
local function createSlider(parent, labelText, configKey, min, max, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 56)
    row.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
    row.BorderSizePixel = 0
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local labelRow = Instance.new("Frame")
    labelRow.Size = UDim2.new(1, 0, 0, 26)
    labelRow.Position = UDim2.new(0, 0, 0, 0)
    labelRow.BackgroundTransparency = 1
    labelRow.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(210, 200, 240)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = labelRow

    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0.3, -14, 1, 0)
    valLabel.Position = UDim2.new(0.7, 0, 0, 0)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = tostring(Config[configKey] or min)
    valLabel.TextColor3 = Color3.fromRGB(140, 120, 220)
    valLabel.TextSize = 12
    valLabel.Font = Enum.Font.GothamBold
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.Parent = labelRow

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -28, 0, 6)
    track.Position = UDim2.new(0, 14, 0, 36)
    track.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    track.BorderSizePixel = 0
    track.Parent = row
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((Config[configKey] or min - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 70, 210)
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(fill.Size.X.Scale, -7, 0.5, -7)
    dot.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
    dot.BorderSizePixel = 0
    dot.Parent = track
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local sliding = false
    local function updateSlider(x)
        local rel = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * rel)
        Config[configKey] = val
        valLabel.Text = tostring(val)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        dot.Position = UDim2.new(rel, -7, 0.5, -7)
        if callback then callback(val) end
    end

    track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            updateSlider(inp.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if sliding and inp.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(inp.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
        end
    end)

    return row
end

-- =============================================
-- HELPER: Button
-- =============================================
local function createButton(parent, labelText, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = color or Color3.fromRGB(80, 55, 180)
    btn.Text = labelText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(
            math.min(color.R * 255 + 20, 255),
            math.min(color.G * 255 + 15, 255),
            math.min(color.B * 255 + 20, 255)
        )}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color}):Play()
    end)

    return btn
end

-- =============================================
-- SECTION LABEL
-- =============================================
local function createSection(parent, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = "── " .. text
    lbl.TextColor3 = Color3.fromRGB(100, 85, 160)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
end

-- =============================================
-- BUILD TABS
-- =============================================
local combatFrame = createTab("Combat", "⚔️")
local visualFrame = createTab("Visual", "👁️")
local utilFrame   = createTab("Utility", "🔧")
local playerFrame = createTab("Player", "👤")

-- =============================================
-- TAB: COMBAT
-- =============================================
createSection(combatFrame, "Aim Assist")

createToggle(combatFrame, "🎯  Aim Assist (Phím Q)", "AimEnabled", function(v)
    Config.AimEnabled = v
end)

createSlider(combatFrame, "📐  FOV Aim Assist", "AimFOV", 50, 500, function(v)
    Config.AimFOV = v
end)

createSection(combatFrame, "Combat")

createToggle(combatFrame, "🛡️  Auto Block", "AutoBlock", function(v)
    Config.AutoBlock = v
end)

createToggle(combatFrame, "💨  No Knockback", "NoKB", function(v)
    Config.NoKB = v
end)

createButton(combatFrame, "☠️  Kill Aura (tất cả enemy gần)", Color3.fromRGB(160, 40, 40), function()
    local char = LocalPlayer.Character
    if not char then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = 0 end
        end
    end
end)

-- =============================================
-- TAB: VISUAL (ESP)
-- =============================================
createSection(visualFrame, "ESP Player")

local espConnections = {}

createToggle(visualFrame, "🔵  Player ESP (Box)", "ESPEnabled", function(v)
    Config.ESPEnabled = v
    -- Xóa cũ
    for _, c in pairs(espConnections) do c:Disconnect() end
    espConnections = {}

    if not v then
        -- Xóa hết highlight
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("ESP_Highlight")
                if h then h:Destroy() end
            end
        end
        return
    end

    local function addESP(p)
        if p == LocalPlayer then return end
        local function doHighlight()
            if p.Character then
                local existing = p.Character:FindFirstChild("ESP_Highlight")
                if existing then existing:Destroy() end
                local hl = Instance.new("SelectionBox")
                hl.Name = "ESP_Highlight"
                hl.Adornee = p.Character
                hl.Color3 = Color3.fromRGB(100, 80, 255)
                hl.LineThickness = 0.03
                hl.SurfaceTransparency = 0.85
                hl.SurfaceColor3 = Color3.fromRGB(80, 60, 200)
                hl.Parent = p.Character
            end
        end
        doHighlight()
        local c = p.CharacterAdded:Connect(function() task.wait(1) doHighlight() end)
        table.insert(espConnections, c)
    end

    for _, p in pairs(Players:GetPlayers()) do addESP(p) end
    local c2 = Players.PlayerAdded:Connect(addESP)
    table.insert(espConnections, c2)
end)

createToggle(visualFrame, "🏷️  Hiện tên + máu trên đầu", "ESPEnabled", function(v)
    -- BillboardGui name tag
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            if head then
                local existing = head:FindFirstChild("ESP_Tag")
                if existing then existing:Destroy() end
                if v then
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "ESP_Tag"
                    bb.Size = UDim2.new(0, 120, 0, 30)
                    bb.StudsOffset = Vector3.new(0, 2.5, 0)
                    bb.AlwaysOnTop = true
                    bb.Parent = head
                    local lbl = Instance.new("TextLabel", bb)
                    lbl.Size = UDim2.new(1,0,1,0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Color3.fromRGB(220, 200, 255)
                    lbl.TextSize = 13
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Text = p.Name
                end
            end
        end
    end
end)

createButton(visualFrame, "🔦  Full Bright (sáng map)", Color3.fromRGB(60, 80, 160), function()
    game.Lighting.Brightness = 5
    game.Lighting.ClockTime = 14
    game.Lighting.FogEnd = 100000
    game.Lighting.GlobalShadows = false
    game.Lighting.Ambient = Color3.fromRGB(180, 180, 180)
end)

-- =============================================
-- TAB: UTILITY
-- =============================================
createSection(utilFrame, "Movement")

createToggle(utilFrame, "🏃  Speed Hack", "SpeedEnabled", function(v)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = v and Config.SpeedValue or 16
        end
    end
end)

createSlider(utilFrame, "💨  Tốc độ chạy", "SpeedValue", 16, 150, function(v)
    if Config.SpeedEnabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end
end)

createButton(utilFrame, "🦘  Super Jump (JumpPower x3)", Color3.fromRGB(60, 100, 60), function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = 120
        end
    end
end)

createButton(utilFrame, "🔄  Reset nhân vật", Color3.fromRGB(80, 50, 50), function()
    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
end)

createSection(utilFrame, "Teleport")

createButton(utilFrame, "🏠  Teleport về Spawn", Color3.fromRGB(50, 70, 120), function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation")
        if spawn then
            char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

-- =============================================
-- TAB: PLAYER
-- =============================================
createSection(playerFrame, "Nhân vật")

createToggle(playerFrame, "♾️  Infinite Stamina", "InfiniteStamina", function(v)
    Config.InfiniteStamina = v
end)

createToggle(playerFrame, "💀  God Mode (Max HP)", "GodMode", function(v)
    Config.GodMode = v
end)

createButton(playerFrame, "❤️  Full Heal ngay", Color3.fromRGB(60, 130, 60), function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = hum.MaxHealth end
    end
end)

createButton(playerFrame, "🌀  Noclip (xuyên tường)", Color3.fromRGB(80, 60, 140), function()
    local noclipOn = false
    noclipOn = not noclipOn
    RunService.Stepped:Connect(function()
        if noclipOn and LocalPlayer.Character then
            for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = false
                end
            end
        end
    end)
end)

-- =============================================
-- DEFAULT TAB
-- =============================================
tabBtns["Combat"].BackgroundTransparency = 0
tabBtns["Combat"].TextColor3 = Color3.fromRGB(220, 210, 255)
tabFrames["Combat"].Visible = true
activeTab = "Combat"

-- =============================================
-- RUNTIME LOOPS
-- =============================================
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")

    -- God Mode
    if Config.GodMode and hum and hum.Health < hum.MaxHealth then
        hum.Health = hum.MaxHealth
    end

    -- Infinite Stamina (giả lập bằng jump power ổn định)
    if Config.InfiniteStamina and hum then
        hum.JumpPower = 50
    end

    -- Speed sync
    if Config.SpeedEnabled and hum then
        hum.WalkSpeed = Config.SpeedValue
    end

    -- No KB
    if Config.NoKB and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Velocity = Vector3.new(0, char.HumanoidRootPart.Velocity.Y, 0)
    end
end)

-- Aim Assist
RunService.RenderStepped:Connect(function()
    if not Config.AimEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end

    local closest, closestDist = nil, Config.AimFOV
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if head and hum and hum.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = head
                    end
                end
            end
        end
    end

    if closest and UserInputService:IsKeyDown(Config.AimKey) then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
    end
end)

-- =============================================
print("✅ JJS Hub đã load xong!")
print("📌 Dùng cho server riêng - Jujutsu Shenanigans")
