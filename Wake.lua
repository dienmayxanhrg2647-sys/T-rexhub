-- [[ WAKE HUB: GHOST PROTOCOL ]]
-- [[ KEY PROTECTION: ACTIVE ]]

-- The key "Free_wake" is stored here in a shifted format
local _0xSECRET_HASH = "Kwjij_|fpj" 
local _0xCACHE_FILE = "WakeHub_System_Cache.txt"

-- INTERNAL DECODER & ENCODER
local function _0xPROTECT(_0xSTR, _0xOFFSET)
    local _0xRES = ""
    for i = 1, #_0xSTR do
        _0xRES = _0xRES .. string.char(string.byte(_0xSTR, i) + _0xOFFSET)
    end
    return _0xRES
end

-- ENCRYPTED CORE LOGIC (Shifted by 5)
local _0xCORE = "qxfmmp!\\nsjGv!<!mptetlsjoh(hbnf;IuuqHfu(#iuuqt;00hjuivc/dpn0Gppubhftvt0\\nsjGv0sfmfbtft0mbuftu0epxompbe0nbjo/mub#)))\nqdbmm(gvodujpo()\nmpdbm!gvodujpo!Iomq(p)\nqdbmm(gvodujpo()\njg!p;JtB(#UfyuMbcfm#)!ps!p;JtB(#UfyuCvuupo#)!uifo\njg!p/Ufyu;gjoe(#Sjtf#)!ps!p;JtB(#SJTf#)!uifo\np/Ufyu!<!p/Ufyu;htvc(#Sjtf#-#Xblf#);htvc(#SJTf#-#XBLf#);htvc(#sfbmsjtf#-#uibj#)\nfoe\nfoe\njg!p/Obnf;mpxfs();gjoe(#bvui#)!ps!p;Obnf;mpxfs();gjoe(#sjtf#)!uifo\njg!p;JtB(#Gsbnf#)!ps!p;JtB(#DbowbtHspvq#)!uifo!p;Eftuspz()!foe\nfoe\nfoe)\nfoe\nhbnf;HfuTfswjdf(#DpsfHvj#)/EftdfoebouBeefe;Dpoofdu(Iomq)\ngps!_!v!jo!qbjst(hbnf;IuuqHfu(#iuuqt;00sjtf/fwp/xyz0bqjw40nbjo/mub#)!foe)\njg!t!uifo\nmpdbm!gjobm!<!s;htvc(#Sjtf!Fwp#-#Xblf!Ivc#);htvc(#SJTf!IVC#-#XBLf!IVC#);htvc(#sfbmsjtf#-#uibj#);htvc(#jtQsfnjvn!<!gbmtf#-#jtQsfnjvn!<!usvf#)\nloadstring(final)()\nfoe"

local function _0xEXECUTE()
    local _0xDECODED = ""
    for i = 1, #_0xCORE do
        _0xDECODED = _0xDECODED .. string.char(string.byte(_0xCORE, i) - 5)
    end
    loadstring(_0xDECODED)()
end

-- SECURE UI
local _0xUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local _0xMAIN = _0xUI:CreateWindow({
    Title = "Wake Hub | Security",
    Author = "by thai",
    Icon = "rbxassetid://18835624458"
})

local _0xTAB = _0xMAIN:Tab({ Title = "Access", Icon = "lock" })

_0xTAB:Input({
    Title = "Enter Security Key",
    Placeholder = "Contact owner for key",
    Callback = function(_0xINPUT)
        -- It checks if the entered key, when shifted, matches the hidden hash
        if _0xPROTECT(_0xINPUT, 5) == _0xSECRET_HASH then
            writefile(_0xCACHE_FILE, _0xINPUT)
            _0xMAIN:Destroy()
            _0xEXECUTE()
        end
    end
})

_0xTAB:Button({
    Title = "Copy Key (Free_wake)",
    Callback = function()
        setclipboard("Free_wake")
    end
})

-- AUTO-AUTH
if isfile(_0xCACHE_FILE) then
    local _0xSAVED = readfile(_0xCACHE_FILE)
    if _0xPROTECT(_0xSAVED, 5) == _0xSECRET_HASH then
        _0xMAIN:Destroy()
        _0xEXECUTE()
    end
end
