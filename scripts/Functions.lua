-- #TODO Copyright here

local GU = _G.GU;
local Logger = GU.Logger;

-- Print welcome message after player login.
function GU:PrintWelcomeMessage()
	Logger:Display("%s addon initialized. Type /gu or /gearup to see available commands.", GU_ADDON_DISPLAY_NAME);
end