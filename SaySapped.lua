
--[[
	SaySapped: Says "Sapped!" when you get sapped allowing you to notify nearby players about it.
	Also works for many other CCs.
	Author: Coax  - Nostalrius PvP
	Original idea: Bitbyte of Icecrown
--]]

-- Check if sapped
function SaySapped_FilterDebuffs(spell)
		if string.find(spell, " Sap.") and SaySappedConfig then
			SendChatMessage("Sapped!","SAY")
			DEFAULT_CHAT_FRAME:AddMessage("Sapped!")
		end
end

-- Check if the player is entering the world and create the config file if it is not yet created.
-- if the event is a debuff on you, filter it.
function SaySapped_OnEvent(event)
	if event == "PLAYER_ENTERING_WORLD" then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if not SaySappedConfig then
			SaySappedConfig = true
		end
	elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then
		if string.find(arg1, "You are") then
			SaySapped_FilterDebuffs(arg1)
		end
	end
end

-- Slash Command
SlashCmdList["SAYSAPPED"] = SaySapped_SlashCmdHandler
SLASH_SAYSAPPED1 = "/saysapped"

function SaySapped_SlashCmdHandler(msg)
	if SaySappedConfig then
		SaySappedConfig = false
		DEFAULT_CHAT_FRAME:AddMessage("SaySapped disabled!")
	else
		SaySappedConfig = true
		DEFAULT_CHAT_FRAME:AddMessage("SaySapped enabled!")
	end
end


-- Start registering events and print the loading message.
function SaySapped_OnLoad()
	SaySapped:RegisterEvent("PLAYER_ENTERING_WORLD")
	SaySapped:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
	DEFAULT_CHAT_FRAME:AddMessage("SaySapped loaded, type /saysapped to toggle on and off.")
end
