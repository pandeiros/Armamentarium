-- #TODO Copyright here

local GU = _G.GU;

local Frames = GU.Frames;
local Data = GU.Data;
local Logger = GU.Logger;

local Options = {};
Data.Options = Options;

local OptionsTable = {
    name = GU_ADDON_NAME,
    handler = GU,
    type = 'group',
    args = {
        reset = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = "execute",
            name = "Data reset",
            desc = "Reset all data to default state",
            func = "ResetAllData",
            order = 2,
            confirm = true,
        },

        config = {
            guiHidden = true,
            type = 'execute',
            name = 'Gear Up config',
            desc = 'Open Gear Up configuration window',
            func = 'OpenConfig',
        },

        test = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = 'execute',
            name = 'Test',
            desc = 'Test command',
            func = 'TestCommand',
        },

        scan = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = "toggle",
            name = "Enable/Disable Item Scan",
            desc = "Enable/Disable item scanning and parsing",
            set = "SetScanEnabled",
            get = "GetScanEnabled",
        },

        scanreset = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = "execute",
            name = "Reset scanning database",
            desc = "Reset scanning database",
            func = "ResetScanningDatabase",
        },

        stats = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = "execute",
            name = "DB Statistics",
            desc = "Print database stats",
            func = "DatabaseStats",
        },

        verbose = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = "toggle",
            name = "Enable/Disable Verbose Log",
            desc = "Enable/Disable detailed logging.",
            set = "SetVerboseLogEnabled",
            get = "GetVerboseLogEnabled",
        },

        fixscan = {
            hidden = "GetDevModeOptionsHidden",
            guiHidden = true,
            type = "execute",
            name = "Fix scanned items",
            desc = "Re-check already scanned items and delete deprecated/invalid ones.",
            func = "FixScannedItems",
        }
    },
}

GU_AceConfig:RegisterOptionsTable(GU_ADDON_NAME, OptionsTable, {"gu", "gearup"});
Options.OptionsTable = OptionsTable;

function GU:PrintNoAccessError(context)
    Logger:Err("You don't have permission to execute: %s", context)
end

function GU:GetDevModeEnabled()
    return GU_DEV_MODE_ENABLED;
end

function GU:GetDevModeOptionsHidden()
    return not self:GetDevModeEnabled();
end

-- Reset
function GU:ResetAllData(info)
    if (not self:GetDevModeEnabled()) then
        self:PrintNoAccessError("Reset All Data");
        return
    end

    Logger:Log("Resetting all data...");

    Data:Cleanup();

    self.db:ResetDB(DEFAULT_DB_NAME);

    GUDB = nil;
    GUCharacterDB = nil;

    self:InitializeDB();

    Data:ResetDatabase();
end

-- Config
function GU:OpenConfig(info)
    -- Frames:OpenConfigFrame();
    Frames:OpenMainFrame();
end

-- Test
function GU:TestCommand(info)
    -- Data:PrintAllItemLinks();
    -- Data:PrintDeprecatedItems();
    -- Data:RestoreDeprecatedItems();
    -- Data:FixDeprecatedNames();
    Data:AddAllDeprecatedIDs();
end

-- Scan
function GU:SetScanEnabled(info, val)
    if (not self:GetDevModeEnabled()) then
        self:PrintNoAccessError("Set Scan Enabled");
        return
    end

    Data:SetScanEnabled(val);
end

function GU:GetScanEnabled(info)
    return Data:IsScanEnabled();
end

-- Reset database
function GU:ResetScanningDatabase(info)
    Data:ResetScanningDatabase();
end

-- Print database stats
function GU:DatabaseStats(info)
    if (not self:GetDevModeEnabled()) then
        self:PrintNoAccessError("Database Stats");
        return;
    end

    Data:PrintDatabaseStats();
end

-- Verbose log
function GU:SetVerboseLogEnabled(info, val)
    if (not self:GetDevModeEnabled()) then
        self:PrintNoAccessError("Set Verbose Log Enabled");
        return
    end

    Logger:SetVerboseLogEnabled(val);
end

function GU:GetVerboseLogEnabled(info)
    return Logger:IsVerboseLogEnabled();
end

-- Scan fixing
function GU:FixScannedItems(info)
    if (not self:GetDevModeEnabled()) then
        self:PrintNoAccessError("Fix Scanned Items");
        return;
    end

    Data:FixItemTooltips();
end