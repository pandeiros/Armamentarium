-- ********************************************************
-- *                      Gear Up!                        *
-- ********************************************************
-- *                                                      *
-- *  This addon is written and copyrighted by:           *
-- *    - Pandeiros (Pandeirosa @ EU-ZandalarTribe)       *
-- *                                                      *
-- ********************************************************

-- TODO
-- * Some items are crafted in random quantity. Example: Coarse Dynamite creates 1-3 pieces. Need to check professions for that kind of items and fix data.

local GU = _G.GU;

local Data = GU.Data;

-- Also, a brief note for more advanced authors: 
-- If for some reason your addon causes LoadAddon() to be called in the main chunk,
-- OnInitialize will fire prematurely for your addon, so you'll need to take other measures
-- to delay initializing AceDB since SavedVariables still won't be loaded.
function GU:OnInitialize()
    self:Initialize();
end

function GU:Initialize()
    if (type(self.init) ~= "boolean" or not self.init) then
        self.db = AceDB:New("GUDB", GU_DB_DEFAULTS, true);
        self.devmode = false;

        Data:Initialize();
        Data.Options.OptionsTable.args.profiles = AceDBOptions:GetOptionsTable(self.db)
    end

    self.init = true;
end