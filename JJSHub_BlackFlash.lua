local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "JJSHub",
    Icon = "shield",
    Author = "by JJSHub",
    Folder = "JJSHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("User clicked!")
        end,
    },
})

-- ================================================
-- SERVICES
-- ================================================
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService  = game:GetService("TweenService")
local Camera        = workspace.CurrentCamera
local LocalPlayer   = Players.LocalPlayer

-- ================================================
-- ESP CONFIG
-- ================================================
local ESP = {
    Box      = false,
    Skeleton = false,
    Name     = false,
    Health   = false,
    Distance = false,
    Tracer   = false,
    BoxColor    = Color3.fromRGB(255, 50, 50),
    TracerColor = Color3.fromRGB(255, 50, 50),
    SkelColor   = Color3.fromRGB(255, 255, 255),
    MaxDist     = 500,
}

local ESPData = {}

-- ================================================
-- AUTO BLACK FLASH CONFIG
-- ================================================
local ABF = {
    Enabled    = false,
    FlySpeed   = 80,        -- toc do bay den muc tieu
    AttackRange = 5,        -- khoang cach bat dau danh
    Cooldown   = 1.2,       -- thoi gian giua moi lan Black Flash
    Target     = nil,       -- player dang nham
    LastHit    = 0,
    Flying     = false,
    Status     = "OFF",
}

-- ================================================
-- DRAWING HELPERS
-- ================================================
local function Line(color, thick)
    local l = Drawing.new("Line")
    l.Visible = false
    l.Color = color or Color3.new(1, 0, 0)
    l.Thickness = thick or 1.5
    l.Transparency = 1
    return l
end

local function Txt(size, color)
    local t = Drawing.new("Text")
    t.Visible = false
    t.Size = size or 13
    t.Color = color or Color3.new(1, 1, 1)
    t.Center = true
    t.Outline = true
    t.OutlineColor = Color3.new(0, 0, 0)
    t.Font = Drawing.Fonts.Plex
    return t
end

-- ================================================
-- ESP PER PLAYER
-- ================================================
local function makeESP(p)
    if p == LocalPlayer or ESPData[p] then return end
    local d = {}
    d.box = {}
    for i = 1, 4 do d.box[i] = Line(ESP.BoxColor, 1.5) end
    d.corner = {}
    for i = 1, 8 do d.corner[i] = Line(ESP.BoxColor, 2.5) end
    d.skel = {}
    for i = 1, 10 do d.skel[i] = Line(ESP.SkelColor, 1) end
    d.name   = Txt(13, Color3.new(1, 1, 1))
    d.hpBG   = Line(Color3.new(0, 0, 0), 4)
    d.hpFill = Line(Color3.new(0, 1, 0), 3)
    d.dist   = Txt(11, Color3.fromRGB(255, 200, 0))
    d.tracer = Line(ESP.TracerColor, 1)
    d.tracer.Transparency = 0.7
    ESPData[p] = d
end

local function clearESP(p)
    local d = ESPData[p]
    if not d then return end
    for _, l in pairs(d.box)    do l:Remove() end
    for _, l in pairs(d.corner) do l:Remove() end
    for _, l in pairs(d.skel)   do l:Remove() end
    d.name:Remove(); d.hpBG:Remove(); d.hpFill:Remove()
    d.dist:Remove(); d.tracer:Remove()
    ESPData[p] = nil
end

local function hideESP(d)
    for _, l in pairs(d.box)    do l.Visible = false end
    for _, l in pairs(d.corner) do l.Visible = false end
    for _, l in pairs(d.skel)   do l.Visible = false end
    d.name.Visible = false; d.hpBG.Visible = false; d.hpFill.Visible = false
    d.dist.Visible = false; d.tracer.Visible = false
end

-- ================================================
-- SCREEN HELPERS
-- ================================================
local function w2s(pos)
    local p, vis = Camera:WorldToViewportPoint(pos)
    return Vector2.new(p.X, p.Y), vis
end

