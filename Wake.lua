-- [[ WAKE HUB: APEX PROTOCOL ]]
-- [[ LICENSED TO: THAI ]]
-- [[ SECURITY STATUS: MAXIMUM ]]

local _ENV_CORE = {
    ["_STORE"] = "Wake_V3_Cache.dat",
    ["_TOKEN"] = "Kwjij_|fpj", -- Obfuscated: "Free_wake"
    ["_ROOT"] = "https://rise-evo.xyz/apiv3/main.lua"
}

-- [[ CRITICAL ENGINE: STRING RECONSTRUCTION ]]
local function _PARSE_STREAM(_INPUT, _SEED)
    local _OUT = ""
    for i = 1, #_INPUT do
        _OUT = _OUT .. string.char(string.byte(_INPUT, i) + _SEED)
    end
    return _OUT
end

local function _BOOT_SEQUENCE()
    -- Injecting VIP/Premium status into Global Environment
    local _GLOBALS = getgenv()
    _GLOBALS.isPremium = true
    _GLOBALS.IsVip = true
    _GLOBALS.WakeLoaded = true

    -- ACTIVE IDENTITY REPLACEMENT ENGINE
    task.spawn(function()
        while task.wait(0.2) do
            pcall(function()
                for _, obj in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                    -- Clean Text Branding
                    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                        local _TXT = obj.Text
                        if _TXT:find("Rise") or _TXT:find("realrise") then
                            obj.Text = _TXT:gsub("Rise Auth", "Wake Hub")
                                          :gsub("RISE HUB", "WAKE HUB")
                                          :gsub("Rise", "Wake")
                                          :gsub("realrise", "thai")
                        end
                    end
                    -- Eliminate Original Auth Overlays
                    if obj.Name:find("Rise") or obj.Name:find("Auth") then
                        if obj:IsA("Frame") or obj:IsA("CanvasGroup") then
                            obj:Destroy()
                        end
                    end
                end
            end)
        end
    end)

    -- DATA FETCH & SOURCE SURGERY
    local _STATUS, _DATA = pcall(function() return game:HttpGet(_ENV_CORE._ROOT) end)
    if _STATUS then
        local _MODIFIED = _DATA:gsub("Rise Evo", "Wake Hub")
                               :gsub("RISE HUB", "WAKE HUB")
                               :gsub("realrise", "thai")
                               :gsub("isPremium = false", "isPremium = true")
                               :gsub("setclipboard", "--")
        
        local _RUNTIME = loadstring(_MODIFIED)
        if _RUNTIME then task.spawn(_RUNTIME) end
    end
end

-- [[ INTERFACE ARCHITECTURE ]]
local _UI_LIB = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local _WINDOW = _UI_LIB:CreateWindow({
    Title = "Wake Hub | Internal Access",
    Author = "by thai",
    Icon = "rbxassetid://18835624458"
})

local _ACCESS = _WINDOW:Tab({ Title = "Authentication", Icon = "shield-check" })

local _BUFFER = ""
_ACCESS:Input({
    Title = "Security Token",
    Placeholder = "Enter access key...",
    Callback = function(_VAL) _BUFFER = _VAL end
})

_ACCESS:Button({
    Title = "Authenticate System",
    Callback = function()
        if _PARSE_STREAM(_BUFFER, 5) == _ENV_CORE._TOKEN then
            writefile(_ENV_CORE._STORE, _BUFFER)
            _UI_LIB:Notify({Title = "Authorized", Content = "Identity verified. Initializing Apex Protocol..."})
            _WINDOW:Destroy()
            _BOOT_SEQUENCE()
        else
            _UI_LIB:Notify({Title = "Access Denied", Content = "Invalid Security Token provided."})
        end
    end
})

_ACCESS:Button({
    Title = "Retrieve Token",
    Callback = function() 
        setclipboard("Free_wake") 
        _UI_LIB:Notify({Title = "Clipboard", Content = "Token copied to system."})
    end
})

-- [[ PERSISTENCE CHECK ]]
if isfile(_ENV_CORE._STORE) and _PARSE_STREAM(readfile(_ENV_CORE._STORE), 5) == _ENV_CORE._TOKEN then
    _WINDOW:Destroy()
    _BOOT_SEQUENCE()
end
