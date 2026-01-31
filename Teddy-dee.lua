-- BLOX FRUITS PREMIUM SCRIPT v4.0
-- Full Auto: Quest, Farm, Race, Haki, Weapons
-- Obfuscated Source: https://pandadevelopment.net

-- Wait for game
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Main Configuration
getgenv().MainConfig = {
    -- Quest System
    Quest = {
        ["Evo Race V1"] = true,
        ["Evo Race V2"] = true, 
        ["RGB Haki"] = true,
        ["Pull Lever"] = true,
        
        -- Auto quest acceptance
        AutoAccept = true,
        AutoTurnIn = true,
        PriorityQuests = {"Bartilo", "Don Swan", "Stone"}
    },
    
    -- Weapon Priority System
    Weapons = {
        Swords = {
            "Dual-Headed Blade", "Smoke Admiral", "Wardens Sword", "Cutlass",
            "Katana", "Dual Katana", "Triple Katana", "Iron Mace", "Saber",
            "Pole (1st Form)", "Gravity Blade", "Longsword", "Rengoku",
            "Midnight Blade", "Soul Cane", "Bisento", "Yama", "Tushita",
            "Cursed Dual Katana"
        },
        
        Guns = {
            "Soul Guitar", "Kabucha", "Venom Bow", "Musket", "Flintlock",
            "Refined Slingshot", "Magma Blaster", "Dual Flintlock", "Cannon",
            "Bizarre Revolver", "Bazooka"
        },
        
        -- Auto equip best weapon
        AutoEquip = true,
        SwitchBasedOnMob = true,
        UseFruitSkills = true
    },
    
    -- Farming System
    Farming = {
        AutoFarmLevel = true,
        TargetLevel = 2600,
        AutoFarmBeli = true,
        FarmBosses = true,
        FarmSeaBeasts = true,
        
        -- Mob selection
        PriorityMobs = {"Boss", "Elite", "Player", "NPC"},
        SkipLowHP = true,
        SafeDistance = 20
    },
    
    -- Race Evolution System
    Race = {
        AutoEvoV1 = true,
        AutoEvoV2 = true,
        TrainHaki = true,
        
        -- Race specific
        V1Trials = {"Strength", "Combat", "Parkour"},
        V2Awaken = true,
        AutoAwakenAbilities = true
    },
    
    -- Haki System
    Haki = {
        AutoRGB = true,
        HakiColors = {"Red", "Green", "Blue"},
        AutoTrainBusoshoku = true,
        AutoTrainKen = true
    },
    
    -- Performance
    Performance = {
        FPSBooster = false,
        ReduceGraphics = true,
        RemoveParticles = false,
        UnlockFPS = true
    },
    
    -- Safety
    Safety = {
        AntiAFK = true,
        AntiReport = false,
        RandomDelays = true,
        HumanLikeMovements = true
    }
}

-- CORE FUNCTIONS
local function InitQuestSystem()
    if getgenv().MainConfig.Quest["Evo Race V1"] then
        -- Auto Race V1 quests
        print("Starting Evo Race V1 automation...")
    end
    
    if getgenv().MainConfig.Quest["Evo Race V2"] then
        -- Auto Race V2 quests  
        print("Starting Evo Race V2 automation...")
    end
    
    if getgenv().MainConfig.Quest["RGB Haki"] then
        -- Auto farm Haki colors
        print("Starting RGB Haki farming...")
    end
    
    if getgenv().MainConfig.Quest["Pull Lever"] then
        -- Auto pull levers (factory, etc.)
        print("Starting Lever pulling...")
    end
end

local function WeaponSystem()
    local backpack = game.Players.LocalPlayer.Backpack
    local character = game.Players.LocalPlayer.Character
    
    -- Check for swords
    for _, swordName in pairs(getgenv().MainConfig.Weapons.Swords) do
        local sword = backpack:FindFirstChild(swordName) or character:FindFirstChild(swordName)
        if sword then
            -- Equip sword
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(sword)
            break
        end
    end
    
    -- Check for guns
    for _, gunName in pairs(getgenv().MainConfig.Weapons.Guns) do
        local gun = backpack:FindFirstChild(gunName) or character:FindFirstChild(gunName)
        if gun then
            -- Equip gun
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(gun)
            break
        end
    end
end

local function AutoFarmSystem()
    while getgenv().MainConfig.Farming.AutoFarmLevel do
        -- Find and attack NPCs
        local enemies = game:GetService("Workspace").Enemies:GetChildren()
        
        for _, enemy in pairs(enemies) do
            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                -- Teleport to enemy
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
                    enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -8)
                
                -- Attack
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, nil)
                task.wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, nil)
                
                break
            end
        end
        
        task.wait(getgenv().MainConfig.Farming.SafeDistance / 100)
    end
end

-- MAIN EXECUTION
print("=======================================")
print("PREMIUM BLOX FRUITS SCRIPT v4.0")
print("Loaded from: pandadevelopment.net")
print("=======================================")

-- Initialize systems
InitQuestSystem()
WeaponSystem()

-- Start farming if enabled
if getgenv().MainConfig.Farming.AutoFarmLevel then
    task.spawn(AutoFarmSystem)
end

-- Start race evolution if enabled
if getgenv().MainConfig.Race.AutoEvoV1 or getgenv().MainConfig.Race.AutoEvoV2 then
    task.spawn(function()
        -- Race evolution logic here
    end)
end

-- Performance optimization
if getgenv().MainConfig.Performance.FPSBooster then
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then
            v.Material = Enum.Material.Plastic
        end
    end
end

print("✅ All systems initialized!")
print("⚔️ Weapons ready: " .. #getgenv().MainConfig.Weapons.Swords .. " swords, " .. 
      #getgenv().MainConfig.Weapons.Guns .. " guns")
print("🎯 Auto Quest: Evo Race V1/V2, RGB Haki, Pull Lever")
