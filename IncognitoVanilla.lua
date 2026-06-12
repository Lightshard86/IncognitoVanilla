local enabled = true

IncognitoVanillaDB = IncognitoVanillaDB or {}

if not IncognitoVanillaDB.mainName then
    IncognitoVanillaDB.mainName = "YourMainName"
end

local function GetMainName()
    return IncognitoVanillaDB.mainName
end

local original_SendChatMessage = SendChatMessage

function SendChatMessage(msg, chatType, language, channel)

    if enabled and msg and msg ~= "" then

        
        if not string.find(msg, "^%.z")
        and not string.find(msg, "^%.legacy")
        and not string.find(msg, "^%.set")
        and not string.find(msg, "^%.settings")
        and not string.find(msg, "^%.stats")
        and not string.find(msg, "^/script")
        and not string.find(msg, "^/run")
        and not string.find(msg, "^/cast")
        and not string.find(msg, "^cast ")
        and not string.find(msg, "^#showtooltip")
        and not string.find(msg, "^set")
        and not string.find(msg, "^reset")
        and not string.find(msg, "^hello")
        and not string.find(msg, "^joke")
        and not string.find(msg, "^cancel")
        and not string.find(msg, "^list")
        and not string.find(msg, "^dispel")
        and not string.find(msg, "^deny ") then

            local prefix = "|cffff0000[|r|cffffcc00" .. GetMainName() .. "|r|cffff0000]|r"

            if not string.find(msg, "^" .. prefix, 1, true) then
                msg = prefix .. " " .. msg
            end
        end
    end

    original_SendChatMessage(msg, chatType, language, channel)
end

SLASH_INCOGNITO1 = "/inc"
SLASH_INCOGNITO2 = "/incognito"

SlashCmdList["INCOGNITO"] = function(msg)

    if not msg or msg == "" then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00IncognitoVanilla commands:|r")
        DEFAULT_CHAT_FRAME:AddMessage("/inc on")
        DEFAULT_CHAT_FRAME:AddMessage("/inc off")
        DEFAULT_CHAT_FRAME:AddMessage("/inc name YourMain")
        DEFAULT_CHAT_FRAME:AddMessage("Current main: " .. GetMainName())
        return
    end

    local _, _, cmd, arg = string.find(msg, "^(%S+)%s*(.-)$")

    cmd = string.lower(cmd or "")

    if cmd == "on" then
        enabled = true
        DEFAULT_CHAT_FRAME:AddMessage("IncognitoVanilla enabled.")

    elseif cmd == "off" then
        enabled = false
        DEFAULT_CHAT_FRAME:AddMessage("IncognitoVanilla disabled.")

    elseif cmd == "name" and arg ~= "" then
        IncognitoVanillaDB.mainName = arg
        DEFAULT_CHAT_FRAME:AddMessage("Main name set to: " .. arg)

    else
        DEFAULT_CHAT_FRAME:AddMessage("Unknown command.")
    end
end