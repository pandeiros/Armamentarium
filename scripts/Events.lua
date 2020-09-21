-- #TODO Copyright here

local Arma = _G.Arma
local Auctions = Arma.Data.Auctions;
local Logger = Arma.Logger;

function Arma:PlayerLogin()
	self:Initialize();
	self:PrintWelcomeMessage();
end

function Arma:GetItemInfoReceived(itemID, success)
	if not success then success = "" end;
	if itemID ~= nil then
		print(itemID .. ": " .. success);
	end
end

---------------------------------------------------------

function Arma.ToolTipHook(tooltip)
	-- Arma.Frames.Tooltip:AddItemInfo(tooltip);
end

GameTooltip:HookScript("OnTooltipSetItem", Arma.ToolTipHook);
ItemRefTooltip:HookScript("OnTooltipSetItem", Arma.ToolTipHook);