local function getBB(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local p = hrp.Position
    local H, W = 5.2, 2.2
    local top, vis1 = w2s(p + Vector3.new(0, H / 2, 0))
    local bot, vis2 = w2s(p - Vector3.new(0, H / 2, 0))
    if not vis1 and not vis2 then return nil end
    local h = math.abs(top.Y - bot.Y)
    local w = h * (W / H)
    return {
        TL = Vector2.new(top.X - w / 2, top.Y),
        TR = Vector2.new(top.X + w / 2, top.Y),
        BL = Vector2.new(top.X - w / 2, bot.Y),
        BR = Vector2.new(top.X + w / 2, bot.Y),
        CT = Vector2.new(top.X, top.Y),
        CB = Vector2.new(top.X, bot.Y),
        W = w, H = h,
    }
end

local function bone(char, name)
    local part = char:FindFirstChild(name)
    if part then
        local s, v = w2s(part.Position)
        if v then return s end
    end
end

-- ================================================
-- AUTO BLACK FLASH HELPERS
-- ================================================

-- Tim player gan nhat con song
local function getNearestTarget()
    local myChar = LocalPlayer.Character
    local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end

    local nearest, nearDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.Health > 0 then
            local d = (myHRP.Position - hrp.Position).Magnitude
            if d < nearDist then
                nearDist = d
                nearest  = p
            end
        end
    end
    return nearest
end

-- Simulate phim bam (dung cho executor co ho tro)
local function pressKey(key)
    local input = Instance.new("InputObject")
    input.KeyCode = key
    input.UserInputType = Enum.UserInputType.Keyboard
    input.UserInputState = Enum.UserInputState.Begin
    game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
    task.wait(0.05)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
end

-- Simulate click chuot trai (M1)
local function clickM1()
    mouse1press()
    task.wait(0.06)
    mouse1release()
end

-- Effect sang len khi Black Flash (BillboardGui tren dau)
local function blackFlashEffect(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Hieu ung sang tren man hinh
    local flash = Instance.new("ScreenGui")
    flash.ResetOnSpawn = false
    flash.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    if syn and syn.protect_gui then syn.protect_gui(flash) end
    flash.Parent = gethui and gethui() or game.CoreGui

    local frame = Instance.new("Frame", flash)
    frame.Size = UDim2.fromScale(1, 1)
    frame.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0

    -- Billboard "BLACK FLASH" tren dau muc tieu
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.fromOffset(160, 40)
    bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true
    bb.Adornee = hrp
    bb.Parent = hrp

    local lbl = Instance.new("TextLabel", bb)
    lbl.Size = UDim2.fromScale(1, 1)
    lbl.BackgroundTransparency = 1
    lbl.Text = "BLACK FLASH"
    lbl.TextColor3 = Color3.fromRGB(180, 0, 255)
    lbl.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0
    lbl.TextSize = 20
    lbl.Font = Enum.Font.GothamBold

    -- Fade out nhanh
    task.delay(0.3, function()
        for i = 1, 10 do
            frame.BackgroundTransparency = 0.2 + i * 0.08
            lbl.TextTransparency = i * 0.1
            task.wait(0.03)
        end
        flash:Destroy()
        bb:Destroy()
    end)
end

-- ================================================
-- AUTO BLACK FLASH LOOP
-- ================================================
local abfConnection = nil

local function startABF()
    if abfConnection then abfConnection:Disconnect() end

    abfConnection = RunService.Heartbeat:Connect(function()
        if not ABF.Enabled then
            ABF.Status = "OFF"
            ABF.Flying = false
            return
        end

        local myChar = LocalPlayer.Character
        local myHRP  = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if not myHRP or not myHum or myHum.Health <= 0 then
            ABF.Status = "Waiting for character..."
            return
        end

        -- Tim muc tieu
        local target = getNearestTarget()
        if not target then
            ABF.Status = "No target found"
            ABF.Flying = false
            return
        end

        ABF.Target = target
        local targetChar = target.Character
        local targetHRP  = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        local targetHum  = targetChar and targetChar:FindFirstChildOfClass("Humanoid")

        if not targetHRP or not targetHum or targetHum.Health <= 0 then
            ABF.Status = "Target dead, finding new..."
            ABF.Target = nil
            return
        end

        local dist = (myHRP.Position - targetHRP.Position).Magnitude

        -- BAY DEN MUC TIEU (glide smooth)
        if dist > ABF.AttackRange then
            ABF.Flying = true
            ABF.Status = "Flying to target: " .. target.Name

            -- Tinh huong bay
            local direction = (targetHRP.Position - myHRP.Position).Unit
            local flyPos    = targetHRP.Position - direction * (ABF.AttackRange - 1)

            -- Di chuyen nhe nhang (khong teleport)
            myHRP.CFrame = myHRP.CFrame:Lerp(
                CFrame.new(flyPos, targetHRP.Position),
                math.min(ABF.FlySpeed * 0.01, 0.3)
            )

            -- Huong nhin ve phia muc tieu
            myHRP.CFrame = CFrame.new(myHRP.Position, Vector3.new(
                targetHRP.Position.X,
                myHRP.Position.Y,
                targetHRP.Position.Z
            ))

        else
            -- DA DEN NOI -> THUC HIEN BLACK FLASH
            ABF.Flying = false
            local now = tick()

            if now - ABF.LastHit >= ABF.Cooldown then
                ABF.LastHit = now
                ABF.Status  = "BLACK FLASH on " .. target.Name .. "!"

                task.spawn(function()
                    -- Buoc 1: Xoay lung ve phia muc tieu (de chain BF)
                    myHRP.CFrame = CFrame.new(myHRP.Position, targetHRP.Position)
                        * CFrame.Angles(0, math.pi, 0)

                    task.wait(0.05)

                    -- Buoc 2: Nhan M1 x3 combo
                    for _ = 1, 3 do
                        clickM1()
                        task.wait(0.12)
                    end

                    -- Buoc 3: Nhan phim 3 (Divergent Fist) -> Black Flash
                    pressKey(Enum.KeyCode.E)  -- skill Black Flash trong JJS
                    task.wait(0.08)
                    pressKey(Enum.KeyCode.E)  -- nhan lan 2 de kich hoat BF

                    -- Buoc 4: Hieu ung
                    blackFlashEffect(targetChar)

                    task.wait(0.1)
                    -- Buoc 5: Dash ra sau
                    myHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, 4)
                end)
            else
                local remaining = ABF.Cooldown - (now - ABF.LastHit)
                ABF.Status = "Cooldown: " .. string.format("%.1f", remaining) .. "s"
            end
        end
    end)
end

startABF()

-- ================================================
-- STATUS HUD (Drawing)
-- ================================================
local statusTxt = Drawing.new("Text")
statusTxt.Visible = true
statusTxt.Size = 14
statusTxt.Color = Color3.fromRGB(180, 100, 255)
statusTxt.Outline = true
statusTxt.OutlineColor = Color3.new(0, 0, 0)
statusTxt.Font = Drawing.Fonts.Plex
statusTxt.Position = Vector2.new(10, 200)

RunService.RenderStepped:Connect(function()
    if ABF.Enabled then
        statusTxt.Visible = true
        statusTxt.Text = "[JJSHub] Black Flash: " .. ABF.Status
        statusTxt.Color = ABF.Flying
            and Color3.fromRGB(100, 200, 255)
            or  Color3.fromRGB(180, 100, 255)
    else
        statusTxt.Visible = false
    end
end)

-- ================================================
-- RENDER LOOP (ESP)
-- ================================================
RunService.RenderStepped:Connect(function()
    local anyOn = ESP.Box or ESP.Skeleton or ESP.Name or ESP.Health or ESP.Distance or ESP.Tracer
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local vp = Camera.ViewportSize

    for p, d in pairs(ESPData) do
        if not p or not p.Parent then clearESP(p); continue end
        local char = p.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")

        if not char or not hum or not hrp or hum.Health <= 0 or not anyOn then
            hideESP(d); continue
        end

        local dist = myHRP and (myHRP.Position - hrp.Position).Magnitude or 0
        if dist > ESP.MaxDist then hideESP(d); continue end

        local bb = getBB(char)
        if not bb then hideESP(d); continue end

        if ESP.Box then
            local pts = {bb.TL, bb.TR, bb.BR, bb.BL}
            for i = 1, 4 do
                d.box[i].From = pts[i]; d.box[i].To = pts[i%4+1]
                d.box[i].Color = ESP.BoxColor; d.box[i].Visible = true
            end
            local cl, ch = bb.W*0.22, bb.H*0.18
            local co = d.corner
            co[1].From=bb.TL; co[1].To=bb.TL+Vector2.new(cl,0);  co[1].Color=ESP.BoxColor; co[1].Visible=true
            co[2].From=bb.TL; co[2].To=bb.TL+Vector2.new(0,ch);  co[2].Color=ESP.BoxColor; co[2].Visible=true
            co[3].From=bb.TR; co[3].To=bb.TR-Vector2.new(cl,0);  co[3].Color=ESP.BoxColor; co[3].Visible=true
            co[4].From=bb.TR; co[4].To=bb.TR+Vector2.new(0,ch);  co[4].Color=ESP.BoxColor; co[4].Visible=true
            co[5].From=bb.BL; co[5].To=bb.BL+Vector2.new(cl,0);  co[5].Color=ESP.BoxColor; co[5].Visible=true
            co[6].From=bb.BL; co[6].To=bb.BL-Vector2.new(0,ch);  co[6].Color=ESP.BoxColor; co[6].Visible=true
            co[7].From=bb.BR; co[7].To=bb.BR-Vector2.new(cl,0);  co[7].Color=ESP.BoxColor; co[7].Visible=true
            co[8].From=bb.BR; co[8].To=bb.BR-Vector2.new(0,ch);  co[8].Color=ESP.BoxColor; co[8].Visible=true
        else
            for _, l in pairs(d.box)    do l.Visible = false end
            for _, l in pairs(d.corner) do l.Visible = false end
        end

        if ESP.Skeleton then
            local bones = {
                {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
                {"LowerTorso","LeftUpperLeg"},{"LowerTorso","RightUpperLeg"},
                {"LeftUpperLeg","LeftLowerLeg"},{"RightUpperLeg","RightLowerLeg"},
                {"UpperTorso","LeftUpperArm"},{"UpperTorso","RightUpperArm"},
                {"LeftUpperArm","LeftLowerArm"},{"RightUpperArm","RightLowerArm"},
            }
            for i, b in pairs(bones) do
                local a, b2 = bone(char, b[1]), bone(char, b[2])
                if a and b2 then
                    d.skel[i].From=a; d.skel[i].To=b2
                    d.skel[i].Color=ESP.SkelColor; d.skel[i].Visible=true
                else d.skel[i].Visible=false end
            end
        else for _, l in pairs(d.skel) do l.Visible=false end end

        if ESP.Name then
            d.name.Text=p.Name; d.name.Position=bb.CT-Vector2.new(0,15); d.name.Visible=true
        else d.name.Visible=false end

        if ESP.Health then
            local ratio = math.clamp(hum.Health/math.max(hum.MaxHealth,1),0,1)
            local bx = bb.TL.X-6
            d.hpBG.From=Vector2.new(bx,bb.TL.Y); d.hpBG.To=Vector2.new(bx,bb.BL.Y); d.hpBG.Visible=true
            d.hpFill.From=Vector2.new(bx,bb.BL.Y)
            d.hpFill.To=Vector2.new(bx,bb.BL.Y-bb.H*ratio)
            d.hpFill.Color=Color3.fromRGB((1-ratio)*255,ratio*255,30); d.hpFill.Visible=true
        else d.hpBG.Visible=false; d.hpFill.Visible=false end

        if ESP.Distance then
            d.dist.Text="["..math.floor(dist).."m]"
            d.dist.Position=bb.CB+Vector2.new(0,4); d.dist.Visible=true
        else d.dist.Visible=false end

        if ESP.Tracer then
            d.tracer.From=Vector2.new(vp.X/2,vp.Y)
            d.tracer.To=bb.CB; d.tracer.Color=ESP.TracerColor; d.tracer.Visible=true
        else d.tracer.Visible=false end
    end
end)

-- ================================================
-- PLAYER EVENTS
-- ================================================
for _, p in pairs(Players:GetPlayers()) do makeESP(p) end
Players.PlayerAdded:Connect(makeESP)
Players.PlayerRemoving:Connect(clearESP)

-- ================================================
-- TABS
-- ================================================
local MainTab  = Window:Tab({ Title = "Main",        Icon = "home"   })
local BFTab    = Window:Tab({ Title = "Black Flash",  Icon = "zap"    })
local ESPTab   = Window:Tab({ Title = "ESP",          Icon = "eye"    })

-- ================================================
-- BLACK FLASH TAB
-- ================================================
local BF = BFTab:Section({ Title = "Auto Black Flash - Jujutsu Shenanigans" })

BF:Toggle({
    Title = "Auto Black Flash",
    Description = "Tu dong bay den muc tieu va thuc hien Black Flash",
    Default = false,
    Callback = function(v)
        ABF.Enabled = v
        ABF.Status  = v and "Searching target..." or "OFF"
    end
})

BF:Slider({
    Title = "Fly Speed",
    Description = "Toc do bay den muc tieu",
    Default = 80, Min = 20, Max = 200, Rounding = 0,
    Callback = function(v) ABF.FlySpeed = v end
})

BF:Slider({
    Title = "Attack Range",
    Description = "Khoang cach bat dau danh",
    Default = 5, Min = 2, Max = 15, Rounding = 0,
    Callback = function(v) ABF.AttackRange = v end
})

BF:Slider({
    Title = "Cooldown (s)",
    Description = "Thoi gian giua moi lan Black Flash",
    Default = 12, Min = 5, Max = 30, Rounding = 0,
    Callback = function(v) ABF.Cooldown = v / 10 end
})

BF:Label({ Title = "Note: Dung cho Vessel (Yuji). Phim E = Black Flash skill" })

-- ================================================
-- ESP TAB
-- ================================================
local S = ESPTab:Section({ Title = "Player ESP - Free Fire Style" })

S:Toggle({ Title = "Box ESP", Default = false,
    Callback = function(v) ESP.Box = v end })

S:Toggle({ Title = "Skeleton ESP", Default = false,
    Callback = function(v) ESP.Skeleton = v end })

S:Toggle({ Title = "Name ESP", Default = false,
    Callback = function(v) ESP.Name = v end })

S:Toggle({ Title = "Health Bar", Default = false,
    Callback = function(v) ESP.Health = v end })

S:Toggle({ Title = "Distance", Default = false,
    Callback = function(v) ESP.Distance = v end })

S:Toggle({ Title = "Tracer Line", Default = false,
    Callback = function(v) ESP.Tracer = v end })

S:Slider({ Title = "Max Distance (m)", Default = 500, Min = 50, Max = 1000, Rounding = 0,
    Callback = function(v) ESP.MaxDist = v end })

S:ColorPicker({ Title = "Box Color", Default = Color3.fromRGB(255, 50, 50),
    Callback = function(v)
        ESP.BoxColor = v
        for _, d in pairs(ESPData) do
            for _, l in pairs(d.box)    do l.Color = v end
            for _, l in pairs(d.corner) do l.Color = v end
        end
    end })

S:ColorPicker({ Title = "Tracer Color", Default = Color3.fromRGB(255, 50, 50),
    Callback = function(v)
        ESP.TracerColor = v
        for _, d in pairs(ESPData) do d.tracer.Color = v end
    end })

-- ================================================
-- MAIN TAB
-- ================================================
local M = MainTab:Section({ Title = "Features" })

M:Toggle({ Title = "Speed Hack", Default = false,
    Callback = function(v)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v and 60 or 16 end
    end })

M:Toggle({ Title = "God Mode", Default = false,
    Callback = function(v)
        RunService.Heartbeat:Connect(function()
            if not v then return end
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = hum.MaxHealth end
        end)
    end })

M:Button({ Title = "Full Heal",
    Callback = function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = hum.MaxHealth end
    end })

print("JJSHub loaded! Auto Black Flash ready.")
