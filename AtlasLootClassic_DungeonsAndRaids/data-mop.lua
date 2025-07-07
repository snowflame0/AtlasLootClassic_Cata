-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.MOP_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.MOP_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local FLEXIBLE_DIFF = data:AddDifficulty(AL["Flexible"], nil, nil, nil, true)
local CELESTIAL_DIFF = data:AddDifficulty(AL["Celestial"], nil, nil, nil, true)
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement", "Item")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID40_COLOR)

-- extra
local CLASS_NAME = AtlasLoot:GetColoredClassNames()

-- name formats
local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"

-- colors
--local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
--local GREEN = "|cff66cc33%s|r"
local RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
local WHITE = "|cffffffff%s|r"

-- format
local BONUS_LOOT_SPLIT = "%s - %s"

local T14_SET = {
    name = format(AL["Tier %s Sets"], "14"),
    ExtraList = true,
    TableType = SET_ITTYPE,
    IgnoreAsSource = true,
    [CELESTIAL_DIFF] = {
        {1, 50001143 }, -- Warlock
        {3, 50001137 }, -- Priest Holy
        {4, 50001138 }, -- Priest Shadow
        {6, 50001139 }, -- Rogue
        {8, 50001129 }, -- Hunter
        {10, 50001145 }, -- Warrior Tank
        {11, 50001144 }, -- Warrior Dps
        {13, 50001124 }, -- Death Knight Tank
        {14, 50001123 }, -- Death Knight DPS
        {16, 50001130 }, -- Mage
        {18, 50001125 }, -- Druid Resto
        {19, 50001126 }, -- Druid Balance
        {20, 50001127 }, -- Druid Feral
        {21, 50001128 }, -- Druid Guardian
        {23, 50001141 }, -- Shaman Resto
        {24, 50001140 }, -- Shaman Elemental
        {25, 50001142 }, -- Shaman Enhance
        {27, 50001134 }, -- Paladin Holy
        {28, 50001136 }, -- Paladin Prot
        {29, 50001135 }, -- Paladin DPS
        {101, 50001131 }, -- Monk Mistweaver
        {102, 50001133 }, -- Monk Brewmaster
        {103, 50001132 }, -- Monk Windwalker
     },
    [NORMAL_DIFF] = {
        {1, 50011143 }, -- Warlock
        {3, 50011137 }, -- Priest Holy
        {4, 50011138 }, -- Priest Shadow
        {6, 50011139 }, -- Rogue
        {8, 50011129 }, -- Hunter
        {10, 50011145 }, -- Warrior Tank
        {11, 50011144 }, -- Warrior Dps
        {13, 50011124 }, -- Death Knight Tan
        {14, 50011123 }, -- Death Knight DPS
        {16, 50011130 }, -- Mage
        {18, 50011125 }, -- Druid Resto
        {19, 50011126 }, -- Druid Balance
        {20, 50011127 }, -- Druid Feral
        {21, 50011128 }, -- Druid Guardian
        {23, 50011141 }, -- Shaman Resto
        {24, 50011140 }, -- Shaman Elemental
        {25, 50011142 }, -- Shaman Enhance
        {27, 50011134 }, -- Paladin Holy
        {28, 50011136 }, -- Paladin Prot
        {29, 50011135 }, -- Paladin DPS
        {101, 50011131 }, -- Monk Mistweaver
        {102, 50011133 }, -- Monk Brewmaster
        {103, 50011132 }, -- Monk Windwalker
    },
    [HEROIC_DIFF] = {
        {1, 50021143 }, -- Warlock
        {3, 50021137 }, -- Priest Holy
        {4, 50021138 }, -- Priest Shadow
        {6, 50021139 }, -- Rogue
        {8, 50021129 }, -- Hunter
        {10, 50021145 }, -- Warrior Tank
        {11, 50021144 }, -- Warrior Dps
        {13, 50021124 }, -- Death Knight Tan
        {14, 50021123 }, -- Death Knight DPS
        {16, 50021130 }, -- Mage
        {18, 50021125 }, -- Druid Resto
        {19, 50021126 }, -- Druid Balance
        {20, 50021127 }, -- Druid Feral
        {21, 50021128 }, -- Druid Guardian
        {23, 50021141 }, -- Shaman Resto
        {24, 50021140 }, -- Shaman Elemental
        {25, 50021142 }, -- Shaman Enhance
        {27, 50021134 }, -- Paladin Holy
        {28, 50021136 }, -- Paladin Prot
        {29, 50021135 }, -- Paladin DPS
        {101, 50021131 }, -- Monk Mistweaver
        {102, 50021133 }, -- Monk Brewmaster
        {103, 50021132 }, -- Monk Windwalker
    },
}

local T15_SET = {
    name = format(AL["Tier %s Sets"], "15"),
    ExtraList = true,
    TableType = SET_ITTYPE,
    IgnoreAsSource = true,
    [CELESTIAL_DIFF] = {
        { 1, 50001171 }, -- Warlock
        { 3, 50001165 }, -- Priest Holy
        { 4, 50001166 }, -- Priest Shadow
        { 6, 50001167 }, -- Rogue
        { 8, 50001157 }, -- Hunter
        { 10, 50001173 }, -- Warrior Tank
        { 11, 50001172 }, -- Warrior Dps
        { 13, 50001151 }, -- Death Knight Tank
        { 14, 50001152 }, -- Death Knight DPS
        { 16, 50001158 }, -- Mage
        { 18, 50001154 }, -- Druid Resto
        { 19, 50001156 }, -- Druid Guardian
        { 20, 50001155 }, -- Druid Balance
        { 21, 50001153 }, -- Druid Feral
        { 23, 50001168 }, -- Shaman Resto
        { 24, 50001170 }, -- Shaman Elemental
        { 25, 50001169 }, -- Shaman Enhance
        { 27, 50001163 }, -- Paladin Holy
        { 28, 50001164 }, -- Paladin Prot
        { 29, 50001162 }, -- Paladin DPS
        { 101, 50001160 }, -- Monk Mistweaver
        { 102, 50001161 }, -- Monk Brewmaster
        { 103, 50001159 }, -- Monk Windwalker
    },
    [NORMAL_DIFF] = {
        { 1, 50011171 }, -- Warlock
        { 3, 50011165 }, -- Priest Holy
        { 4, 50011166 }, -- Priest Shadow
        { 6, 50011167 }, -- Rogue
        { 8, 50011157 }, -- Hunter
        { 10, 50011173 }, -- Warrior Tank
        { 11, 50011172 }, -- Warrior Dps
        { 13, 50011151 }, -- Death Knight Tank
        { 14, 50011152 }, -- Death Knight DPS
        { 16, 50011158 }, -- Mage
        { 18, 50011154 }, -- Druid Resto
        { 19, 50011156 }, -- Druid Guardian
        { 20, 50011155 }, -- Druid Balance
        { 21, 50011153 }, -- Druid Feral
        { 23, 50011168 }, -- Shaman Resto
        { 24, 50011170 }, -- Shaman Elemental
        { 25, 50011169 }, -- Shaman Enhance
        { 27, 50011163 }, -- Paladin Holy
        { 28, 50011164 }, -- Paladin Prot
        { 29, 50011162 }, -- Paladin DPS
        { 101, 50011160 }, -- Monk Mistweaver
        { 102, 50011161 }, -- Monk Brewmaster
        { 103, 50011159 }, -- Monk Windwalker
    },
    [HEROIC_DIFF] = {
        { 1, 50021171 }, -- Warlock
        { 3, 50021165 }, -- Priest Holy
        { 4, 50021166 }, -- Priest Shadow
        { 6, 50021167 }, -- Rogue
        { 8, 50021157 }, -- Hunter
        { 10, 50021173 }, -- Warrior Tank
        { 11, 50021172 }, -- Warrior Dps
        { 13, 50021151 }, -- Death Knight Tank
        { 14, 50021152 }, -- Death Knight DPS
        { 16, 50021158 }, -- Mage
        { 18, 50021154 }, -- Druid Resto
        { 19, 50021156 }, -- Druid Guardian
        { 20, 50021155 }, -- Druid Balance
        { 21, 50021153 }, -- Druid Feral
        { 23, 50021168 }, -- Shaman Resto
        { 24, 50021170 }, -- Shaman Elemental
        { 25, 50021169 }, -- Shaman Enhance
        { 27, 50021163 }, -- Paladin Holy
        { 28, 50021164 }, -- Paladin Prot
        { 29, 50021162 }, -- Paladin DPS
        { 101, 50021160 }, -- Monk Mistweaver
        { 102, 50021161 }, -- Monk Brewmaster
        { 103, 50021159 }, -- Monk Windwalker
    },
}

local T16_SET = {
    name = format(AL["Tier %s Sets"], "16"),
    ExtraList = true,
    TableType = SET_ITTYPE,
    IgnoreAsSource = true,
    [CELESTIAL_DIFF] = {
        { 1, 50001181 }, -- Warlock
        { 3, 50001187 }, -- Priest Holy
        { 4, 50001186 }, -- Priest Shadow
        { 6, 50001185 }, -- Rogue
        { 8, 50001195 }, -- Hunter
        { 10, 50001179 }, -- Warrior Tank
        { 11, 50001180 }, -- Warrior Dps
        { 13, 50001201 }, -- Death Knight Tank
        { 14, 50001200 }, -- Death Knight DPS
        { 16, 50001194 }, -- Mage
        { 18, 50001198 }, -- Druid Resto
        { 19, 50001196 }, -- Druid Guardian
        { 20, 50001197 }, -- Druid Balance
        { 21, 50001199 }, -- Druid Feral
        { 23, 50001184 }, -- Shaman Resto
        { 24, 50001182 }, -- Shaman Elemental
        { 25, 50001183 }, -- Shaman Enhance
        { 27, 50001189 }, -- Paladin Holy
        { 28, 50001188 }, -- Paladin Prot
        { 29, 50001190 }, -- Paladin DPS
        { 101, 50001192 }, -- Monk Mistweaver
        { 102, 50001191 }, -- Monk Brewmaster
        { 103, 50001193 }, -- Monk Windwalker
    },
    [FLEXIBLE_DIFF] = {
        { 1, 50011181 }, -- Warlock
        { 3, 50011187 }, -- Priest Holy
        { 4, 50011186 }, -- Priest Shadow
        { 6, 50011185 }, -- Rogue
        { 8, 50011195 }, -- Hunter
        { 10, 50011179 }, -- Warrior Tank
        { 11, 50011180 }, -- Warrior Dps
        { 13, 50011201 }, -- Death Knight Tank
        { 14, 50011200 }, -- Death Knight DPS
        { 16, 50011194 }, -- Mage
        { 18, 50011198 }, -- Druid Resto
        { 19, 50011196 }, -- Druid Guardian
        { 20, 50011197 }, -- Druid Balance
        { 21, 50011199 }, -- Druid Feral
        { 23, 50011184 }, -- Shaman Resto
        { 24, 50011182 }, -- Shaman Elemental
        { 25, 50011183 }, -- Shaman Enhance
        { 27, 50011189 }, -- Paladin Holy
        { 28, 50011188 }, -- Paladin Prot
        { 29, 50011190 }, -- Paladin DPS
        { 101, 50011192 }, -- Monk Mistweaver
        { 102, 50011191 }, -- Monk Brewmaster
        { 103, 50011193 }, -- Monk Windwalker
    },
    [NORMAL_DIFF] = {
        { 1, 50021181 }, -- Warlock
        { 3, 50021187 }, -- Priest Holy
        { 4, 50021186 }, -- Priest Shadow
        { 6, 50021185 }, -- Rogue
        { 8, 50021195 }, -- Hunter
        { 10, 50021179 }, -- Warrior Tank
        { 11, 50021180 }, -- Warrior Dps
        { 13, 50021201 }, -- Death Knight Tank
        { 14, 50021200 }, -- Death Knight DPS
        { 16, 50021194 }, -- Mage
        { 18, 50021198 }, -- Druid Resto
        { 19, 50021196 }, -- Druid Guardian
        { 20, 50021197 }, -- Druid Balance
        { 21, 50021199 }, -- Druid Feral
        { 23, 50021184 }, -- Shaman Resto
        { 24, 50021182 }, -- Shaman Elemental
        { 25, 50021183 }, -- Shaman Enhance
        { 27, 50021189 }, -- Paladin Holy
        { 28, 50021188 }, -- Paladin Prot
        { 29, 50021190 }, -- Paladin DPS
        { 101, 50021192 }, -- Monk Mistweaver
        { 102, 50021191 }, -- Monk Brewmaster
        { 103, 50021193 }, -- Monk Windwalker
    },
    [HEROIC_DIFF] = {
        { 1, 50031181 }, -- Warlock
        { 3, 50031187 }, -- Priest Holy
        { 4, 50031186 }, -- Priest Shadow
        { 6, 50031185 }, -- Rogue
        { 8, 50031195 }, -- Hunter
        { 10, 50031179 }, -- Warrior Tank
        { 11, 50031180 }, -- Warrior Dps
        { 13, 50031201 }, -- Death Knight Tank
        { 14, 50031200 }, -- Death Knight DPS
        { 16, 50031194 }, -- Mage
        { 18, 50031198 }, -- Druid Resto
        { 19, 50031196 }, -- Druid Guardian
        { 20, 50031197 }, -- Druid Balance
        { 21, 50031199 }, -- Druid Feral
        { 23, 50031184 }, -- Shaman Resto
        { 24, 50031182 }, -- Shaman Elemental
        { 25, 50031183 }, -- Shaman Enhance
        { 27, 50031189 }, -- Paladin Holy
        { 28, 50031188 }, -- Paladin Prot
        { 29, 50031190 }, -- Paladin DPS
        { 101, 50031192 }, -- Monk Mistweaver
        { 102, 50031191 }, -- Monk Brewmaster
        { 103, 50031193 }, -- Monk Windwalker
    },
}

local MOP_DUNGEON_HERO_AC_TABLE = {	--[Pandaria Dungeon Hero]
    name = select(2, GetAchievementInfo(6925)),
    TableType = AC_ITTYPE,
    ExtraList = true,
    CoinTexture = "Achievement",
    [HEROIC_DIFF] = {
        { 1, 6925 },
        { 2, 6758 },			{ 17, 6456 },
        { 3, 6756 },			{ 18, 6470 },
        { 4, 6759 },			{ 19, 6760 },
        { 5, 6761 },			{ 20, 6762 },
        { 6, 6763 }
    },
}

local MOP_GLORY_OF_THE_HERO_AC_TABLE = {		--[Glory of the Pandaria Hero]
    name = select(2, GetAchievementInfo(6927)),
    TableType = AC_ITTYPE,
    ExtraList = true,
    CoinTexture = "Achievement",
    [HEROIC_DIFF] = {
        { 1, 6927 },
        { 2, 6925 },			{ 17, 6460 },
        { 3, 6475 },			{ 18, 6671 },
        { 4, 6420 },			{ 19, 6089 },
        { 5, 6400 },			{ 20, 6402 },
        { 6, 6478 },			{ 21, 6736 },
        { 7, 6713 },			{ 22, 6477 },
        { 8, 6472 },			{ 23, 6471 },
        { 9, 6479 },			{ 24, 6476 },
        { 10, 6684 },			{ 25, 6427 },
        { 11, 6928 },			{ 26, 6929 },
        { 12, 6531 },			{ 27, 6394 },
        { 13, 6396 },			{ 28, 6821 },
        { 14, 6688 },			{ 29, 6485 },
        { 15, 6822 },			{ 30, 6715 },
    },
}

local MOP_RAID1_AC_TABLE = {	-- Glory of the Pandaria Raider
    name = select(2, GetAchievementInfo(6932)),
    TableType = AC_ITTYPE,
    ExtraList = true,
    CoinTexture = "Achievement",
    [NORMAL_DIFF] = {
        { 1, 6932 },
        { 2, 6823 },			{ 17, 6674 },
        { 3, 7056 },			{ 18, 6687 },
        { 4, 6686 },			{ 19, 6455 },
        { 5, 6937 },			{ 20, 6936 },
        { 6, 6553 },			{ 21, 6683 },
        { 7, 6518 },			{ 22, 6922 },
        { 8, 6717 },			{ 23, 6824 },
        { 9, 6933 },			{ 24, 6825 },
    },
    [HEROIC_DIFF] = {
        { 1, 6932 },
        { 2, 6719 },			{ 17, 6720 },
        { 3, 6721 },			{ 18, 6722 },
        { 4, 6723 },			{ 19, 6724 },
        { 5, 6725 },			{ 20, 6726 },
        { 6, 6727 },			{ 21, 6728 },
        { 7, 6729 },			{ 22, 6730 },
        { 8, 6731 },			{ 23, 6732 },
        { 9, 6733 }
    },
}

local MOP_RAID2_AC_TABLE = {	-- Glory of the Thundering Raider
    name = select(2, GetAchievementInfo(8124)),
    TableType = AC_ITTYPE,
    ExtraList = true,
    CoinTexture = "Achievement",
    [NORMAL_DIFF] = {
        { 1, 8124 },
        { 2, 8038 },			{ 17, 8094 },
        { 3, 8077 },			{ 18, 8073 },
        { 4, 8097 },			{ 19, 8082 },
        { 5, 8037 },			{ 20, 8098 },
        { 6, 8087 },			{ 21, 8081 },
        { 7, 8090 },			{ 22, 8086 },
    },
    [HEROIC_DIFF] = {
        { 1, 8124 },
        { 2, 8056 },			{ 17, 8057 },
        { 3, 8058 },			{ 18, 8059 },
        { 4, 8060 },			{ 19, 8061 },
        { 5, 8062 },			{ 20, 8063 },
        { 6, 8064 },			{ 21, 8065 },
        { 7, 8066 }
    },
}

local PATTERNS_ILVL_496 = {		-- Patterns with iLvl 496 (Mogu, HoF, ToEs)
    name = AL["Patterns"],
    ExtraList = true,
    [NORMAL_DIFF] = {
        { 1, 86381 },	-- Pattern: Legacy of the Emperor
        { 2, 86379 },	-- Pattern: Robe of Eternal Rule
        { 3, 86380 },	-- Pattern: Imperial Silk Gloves
        { 4, 86382 },	-- Pattern: Touch of the Light
        { 6, 86238 },	-- Pattern: Chestguard of Nemeses
        { 7, 86281 },	-- Pattern: Nightfire Robe
        { 8, 86279 },	-- Pattern: Liferuned Leather Gloves
        { 9, 86280 },	-- Pattern: Murderer's Gloves
        { 10, 86283 },	-- Pattern: Raiment of Blood and Bone
        { 11, 86297 },	-- Pattern: Stormbreaker Chestguard
        { 12, 86272 },	-- Pattern: Fists of Lightning
        { 13, 86284 },	-- Pattern: Raven Lord's Gloves
        { 16, 87412 },	-- Plans: Chestplate of Limitless Faith
        { 17, 87410 },	-- Plans: Ornate Battleplate of the Master
        { 18, 87408 },	-- Plans: Unyielding Bloodplate
        { 19, 87411 },	-- Plans: Bloodforged Warfists
        { 20, 87409 },	-- Plans: Gauntlets of Battle Command
        { 21, 87413 },	-- Plans: Gauntlets of Unbound Devotion
    },
}

data["StormstoutBrewery"] = {
    EncounterJournalID = 302,
    MapID = 5963,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {85, 85, 90},
    items = {
        {	--BreweryOokOok
            EncounterJournalID = 668,
            [NORMAL_DIFF] = {
                { 1, 80897 },	-- Bracers of Displaced Air
                { 2, 80896 },	-- Nimbletoe Chestguard
                { 3, 80892 },	-- Ook's Hozen Slicer
            },
            [HEROIC_DIFF] = {
                { 1, 81064 },	-- Bracers of Displaced Air
                { 2, 81080 },	-- Nimbletoe Chestguard
                { 3, 81134 },	-- Barreldodger Boots
                { 4, 81133 },	-- Empty Fruit Barrel
                { 5, 81061 },	-- Ook's Hozen Slicer
                { 16, "ac6089" },
            },
        },
        {	--BreweryHoptallus
            EncounterJournalID = 669,
            [NORMAL_DIFF] = {
                { 1, 80898 },	-- Hopping Mad Leggings
                { 2, 80899 },	-- Bubble-Breaker Bracers
                { 3, 80893 },	-- Bottle of Potent Potables
            },
            [HEROIC_DIFF] = {
                { 1, 81136 },	-- Cloak of Hidden Flasks
                { 2, 81135 },	-- Belt of Brazen Inebriation
                { 3, 81077 },	-- Hopping Mad Leggings
                { 4, 81065 },	-- Bubble-Breaker Bracers
                { 5, 81076 },	-- Bottle of Potent Potables
            },
        },
        {	--BreweryYanZhu
            EncounterJournalID = 670,
            [NORMAL_DIFF] = {
                { 1, 80903 },	-- Fermenting Belt
                { 2, 80900 },	-- Fizzy Spaulders
                { 3, 80902 },	-- Uncasked Chestguard
                { 4, 80901 },	-- Sudsy Legplates
                { 5, 80894 },	-- Gao's Keg Tapper
                { 6, 80895 },	-- Yan-Zhu's Pressure Valve
                { 16, "ac6457" },
            },
            [HEROIC_DIFF] = {
                { 1, 87545 },	-- Inelava, Spirit of Inebriation
                { 2, 81059 },	-- Fermenting Belt
                { 3, 81068 },	-- Fizzy Spaulders
                { 4, 81081 },	-- Uncasked Chestguard
                { 5, 81078 },	-- Sudsy Legplates
                { 6, 81141 },	-- Alemental Seal
                { 7, 81139 },	-- Lime-Rimmed Signet
                { 8, 81138 },	-- Carbonic Carbuncle
                { 9, 81062 },	-- Gao's Keg Tapper
                { 10, 811400 },	-- Wort Sitrring Rod
                { 11, 810660 },	-- Yan-Zhu's Pressure Valve
                { 16, "ac6456" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["TempleOfTheJadeSerpent"] = {
    EncounterJournalID = 313,
    MapID = 5956,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {85, 85, 90},
    items = {
        {	--TJSMari
            EncounterJournalID = 672,
            [NORMAL_DIFF] = {
                { 1, 80862 },	-- Treads of Corrupted Water
                { 2, 80860 },	-- Waterburst Helm
                { 3, 80861 },	-- Riverbed Chestguard
            },
            [HEROIC_DIFF] = {
                { 1, 81123 },	-- Wind-Soaked Drape
                { 2, 81072 },	-- Treads of Corrupted Water
                { 3, 81075 },	-- Waterburst Helm
                { 4, 81083 },	-- Riverbed Chestguard
                { 5, 81124 },	-- Crystallized Droplet
                { 16, "ac6460" },
            },
        },
        {	--TJSStonestep
            EncounterJournalID = 664,
            [NORMAL_DIFF] = {
                { 1, 80864 },	-- Girdle of Endemic Anger
                { 2, 80865 },	-- Sunheart Waistband
                { 3, 80863 },	-- Stonestep Boots
            },
            [HEROIC_DIFF] = {
                { 1, 81058 },	-- Girdle of Endemic Anger
                { 2, 81126 },	-- Leggings of Whispered Dreams
                { 3, 81060 },	-- Sunheart Waistband
                { 4, 81073 },	-- Stonestep Boots
                { 5, 81125 },	-- Windswept Pages
            },
        },
        {	--TJSFlameheart
            EncounterJournalID = 658,
            [NORMAL_DIFF] = {
                { 1, 80866 },	-- Cape of Entanglement
                { 2, 80867 },	-- Serpentstrike Shoulderpads
                { 3, 80872 },	-- Firebelcher Hand Cannon
            },
            [HEROIC_DIFF] = {
                { 1, 81084 },	-- Cape of Entanglement
                { 2, 81127 },	-- Flameheart Sandals
                { 3, 81070 },	-- Serpentstrike Shoulderpads
                { 4, 81128 },	-- Signet of Dancing Jade
                { 5, 81067 },	-- Firebelcher Hand Cannon
            },
        },
        {	--TJSShaDoubt
            EncounterJournalID = 335,
            [NORMAL_DIFF] = {
                { 1, 80868 },	-- Doubtridden Shoulderguards
                { 2, 80870 },	-- Chestguard of Despair
                { 3, 80871 },	-- Neverdare Shoulders
                { 4, 80869 },	-- Hopecrusher Gauntlets
                { 5, 80873 },	-- Dubious Handaxe
                { 6, 80874 },	-- Staff of Trembling Will
                { 16, "ac6757" },
            },
            [HEROIC_DIFF] = {
                { 1, 87544 },	-- Je'lyu, Spirit of the Serpent
                { 2, 81129 },	-- Cloak of Failing Will
                { 3, 81132 },	-- Paralyzing Gloves
                { 4, 81071 },	-- Doubtridden Shoulderguards
                { 5, 81082 },	-- Chestguard of Despair
                { 6, 81069 },	-- Neverdare Shoulders
                { 7, 81074 },	-- Hopecrusher Gauntlets
                { 8, 81130 },	-- Binding of Broken Dreams
                { 9, 81131 },	-- Mindbreaker Pendant
                { 10, 81063 },	-- Dubious Handaxe
                { 11, 81079 },	-- Staff of Trembling Will
                { 16, "ac6758" },
                { 17, "ac6926" },
                { 18, "ac6475" },
                { 19, "ac6671" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["ShadoPanMonastery"] = {
    EncounterJournalID = 312,
    MapID = 5918,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {87, 87, 90},
    items = {
        {	--ShadoPanCloudstrike
            EncounterJournalID = 673,
            [NORMAL_DIFF] = {
                { 1, 80909 },	-- Azure Serpent Chestguard
                { 2, 80910 },	-- Leggings of the Charging Soul
                { 3, 80908 },	-- Sparkbreath Girdle
            },
            [HEROIC_DIFF] = {
                { 1, 81179 },	-- Star Summoner Bracers
                { 2, 81110 },	-- Azure Serpent Chestguard
                { 3, 81092 },	-- Leggings of the Charging Soul
                { 4, 81086 },	-- Sparkbreath Girdle
                { 5, 81180 },	-- Cloudstrike Pendant
            },
        },
        {	--ShadoPanSnowdrift
            EncounterJournalID = 657,
            [NORMAL_DIFF] = {
                { 1, 80912, 33 },	-- Gauntlets of Resolute Fury
                { 2, 80911, 33 },	-- Quivering Heart Girdle
                { 3, 80937, 33 },	-- Snowdrift's Bladed Staff
            },
            [HEROIC_DIFF] = {
                { 1, 81101, 20 },	-- Gauntlets of Resolute Fury
                { 2, 81087, 20 },	-- Quivering Heart Girdle
                { 3, 81182, 20 },	-- Eye of the Tornado
                { 4, 81181, 20 },	-- Heart of Fire
                { 5, 81108, 20 },	-- Snowdrift's Bladed Staff
                { 16, "ac6477" },
            },
        },
        {	--ShadoPanShaViolence
            EncounterJournalID = 685,
            [NORMAL_DIFF] = {
                { 1, 80913 },	-- Gloves of Enraged Slaughter
                { 2, 80915 },	-- Spike-Soled Stompers
                { 3, 80883 },	-- Crescent of Ichor
            },
            [HEROIC_DIFF] = {
                { 1, 81102 },	-- Gloves of Enraged Slaughter
                { 2, 81185 },	-- Bladed Smoke Bracers
                { 3, 81113 },	-- Spike-Soled Stompers
                { 4, 81184 },	-- Necklace of Disorientation
                { 5, 81089 },	-- Crescent of Ichor
                { 16, "ac6926" },
                { 17, "ac6472" },
            },
        },
        {	--ShadoPanTaranZhu
            EncounterJournalID = 686,
            [NORMAL_DIFF] = {
                { 1, 80919 },	-- Darkbinder Leggings
                { 2, 80916 },	-- Shadowspine Shoulderguards
                { 3, 80917 },	-- Blastwalker Footguards
                { 4, 80918 },	-- Mindbinder Plate Gloves
                { 5, 80936 },	-- Warmace of Taran Zhu
                { 6, 80935 },	-- Shield of Blind Hate
                { 16, "ac6469" },
            },
            [HEROIC_DIFF] = {
                { 1, 87543 },	-- Ka'eng, Breath of the Shadow
                { 2, 81188 },	-- Robes of Fevered Dreams
                { 3, 81093 },	-- Darkbinder Leggings
                { 4, 81099 },	-- Shadowspine Shoulderguards
                { 5, 81114 },	-- Blastwalker Footguards
                { 6, 81187 },	-- Hateshatter Chestplate
                { 7, 81103 },	-- Mindbinder Plate Gloves
                { 8, 81189 },	-- Ring of Malice
                { 9, 81186 },	-- Seal of Hateful Meditation
                { 10, 81107 },	-- Warmace of Taran Zhu
                { 11, 81096 },	-- Shield of Blind Hate
                { 16, "ac6470" },
                { 17, "ac6471" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["MoguShanPalace"] = {
    EncounterJournalID = 321,
    MapID = 6182,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {87, 87, 90},
    items = {
        {	--MoguShanTrialKing
            EncounterJournalID = 708,
            [NORMAL_DIFF] = {
                { 1, 85178 },	-- Conflagrating Gloves
                { 2, 85176 },	-- Hurricane Belt
                { 3, 85175 },	-- Crest of the Clan Lords
                { 4, 85179 },	-- Meteoric Greathelm
                { 5, 85177 },	-- Whirling Dervish Choker
            },
            [HEROIC_DIFF] = {
                { 1, 81240 },	-- Conflagrating Gloves
                { 2, 81238 },	-- Hurricane Belt
                { 3, 81237 },	-- Crest of the Clan Lords
                { 4, 81241 },	-- Meteoric Greathelm
                { 5, 81239 },	-- Whirling Dervish Choker
            },
        },
        {	--MoguShanGekkan
            EncounterJournalID = 690,
            [NORMAL_DIFF] = {
                { 1, 85182 },	-- Cloak of Cleansing Flame
                { 2, 85184 },	-- Hexxer's Lethargic Gloves
                { 3, 85180 },	-- Glintrok Sollerets
                { 4, 85181 },	-- Iron Protector Talisman
                { 5, 85183 },	-- Claws of Gekkan
            },
            [HEROIC_DIFF] = {
                { 1, 81244 },	-- Cloak of Cleansing Flame
                { 2, 81246 },	-- Hexxer's Lethargic Gloves
                { 3, 81242 },	-- Glintrok Sollerets
                { 4, 81243 },	-- Iron Protector Talisman
                { 5, 81245 },	-- Claws of Gekkan
                { 16, "ac6478" },
            },
        },
        {	--MoguShanXin
            EncounterJournalID = 698,
            [NORMAL_DIFF] = {
                { 1, 85194 },	-- Regal Silk Shoulderpads
                { 2, 85192 },	-- Soulbinder Treads
                { 3, 85187 },	-- Boots of Plummeting Death
                { 4, 85189 },	-- Groundshaker Bracers
                { 5, 85193 },	-- Mind's Eye Breastplate
                { 6, 85186 },	-- Axebreaker Gauntlets
                { 7, 85191 },	-- Mindcapture Pendant
                { 8, 85188 },	-- Blade Trap Signet
                { 9, 85190 },	-- Firescribe Dagger
                { 10, 85185 },	-- Ghostheart
                { 16, "ac6755" },
            },
            [HEROIC_DIFF] = {
                { 1, 87542 },	-- Mogu'Dar, Blade of the Thousand Slaves
                { 2, 81257 },	-- Regal Silk Shoulderpads
                { 3, 81255 },	-- Soulbinder Treads
                { 4, 81249 },	-- Boots of Plummeting Death
                { 5, 81252 },	-- Groundshaker Bracers
                { 6, 81256 },	-- Mind's Eye Breastplate
                { 7, 81248 },	-- Axebreaker Gauntlets
                { 8, 81254 },	-- Mindcapture Pendant
                { 9, 81251 },	-- Blade Trap Signet
                { 10, 81253 },	-- Firescribe Dagger
                { 11, 81247 },	-- Ghostheart
                { 16, "ac6756" },
                { 17, "ac6736" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["GateoftheSettingSun"] = {
    EncounterJournalID = 303,
    MapID = 5976,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {88, 88, 90},
    items = {
        {	--GotSSKiptilak
            EncounterJournalID = 655,
            [NORMAL_DIFF] = {
                { 1, 80920 },	-- Fallout Filter
                { 2, 80921 },	-- Saboteur's Stabilizing Bracers
                { 3, 80934 },	-- Pendant of Precise Timing
            },
            [HEROIC_DIFF] = {
                { 1, 81104 },	-- Fallout-Filtering Hood
                { 2, 81090 },	-- Saboteur's Stabilizing Bracers
                { 3, 81190 },	-- Grenadier's Belt
                { 4, 81095 },	-- Pendant of Precise Timing
                { 5, 81191 },	-- Pulled Grenade Pin
                { 16, "ac6479" }
            },
        },
        {	--GotSSGadok
            EncounterJournalID = 675,
            [NORMAL_DIFF] = {
                { 1, 80922 },	-- Airstream Treads
                { 2, 80923 },	-- Impaler's Girdle
                { 3, 80924 },	-- Acid-Scarred Spaulders
            },
            [HEROIC_DIFF] = {
                { 1, 81229 },	-- Bomber's Precision Gloves
                { 2, 81111 },	-- Airstream Treads
                { 3, 81085 },	-- Impaler's Girdle
                { 4, 81098 },	-- Acid-Scarred Spaulders
                { 5, 81192 },	-- Vision of the Predator
            },
        },
        {	--GotSSRimok
            EncounterJournalID = 676,
            [NORMAL_DIFF] = {
                { 1, 80926 },	-- Leggings of the Frenzy
                { 2, 80925 },	-- Swarmcall Helm
                { 3, 80933 },	-- Mantid Trochanter
            },
            [HEROIC_DIFF] = {
                { 1, 81106 },	-- Leggings of the Frenzy
                { 2, 81105 },	-- Swarmcall Helm
                { 3, 81230 },	-- Ri'mok's Shattered Scale
                { 4, 81232 },	-- Viscous Ring
                { 5, 81088 },	-- Mantid Trochanter
            },
        },
        {	--GotSSRaigonn
            EncounterJournalID = 649,
            [NORMAL_DIFF] = {
                { 1, 80929 },	-- Wall-Breaker Legguards
                { 2, 80928 },	-- Treads of Fixation
                { 3, 80930 },	-- Swarmbringer Chestguard
                { 4, 80927 },	-- Hive Protector's Gauntlets
                { 5, 80932 },	-- Carapace Breaker
                { 6, 80931 },	-- Shield of the Protectorate
            },
            [HEROIC_DIFF] = {
                { 1, 87546 },	-- Klatith, Fangs of the Swarm
                { 2, 81234 },	-- Drape of the Screeching Swarm
                { 3, 81235 },	-- Shoulders of Engulfing Winds
                { 4, 81236 },	-- Frenzyswarm Bracers
                { 5, 81091 },	-- Wall-Breaker Legguards
                { 6, 81112 },	-- Treads of Fixation
                { 7, 81109 },	-- Swarmbringer Chestguard
                { 8, 81100 },	-- Hive Protector's Gauntlets
                { 9, 81094 },	-- Carapace Breaker
                { 10, 81233 },	-- Impervious Carapace
                { 11, 81097 },	-- Shield of the Protectorate
                { 16, "ac6759" },
                { 17, "ac6945" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["SiegeofNiuzaoTemple"] = {
    EncounterJournalID = 324,
    MapID = 6214,
    ContentType = DUNGEON_CONTENT,
    LevelRange = {88, 88, 90},
    items = {
        {	--NTJinbak
            EncounterJournalID = 693,
            [NORMAL_DIFF] = {
                { 1, 100952 },	-- Hood of Viridian Residue
                { 2, 100953 },	-- Girdle of Soothing Detonation
                { 3, 100954 },	-- Sap-Encrusted Legplates
                { 4, 100950 },	-- Engraved Amber Pendant
                { 5, 100951 },	-- Flashfrozen Resin Globule
            },
            [HEROIC_DIFF] = {
                { 1, 81262 },	-- Hood of Viridian Residue
                { 2, 81272 },	-- Girdle of Soothing Detonation
                { 3, 81270 },	-- Sap-Encrusted Legplates
                { 4, 81271 },	-- Engraved Amber Pendant
                { 5, 81263 },	-- Flashfrozen Resin Globule
            },
        },
        {	--NTVojak
            EncounterJournalID = 738,
            [NORMAL_DIFF] = {
                { 1, 100956 },	-- Bombardment Bracers
                { 2, 100957 },	-- Chestwrap of Arcing Flame
                { 3, 100958 },	-- Archer's Precision Grips
                { 4, 100959 },	-- Sightfinder Helm
                { 5, 100955 },	-- Siege-Captain's Scimitar
            },
            [HEROIC_DIFF] = {
                { 1, 81276 },	-- Bombardment Bracers
                { 2, 81275 },	-- Chestwrap of Arcing Flame
                { 3, 81277 },	-- Archer's Precision Grips
                { 4, 81274 },	-- Sightfinder Helm
                { 5, 81273 },	-- Siege-Captain's Scimitar
                { 16, "ac6688" },
            },
        },
        {	--NTPavalak
            EncounterJournalID = 692,
            [NORMAL_DIFF] = {
                { 1, 100961 },	-- Aerial Bombardment Cloak
                { 2, 100962 },	-- Breezebinder Handwraps
                { 3, 100964 },	-- Siegeworn Bracers
                { 4, 100963 },	-- Vial of Ichorous Blood
                { 5, 100960 },	-- Tempestuous Longbow
            },
            [HEROIC_DIFF] = {
                { 1, 81282 },	-- Aerial Bombardment Cloak
                { 2, 81281 },	-- Breezebinder Handwraps
                { 3, 81280 },	-- Siegeworn Bracers
                { 4, 81264 },	-- Vial of Ichorous Blood
                { 5, 81279 },	-- Tempestuous Longbow
                { 16, "ac6485" },
            },
        },
        {	--NTNeronok
            EncounterJournalID = 727,
            [NORMAL_DIFF] = {
                { 1, 100971 },	-- Breezeswept Hood
                { 2, 100972 },	-- Whisperwind Spaulders
                { 3, 100967 },	-- Windblast Helm
                { 4, 100968 },	-- Galedodger Chestguard
                { 5, 100974 },	-- Belt of Totemic Binding
                { 6, 100975 },	-- Airbender Sandals
                { 7, 100970 },	-- Spaulders of Immovable Stone
                { 8, 100969 },	-- Anchoring Sabatons
                { 9, 100965 },	-- Ner'onok's Razor Katar
                { 10, 100973 },	-- Gustwalker Staff
            },
            [HEROIC_DIFF] = {
                { 1, 87547 },
                { 2, 81289 },	-- Breezeswept Hood
                { 3, 81291 },	-- Whisperwind Spaulders
                { 4, 81283 },	-- Windblast Helm
                { 5, 81285 },	-- Galedodger Chestguard
                { 6, 81290 },	-- Belt of Totemic Binding
                { 7, 81292 },	-- Airbender Sandals
                { 8, 81287 },	-- Spaulders of Immovable Stone
                { 9, 81284 },	-- Anchoring Sabatons
                { 10, 81286 },	-- Ner'onok's Razor Katar
                { 11, 81288 },	-- Gustwalker Staff
                { 16, "ac6763" },
                { 17, "ac6822" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["ScarletHallsMoP"] = {
    EncounterJournalID = 311,
    MapID = 6052,
    ContentType = DUNGEON_CONTENT,
    LoadDifficulty = HEROIC_DIFF,
    LevelRange = {90, 90, 90},
    items = {
        {	--SHBraun
            EncounterJournalID = 660,
            -- [NORMAL_DIFF] = "AtlasLootClassic",
            [HEROIC_DIFF] = {
                { 1, 81695 },	-- Hound Trainer's Gloves
                { 2, 81696 },	-- Canine Commander's Breastplate
                { 3, 81694 },	-- Commanding Bracers
                { 4, 81563 },	-- Beastbinder Ring
                { 5, 81693 },	-- Houndmaster's Compound Crossbow
                { 16, "ac6684" },
            },
        },
        {	--SHHarlan
            EncounterJournalID = 654,
            -- [NORMAL_DIFF] = "AtlasLootClassic",
            [HEROIC_DIFF] = {
                { 1, 81699 },	-- Scarlet Sandals
                { 2, 81700 },	-- Lightblade Bracer
                { 3, 81698 },	-- Harlan's Shoulders
                { 4, 81568 },	-- Armsmaster's Sealed Locket
                { 5, 81697 },	-- The Gleaming Ravager
                { 7, 23192, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tabard of the Scarlet Crusade
                { 16, "ac6427" },
            },
        },
        {	--SHKoegler
            EncounterJournalID = 656,
            -- [NORMAL_DIFF] = "AtlasLootClassic",
            [HEROIC_DIFF] = {
                { 1, 87550 },	-- Vithrak, Gaze of the Deadman
                { 2, 82817 },	-- Robes of Koegler
                { 3, 82818 },	-- Vellum-Ripper Gloves
                { 4, 82815 },	-- Bindburner Belt
                { 5, 82819 },	-- Bradbury's Entropic Legguards
                { 6, 82812 },	-- Pyretic Legguards
                { 7, 81564 },	-- Scorched Scarlet Key
                { 8, 81565 },	-- Temperature-Sensing Necklace
                { 9, 82816 },	-- Melted Hypnotic Blade
                { 10, 82813 },	-- Koegler's Ritual Knife
                { 11, 82814 },	-- Mograine's Immaculate Might
                { 13, 87268, [ATLASLOOT_IT_FILTERIGNORE] = true }, -- Codex of the Crusade
                { 15, 82470 }, -- Ancient Tome of Portal: Dalaran
                { 16, "ac6760" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["ScarletMonasteryMoP"] = {
    EncounterJournalID = 316,
    MapID = 6109,
    ContentType = DUNGEON_CONTENT,
    LoadDifficulty = HEROIC_DIFF,
    LevelRange = {90, 90, 90},
    items = {
        {	--SMThalnos
            EncounterJournalID = 688,
            -- [NORMAL_DIFF] = "AtlasLootClassic",
            [HEROIC_DIFF] = {
                { 1, 81571 },	-- Soulrender Greatcloak
                { 2, 81569 },	-- Forgotten Bloodmage Mantle
                { 3, 81570 },	-- Legguards of the Crimson Magus
                { 4, 81572 },	-- Bracers of the Fallen Crusader
                { 5, 81560 },	-- Signet of the Hidden Door
                { 16, "ac6946" },
            },
        },
        {	--SMKorloff
            EncounterJournalID = 671,
            -- [NORMAL_DIFF] = "AtlasLootClassic",
            [HEROIC_DIFF] = {
                { 1, 81575 },	-- Scorched Earth Cloak
                { 2, 81573 },	-- Korloff's Raiment
                { 3, 81574 },	-- Helm of Rising Flame
                { 4, 81561 },	-- Firefinger Ring
                { 5, 81576 },	-- Firestorm Greatstaff
                { 16, "ac6928" },
            },
        },
        {	--SMWhitemane
            EncounterJournalID = 674,
            -- [NORMAL_DIFF] = "AtlasLootClassic",
            [HEROIC_DIFF] = {
                { 1, 87551 },	-- Helios, Durand's Soul of Purity
                { 2, 81692 },	-- Whitemane's Embroidered Chapeau
                { 3, 81689 },	-- Leggings of Hallowed Fire
                { 4, 81690 },	-- Incarnadine Scarlet Spaulders
                { 5, 81688 },	-- Dashing Strike Treads
                { 6, 81578 },	-- Crown of Holy Flame
                { 7, 81687 },	-- Waistplate of Imminent Resurrection
                { 8, 81562 },	-- Triune Signet
                { 9, 81265 },	-- Flashing Steel Talisman
                { 10, 81577 },	-- Lightbreaker Greatsword
                { 11, 81691 },	-- Greatstaff of Righteousness
                { 16, "ac6761" },
                { 17, "ac6929" },
            },
        },
        -- {	--HallowsEndHeadlessHorseman
        -- 	name = AL["Headless Horseman"] .. "(" .. AL["Hallow's End"] .. ")",
        -- 	ExtraList = true,
        -- 	-- [NORMAL_DIFF] = "AtlasLoot_Collections:HallowsEnd:1",
        -- },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["ScholomanceMoP"] = {
    EncounterJournalID = 246,
    MapID = 6066,
    ContentType = DUNGEON_CONTENT,
    LoadDifficulty = HEROIC_DIFF,
    LevelRange = {90, 90, 90},
    items = {
        {	--ScholoChillheart
            EncounterJournalID = 659,
            -- [NORMAL_DIFF] = "AtlasLoot_Classic",
            [HEROIC_DIFF] = {
                { 1, 82823 },	-- Icewrath Belt
                { 2, 82820 },	-- Shadow Puppet Bracers
                { 3, 82821 },	-- Breastplate of Wracking Souls
                { 4, 81566 },	-- Anarchist's Pendant
                { 5, 82822 },	-- Gravetouch Greatsword
            },
        },
        {	--ScholoJandice
            EncounterJournalID = 663,
            -- [NORMAL_DIFF] = "AtlasLoot_Classic",
            [HEROIC_DIFF] = {
                { 1, 82850 },	-- Phantasmal Drape
                { 2, 82848 },	-- Barovian Ritual Hood
                { 3, 82851 },	-- Ghostwoven Legguards
                { 4, 82852 },	-- Wraithplate Treads
                { 5, 82847 },	-- Metanoia Shield
                { 16, "ac6531" },
            },
        },
        {	--ScholoRattlegore
            EncounterJournalID = 665,
            -- [NORMAL_DIFF] = "AtlasLoot_Classic",
            [HEROIC_DIFF] = {
                { 1, 82825 },	-- Deadwalker Bracers
                { 2, 82827 },	-- Rattling Gloves
                { 3, 82828 },	-- Bone Golem Boots
                { 4, 82824 },	-- Goresoaked Headreaper
                { 5, 82826 },	-- Necromantic Wand
                { 16, "ac6394" },
            },
        },
        {	--ScholoVoss
            EncounterJournalID = 666,
            -- [NORMAL_DIFF] = "AtlasLoot_Classic",
            [HEROIC_DIFF] = {
                { 1, 82854 },	-- Leggings of Unleashed Anguish
                { 2, 82853 },	-- Soulburner Crown
                { 3, 82855 },	-- Shivbreaker Vest
                { 4, 82856 },	-- Dark Blaze Gauntlets
                { 5, 81567 },	-- Necklace of the Dark Blaze
            },
        },
        {	--ScholoGandling
            EncounterJournalID = 684,
            -- [NORMAL_DIFF] = "AtlasLoot_Classic",
            [HEROIC_DIFF] = {
                { 1, 82859 },	-- Headmaster's Will
                { 2, 82861 },	-- Incineration Belt
                { 3, 82858 },	-- Tombstone Gauntlets
                { 4, 82860 },	-- Gloves of Explosive Pain
                { 5, 82862 },	-- Shoulderguards of Painful Lessons
                { 6, 82857 },	-- Vigorsteel Spaulders
                { 7, 81268 },	-- Lessons of the Darkmaster
                { 8, 81266 },	-- Price of Progress
                { 9, 81267 },	-- Searing Words
                { 16, "ac6762" },
                { 17, "ac6821" },
            },
        },
        MOP_DUNGEON_HERO_AC_TABLE,
        MOP_GLORY_OF_THE_HERO_AC_TABLE,
    }
}

data["WorldBossesMoP"] = {
    EncounterJournalID = 322,
    Name = AL["World Bosses"],
    ContentType = RAID_CONTENT,
    items = {
        {	--ShaofAnger
            EncounterJournalID = 691,
            [NORMAL_DIFF] = {
                { 1, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
                { 2, 85308 },	-- Eternal Blossom Gloves
                { 3, 85306 },	-- Eternal Blossom Leggings
                { 5, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
                { 6, 85312 },	-- Eternal Blossom Grips
                { 7, 85310 },	-- Eternal Blossom Legguards
                { 9, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
                { 10, 85358 },	-- Eternal Blossom Handwraps
                { 11, 85356 },	-- Eternal Blossom Legwraps
                { 13, "ICON_ability_racial_bearform", nil, ALIL["DRUID"], ALIL["Guardian"] },
                { 14, 85380 },	-- Eternal Blossom Handguards
                { 15, 85382 },	-- Eternal Blossom Breeches
                { 16, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
                { 17, 84843 },	-- Malevolent Gladiator's Wyrmhide Gloves
                { 20, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
                { 21, 84832 },	-- Malevolent Gladiator's Dragonhide Gloves
                { 24, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
                { 25, 84833 },	-- Malevolent Gladiator's Kodohide Gloves
                { 101, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
                { 102, 85297 },	-- Yaungol Slayer's Gloves
                { 103, 85295 },	-- Yaungol Slayer's Legguards
                { 105, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
                { 106, 85378 },	-- Gloves of the Burning Scroll
                { 107, 85376 },	-- Leggings of the Burning Scroll
                { 109, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
                { 110, 85302 },	-- Gloves of the Thousandfold Blades
                { 111, 85300 },	-- Legguards of the Thousandfold Blades
                { 113, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
                { 114, 85369 },	-- Sha-Skin Gloves
                { 115, 85371 },	-- Sha-Skin Leggings
                { 116, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
                { 117, 84841 },	-- Malevolent Gladiator's Chain Gauntlets
                { 120, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
                { 121, 84837 },	-- Malevolent Gladiator's Silk Handguards
                { 124, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
                { 125, 84830 },	-- Malevolent Gladiator's Leather Gloves
                { 128, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
                { 129, 84842 },	-- Malevolent Gladiator's Felweave Handguards
                { 201, "ICON_spell_monk_mistweaver_spec", nil, ALIL["MONK"], ALIL["Mistweaver"] },
                { 202, 85389 },	-- Red Crane Handwraps
                { 203, 85391 },	-- Red Crane Legwraps
                { 205, "ICON_spell_monk_windwalker_spec", nil, ALIL["MONK"], ALIL["Windwalker"] },
                { 206, 85395 },	-- Red Crane Grips
                { 207, 85397 },	-- Red Crane Leggings
                { 209, "ICON_spell_monk_brewmaster_spec", nil, ALIL["MONK"], ALIL["Brewmaster"] },
                { 210, 85387 },	-- Red Crane Gauntlets
                { 211, 85385 },	-- Red Crane Legguards
                { 216, "ICON_spell_monk_mistweaver_spec", nil, ALIL["MONK"], ALIL["Mistweaver"] },
                { 217, 84836 },	-- Malevolent Gladiator's Copperskin Gloves
                { 220, "ICON_spell_monk_windwalker_spec", nil, ALIL["MONK"], ALIL["Windwalker"] },
                { 221, 84839 },	-- Malevolent Gladiator's Ironskin Gloves
                { 301, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
                { 302, 85347 },	-- White Tiger Gloves
                { 303, 85345 },	-- White Tiger Greaves
                { 305, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
                { 306, 85342 },	-- White Tiger Gauntlets
                { 307, 85340 },	-- White Tiger Legplates
                { 309, "ICON_spell_holy_devotionaura", nil, ALIL["PALADIN"], ALIL["Protection"] },
                { 310, 85322 },	-- White Tiger Handguards
                { 311, 85320 },	-- White Tiger Legguards
                { 316, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
                { 317, 84831 },	-- Malevolent Gladiator's Ornamented Gloves
                { 320, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
                { 321, 84834 },	-- Malevolent Gladiator's Scaled Gauntlets
                { 401, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"] .. " / " .. ALIL["Holy"] },
                { 402, 85363 },	-- Guardian Serpent Handwraps
                { 403, 85361 },	-- Guardian Serpent Legwraps
                { 405, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
                { 406, 85364 },	-- Guardian Serpent Gloves
                { 407, 85366 },	-- Guardian Serpent Leggings
                { 416, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"] .. " / " .. ALIL["Holy"] },
                { 417, 84846 },	-- Malevolent Gladiator's Mooncloth Gloves
                { 420, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
                { 421, 84838 },	-- Malevolent Gladiator's Satin Gloves
                { 501, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
                { 502, 85290 },	-- Firebird's Gloves
                { 503, 85292 },	-- Firebird's Kilt
                { 505, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
                { 506, 85287 },	-- Firebird's Grips
                { 507, 85285 },	-- Firebird's Legguards
                { 509, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
                { 510, 85352 },	-- Firebird's Handwraps
                { 511, 85350 },	-- Firebird's Legwraps
                { 516, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
                { 517, 84845 },	-- Malevolent Gladiator's Mail Gauntlets
                { 520, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
                { 521, 84844 },	-- Malevolent Gladiator's Linked Gauntlets
                { 524, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
                { 525, 84847 },	-- Malevolent Gladiator's Ringmail Gauntlets
                { 601, "ICON_spell_deathknight_frostpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Frost"] .. " / " .. ALIL["Unholy"] },
                { 602, 85337 },	-- Gauntlets of the Lost Catacomb
                { 603, 85335 },	-- Greaves of the Lost Catacomb
                { 605, "ICON_spell_deathknight_bloodpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Blood"] },
                { 606, 85317 },	-- Handguards of the Lost Catacomb
                { 607, 85315 },	-- Legguards of the Lost Catacomb
                { 609, "ICON_ability_warrior_innerrage", nil, ALIL["WARRIOR"], ALIL["Arms"] .. " / " .. ALIL["Fury"] },
                { 610, 85331 },	-- Gauntlets of Resounding Rings
                { 611, 85330 },	-- Legplates of Resounding Rings
                { 613, "ICON_ability_warrior_defensivestance", nil, ALIL["WARRIOR"], ALIL["Protection"] },
                { 614, 85327 },	-- Handguards of Resounding Rings
                { 615, 85325 },	-- Legguards of Resounding Rings
                { 616, "ICON_Spell_deathknight_classicon", nil, ALIL["DEATHKNIGHT"], nil },
                { 617, 84835 },	-- Malevolent Gladiator's Dreadplate Gauntlets
                { 624, "ICON_inv_sword_27", nil, ALIL["WARRIOR"], nil },
                { 625, 84840 },	-- Malevolent Gladiator's Plate Gauntlets
                { 701, 84977 },	-- Malevolent Gladiator's Cuffs of Accuracy
                { 702, 84955 },	-- Malevolent Gladiator's Cord of Accuracy
                { 703, 84815 },	-- Malevolent Gladiator's Treads of Alacrity
                { 705, 84979 },	-- Malevolent Gladiator's Cuffs of Meditation
                { 706, 84956 },	-- Malevolent Gladiator's Cord of Meditation
                { 707, 84816 },	-- Malevolent Gladiator's Treads of Meditation
                { 709, 84978 },	-- Malevolent Gladiator's Cuffs of Prowess
                { 710, 84954 },	-- Malevolent Gladiator's Cord of Cruelty
                { 711, 84814 },	-- Malevolent Gladiator's Treads of Cruelty
                { 716, 84973 },	-- Malevolent Gladiator's Armwraps of Accuracy
                { 717, 84948 },	-- Malevolent Gladiator's Waistband of Accuracy
                { 718, 84808 },	-- Malevolent Gladiator's Boots of Cruelty
                { 720, 84972 },	-- Malevolent Gladiator's Armwraps of Alacrity
                { 721, 84947 },	-- Malevolent Gladiator's Waistband of Cruelty
                { 722, 84809 },	-- Malevolent Gladiator's Boots of Alacrity
                { 724, 84982 },	-- Malevolent Gladiator's Bindings of Prowess
                { 725, 84960 },	-- Malevolent Gladiator's Belt of Cruelty
                { 726, 84819 },	-- Malevolent Gladiator's Footguards of Alacrity
                { 728, 84976 },	-- Malevolent Gladiator's Bindings of Meditation
                { 729, 84953 },	-- Malevolent Gladiator's Belt of Meditation
                { 730, 84813 },	-- Malevolent Gladiator's Footguards of Meditation
                { 801, 84984 },	-- Malevolent Gladiator's Armbands of Meditation
                { 802, 84946 },	-- Malevolent Gladiator's Waistguard of Meditation
                { 803, 84821 },	-- Malevolent Gladiator's Footguards of Meditation
                { 805, 84983 },	-- Malevolent Gladiator's Armbands of Prowess
                { 806, 84959 },	-- Malevolent Gladiator's Waistguard of Cruelty
                { 807, 84820 },	-- Malevolent Gladiator's Footguards of Alacrity
                { 809, 84980 },	-- Malevolent Gladiator's Wristguards of Alacrity
                { 810, 84958 },	-- Malevolent Gladiator's Links of Cruelty
                { 811, 84818 },	-- Malevolent Gladiator's Sabatons of Alacrity
                { 813, 84981 },	-- Malevolent Gladiator's Wristguards of Accuracy
                { 814, 84957 },	-- Malevolent Gladiator's Links of Accuracy
                { 815, 84817 },	-- Malevolent Gladiator's Sabatons of Cruelty
                { 816, 84975 },	-- Malevolent Gladiator's Bracers of Meditation
                { 817, 84952 },	-- Malevolent Gladiator's Clasp of Meditation
                { 818, 84812 },	-- Malevolent Gladiator's Greaves of Meditation
                { 820, 84985 },	-- Malevolent Gladiator's Armplates of Proficiency
                { 821, 84949 },	-- Malevolent Gladiator's Girdle of Accuracy
                { 822, 84810 },	-- Malevolent Gladiator's Warboots of Cruelty
                { 824, 84974 },	-- Malevolent Gladiator's Bracers of Prowess
                { 825, 84951 },	-- Malevolent Gladiator's Clasp of Cruelty
                { 826, 84811 },	-- Malevolent Gladiator's Greaves of Alacrity
                { 828, 84986 },	-- Malevolent Gladiator's Armplates of Alacrity
                { 829, 84950 },	-- Malevolent Gladiator's Girdle of Prowess
                { 830, 84822 },	-- Malevolent Gladiator's Warboots of Alacrity
                { 901, 84804 },	-- Malevolent Gladiator's Cape of Cruelty
                { 902, 84805 },	-- Malevolent Gladiator's Cape of Prowess
                { 903, 84807 },	-- Malevolent Gladiator's Cloak of Alacrity
                { 904, 84806 },	-- Malevolent Gladiator's Cloak of Prowess
                { 905, 84801 },	-- Malevolent Gladiator's Drape of Cruelty
                { 906, 84802 },	-- Malevolent Gladiator's Drape of Meditation
                { 907, 84803 },	-- Malevolent Gladiator's Drape of Prowess
                { 909, 84892 },	-- Malevolent Gladiator's Choker of Accuracy
                { 910, 84891 },	-- Malevolent Gladiator's Choker of Proficiency
                { 911, 84889 },	-- Malevolent Gladiator's Necklace of Proficiency
                { 912, 84890 },	-- Malevolent Gladiator's Necklace of Prowess
                { 913, 84886 },	-- Malevolent Gladiator's Pendant of Alacrity
                { 914, 84887 },	-- Malevolent Gladiator's Pendant of Cruelty
                { 915, 84888 },	-- Malevolent Gladiator's Pendant of Meditation
                { 916, 84824 },	-- Malevolent Gladiator's Band of Accuracy
                { 917, 84823 },	-- Malevolent Gladiator's Band of Cruelty
                { 918, 84825 },	-- Malevolent Gladiator's Band of Meditation
                { 919, 84827 },	-- Malevolent Gladiator's Ring of Accuracy
                { 920, 84826 },	-- Malevolent Gladiator's Ring of Cruelty
                { 921, 84829 },	-- Malevolent Gladiator's Signet of Accuracy
                { 922, 84828 },	-- Malevolent Gladiator's Signet of Cruelty
                { 1001, 89317 },	-- Claw of Anger
                { 1002, 90911 },	-- Furyheart Treads
                { 1003, 90913 },	-- Sandals of the Shadow
                { 1004, 90914 },	-- Boots of Raging Haze
                { 1005, 90908 },	-- Crushing Treads of Anger
                { 1006, 90907 },	-- Boots of Unbreakable Umbrage
                { 1007, 90906 };	-- Treads of Ardent Antagonism
                { 1008, 90912 },	-- Angerforged Stompers
                { 1009, 90909 };	-- Intemperate Greatboots
                { 1010, 90910 },	-- Mindfire Sollerets
                { 1016, 87771 },	-- Reins of the Heavenly Onyx Cloud Serpent
                { 1017, 90839 },	-- Cache of Sha-Touched Gold
                { 1019, "ac6480" },
            },
        },
        {	--SalyisWarband
            EncounterJournalID = 725,
            [NORMAL_DIFF] = {
                { 1, 90408 },	-- Free Spirit Hood
                { 2, 90409 },	-- Sky-Sear Cowl
                { 3, 90417 },	-- Robes of Blue Skies
                { 4, 90418 },	-- Robes of the Lightning Rider
                { 5, 90449 },	-- Belt of Detonation
                { 6, 90448 },	-- Cannonfire Cord
                { 7, 90439 },	-- Open Steppe Sandals
                { 8, 90440 },	-- Slippers of Fiery Retribution
                { 10, 90413 },	-- Crest of the Grand Warband
                { 11, 90412 },	-- Helm of Restoring Wind
                { 12, 90422 },	-- Armor of the Single Cloud
                { 13, 90421 },	-- Chain of Unsiezed Skies
                { 16, 90410 },	-- Cap of Wandering Pride
                { 17, 90411 },	-- Facemask of Unrepentant Banditry
                { 18, 90419 },	-- Fireproofed Chestguard
                { 19, 90420 },	-- Flameshot Wrap
                { 20, 90451 },	-- Cannoneer's Gunpowder Carrier
                { 21, 90450 },	-- Carrot-Holder Belt
                { 22, 90442 },	-- Flamefoot Tabi
                { 23, 90441 },	-- Stompdodger Boots
                { 25, 90453 },	-- Girdle of the Raging Rider
                { 26, 90452 },	-- Sparkmaker Girdle
                { 27, 90443 },	-- Burnmender Boots
                { 28, 90444 },	-- Treads of Gentle Nudges
                { 30, "ac6517" },
                { 101, 90416 },	-- Crown of Ranging Invasion
                { 102, 90415 },	-- Giantfoot Headguard
                { 103, 90414 },	-- Greathelm of the Monstrous Mushan
                { 104, 90425 },	-- Carapace of Crushed Conviction
                { 105, 90423 },	-- Chestguard of the Unbowed Back
                { 106, 90424 },	-- Ravaging Warrior's Chestplate
                { 107, 90456 },	-- Cord of Crazed Strength
                { 108, 90454 },	-- Girdle of the Galloping Giant
                { 109, 90455 },	-- Greatbelt of Livid Fury
                { 110, 90445 },	-- Firerider Treads
                { 111, 90446 },	-- Silverspur Warboots
                { 112, 90447 },	-- Stompers of Vigorous Stomping
                { 116, 90432 },	-- Hellrider's Choker
                { 117, 90433 },	-- Mushan Rider's Collar
                { 118, 90429 },	-- Necklace of Imbued Fury
                { 119, 90431 },	-- Saddlebinder Links
                { 120, 90430 },	-- Stomphowl Pendant
                { 122, 90436 },	-- Circle of Scaled Fury
                { 123, 90437 },	-- Hereditary Saurok Loop
                { 124, 90435 },	-- Ring of Wretched Flames
                { 125, 90438 },	-- Signet of the Bandit Lord
                { 126, 90434 },	-- Steaming Seal of Flame
                { 128, 89783,},	-- Son of Galleon's Saddle
                { 129, 90840 },	-- Marauder's Gleaming Sack of Gold
            },
        },
        {	--Nalak
            EncounterJournalID = 814,
            [NORMAL_DIFF] = {
                { 1, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
                { 2, 95245 },	-- Gloves of the Haunted Forest
                { 3, 95247 },	-- Leggings of the Haunted Forest
                { 5, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
                { 6, 95236 },	-- Grips of the Haunted Forest
                { 7, 95238 },	-- Legguards of the Haunted Forest
                { 9, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
                { 10, 95240 },	-- Handwraps of the Haunted Forest
                { 11, 95242 },	-- Legwraps of the Haunted Forest
                { 13, "ICON_ability_racial_bearform", nil, ALIL["DRUID"], ALIL["Guardian"] },
                { 14, 95251 },	-- Handguards of the Haunted Forest
                { 15, 95253 },	-- Breeches of the Haunted Forest
                { 16, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
                { 17, [ATLASLOOT_IT_ALLIANCE] = 91189, [ATLASLOOT_IT_HORDE] = 94412 },	-- Tyrannical Gladiator's Wyrmhide Gloves
                { 18, [ATLASLOOT_IT_ALLIANCE] = 91193, [ATLASLOOT_IT_HORDE] = 94483 },	-- Tyrannical Gladiator's Wyrmhide Legguards
                { 20, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
                { 21, [ATLASLOOT_IT_ALLIANCE] = 91157, [ATLASLOOT_IT_HORDE] = 94455 },	-- Tyrannical Gladiator's Dragonhide Gloves
                { 22, [ATLASLOOT_IT_ALLIANCE] = 91161, [ATLASLOOT_IT_HORDE] = 94368 },	-- Tyrannical Gladiator's Dragonhide Legguards
                { 24, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
                { 25, [ATLASLOOT_IT_ALLIANCE] = 91172, [ATLASLOOT_IT_HORDE] = 94371 },	-- Tyrannical Gladiator's Kodohide Gloves
                { 26, [ATLASLOOT_IT_ALLIANCE] = 91176, [ATLASLOOT_IT_HORDE] = 94477 },	-- Tyrannical Gladiator's Kodohide Legguards
                { 101, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
                { 102, 95256 },	-- Saurok Stalker's Gloves
                { 103, 95258 },	-- Saurok Stalker's Legguards
                { 105, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
                { 106, 95260 },	-- Gloves of the Chromatic Hydra
                { 107, 95262 },	-- Leggings of the Chromatic Hydra
                { 109, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
                { 110, 95306 },	-- Nine-Tailed Gloves
                { 111, 95308 },	-- Nine-Tailed Legguards
                { 113, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
                { 114, 95325 },	-- Gloves of the Thousandfold Hells
                { 115, 95327 },	-- Leggings of the Thousandfold Hells
                { 116, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
                { 117, [ATLASLOOT_IT_ALLIANCE] = 91224, [ATLASLOOT_IT_HORDE] = 94453 },	-- Tyrannical Gladiator's Chain Gauntlets
                { 118, [ATLASLOOT_IT_ALLIANCE] = 91228, [ATLASLOOT_IT_HORDE] = 94384 },	-- Tyrannical Gladiator's Chain Leggings
                { 120, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
                { 121, [ATLASLOOT_IT_ALLIANCE] = 91232, [ATLASLOOT_IT_HORDE] = 94451 },	-- Tyrannical Gladiator's Silk Handguards
                { 122, [ATLASLOOT_IT_ALLIANCE] = 91236, [ATLASLOOT_IT_HORDE] = 94362 },	-- Tyrannical Gladiator's Silk Trousers
                { 124, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
                { 125, [ATLASLOOT_IT_ALLIANCE] = 91342, [ATLASLOOT_IT_HORDE] = 94377 },	-- Tyrannical Gladiator's Leather Gloves
                { 126, [ATLASLOOT_IT_ALLIANCE] = 91346, [ATLASLOOT_IT_HORDE] = 94446 },	-- Tyrannical Gladiator's Leather Legguards
                { 128, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
                { 129, [ATLASLOOT_IT_ALLIANCE] = 91420, [ATLASLOOT_IT_HORDE] = 94441 },	-- Tyrannical Gladiator's Felweave Handguards
                { 130, [ATLASLOOT_IT_ALLIANCE] = 91424, [ATLASLOOT_IT_HORDE] = 94471 },	-- Tyrannical Gladiator's Felweave Trousers
                { 201, "ICON_spell_monk_mistweaver_spec", nil, ALIL["MONK"], ALIL["Mistweaver"] },
                { 202, 95270 },	-- Fire-Charm Handwraps
                { 203, 95272 },	-- Fire-Charm Legwraps
                { 205, "ICON_spell_monk_windwalker_spec", nil, ALIL["MONK"], ALIL["Windwalker"] },
                { 206, 95266 },	-- Fire-Charm Grips
                { 207, 95268 },	-- Fire-Charm Leggings
                { 209, "ICON_spell_monk_brewmaster_spec", nil, ALIL["MONK"], ALIL["Brewmaster"] },
                { 210, 95276 },	-- Fire-Charm Gauntlets
                { 211, 95278 },	-- Fire-Charm Legguards
                { 216, "ICON_spell_monk_mistweaver_spec", nil, ALIL["MONK"], ALIL["Mistweaver"] },
                { 217, [ATLASLOOT_IT_ALLIANCE] = 91257, [ATLASLOOT_IT_HORDE] = 94340 },	-- Tyrannical Gladiator's Copperskin Gloves
                { 218, [ATLASLOOT_IT_ALLIANCE] = 91261, [ATLASLOOT_IT_HORDE] = 94478 },	-- Tyrannical Gladiator's Copperskin Legguards
                { 220, "ICON_spell_monk_windwalker_spec", nil, ALIL["MONK"], ALIL["Windwalker"] },
                { 221, [ATLASLOOT_IT_ALLIANCE] = 91247, [ATLASLOOT_IT_HORDE] = 94391 },	-- Tyrannical Gladiator's Ironskin Gloves
                { 222, [ATLASLOOT_IT_ALLIANCE] = 91251, [ATLASLOOT_IT_HORDE] = 94370 },	-- Tyrannical Gladiator's Ironskin Legguards
                { 301, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
                { 302, 95286 },	-- Lightning Emperor's Gloves
                { 303, 95288 },	-- Lightning Emperor's Greaves
                { 305, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
                { 306, 95281 },	-- Lightning Emperor's Gauntlets
                { 307, 95283 },	-- Lightning Emperor's Legplates
                { 309, "ICON_spell_holy_devotionaura", nil, ALIL["PALADIN"], ALIL["Protection"] },
                { 310, 95291 },	-- Lightning Emperor's Handguards
                { 311, 95293 },	-- Lightning Emperor's Legguards
                { 316, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
                { 317, [ATLASLOOT_IT_ALLIANCE] = 91289, [ATLASLOOT_IT_HORDE] = 94438 },	-- Tyrannical Gladiator's Ornamented Gloves
                { 318, [ATLASLOOT_IT_ALLIANCE] = 91293, [ATLASLOOT_IT_HORDE] = 94484 },	-- Tyrannical Gladiator's Ornamented Legplates
                { 320, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
                { 321, [ATLASLOOT_IT_ALLIANCE] = 91269, [ATLASLOOT_IT_HORDE] = 94343 },	-- Tyrannical Gladiator's Scaled Gauntlets
                { 322, [ATLASLOOT_IT_ALLIANCE] = 91273, [ATLASLOOT_IT_HORDE] = 94496 },	-- Tyrannical Gladiator's Scaled Legguards
                { 401, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"] .. " / " .. ALIL["Holy"] },
                { 402, 95295 },	-- Handwraps of the Exorcist
                { 403, 95297 },	-- Legwraps of the Exorcist
                { 405, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
                { 406, 95300 },	-- Gloves of the Exorcist
                { 407, 95302 },	-- Leggings of the Exorcist
                { 416, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"] .. " / " .. ALIL["Holy"] },
                { 417, [ATLASLOOT_IT_ALLIANCE] = 91309, [ATLASLOOT_IT_HORDE] = 94328 },	-- Tyrannical Gladiator's Mooncloth Gloves
                { 418, [ATLASLOOT_IT_ALLIANCE] = 91313, [ATLASLOOT_IT_HORDE] = 94420 },	-- Tyrannical Gladiator's Mooncloth Leggings
                { 420, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
                { 421, [ATLASLOOT_IT_ALLIANCE] = 91319, [ATLASLOOT_IT_HORDE] = 94423 },	-- Tyrannical Gladiator's Satin Gloves
                { 422, [ATLASLOOT_IT_ALLIANCE] = 91323, [ATLASLOOT_IT_HORDE] = 94334 },	-- Tyrannical Gladiator's Satin Leggings
                { 501, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
                { 502, 95321 },	-- Gloves of the Witch Doctor
                { 503, 95323 },	-- Kilt of the Witch Doctor
                { 505, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
                { 506, 95316 },	-- Grips of the Witch Doctor
                { 507, 95318 },	-- Legguards of the Witch Doctor
                { 509, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
                { 510, 95311 },	-- Handwraps of the Witch Doctor
                { 511, 95313 },	-- Legwraps of the Witch Doctor
                { 516, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
                { 517, [ATLASLOOT_IT_ALLIANCE] = 91382, [ATLASLOOT_IT_HORDE] = 94408 },	-- Tyrannical Gladiator's Mail Gauntlets
                { 518, [ATLASLOOT_IT_ALLIANCE] = 91386, [ATLASLOOT_IT_HORDE] = 94497 },	-- Tyrannical Gladiator's Mail Leggings
                { 520, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
                { 521, [ATLASLOOT_IT_ALLIANCE] = 91370, [ATLASLOOT_IT_HORDE] = 94458 },	-- Tyrannical Gladiator's Linked Gauntlets
                { 522, [ATLASLOOT_IT_ALLIANCE] = 91374, [ATLASLOOT_IT_HORDE] = 94494 },	-- Tyrannical Gladiator's Linked Leggings
                { 524, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
                { 525, [ATLASLOOT_IT_ALLIANCE] = 91360, [ATLASLOOT_IT_HORDE] = 94490 },	-- Tyrannical Gladiator's Ringmail Gauntlets
                { 526, [ATLASLOOT_IT_ALLIANCE] = 91364, [ATLASLOOT_IT_HORDE] = 94435 },	-- Tyrannical Gladiator's Ringmail Leggings
                { 601, "ICON_spell_deathknight_frostpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Frost"] .. " / " .. ALIL["Unholy"] },
                { 602, 95226 },	-- Gauntlets of the All-Consuming Maw
                { 603, 95228 },	-- Greaves of the All-Consuming Maw
                { 605, "ICON_spell_deathknight_bloodpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Blood"] },
                { 606, 95231 },	-- Handguards of the All-Consuming Maw
                { 607, 95233 },	-- Legguards of the All-Consuming Maw
                { 609, "ICON_ability_warrior_innerrage", nil, ALIL["WARRIOR"], ALIL["Arms"] .. " / " .. ALIL["Fury"] },
                { 610, 95332 },	-- Gauntlets of the Last Mogu
                { 611, 95333 },	-- Legplates of the Last Mogu
                { 613, "ICON_ability_warrior_defensivestance", nil, ALIL["WARRIOR"], ALIL["Protection"] },
                { 614, 95336 },	-- Handguards of the Last Mogu
                { 615, 95338 },	-- Legguards of the Last Mogu
                { 616, "ICON_Spell_deathknight_classicon", nil, ALIL["DEATHKNIGHT"], nil },
                { 617, [ATLASLOOT_IT_ALLIANCE] = 91149, [ATLASLOOT_IT_HORDE] = 94364 },	-- Tyrannical Gladiator's Dreadplate Gauntlets
                { 618, [ATLASLOOT_IT_ALLIANCE] = 91153, [ATLASLOOT_IT_HORDE] = 94365 },	-- Tyrannical Gladiator's Dreadplate Legguards
                { 624, "ICON_inv_sword_27", nil, ALIL["WARRIOR"], nil },
                { 625, [ATLASLOOT_IT_ALLIANCE] = 91432, [ATLASLOOT_IT_HORDE] = 94331 },	-- Tyrannical Gladiator's Plate Gauntlets
                { 626, [ATLASLOOT_IT_ALLIANCE] = 91436, [ATLASLOOT_IT_HORDE] = 94448 },	-- Tyrannical Gladiator's Plate Legguards
                { 701, [ATLASLOOT_IT_ALLIANCE] = 91121, [ATLASLOOT_IT_HORDE] = 94403 },	-- Tyrannical Gladiator's Cuffs of Accuracy
                { 702, [ATLASLOOT_IT_ALLIANCE] = 91111, [ATLASLOOT_IT_HORDE] = 94376 },	-- Tyrannical Gladiator's Cord of Accuracy
                { 703, [ATLASLOOT_IT_ALLIANCE] = 91117, [ATLASLOOT_IT_HORDE] = 94333 },	-- Tyrannical Gladiator's Treads of Alacrity
                { 705, [ATLASLOOT_IT_ALLIANCE] = 91123, [ATLASLOOT_IT_HORDE] = 94380 },	-- Tyrannical Gladiator's Cuffs of Meditation
                { 706, [ATLASLOOT_IT_ALLIANCE] = 91113, [ATLASLOOT_IT_HORDE] = 94425 },	-- Tyrannical Gladiator's Cord of Meditation
                { 707, [ATLASLOOT_IT_ALLIANCE] = 91119, [ATLASLOOT_IT_HORDE] = 94468 },	-- Tyrannical Gladiator's Treads of Meditation
                { 709, [ATLASLOOT_IT_ALLIANCE] = 91122, [ATLASLOOT_IT_HORDE] = 94449 },	-- Tyrannical Gladiator's Cuffs of Prowess
                { 710, [ATLASLOOT_IT_ALLIANCE] = 91109, [ATLASLOOT_IT_HORDE] = 94400 },	-- Tyrannical Gladiator's Cord of Cruelty
                { 711, [ATLASLOOT_IT_ALLIANCE] = 91115, [ATLASLOOT_IT_HORDE] = 94402 },	-- Tyrannical Gladiator's Treads of Cruelty
                { 716, [ATLASLOOT_IT_ALLIANCE] = 91246, [ATLASLOOT_IT_HORDE] = 94427 },	-- Tyrannical Gladiator's Armwraps of Accuracy
                { 717, [ATLASLOOT_IT_ALLIANCE] = 91335, [ATLASLOOT_IT_HORDE] = 94424 },	-- Tyrannical Gladiator's Waistband of Accuracy
                { 718, [ATLASLOOT_IT_ALLIANCE] = 91337, [ATLASLOOT_IT_HORDE] = 94374 },	-- Tyrannical Gladiator's Boots of Cruelty
                { 720, [ATLASLOOT_IT_ALLIANCE] = 91339, [ATLASLOOT_IT_HORDE] = 94470 },	-- Tyrannical Gladiator's Armwraps of Alacrity
                { 721, [ATLASLOOT_IT_ALLIANCE] = 91242, [ATLASLOOT_IT_HORDE] = 94360 },	-- Tyrannical Gladiator's Waistband of Cruelty
                { 722, [ATLASLOOT_IT_ALLIANCE] = 91244, [ATLASLOOT_IT_HORDE] = 94432 },	-- Tyrannical Gladiator's Boots of Alacrity
                { 724, [ATLASLOOT_IT_ALLIANCE] = 91188, [ATLASLOOT_IT_HORDE] = 94439 },	-- Tyrannical Gladiator's Bindings of Prowess
                { 725, [ATLASLOOT_IT_ALLIANCE] = 91184, [ATLASLOOT_IT_HORDE] = 94410 },	-- Tyrannical Gladiator's Belt of Cruelty
                { 726, [ATLASLOOT_IT_ALLIANCE] = 91186, [ATLASLOOT_IT_HORDE] = 94344 },	-- Tyrannical Gladiator's Footguards of Alacrity
                { 728, [ATLASLOOT_IT_ALLIANCE] = 91171, [ATLASLOOT_IT_HORDE] = 94407 },	-- Tyrannical Gladiator's Bindings of Meditation
                { 729, [ATLASLOOT_IT_ALLIANCE] = 91167, [ATLASLOOT_IT_HORDE] = 94491 },	-- Tyrannical Gladiator's Belt of Meditation
                { 730, [ATLASLOOT_IT_ALLIANCE] = 91169, [ATLASLOOT_IT_HORDE] = 94476 },	-- Tyrannical Gladiator's Footguards of Meditation
                { 801, [ATLASLOOT_IT_ALLIANCE] = 91357, [ATLASLOOT_IT_HORDE] = 94337 },	-- Tyrannical Gladiator's Armbands of Meditation
                { 802, [ATLASLOOT_IT_ALLIANCE] = 91350, [ATLASLOOT_IT_HORDE] = 94382 },	-- Tyrannical Gladiator's Waistguard of Meditation
                { 803, [ATLASLOOT_IT_ALLIANCE] = 91354, [ATLASLOOT_IT_HORDE] = 94336 },	-- Tyrannical Gladiator's Footguards of Meditation
                { 805, [ATLASLOOT_IT_ALLIANCE] = 91356, [ATLASLOOT_IT_HORDE] = 94379 },	-- Tyrannical Gladiator's Armbands of Prowess
                { 806, [ATLASLOOT_IT_ALLIANCE] = 91378, [ATLASLOOT_IT_HORDE] = 94393 },	-- Tyrannical Gladiator's Waistguard of Cruelty
                { 807, [ATLASLOOT_IT_ALLIANCE] = 91352, [ATLASLOOT_IT_HORDE] = 94378 },	-- Tyrannical Gladiator's Footguards of Alacrity
                { 809, [ATLASLOOT_IT_ALLIANCE] = 91220, [ATLASLOOT_IT_HORDE] = 94404 },	-- Tyrannical Gladiator's Wristguards of Alacrity
                { 810, [ATLASLOOT_IT_ALLIANCE] = 91212, [ATLASLOOT_IT_HORDE] = 94330 },	-- Tyrannical Gladiator's Links of Cruelty
                { 811, [ATLASLOOT_IT_ALLIANCE] = 91218, [ATLASLOOT_IT_HORDE] = 94359 },	-- Tyrannical Gladiator's Sabatons of Alacrity
                { 813, [ATLASLOOT_IT_ALLIANCE] = 91221, [ATLASLOOT_IT_HORDE] = 94469 },	-- Tyrannical Gladiator's Wristguards of Accuracy
                { 814, [ATLASLOOT_IT_ALLIANCE] = 91214, [ATLASLOOT_IT_HORDE] = 94358 },	-- Tyrannical Gladiator's Links of Accuracy
                { 815, [ATLASLOOT_IT_ALLIANCE] = 91216, [ATLASLOOT_IT_HORDE] = 94445 },	-- Tyrannical Gladiator's Sabatons of Cruelty
                { 816, [ATLASLOOT_IT_ALLIANCE] = 91286, [ATLASLOOT_IT_HORDE] = 94481 },	-- Tyrannical Gladiator's Bracers of Meditation
                { 817, [ATLASLOOT_IT_ALLIANCE] = 91279, [ATLASLOOT_IT_HORDE] = 94464 },	-- Tyrannical Gladiator's Clasp of Meditation
                { 818, [ATLASLOOT_IT_ALLIANCE] = 91283, [ATLASLOOT_IT_HORDE] = 94352 },	-- Tyrannical Gladiator's Greaves of Meditation
                { 820, [ATLASLOOT_IT_ALLIANCE] = 91305, [ATLASLOOT_IT_HORDE] = 94418 },	-- Tyrannical Gladiator's Armplates of Proficiency
                { 821, [ATLASLOOT_IT_ALLIANCE] = 91297, [ATLASLOOT_IT_HORDE] = 94353 },	-- Tyrannical Gladiator's Girdle of Accuracy
                { 822, [ATLASLOOT_IT_ALLIANCE] = 91301, [ATLASLOOT_IT_HORDE] = 94414 },	-- Tyrannical Gladiator's Warboots of Cruelty
                { 824, [ATLASLOOT_IT_ALLIANCE] = 91285, [ATLASLOOT_IT_HORDE] = 94411 },	-- Tyrannical Gladiator's Bracers of Prowess
                { 825, [ATLASLOOT_IT_ALLIANCE] = 91277, [ATLASLOOT_IT_HORDE] = 94480 },	-- Tyrannical Gladiator's Clasp of Cruelty
                { 826, [ATLASLOOT_IT_ALLIANCE] = 91281, [ATLASLOOT_IT_HORDE] = 94351 },	-- Tyrannical Gladiator's Greaves of Alacrity
                { 828, [ATLASLOOT_IT_ALLIANCE] = 91306, [ATLASLOOT_IT_HORDE] = 94487 },	-- Tyrannical Gladiator's Armplates of Alacrity
                { 829, [ATLASLOOT_IT_ALLIANCE] = 91299, [ATLASLOOT_IT_HORDE] = 94440 },	-- Tyrannical Gladiator's Girdle of Prowess
                { 830, [ATLASLOOT_IT_ALLIANCE] = 91303, [ATLASLOOT_IT_HORDE] = 94461 },	-- Tyrannical Gladiator's Warboots of Alacrity
                { 901, [ATLASLOOT_IT_ALLIANCE] = 91100, [ATLASLOOT_IT_HORDE] = 94421 },	-- Tyrannical Gladiator's Cape of Cruelty
                { 902, [ATLASLOOT_IT_ALLIANCE] = 91101, [ATLASLOOT_IT_HORDE] = 94355 },	-- Tyrannical Gladiator's Cape of Prowess
                { 903, [ATLASLOOT_IT_ALLIANCE] = 91411, [ATLASLOOT_IT_HORDE] = 94485 },	-- Tyrannical Gladiator's Cloak of Alacrity
                { 904, [ATLASLOOT_IT_ALLIANCE] = 91412, [ATLASLOOT_IT_HORDE] = 94486 },	-- Tyrannical Gladiator's Cloak of Prowess
                { 905, [ATLASLOOT_IT_ALLIANCE] = 91124, [ATLASLOOT_IT_HORDE] = 94383 },	-- Tyrannical Gladiator's Drape of Cruelty
                { 906, [ATLASLOOT_IT_ALLIANCE] = 91126, [ATLASLOOT_IT_HORDE] = 94472 },	-- Tyrannical Gladiator's Drape of Meditation
                { 907, [ATLASLOOT_IT_ALLIANCE] = 91125, [ATLASLOOT_IT_HORDE] = 94488 },	-- Tyrannical Gladiator's Drape of Prowess
                { 909, [ATLASLOOT_IT_ALLIANCE] = 91414, [ATLASLOOT_IT_HORDE] = 94354 },	-- Tyrannical Gladiator's Choker of Accuracy
                { 910, [ATLASLOOT_IT_ALLIANCE] = 91413, [ATLASLOOT_IT_HORDE] = 94465 },	-- Tyrannical Gladiator's Choker of Proficiency
                { 911, [ATLASLOOT_IT_ALLIANCE] = 91102, [ATLASLOOT_IT_HORDE] = 94394 },	-- Tyrannical Gladiator's Necklace of Proficiency
                { 912, [ATLASLOOT_IT_ALLIANCE] = 91103, [ATLASLOOT_IT_HORDE] = 94395 },	-- Tyrannical Gladiator's Necklace of Prowess
                { 913, [ATLASLOOT_IT_ALLIANCE] = 91136, [ATLASLOOT_IT_HORDE] = 94473 },	-- Tyrannical Gladiator's Pendant of Alacrity
                { 914, [ATLASLOOT_IT_ALLIANCE] = 91135, [ATLASLOOT_IT_HORDE] = 94489 },	-- Tyrannical Gladiator's Pendant of Cruelty
                { 915, [ATLASLOOT_IT_ALLIANCE] = 91137, [ATLASLOOT_IT_HORDE] = 94452 },	-- Tyrannical Gladiator's Pendant of Meditation
                { 916, [ATLASLOOT_IT_ALLIANCE] = 91139, [ATLASLOOT_IT_HORDE] = 94363 },	-- Tyrannical Gladiator's Band of Accuracy
                { 917, [ATLASLOOT_IT_ALLIANCE] = 91138, [ATLASLOOT_IT_HORDE] = 94390 },	-- Tyrannical Gladiator's Band of Cruelty
                { 918, [ATLASLOOT_IT_ALLIANCE] = 91140, [ATLASLOOT_IT_HORDE] = 94474 },	-- Tyrannical Gladiator's Band of Meditation
                { 919, [ATLASLOOT_IT_ALLIANCE] = 91106, [ATLASLOOT_IT_HORDE] = 94399 },	-- Tyrannical Gladiator's Ring of Accuracy
                { 920, [ATLASLOOT_IT_ALLIANCE] = 91105, [ATLASLOOT_IT_HORDE] = 94357 },	-- Tyrannical Gladiator's Ring of Cruelty
                { 921, [ATLASLOOT_IT_ALLIANCE] = 91417, [ATLASLOOT_IT_HORDE] = 94462 },	-- Tyrannical Gladiator's Signet of Accuracy
                { 922, [ATLASLOOT_IT_ALLIANCE] = 91416, [ATLASLOOT_IT_HORDE] = 94417 },	-- Tyrannical Gladiator's Signet of Cruelty
                { 924, 95057 },	-- Reins of the Thundering Cobalt Cloud Serpent
                { 925, 95602, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stormtouched Cache
                { 927, "ac8028" },
            },
        },
        {	--Oondasta
            EncounterJournalID = 826,
            [NORMAL_DIFF] = {
                { 1, 95182 },	-- Robes of Zalmoxes
                { 2, 95183 },	-- Waistband of Elder Falcarius
                { 3, 95194 },	-- Gloves of Tyranomancy
                { 4, 95193 },	-- Gloves of Varsoon the Greater
                { 5, 95184 },	-- Girdle of Dimorphodontics
                { 6, 95185 },	-- Terrorful Weave
                { 8, 95147 },	-- Fancifully Frilled Tunic
                { 9, 95148 },	-- Vest of the Bordomorono
                { 10, 95196 },	-- Gloves of Gastric Rumbling
                { 11, 95195 },	-- Gloves of Unliving Fossil
                { 12, 95186 },	-- Belt of Crushed Dreams
                { 13, 95187 },	-- Girdle of the Derrodoccus
                { 16, 95149 },	-- Gorgoraptor Scale Chest
                { 17, 95150 },	-- Mail of the Mosschopper
                { 18, 95200 },	-- Orndo Mando's Gloves
                { 19, 95197 },	-- Therapsid Scale Gloves
                { 20, 95188 },	-- Belt of the Arch Avimimus
                { 21, 95189 },	-- Belt of the Dying Diemetradon
                { 23, "ac8123" },
                { 101, 95152 },	-- Breastplate of the Iguanocolossus
                { 102, 95151 },	-- Scorched Spiritfire Drape
                { 103, 95153 },	-- Tyrant King Battleplate
                { 104, 95199 },	-- Carnotaur Battlegloves
                { 105, 95201 },	-- Skullsmashing Gauntlets
                { 106, 95198 },	-- Vulcanodon Gauntlets
                { 107, 95192 },	-- Belt of the Tyrannotitan
                { 108, 95191 },	-- Voolar's Bloodied Belt
                { 109, 95190 },	-- Waistband of Furious Stomping
                { 111, 94228 },	-- Reins of the Cobalt Primordial Direhorn
                { 112, 95601, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shiny Pile of Refuse
                { 113, 94295, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Primal Egg
                { 114, 94288, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Giant Dinosaur Bone
                { 116, 95181 },	-- Amulet of the Titanorex
                { 117, 95177 },	-- Choker of Stygimolochy
                { 118, 95178 },	-- Lootraptor's Amulet
                { 119, 95179 },	-- Necklace of the Hazillosaurus
                { 120, 95180 },	-- Overcompensating Chain of the Alpha Male
                { 122, 95165 },	-- Achillobator Ring
                { 123, 95164 },	-- Eye of Oondasta
                { 124, 95166 },	-- Forzarra's Last Meal
                { 125, 95167 },	-- Ring of King Kangrom
                { 126, 95163 },	-- Ring of Shamuru
            },
        },
        {	--Ordos
            EncounterJournalID = 861,
            [NORMAL_DIFF] = {
                { 1, 105810 },	-- Buc-Zakai Burning Hood
                { 2, 105808 },	-- Damien's Ice-Vein Mask
                { 3, 105795 },	-- Bo He Me's Deathwind Mantle
                { 4, 105797 },	-- Shay-Nii's Popping Shoulderpads
                { 5, 105774 },	-- Catia's Flowing Robes
                { 6, 105773 },	-- Ulmaas' Robes of Crushing Magma
                { 7, 105789 },	-- Bjam's Blasting Bracers
                { 8, 105788 },	-- Paululum's Doodled Wraps
                { 9, 105778 },	-- Derevka's Gleaming Girdle
                { 10, 105781 },	-- Venruki's Venerable Sash
                { 11, 105757 },	-- Shipley's Shady Silks
                { 16, 105806 },	-- Circlet of the Panser
                { 17, 105803 },	-- Stickney's Grey-Shade Hood
                { 18, 105798 },	-- Flame Healer's Shoulderguards
                { 19, 105801 },	-- Spaulders of Dominating Dreams
                { 20, 105768 },	-- Pamela's Muuscat Wrap
                { 21, 105770 },	-- Zoo-Per's Superior Chestguard
                { 22, 105793 },	-- Bracers of Simmering Fury
                { 23, 105787 },	-- Burnseal Bracers
                { 24, 105782 },	-- Belt of Glowing Embers
                { 25, 105780 },	-- Windflame Girdle
                { 26, 105758 },	-- Arielle's Ancient Legwraps
                { 27, 105760 },	-- Hamlet's Wind-Whipped Leggings
                { 29, "ac8533" },
                { 101, 105809 },	-- Crest of Burning Deeds
                { 102, 105811 },	-- Olivia's Graceful Gaze
                { 103, 105800 },	-- Firearrow Shoulderpads
                { 104, 105799 },	-- Fleshsmoke Chain Shoulders
                { 105, 105771 },	-- Chestguard of Pyrrhic Immolation
                { 106, 105772 },	-- Moonhee's Mean Vest
                { 107, 105792 },	-- Bowflight Wristguard
                { 108, 105790 },	-- Firetotem Bracers
                { 109, 105784 },	-- Binkenstein's Burnished Belt
                { 110, 105779 },	-- Light Kindler Waistguard
                { 111, 105754 },	-- Desirae's Dashing Leggings
                { 112, 105755 },	-- Moshne's Keen Kilt
                { 116, 105804 },	-- Aladya's Spiritfire Greathelm
                { 117, 105805 },	-- Dominik's Casque of Raging Flame
                { 118, 105807 },	-- Magdalena's Murderous Crown
                { 119, 105796 },	-- Rossi's Rosin-Soaked Shoulderplates
                { 120, 105794 },	-- Starry Spaulders of Durability
                { 121, 105802 },	-- Yaungol Deathcult Shoulderguards
                { 122, 105775 },	-- Gleaming Eye Spellplate
                { 123, 105767 },	-- Hoodrych's Bloodied Chestplate
                { 124, 105769 },	-- Omegal's Crushing Carapace
                { 125, 105791 },	-- Bracers of Unquestioning Belief
                { 126, 105786 },	-- Ordosian Cultist's Bracers
                { 127, 105785 },	-- Vanguard's Burly Bracers
                { 201, 105776 },	-- Belt of the Burning Soul
                { 202, 105783 },	-- Greatbelt of the Crendor
                { 203, 105777 },	-- Remnar's Ruinous Girdle
                { 204, 105759 },	-- Magmaplates of Jian Wu Xi Feng
                { 205, 105761 },	-- Partik's Purified Legplates
                { 206, 105756 },	-- Poxleitner's Leggings of Lights
                { 208, 104273, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Flame-Scarred Cache of Offerings
                { 216, 105766 },	-- Anafielle's Spiked Choker
                { 217, 105765 },	-- Bladeforger Necklace
                { 218, 105763 },	-- Penate's Perilous Pendant
                { 219, 105764 },	-- Rising New Moon Talisman
                { 220, 105762 },	-- Smoldering Eye
            },
        },
        {	--TheAugustCelestials
            EncounterJournalID = 857,
            name = ALIL["The August Celestials"],
            [NORMAL_DIFF] = {
                { 1, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
                { 2, 99174 },	-- Gloves of the Shattered Vale
                { 3, 99176 },	-- Leggings of the Shattered Vale
                { 5, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
                { 6, 99181 },	-- Grips of the Shattered Vale
                { 7, 99183 },	-- Legguards of the Shattered Vale
                { 9, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
                { 10, 99185 },	-- Handwraps of the Shattered Vale
                { 11, 99171 },	-- Legwraps of the Shattered Vale
                { 13, "ICON_ability_racial_bearform", nil, ALIL["DRUID"], ALIL["Guardian"] },
                { 14, 99163 },	-- Handguards of the Shattered Vale
                { 15, 99165 },	-- Breeches of the Shattered Vale
                { 16, "ICON_spell_nature_starfall", nil, ALIL["DRUID"], ALIL["Balance"] },
                { 17, [ATLASLOOT_IT_ALLIANCE] = 102696, [ATLASLOOT_IT_HORDE] = 103398 },	-- Prideful Gladiator's Wyrmhide Gloves
                { 18, [ATLASLOOT_IT_ALLIANCE] = 102767, [ATLASLOOT_IT_HORDE] = 103400 },	-- Prideful Gladiator's Wyrmhide Legguards
                { 20, "ICON_ability_druid_catform", nil, ALIL["DRUID"], ALIL["Feral"] },
                { 21, [ATLASLOOT_IT_ALLIANCE] = 102739, [ATLASLOOT_IT_HORDE] = 103381 },	-- Prideful Gladiator's Dragonhide Gloves
                { 22, [ATLASLOOT_IT_ALLIANCE] = 102654, [ATLASLOOT_IT_HORDE] = 103383 },	-- Prideful Gladiator's Dragonhide Legguards
                { 24, "ICON_spell_nature_healingtouch", nil, ALIL["DRUID"], ALIL["Restoration"] },
                { 25, [ATLASLOOT_IT_ALLIANCE] = 102657, [ATLASLOOT_IT_HORDE] = 103389 },	-- Prideful Gladiator's Kodohide Gloves
                { 26, [ATLASLOOT_IT_ALLIANCE] = 102761, [ATLASLOOT_IT_HORDE] = 103391 },	-- Prideful Gladiator's Kodohide Legguards
                { 101, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
                { 102, 99168 },	-- Gloves of the Unblinking Vigil
                { 103, 99158 },	-- Legguards of the Unblinking Vigil
                { 105, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
                { 106, 99160 },	-- Chronomancer Gloves
                { 107, 99162 },	-- Chronomancer Leggings
                { 109, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
                { 110, 99113 },	-- Gloves of the Barbed Assassin
                { 111, 99115 },	-- Legguards of the Barbed Assassin
                { 113, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
                { 114, 99096 },	-- Gloves of the Horned Nightmare
                { 115, 99098 },	-- Leggings of the Horned Nightmare
                { 116, "ICON_inv_weapon_bow_07", nil, ALIL["HUNTER"], nil },
                { 117, [ATLASLOOT_IT_ALLIANCE] = 102737, [ATLASLOOT_IT_HORDE] = 103417 },	-- Prideful Gladiator's Chain Gauntlets
                { 118, [ATLASLOOT_IT_ALLIANCE] = 102670, [ATLASLOOT_IT_HORDE] = 103419 },	-- Prideful Gladiator's Chain Leggings
                { 120, "ICON_inv_staff_13", nil, ALIL["MAGE"], nil },
                { 121, [ATLASLOOT_IT_ALLIANCE] = 102735, [ATLASLOOT_IT_HORDE] = 103421 },	-- Prideful Gladiator's Silk Handguards
                { 122, [ATLASLOOT_IT_ALLIANCE] = 102648, [ATLASLOOT_IT_HORDE] = 103423 },	-- Prideful Gladiator's Silk Trousers
                { 124, "ICON_inv_throwingknife_04", nil, ALIL["ROGUE"], nil },
                { 125, [ATLASLOOT_IT_ALLIANCE] = 102663, [ATLASLOOT_IT_HORDE] = 103476 },	-- Prideful Gladiator's Leather Gloves
                { 126, [ATLASLOOT_IT_ALLIANCE] = 102730, [ATLASLOOT_IT_HORDE] = 103478 },	-- Prideful Gladiator's Leather Legguards
                { 128, "ICON_spell_nature_drowsy", nil, ALIL["WARLOCK"], nil },
                { 129, [ATLASLOOT_IT_ALLIANCE] = 102725, [ATLASLOOT_IT_HORDE] = 103520 },	-- Prideful Gladiator's Felweave Handguards
                { 130, [ATLASLOOT_IT_ALLIANCE] = 102755, [ATLASLOOT_IT_HORDE] = 103522 },	-- Prideful Gladiator's Felweave Trousers
                { 201, "ICON_spell_monk_mistweaver_spec", nil, ALIL["MONK"], ALIL["Mistweaver"] },
                { 202, 99147 },	-- Handwraps of Seven Sacred Seals
                { 203, 99149 },	-- Legwraps of Seven Sacred Seals
                { 205, "ICON_spell_monk_windwalker_spec", nil, ALIL["MONK"], ALIL["Windwalker"] },
                { 206, 99155 },	-- Grips of Seven Sacred Seals
                { 207, 99145 },	-- Leggings of Seven Sacred Seals
                { 209, "ICON_spell_monk_brewmaster_spec", nil, ALIL["MONK"], ALIL["Brewmaster"] },
                { 210, 99141 },	-- Gauntlets of Seven Sacred Seals
                { 211, 99143 },	-- Legguards of Seven Sacred Seals
                { 216, "ICON_spell_monk_mistweaver_spec", nil, ALIL["MONK"], ALIL["Mistweaver"] },
                { 217, [ATLASLOOT_IT_ALLIANCE] = 102627, [ATLASLOOT_IT_HORDE] = 103434 },	-- Prideful Gladiator's Copperskin Gloves
                { 218, [ATLASLOOT_IT_ALLIANCE] = 102762, [ATLASLOOT_IT_HORDE] = 103436 },	-- Prideful Gladiator's Copperskin Legguards
                { 220, "ICON_spell_monk_windwalker_spec", nil, ALIL["MONK"], ALIL["Windwalker"] },
                { 221, [ATLASLOOT_IT_ALLIANCE] = 102675, [ATLASLOOT_IT_HORDE] = 103429 },	-- Prideful Gladiator's Ironskin Gloves
                { 222, [ATLASLOOT_IT_ALLIANCE] = 102656, [ATLASLOOT_IT_HORDE] = 103431 },	-- Prideful Gladiator's Ironskin Legguards
                { 301, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
                { 302, 99134 },	-- Gloves of Winged Triumph
                { 303, 99124 },	-- Greaves of Winged Triumph
                { 305, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
                { 306, 99137 },	-- Gauntlets of Winged Triumph
                { 307, 99139 },	-- Legplates of Winged Triumph
                { 309, "ICON_spell_holy_devotionaura", nil, ALIL["PALADIN"], ALIL["Protection"] },
                { 310, 99127 },	-- Handguards of Winged Triumph
                { 311, 99129 },	-- Legguards of Winged Triumph
                { 316, "ICON_Spell_Holy_HolyBolt", nil, ALIL["PALADIN"], ALIL["Holy"] },
                { 317, [ATLASLOOT_IT_ALLIANCE] = 102722, [ATLASLOOT_IT_HORDE] = 103451 },	-- Prideful Gladiator's Ornamented Gloves
                { 318, [ATLASLOOT_IT_ALLIANCE] = 102768, [ATLASLOOT_IT_HORDE] = 103453 },	-- Prideful Gladiator's Ornamented Legplates
                { 320, "ICON_Spell_Holy_AuraOfLight", nil, ALIL["PALADIN"], ALIL["Retribution"] },
                { 321, [ATLASLOOT_IT_ALLIANCE] = 102630, [ATLASLOOT_IT_HORDE] = 103440 },	-- Prideful Gladiator's Scaled Gauntlets
                { 322, [ATLASLOOT_IT_ALLIANCE] = 102780, [ATLASLOOT_IT_HORDE] = 103442 },	-- Prideful Gladiator's Scaled Legguards
                { 401, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"] .. " / " .. ALIL["Holy"] },
                { 402, 99131 },	-- Handwraps of the Ternion Glory
                { 403, 99118 },	-- Legwraps of the Ternion Glory
                { 405, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
                { 406, 99121 },	-- Gloves of the Ternion Glory
                { 407, 99123 },	-- Leggings of the Ternion Glory
                { 416, "ICON_spell_holy_guardianspirit", nil, ALIL["PRIEST"], ALIL["Discipline"] .. " / " .. ALIL["Holy"] },
                { 417, [ATLASLOOT_IT_ALLIANCE] = 102615, [ATLASLOOT_IT_HORDE] = 103462 },	-- Prideful Gladiator's Mooncloth Gloves
                { 418, [ATLASLOOT_IT_ALLIANCE] = 102704, [ATLASLOOT_IT_HORDE] = 103464 },	-- Prideful Gladiator's Mooncloth Leggings
                { 420, "ICON_spell_shadow_shadowwordpain", nil, ALIL["PRIEST"], ALIL["Shadow"] },
                { 421, [ATLASLOOT_IT_ALLIANCE] = 102707, [ATLASLOOT_IT_HORDE] = 103467 },	-- Prideful Gladiator's Satin Gloves
                { 422, [ATLASLOOT_IT_ALLIANCE] = 102621, [ATLASLOOT_IT_HORDE] = 103469 },	-- Prideful Gladiator's Satin Leggings
                { 501, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
                { 502, 99092 },	-- Gloves of Celestial Harmony
                { 503, 99094 },	-- Kilt of Celestial Harmony
                { 505, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
                { 506, 99102 },	-- Grips of Celestial Harmony
                { 507, 99104 },	-- Legguards of Celestial Harmony
                { 509, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
                { 510, 99108 },	-- Handwraps of Celestial Harmony
                { 511, 99099 },	-- Legwraps of Celestial Harmony
                { 516, "ICON_Spell_Nature_Lightning", nil, ALIL["SHAMAN"], ALIL["Elemental"] },
                { 517, [ATLASLOOT_IT_ALLIANCE] = 102692, [ATLASLOOT_IT_HORDE] = 103497 },	-- Prideful Gladiator's Mail Gauntlets
                { 518, [ATLASLOOT_IT_ALLIANCE] = 102781, [ATLASLOOT_IT_HORDE] = 103499 },	-- Prideful Gladiator's Mail Leggings
                { 520, "ICON_spell_nature_lightningshield", nil, ALIL["SHAMAN"], ALIL["Enhancement"] },
                { 521, [ATLASLOOT_IT_ALLIANCE] = 102742, [ATLASLOOT_IT_HORDE] = 103491 },	-- Prideful Gladiator's Linked Gauntlets
                { 522, [ATLASLOOT_IT_ALLIANCE] = 102778, [ATLASLOOT_IT_HORDE] = 103493 },	-- Prideful Gladiator's Linked Leggings
                { 524, "ICON_spell_nature_magicimmunity", nil, ALIL["SHAMAN"], ALIL["Restoration"] },
                { 525, [ATLASLOOT_IT_ALLIANCE] = 102774, [ATLASLOOT_IT_HORDE] = 103486 },	-- Prideful Gladiator's Ringmail Gauntlets
                { 526, [ATLASLOOT_IT_ALLIANCE] = 102719, [ATLASLOOT_IT_HORDE] = 103488 },	-- Prideful Gladiator's Ringmail Leggings
                { 601, "ICON_spell_deathknight_frostpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Frost"] .. " / " .. ALIL["Unholy"] },
                { 602, 99193 },	-- Gauntlets of Cyclopean Dread
                { 603, 99186 },	-- Greaves of Cyclopean Dread
                { 605, "ICON_spell_deathknight_bloodpresence", nil, ALIL["DEATHKNIGHT"], ALIL["Blood"] },
                { 606, 99189 },	-- Handguards of Cyclopean Dread
                { 607, 99191 },	-- Legguards of Cyclopean Dread
                { 609, "ICON_ability_warrior_innerrage", nil, ALIL["WARRIOR"], ALIL["Arms"] .. " / " .. ALIL["Fury"] },
                { 610, 99198 },	-- Gauntlets of the Prehistoric Marauder
                { 611, 99199 },	-- Legplates of the Prehistoric Marauder
                { 613, "ICON_ability_warrior_defensivestance", nil, ALIL["WARRIOR"], ALIL["Protection"] },
                { 614, 99202 },	-- Handguards of the Prehistoric Marauder
                { 615, 99195 },	-- Legguards of the Prehistoric Marauder
                { 616, "ICON_Spell_deathknight_classicon", nil, ALIL["DEATHKNIGHT"], nil },
                { 617, [ATLASLOOT_IT_ALLIANCE] = 103005, [ATLASLOOT_IT_HORDE] = 103377 },	-- Prideful Gladiator's Dreadplate Gauntlets
                { 618, [ATLASLOOT_IT_ALLIANCE] = 102651, [ATLASLOOT_IT_HORDE] = 103379 },	-- Prideful Gladiator's Dreadplate Legguards
                { 624, "ICON_inv_sword_27", nil, ALIL["WARRIOR"], nil },
                { 625, [ATLASLOOT_IT_ALLIANCE] = 102618, [ATLASLOOT_IT_HORDE] = 103526 },	-- Prideful Gladiator's Plate Gauntlets
                { 626, [ATLASLOOT_IT_ALLIANCE] = 102732, [ATLASLOOT_IT_HORDE] = 103528 },	-- Prideful Gladiator's Plate Legguards
                { 701, [ATLASLOOT_IT_ALLIANCE] = 102687, [ATLASLOOT_IT_HORDE] = 103357 },	-- Prideful Gladiator's Cuffs of Accuracy
                { 702, [ATLASLOOT_IT_ALLIANCE] = 102662, [ATLASLOOT_IT_HORDE] = 103352 },	-- Prideful Gladiator's Cord of Accuracy
                { 703, [ATLASLOOT_IT_ALLIANCE] = 102620, [ATLASLOOT_IT_HORDE] = 103355 },	-- Prideful Gladiator's Treads of Alacrity
                { 705, [ATLASLOOT_IT_ALLIANCE] = 102666, [ATLASLOOT_IT_HORDE] = 103359 },	-- Prideful Gladiator's Cuffs of Meditation
                { 706, [ATLASLOOT_IT_ALLIANCE] = 102709, [ATLASLOOT_IT_HORDE] = 103353 },	-- Prideful Gladiator's Cord of Meditation
                { 707, [ATLASLOOT_IT_ALLIANCE] = 102752, [ATLASLOOT_IT_HORDE] = 103356 },	-- Prideful Gladiator's Treads of Meditation
                { 709, [ATLASLOOT_IT_ALLIANCE] = 102733, [ATLASLOOT_IT_HORDE] = 103358 },	-- Prideful Gladiator's Cuffs of Prowess
                { 710, [ATLASLOOT_IT_ALLIANCE] = 102684, [ATLASLOOT_IT_HORDE] = 103351 },	-- Prideful Gladiator's Cord of Cruelty
                { 711, [ATLASLOOT_IT_ALLIANCE] = 102686, [ATLASLOOT_IT_HORDE] = 103354 },	-- Prideful Gladiator's Treads of Cruelty
                { 716, [ATLASLOOT_IT_ALLIANCE] = 102711, [ATLASLOOT_IT_HORDE] = 103428 },	-- Prideful Gladiator's Armwraps of Accuracy
                { 717, [ATLASLOOT_IT_ALLIANCE] = 102708, [ATLASLOOT_IT_HORDE] = 103472 },	-- Prideful Gladiator's Waistband of Accuracy
                { 718, [ATLASLOOT_IT_ALLIANCE] = 102660, [ATLASLOOT_IT_HORDE] = 103473 },	-- Prideful Gladiator's Boots of Cruelty
                { 720, [ATLASLOOT_IT_ALLIANCE] = 102754, [ATLASLOOT_IT_HORDE] = 103474 },	-- Prideful Gladiator's Armwraps of Alacrity
                { 721, [ATLASLOOT_IT_ALLIANCE] = 102647, [ATLASLOOT_IT_HORDE] = 103426 },	-- Prideful Gladiator's Waistband of Cruelty
                { 722, [ATLASLOOT_IT_ALLIANCE] = 102716, [ATLASLOOT_IT_HORDE] = 103427 },	-- Prideful Gladiator's Boots of Alacrity
                { 724, [ATLASLOOT_IT_ALLIANCE] = 102723, [ATLASLOOT_IT_HORDE] = 103397 },	-- Prideful Gladiator's Bindings of Prowess
                { 725, [ATLASLOOT_IT_ALLIANCE] = 102694, [ATLASLOOT_IT_HORDE] = 103395 },	-- Prideful Gladiator's Belt of Cruelty
                { 726, [ATLASLOOT_IT_ALLIANCE] = 102631, [ATLASLOOT_IT_HORDE] = 103396 },	-- Prideful Gladiator's Footguards of Alacrity
                { 728, [ATLASLOOT_IT_ALLIANCE] = 102691, [ATLASLOOT_IT_HORDE] = 103388 },	-- Prideful Gladiator's Bindings of Meditation
                { 729, [ATLASLOOT_IT_ALLIANCE] = 102775, [ATLASLOOT_IT_HORDE] = 103386 },	-- Prideful Gladiator's Belt of Meditation
                { 730, [ATLASLOOT_IT_ALLIANCE] = 102760, [ATLASLOOT_IT_HORDE] = 102623 },	-- Prideful Gladiator's Footguards of Meditation
                { 801, [ATLASLOOT_IT_ALLIANCE] = 102624, [ATLASLOOT_IT_HORDE] = 103484 },	-- Prideful Gladiator's Armbands of Meditation
                { 802, [ATLASLOOT_IT_ALLIANCE] = 102668, [ATLASLOOT_IT_HORDE] = 103480 },	-- Prideful Gladiator's Waistguard of Meditation
                { 803, [ATLASLOOT_IT_ALLIANCE] = 102623, [ATLASLOOT_IT_HORDE] = 103482 },	-- Prideful Gladiator's Footguards of Meditation
                { 805, [ATLASLOOT_IT_ALLIANCE] = 102665, [ATLASLOOT_IT_HORDE] = 103483 },	-- Prideful Gladiator's Armbands of Prowess
                { 806, [ATLASLOOT_IT_ALLIANCE] = 102677, [ATLASLOOT_IT_HORDE] = 103495 },	-- Prideful Gladiator's Waistguard of Cruelty
                { 807, [ATLASLOOT_IT_ALLIANCE] = 102664, [ATLASLOOT_IT_HORDE] = 103481 },	-- Prideful Gladiator's Footguards of Alacrity
                { 809, [ATLASLOOT_IT_ALLIANCE] = 102688, [ATLASLOOT_IT_HORDE] = 103414 },	-- Prideful Gladiator's Wristguards of Alacrity
                { 810, [ATLASLOOT_IT_ALLIANCE] = 102617, [ATLASLOOT_IT_HORDE] = 103410 },	-- Prideful Gladiator's Links of Cruelty
                { 811, [ATLASLOOT_IT_ALLIANCE] = 102646, [ATLASLOOT_IT_HORDE] = 103413 },	-- Prideful Gladiator's Sabatons of Alacrity
                { 813, [ATLASLOOT_IT_ALLIANCE] = 102753, [ATLASLOOT_IT_HORDE] = 103415 },	-- Prideful Gladiator's Wristguards of Accuracy
                { 814, [ATLASLOOT_IT_ALLIANCE] = 102645, [ATLASLOOT_IT_HORDE] = 103411 },	-- Prideful Gladiator's Links of Accuracy
                { 815, [ATLASLOOT_IT_ALLIANCE] = 102729, [ATLASLOOT_IT_HORDE] = 103412 },	-- Prideful Gladiator's Sabatons of Cruelty
                { 816, [ATLASLOOT_IT_ALLIANCE] = 102765, [ATLASLOOT_IT_HORDE] = 103449 },	-- Prideful Gladiator's Bracers of Meditation
                { 817, [ATLASLOOT_IT_ALLIANCE] = 102748, [ATLASLOOT_IT_HORDE] = 103445 },	-- Prideful Gladiator's Clasp of Meditation
                { 818, [ATLASLOOT_IT_ALLIANCE] = 102639, [ATLASLOOT_IT_HORDE] = 103447 },	-- Prideful Gladiator's Greaves of Meditation
                { 820, [ATLASLOOT_IT_ALLIANCE] = 102702, [ATLASLOOT_IT_HORDE] = 103459 },	-- Prideful Gladiator's Armplates of Proficiency
                { 821, [ATLASLOOT_IT_ALLIANCE] = 102640, [ATLASLOOT_IT_HORDE] = 103455 },	-- Prideful Gladiator's Girdle of Accuracy
                { 822, [ATLASLOOT_IT_ALLIANCE] = 102698, [ATLASLOOT_IT_HORDE] = 103457 },	-- Prideful Gladiator's Warboots of Cruelty
                { 824, [ATLASLOOT_IT_ALLIANCE] = 102695, [ATLASLOOT_IT_HORDE] = 103448 },	-- Prideful Gladiator's Bracers of Prowess
                { 825, [ATLASLOOT_IT_ALLIANCE] = 102764, [ATLASLOOT_IT_HORDE] = 103444 },	-- Prideful Gladiator's Clasp of Cruelty
                { 826, [ATLASLOOT_IT_ALLIANCE] = 102638, [ATLASLOOT_IT_HORDE] = 103446 },	-- Prideful Gladiator's Greaves of Alacrity
                { 828, [ATLASLOOT_IT_ALLIANCE] = 102771, [ATLASLOOT_IT_HORDE] = 103460 },	-- Prideful Gladiator's Armplates of Alacrity
                { 829, [ATLASLOOT_IT_ALLIANCE] = 102724, [ATLASLOOT_IT_HORDE] = 103456 },	-- Prideful Gladiator's Girdle of Prowess
                { 830, [ATLASLOOT_IT_ALLIANCE] = 102745, [ATLASLOOT_IT_HORDE] = 103458 },	-- Prideful Gladiator's Warboots of Alacrity
                { 901, [ATLASLOOT_IT_ALLIANCE] = 102705, [ATLASLOOT_IT_HORDE] = 103343 },	-- Prideful Gladiator's Cape of Cruelty
                { 902, [ATLASLOOT_IT_ALLIANCE] = 102642, [ATLASLOOT_IT_HORDE] = 103344 },	-- Prideful Gladiator's Cape of Prowess
                { 903, [ATLASLOOT_IT_ALLIANCE] = 102769, [ATLASLOOT_IT_HORDE] = 103512 },	-- Prideful Gladiator's Cloak of Alacrity
                { 904, [ATLASLOOT_IT_ALLIANCE] = 102770, [ATLASLOOT_IT_HORDE] = 103513 },	-- Prideful Gladiator's Cloak of Prowess
                { 905, [ATLASLOOT_IT_ALLIANCE] = 102669, [ATLASLOOT_IT_HORDE] = 103360 },	-- Prideful Gladiator's Drape of Cruelty
                { 906, [ATLASLOOT_IT_ALLIANCE] = 102756, [ATLASLOOT_IT_HORDE] = 103362 },	-- Prideful Gladiator's Drape of Meditation
                { 907, [ATLASLOOT_IT_ALLIANCE] = 102772, [ATLASLOOT_IT_HORDE] = 103361 },	-- Prideful Gladiator's Drape of Prowess
                { 909, [ATLASLOOT_IT_ALLIANCE] = 102641, [ATLASLOOT_IT_HORDE] = 103515 },	-- Prideful Gladiator's Choker of Accuracy
                { 910, [ATLASLOOT_IT_ALLIANCE] = 102749, [ATLASLOOT_IT_HORDE] = 103514 },	-- Prideful Gladiator's Choker of Proficiency
                { 911, [ATLASLOOT_IT_ALLIANCE] = 102678, [ATLASLOOT_IT_HORDE] = 103345 },	-- Prideful Gladiator's Necklace of Proficiency
                { 912, [ATLASLOOT_IT_ALLIANCE] = 102679, [ATLASLOOT_IT_HORDE] = 103346 },	-- Prideful Gladiator's Necklace of Prowess
                { 913, [ATLASLOOT_IT_ALLIANCE] = 102757, [ATLASLOOT_IT_HORDE] = 103368 },	-- Prideful Gladiator's Pendant of Alacrity
                { 914, [ATLASLOOT_IT_ALLIANCE] = 102773, [ATLASLOOT_IT_HORDE] = 103367 },	-- Prideful Gladiator's Pendant of Cruelty
                { 915, [ATLASLOOT_IT_ALLIANCE] = 102736, [ATLASLOOT_IT_HORDE] = 103369 },	-- Prideful Gladiator's Pendant of Meditation
                { 916, [ATLASLOOT_IT_ALLIANCE] = 102649, [ATLASLOOT_IT_HORDE] = 103371 },	-- Prideful Gladiator's Band of Accuracy
                { 917, [ATLASLOOT_IT_ALLIANCE] = 102674, [ATLASLOOT_IT_HORDE] = 103370 },	-- Prideful Gladiator's Band of Cruelty
                { 918, [ATLASLOOT_IT_ALLIANCE] = 102758, [ATLASLOOT_IT_HORDE] = 103372 },	-- Prideful Gladiator's Band of Meditation
                { 919, [ATLASLOOT_IT_ALLIANCE] = 102683, [ATLASLOOT_IT_HORDE] = 103349 },	-- Prideful Gladiator's Ring of Accuracy
                { 920, [ATLASLOOT_IT_ALLIANCE] = 102644, [ATLASLOOT_IT_HORDE] = 103348 },	-- Prideful Gladiator's Ring of Cruelty
                { 921, [ATLASLOOT_IT_ALLIANCE] = 102746, [ATLASLOOT_IT_HORDE] = 103518 },	-- Prideful Gladiator's Signet of Accuracy
                { 922, [ATLASLOOT_IT_ALLIANCE] = 102701, [ATLASLOOT_IT_HORDE] = 103517 },	-- Prideful Gladiator's Signet of Cruelty
                { 924, 104272, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Celestial Treasure Box
                { 926, "ac8535" },
            },
        },
        T14_SET,
    }
}

data["MoguShanVaults"] = {
    EncounterJournalID = 317,
    MapID = 6125,
    ContentType = RAID_CONTENT,
    items = {
        {	--MSVTheStoneGuard
            EncounterJournalID = 679,
            [NORMAL_DIFF] = {
                { 1, 85979 },	-- Cape of Three Lanterns
                { 2, 89768 },	-- Claws of Amethyst
                { 3, 89767 },	-- Ruby-Linked Girdle
                { 4, 85978 },	-- Jade Dust Leggings
                { 5, 85977 },	-- Stonebound Cinch
                { 6, 85926 },	-- Stoneflesh Leggings
                { 7, 85976 },	-- Sixteen-Fanged Crown
                { 8, 89766 },	-- Stonefang Chestguard
                { 9, 85923 },	-- Stonemaw Armguards
                { 10, 86134 },	-- Star-Stealer Waistguard
                { 11, 85975 },	-- Heavenly Jade Greatboots
                { 12, 85925 },	-- Jasper Clawfeet
                { 16, 85922 },	-- Beads of the Mogu'shi
                { 18, 85924 },	-- Dagger of the Seven Stars
                { 20, "ac6823" },
            },
            [HEROIC_DIFF] = {
                { 1, 87018 },	-- Cape of Three Lanterns
                { 2, 89931 },	-- Claws of Amethyst
                { 3, 89930 },	-- Ruby-Linked Girdle
                { 4, 87017 },	-- Jade Dust Leggings
                { 5, 87019 },	-- Stonebound Cinch
                { 6, 87013 },	-- Stoneflesh Leggings
                { 7, 87020 },	-- Sixteen-Fanged Crown
                { 8, 89929 },	-- Stonefang Chestguard
                { 9, 87014 },	-- Stonemaw Armguards
                { 10, 87060 },	-- Star-Stealer Waistguard
                { 11, 87021 },	-- Heavenly Jade Greatboots
                { 12, 87015 },	-- Jasper Clawfeet
                { 16, 87016 },	-- Beads of the Mogu'shi
                { 18, 87012 },	-- Dagger of the Seven Stars
                { 20, "ac6719" },
                { 21, "ac6823" },
            },
        },
        {	--MSVFeng
            EncounterJournalID = 689,
            [NORMAL_DIFF] = {
                { 1, 86082 },	-- Arrow Breaking Windcloak
                { 2, 85985 },	-- Cloak of Peacock Feathers
                { 3, 85990 },	-- Imperial Ghostbinder's Robes
                { 4, 85989 },	-- Hood of Cursed Dreams
                { 5, 85982 },	-- Tomb Raider's Girdle
                { 6, 85987 },	-- Chain of Shadow
                { 7, 85980 },	-- Wildfire Worldwalkers
                { 8, 85984 },	-- Nullification Greathelm
                { 9, 85983 },	-- Bracers of Six Oxen
                { 10, 85988 },	-- Legplates of Sagacious Shadows
                { 16, 85986 },	-- Amulet of Seven Curses
                { 17, 89803 },	-- Feng's Ring of Dreams
                { 18, 89802 },	-- Feng's Seal of Binding
                { 20, 89424 },	-- Fan of Fiery Winds
                { 22, "ac6674" },
            },
            [HEROIC_DIFF] = {
                { 1, 87044 },	-- Arrow Breaking Windcloak
                { 2, 87026 },	-- Cloak of Peacock Feathers
                { 3, 87027 },	-- Imperial Ghostbinder's Robes
                { 4, 87029 },	-- Hood of Cursed Dreams
                { 5, 87022 },	-- Tomb Raider's Girdle
                { 6, 87030 },	-- Chain of Shadow
                { 7, 87023 },	-- Wildfire Worldwalkers
                { 8, 87024 },	-- Nullification Greathelm
                { 9, 87025 },	-- Bracers of Six Oxen
                { 10, 87031 },	-- Legplates of Sagacious Shadows
                { 16, 87028 },	-- Amulet of Seven Curses
                { 17, 89933 },	-- Feng's Ring of Dreams
                { 18, 89932 },	-- Feng's Seal of Binding
                { 20, 89425 },	-- Fan of Fiery Winds
                { 22, "ac6720" },
                { 23, "ac6674" },
            },
        },
        {	--MSVGarajal
            EncounterJournalID = 682,
            [NORMAL_DIFF] = {
                { 1, 86041 },	-- Shadowsummoner Spaulders
                { 2, 85997 },	-- Sandals of the Severed Soul
                { 3, 85995 },	-- Netherrealm Shoulderpads
                { 4, 86039 },	-- Spaulders of the Divided Mind
                { 5, 85993 },	-- Fetters of Death
                { 6, 86040 },	-- Leggings of Imprisoned Will
                { 7, 86027 },	-- Bindings of Ancient Spirits
                { 8, 89817 },	-- Bonded Soul Bracers
                { 9, 85992 },	-- Sollerets of Spirit Splitting
                { 16, 85991 },	-- Soulgrasp Choker
                { 17, 86038 },	-- Circuit of the Frail Soul
                { 19, 85994 },	-- Gara'kal, Fist of the Spiritbinder
                { 20, 85996 },	-- Eye of the Ancient Spirit
                { 22, "ac7056" },
            },
            [HEROIC_DIFF] = {
                { 1, 87038 },	-- Shadowsummoner Spaulders
                { 2, 87037 },	-- Sandals of the Severed Soul
                { 3, 87033 },	-- Netherrealm Shoulderpads
                { 4, 87041 },	-- Spaulders of the Divided Mind
                { 5, 87034 },	-- Fetters of Death
                { 6, 87042 },	-- Leggings of Imprisoned Will
                { 7, 87043 },	-- Bindings of Ancient Spirits
                { 8, 89934 },	-- Bonded Soul Bracers
                { 9, 87035 },	-- Sollerets of Spirit Splitting
                { 16, 87036 },	-- Soulgrasp Choker
                { 17, 87040 },	-- Circuit of the Frail Soul
                { 19, 87032 },	-- Gara'kal, Fist of the Spiritbinder
                { 20, 87039 },	-- Eye of the Ancient Spirit
                { 22, "ac6721" },
                { 23, "ac7056" },
            },
        },
        {	--MSVSpiritKings
            EncounterJournalID = 687,
            [NORMAL_DIFF] = {
                { 1, 86082 },	-- Arrow Breaking Windcloak
                { 2, 89819 },	-- Mindshard Drape
                { 3, 86129 },	-- Hood of Blind Eyes
                { 4, 86128 },	-- Undying Shadow Grips
                { 5, 86127 },	-- Bracers of Dark Thoughts
                { 6, 89818 },	-- Bracers of Violent Meditation
                { 7, 86081 },	-- Subetai's Pillaging Leggings
                { 8, 86084 },	-- Meng's Treads of Insanity
                { 9, 86080 },	-- Shoulderguards of the Unflanked
                { 10, 86076 },	-- Breastplate of the Kings' Guard
                { 11, 86086 },	-- Girdle of Delirious Visions
                { 16, 86047 },	-- Amulet of the Hidden Kings
                { 17, 86083 },	-- Zian's Choker of Coalesced Shadow
                { 19, 86071 },	-- Screaming Tiger, Qiang's Unbreakable Polearm
                { 20, 86075 },	-- Steelskin, Qiang's Impervious Shield
                { 22, "ac6687" },
            },
            [HEROIC_DIFF] = {
                { 1, 87044 },	-- Arrow Breaking Windcloak
                { 2, 89936 },	-- Mindshard Drape
                { 3, 87051 },	-- Hood of Blind Eyes
                { 4, 87052 },	-- Undying Shadow Grips
                { 5, 87054 },	-- Bracers of Dark Thoughts
                { 6, 89935 },	-- Bracers of Violent Meditation
                { 7, 87047 },	-- Subetai's Pillaging Leggings
                { 8, 87055 },	-- Meng's Treads of Insanity
                { 9, 87049 },	-- Shoulderguards of the Unflanked
                { 10, 87048 },	-- Breastplate of the Kings' Guard
                { 11, 87056 },	-- Girdle of Delirious Visions
                { 16, 87045 },	-- Amulet of the Hidden Kings
                { 17, 87053 },	-- Zian's Choker of Coalesced Shadow
                { 19, 87046 },	-- Screaming Tiger, Qiang's Unbreakable Polearm
                { 20, 87050 },	-- Steelskin, Qiang's Impervious Shield
                { 22, "ac6722" },
                { 23, "ac6687" },
            },
        },
        {	--MSVElegon
            EncounterJournalID = 726,
            [NORMAL_DIFF] = {
                { 1, 89822 },	-- Galaxyfire Girdle
                { 2, 86139 },	-- Orbital Belt
                { 3, 86136 },	-- Chestguard of Total Annihilation
                { 4, 86138 },	-- Phasewalker Striders
                { 5, 86141 },	-- Shoulders of Empyreal Focus
                { 6, 89821 },	-- Crown of Keening Stars
                { 7, 86135 },	-- Starcrusher Gauntlets
                { 9, 87777, "mount", [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reins of the Astral Cloud Serpent
                { 16, 89824 },	-- Band of Bursting Novas
                { 17, 86132 },	-- Bottle of Infinite Stars
                { 18, 86133 },	-- Light of the Cosmos
                { 19, 86131 },	-- Vial of Dragon's Blood
                { 21, 86130 },	-- Elegion, the Fanged Crescent
                { 22, 86140 },	-- Starshatter
                { 23, 86137 },	-- Torch of the Celestial Spark
                { 25, "ac6686" },
            },
            [HEROIC_DIFF] = {
                { 1, 89938 },	-- Galaxyfire Girdle
                { 2, 87064 },	-- Orbital Belt
                { 3, 87058 },	-- Chestguard of Total Annihilation
                { 4, 87067 },	-- Phasewalker Striders
                { 5, 87068 },	-- Shoulders of Empyreal Focus
                { 6, 89939 },	-- Crown of Keening Stars
                { 7, 87059 },	-- Starcrusher Gauntlets
                { 9, 87777, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reins of the Astral Cloud Serpent
                { 16, 89937 },	-- Band of Bursting Novas
                { 17, 87057 },	-- Bottle of Infinite Stars
                { 18, 87065 },	-- Light of the Cosmos
                { 19, 87063 },	-- Vial of Dragon's Blood
                { 21, 87062 },	-- Elegion, the Fanged Crescent
                { 22, 87061 },	-- Starshatter
                { 23, 87066 },	-- Torch of the Celestial Spark
                { 25, "ac6723" },
                { 26, "ac6686" },
            },
        },
        {	--MSVWilloftheEmperor
            EncounterJournalID = 677,
            [NORMAL_DIFF] = {
                { 1, 86151 },	-- Hood of Focused Energy
                { 2, 86146 },	-- Crown of Opportunistic Strikes
                { 3, 86150 },	-- Magnetized Leggings
                { 4, 89820 },	-- Dreadeye Gaze
                { 5, 89825 },	-- Enameled Grips of Solemnity
                { 6, 87827 },	-- Grips of Terra Cotta
                { 7, 86149 },	-- Spaulders of the Emperor's Rage
                { 8, 89823 },	-- Chestguard of Eternal Vigilance
                { 9, 86145 },	-- Jang-xi's Devastating Legplates
                { 16, 86152 },	-- Worldwaker Cachabon
                { 17, 86144 },	-- Lei Shin's Final Orders
                { 18, 86147 },	-- Qin-xi's Polarizing Seal
                { 20, 86148 },	-- Tihan, Scepter of the Sleeping Emperor
                { 21, 86142 },	-- Fang Kung, Spark of Titans
                { 23, "ac6455" },
            },
            [HEROIC_DIFF] = {
                { 1, 87073 },	-- Hood of Focused Energy
                { 2, 87070 },	-- Crown of Opportunistic Strikes
                { 3, 87077 },	-- Magnetized Leggings
                { 4, 89940 },	-- Dreadeye Gaze
                { 5, 89942 },	-- Enameled Grips of Solemnity
                { 6, 87825 },	-- Grips of Terra Cotta
                { 7, 87078 },	-- Spaulders of the Emperor's Rage
                { 8, 89941 },	-- Chestguard of Eternal Vigilance
                { 9, 87071 },	-- Jang-xi's Devastating Legplates
                { 16, 87076 },	-- Worldwaker Cachabon
                { 17, 87072 },	-- Lei Shin's Final Orders
                { 18, 87075 },	-- Qin-xi's Polarizing Seal
                { 20, 87074 },	-- Tihan, Scepter of the Sleeping Emperor
                { 21, 87069 },	-- Fang Kung, Spark of Titans
                { 23, "ac6724" },
                { 24, "ac6455" },
            },
        },
        {	--MoguShanVaultsTrash
            name = AL["Trash Mobs"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 86043 },	-- Jade Bandit Figurine
                { 2, 86042 },	-- Jade Charioteer Figurine
                { 3, 86045 },	-- Jade Courtesan Figurine
                { 4, 86044 },	-- Jade Magistrate Figurine
                { 5, 86046 },	-- Jade Warlord Figurine
            },
        },
        PATTERNS_ILVL_496,
        MOP_RAID1_AC_TABLE,
    }
}

data["HeartofFear"] = {
    EncounterJournalID = 330,
    MapID = 6297,
    ContentType = RAID_CONTENT,
    items = {
        {	--HoFZorlok
            EncounterJournalID = 745,
            [NORMAL_DIFF] = {
                { 1, 86154 },	-- Hisek's Chrysanthemum Cape
                { 2, 86157 },	-- Attenuating Bracers
                { 3, 86161 },	-- Gloves of Grasping Claws
                { 4, 89829 },	-- Scent-Soaked Sandals
                { 5, 86159 },	-- Gauntlets of Undesired Gifts
                { 6, 86153 },	-- Boots of the Still Breath
                { 7, 86160 },	-- Mail of Screaming Secrets
                { 8, 87824 },	-- Zor'lok's Fizzing Chestguard
                { 9, 86158 },	-- Chestplate of the Forbidden Tower
                { 10, 89826 },	-- Warbelt of Sealed Pods
                { 11, 86203 },	-- Articulated Legplates
                { 16, 89827 },	-- Pheromone-Coated Choker
                { 17, 86156 },	-- Fragment of Fear Made Flesh
                { 18, 86155 },	-- Vizier's Ruby Signet
                { 20, "ac6937" },
            },
            [HEROIC_DIFF] = {
                { 1, 86945 },	-- Hisek's Chrysanthemum Cape
                { 2, 86948 },	-- Attenuating Bracers
                { 3, 86947 },	-- Gloves of Grasping Claws
                { 4, 89918 },	-- Scent-Soaked Sandals
                { 5, 86950 },	-- Gauntlets of Undesired Gifts
                { 6, 86943 },	-- Boots of the Still Breath
                { 7, 86951 },	-- Mail of Screaming Secrets
                { 8, 87822 },	-- Zor'lok's Fizzing Chestguard
                { 9, 86952 },	-- Chestplate of the Forbidden Tower
                { 10, 89919 },	-- Warbelt of Sealed Pods
                { 11, 86944 },	-- Articulated Legplates
                { 16, 89917 },	-- Pheromone-Coated Choker
                { 17, 86949 },	-- Fragment of Fear Made Flesh
                { 18, 86946 },	-- Vizier's Ruby Signet
                { 20, "ac6725" },
                { 21, "ac6937" },
            },
        },
        {	--HoFTayak
            EncounterJournalID = 744,
            [NORMAL_DIFF] = {
                { 1, 86169 },	-- Drape of Gathering Clouds
                { 2, 86170 },	-- Twisting Wind Bracers
                { 3, 86167 },	-- Boots of the Blowing Wind
                { 4, 89831 },	-- Hood of Stilled Winds
                { 5, 86163 },	-- Bracers of Unseen Strikes
                { 6, 86168 },	-- Bracers of Tempestuous Fury
                { 7, 90738 },	-- Kaz'tik's Stormseizer Gauntlets
                { 8, 89830 },	-- Sword Dancer's Leggings
                { 9, 89828 },	-- Pauldrons of the Broken Blade
                { 10, 86165 },	-- Windblade Talons
                { 11, 86164 },	-- Waistplate of Overwhelming Assault
                { 16, 86166 },	-- Choker of the Unleashed Storm
                { 17, 86162 },	-- Ring of the Bladed Tempest
                { 19, 86171 },	-- Tornado-Summoning Censer
                { 21, "ac6936" },
            },
            [HEROIC_DIFF] = {
                { 1, 86961 },	-- Drape of Gathering Clouds
                { 2, 86958 },	-- Twisting Wind Bracers
                { 3, 86959 },	-- Boots of the Blowing Wind
                { 4, 89922 },	-- Hood of Stilled Winds
                { 5, 86954 },	-- Bracers of Unseen Strikes
                { 6, 86962 },	-- Bracers of Tempestuous Fury
                { 7, 90740 },	-- Kaz'tik's Stormseizer Gauntlets
                { 8, 89920 },	-- Sword Dancer's Leggings
                { 9, 89921 },	-- Pauldrons of the Broken Blade
                { 10, 86956 },	-- Windblade Talons
                { 11, 86955 },	-- Waistplate of Overwhelming Assault
                { 16, 86953 },	-- Choker of the Unleashed Storm
                { 17, 86957 },	-- Ring of the Bladed Tempest
                { 19, 86960 },	-- Tornado-Summoning Censer
                { 21, "ac6726" },
                { 22, "ac6936" },
            },
        },
        {	--HoFGaralon
            EncounterJournalID = 713,
            [NORMAL_DIFF] = {
                { 1, 86173 },	-- Legbreaker Greatcloak
                { 2, 86182 },	-- Stormwake Mistcloak
                { 3, 86181 },	-- Xaril's Hood of Intoxicating Vapors
                { 4, 89833 },	-- Shoulders of Foaming Fluids
                { 5, 86178 },	-- Sandals of the Unbidden
                { 6, 86180 },	-- Robes of Eighty Lights
                { 7, 86176 },	-- Bonebreaker Gauntlets
                { 8, 89834 },	-- Vestments of Steaming Ichor
                { 9, 86175 },	-- Grips of the Leviathan
                { 10, 86174 },	-- Garalon's Hollow Skull
                { 11, 89832 },	-- Garalon's Graven Carapace
                { 12, 86179 },	-- Grasps of Panic
                { 16, 86177 },	-- Necklace of Congealed Weaknesses
                { 17, 86172 },	-- Ring of the Shattered Shell
                { 19, "ac6553" },
            },
            [HEROIC_DIFF] = {
                { 1, 86963 },	-- Legbreaker Greatcloak
                { 2, 86971 },	-- Stormwake Mistcloak
                { 3, 86970 },	-- Xaril's Hood of Intoxicating Vapors
                { 4, 89924 },	-- Shoulders of Foaming Fluids
                { 5, 86969 },	-- Sandals of the Unbidden
                { 6, 86972 },	-- Robes of Eighty Lights
                { 7, 86964 },	-- Bonebreaker Gauntlets
                { 8, 89925 },	-- Vestments of Steaming Ichor
                { 9, 86965 },	-- Grips of the Leviathan
                { 10, 86966 },	-- Garalon's Hollow Skull
                { 11, 89923 },	-- Garalon's Graven Carapace
                { 12, 86973 },	-- Grasps of Panic
                { 16, 86967 },	-- Necklace of Congealed Weaknesses
                { 17, 86968 },	-- Ring of the Shattered Shell
                { 19, "ac6727" },
                { 20, "ac6553" },
            },
        },
        {	--HoFMeljarak
            EncounterJournalID = 741,
            [NORMAL_DIFF] = {
                { 1, 86202 },	-- Cloak of Raining Blades
                { 2, 86513 },	-- Robes of Torn Nightmares
                { 3, 86514 },	-- Clutches of Dying Hope
                { 4, 86204 },	-- Wingslasher Pauldrons
                { 5, 86201 },	-- Impaling Treads
                { 16, 89240 },	-- Gauntlets of the Shadowy Conqueror
                { 17, 89241 },	-- Gauntlets of the Shadowy Protector
                { 18, 89242 },	-- Gauntlets of the Shadowy Vanquisher
                { 20, 86205 },	-- Korven's Amber-Sealed Beetle
                { 21, 86200 },	-- Painful Thorned Ring
                { 23, "ac6683" },
            },
            [HEROIC_DIFF] = {
                { 1, 86980 },	-- Cloak of Raining Blades
                { 2, 86975 },	-- Robes of Torn Nightmares
                { 3, 86977 },	-- Clutches of Dying Hope
                { 4, 86978 },	-- Wingslasher Pauldrons
                { 5, 86979 },	-- Impaling Treads
                { 16, 89256 },	-- Gauntlets of the Shadowy Conqueror
                { 17, 89257 },	-- Gauntlets of the Shadowy Protector
                { 18, 89255 },	-- Gauntlets of the Shadowy Vanquisher
                { 20, 86976 },	-- Korven's Amber-Sealed Beetle
                { 21, 86974 },	-- Painful Thorned Ring
                { 23, "ac6728" },
                { 24, "ac6683" },
            },
        },
        {	--HoFUnsok
            EncounterJournalID = 737,
            [NORMAL_DIFF] = {
                { 1, 86210 },	-- Belt of Malleable Amber
                { 2, 86212 },	-- Treads of Deadly Secretions
                { 3, 86214 },	-- Monstrous Stompers
                { 4, 86213 },	-- Shoulderpads of Misshapen Life
                { 6, 86211 },	-- Seal of the Profane
                { 16, 89243 },	-- Leggings of the Shadowy Conqueror
                { 17, 89244 },	-- Leggings of the Shadowy Protector
                { 18, 89245 },	-- Leggings of the Shadowy Vanquisher
                { 20, 86217 },	-- Un'sok's Amber Scalpel
                { 21, 86219 },	-- Scimitar of Seven Stars
                { 23, "ac6518" },
            },
            [HEROIC_DIFF] = {
                { 1, 86981 },	-- Belt of Malleable Amber
                { 2, 86984 },	-- Treads of Deadly Secretions
                { 3, 86985 },	-- Monstrous Stompers
                { 4, 86986 },	-- Shoulderpads of Misshapen Life
                { 6, 86982 },	-- Seal of the Profane
                { 16, 89253 },	-- Leggings of the Shadowy Conqueror
                { 17, 89254 },	-- Leggings of the Shadowy Protector
                { 18, 89252 },	-- Leggings of the Shadowy Vanquisher
                { 20, 86983 },	-- Un'sok's Amber Scalpel
                { 21, 86987 },	-- Scimitar of Seven Stars
                { 23, "ac6729" },
                { 24, "ac6518" },
            },
        },
        {	--HoFShekzeer
            EncounterJournalID = 743,
            [NORMAL_DIFF] = {
                { 1, 86229 },	-- Leggings of Shadow Infestation
                { 2, 89836 },	-- Shadow Heart Spaulders
                { 3, 86228 },	-- Crown of the Doomed Empress
                { 4, 89835 },	-- Hood of Dark Dreams
                { 5, 89837 },	-- Legplates of Regal Reinforcement
                { 7, 86226 },	-- Claws of Shek'zeer
                { 8, 86227 },	-- Kri'tak, Imperial Scepter of the Swarm
                { 16, 89237 },	-- Chest of the Shadowy Conqueror
                { 17, 89238 },	-- Chest of the Shadowy Protector
                { 18, 89239 },	-- Chest of the Shadowy Vanquisher
                { 20, "ac6922" },
            },
            [HEROIC_DIFF] = {
                { 1, 86989 },	-- Leggings of Shadow Infestation
                { 2, 89926 },	-- Shadow Heart Spaulders
                { 3, 86991 },	-- Crown of the Doomed Empress
                { 4, 89927 },	-- Hood of Dark Dreams
                { 5, 89928 },	-- Legplates of Regal Reinforcement
                { 7, 86988 },	-- Claws of Shek'zeer
                { 8, 86990 },	-- Kri'tak, Imperial Scepter of the Swarm
                { 16, 89250 },	-- Chest of the Shadowy Conqueror
                { 17, 89251 },	-- Chest of the Shadowy Protector
                { 18, 89249 },	-- Chest of the Shadowy Vanquisher
                { 20, "ac6730" },
                { 21, "ac6922" },
            },
        },
        {	--HoFTrash
            name = AL["Trash Mobs"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 86192 },	-- Darting Damselfly Cuffs
                { 2, 86186 },	-- Gleaming Moth Cuffs
                { 3, 86183 },	-- Shining Cicada Bracers
                { 4, 86187 },	-- Pearlescent Butterfly Wristbands
                { 5, 86185 },	-- Smooth Beetle Wristbands
                { 6, 86189 },	-- Jagged Hornet Bracers
                { 7, 86184 },	-- Luminescent Firefly Wristguards
                { 8, 86188 },	-- Inlaid Cricket Bracers
                { 9, 86191 },	-- Plated Locust Bracers
                { 10, 86190 },	-- Serrated Wasp Bracers
            },
        },
        PATTERNS_ILVL_496,
        T14_SET,
        MOP_RAID1_AC_TABLE,
    }
}

data["TerraceofEndlessSpring"] = {
    EncounterJournalID = 320,
    MapID = 6067,
    ContentType = RAID_CONTENT,
    items = {
        {	--ToESProtectors
            EncounterJournalID = 683,
            [NORMAL_DIFF] = {
                { 1, 86316, 90526 },	-- Cloak of Overwhelming Corruption
                { 2, 86317, 90524 },	-- Cuffs of the Corrupted Waters
                { 3, 86320, 90528 },	-- Asani's Uncleansed Sandals
                { 4, 89841, 90518 },	-- Legguards of Failing Purification
                { 5, 89885, 90519 },	-- Waterborne Shoulderguards
                { 6, 86319, 90529 },	-- Lightning Prisoner's Boots
                { 7, 86318, 90530 },	-- Casque of Expelled Corruption
                { 8, 86230, 90520 },	-- Bracers of Defiled Earth
                { 9, 86232, 90521 },	-- Deepwater Greatboots
                { 16, 86234, 90523 },	-- Kaolan's Withering Necklace
                { 17, 86233, 90522 },	-- Shackle of Eversparks
                { 18, 86231, 90517 },	-- Regail's Band of the Endless
                { 19, 86315, 90525 },	-- Watersoul Signet
                { 21, 86390, 90527 },	-- Regail's Crackling Dagger
                { 23, "ac6717" },
            },
            [HEROIC_DIFF] = {
                { 1, 87150, 90512 },	-- Cloak of Overwhelming Corruption
                { 2, 87149, 90510 },	-- Cuffs of the Corrupted Waters
                { 3, 87153, 90514 },	-- Asani's Uncleansed Sandals
                { 4, 89943, 90504 },	-- Legguards of Failing Purification
                { 5, 89944, 90505 },	-- Waterborne Shoulderguards
                { 6, 87154, 90515 },	-- Lightning Prisoner's Boots
                { 7, 87155, 90516 },	-- Casque of Expelled Corruption
                { 8, 87145, 90506 },	-- Bracers of Defiled Earth
                { 9, 87146, 90507 },	-- Deepwater Greatboots
                { 16, 87148, 90509 },	-- Kaolan's Withering Necklace
                { 17, 87147, 90508 },	-- Shackle of Eversparks
                { 18, 87144, 90503 },	-- Regail's Band of the Endless
                { 19, 87151, 90511 },	-- Watersoul Signet
                { 21, 87152, 90513 },	-- Regail's Crackling Dagger
                { 23, "ac6731" },
                { 24, "ac6717" },
            },
        },
        {	--ToESTsulong
            EncounterJournalID = 742,
            [NORMAL_DIFF] = {
                { 1, 86325 },	-- Daybreak Drape
                { 2, 89883 },	-- Shoulderpads of Twisted Fate
                { 3, 86326 },	-- Belt of Embodied Terror
                { 4, 86337 },	-- Healer's Belt of Final Winter
                { 5, 86338 },	-- Invoker's Belt of Final Winter
                { 6, 86339 },	-- Sorcerer's Belt of Final Winter
                { 7, 86330 },	-- Sandals of the Blackest Night
                { 8, 89842 },	-- Gauntlets of the Shadow's Caress
                { 9, 86341 },	-- Stalker's Cord of Eternal Autumn
                { 10, 86340 },	-- Weaver's Cord of Eternal Autumn
                { 11, 89884 },	-- Fear-Blackened Leggings
                { 12, 86324 },	-- Sunwrought Mail Hauberk
                { 13, 86342 },	-- Binder's Chain of Unending Summer
                { 14, 86343 },	-- Ranger's Chain of Unending Summer
                { 15, 89843 },	-- Grasps of Serpentine Might
                { 16, 86383 },	-- Mender's Girdle of Endless Spring
                { 17, 86385 },	-- Patroller's Girdle of Endless Spring
                { 18, 86384 },	-- Protector's Girdle of Endless Spring
                { 19, 86329 },	-- Sollerets of Instability
                { 21, 86322 },	-- Dread Shadow Ring
                { 22, 86327 },	-- Spirits of the Sun
                { 23, 86323 },	-- Stuff of Nightmares
                { 25, 86328 },	-- Loshan, Terror Incarnate
                { 26, 86321 },	-- Gao-Rei, Staff of the Legendary Protector
                { 28, "ac6933" },
            },
            [HEROIC_DIFF] = {
                { 1, 87159 },	-- Daybreak Drape
                { 2, 89947 },	-- Shoulderpads of Twisted Fate
                { 3, 87161 },	-- Belt of Embodied Terror
                { 4, 87178 },	-- Healer's Belt of Final Winter
                { 5, 87177 },	-- Invoker's Belt of Final Winter
                { 6, 87179 },	-- Sorcerer's Belt of Final Winter
                { 7, 87162 },	-- Sandals of the Blackest Night
                { 8, 89945 },	-- Gauntlets of the Shadow's Caress
                { 9, 87180 },	-- Stalker's Cord of Eternal Autumn
                { 10, 87181 },	-- Weaver's Cord of Eternal Autumn
                { 11, 89948 },	-- Fear-Blackened Leggings
                { 12, 87157 },	-- Sunwrought Mail Hauberk
                { 13, 87183 },	-- Binder's Chain of Unending Summer
                { 14, 87182 },	-- Ranger's Chain of Unending Summer
                { 15, 89946 },	-- Grasps of Serpentine Might
                { 16, 87184 },	-- Mender's Girdle of Endless Spring
                { 17, 87186 },	-- Patroller's Girdle of Endless Spring
                { 18, 87185 },	-- Protector's Girdle of Endless Spring
                { 19, 87165 },	-- Sollerets of Instability
                { 21, 87158 },	-- Dread Shadow Ring
                { 22, 87163 },	-- Spirits of the Sun
                { 23, 87160 },	-- Stuff of Nightmares
                { 25, 87164 },	-- Loshan, Terror Incarnate
                { 26, 87156 },	-- Gao-Rei, Staff of the Legendary Protector
                { 28, "ac6732" },
                { 29, "ac6933" },
            },
        },
        {	--ToESLeiShi
            EncounterJournalID = 729,
            [NORMAL_DIFF] = {
                { 1, 86334 },	-- Robes of the Unknown Fear
                { 2, 86337 },	-- Healer's Belt of Final Winter
                { 3, 86338 },	-- Invoker's Belt of Final Winter
                { 4, 86339 },	-- Sorcerer's Belt of Final Winter
                { 5, 86341 },	-- Stalker's Cord of Eternal Autumn
                { 6, 86340 },	-- Weaver's Cord of Eternal Autumn
                { 7, 86342 },	-- Binder's Chain of Unending Summer
                { 8, 86343 },	-- Ranger's Chain of Unending Summer
                { 9, 86333 },	-- Cuirass of the Animated Protector
                { 10, 86383 },	-- Mender's Girdle of Endless Spring
                { 11, 86385 },	-- Patroller's Girdle of Endless Spring
                { 12, 86384 },	-- Protector's Girdle of Endless Spring
                { 16, 89246 },	-- Shoulders of the Shadowy Conqueror
                { 17, 89247 },	-- Shoulders of the Shadowy Protector
                { 18, 89248 },	-- Shoulders of the Shadowy Vanquisher
                { 20, 86336 },	-- Darkmist Vortex
                { 21, 86332 },	-- Terror in the Mists
                { 23, 86391 },	-- Spiritsever
                { 24, 86335 },	-- Jin'ya, Orb of the Waterspeaker
                { 25, 86331 },	-- Taoren, the Soul Burner
                { 27, "ac6824" },
            },
            [HEROIC_DIFF] = {
                { 1, 87169 },	-- Robes of the Unknown Fear
                { 2, 87178 },	-- Healer's Belt of Final Winter
                { 3, 87177 },	-- Invoker's Belt of Final Winter
                { 4, 87179 },	-- Sorcerer's Belt of Final Winter
                { 5, 87180 },	-- Stalker's Cord of Eternal Autumn
                { 6, 87181 },	-- Weaver's Cord of Eternal Autumn
                { 7, 87183 },	-- Binder's Chain of Unending Summer
                { 8, 87182 },	-- Ranger's Chain of Unending Summer
                { 9, 87171 },	-- Cuirass of the Animated Protector
                { 10, 87184 },	-- Mender's Girdle of Endless Spring
                { 11, 87186 },	-- Patroller's Girdle of Endless Spring
                { 12, 87185 },	-- Protector's Girdle of Endless Spring
                { 16, 89262 },	-- Shoulders of the Shadowy Conqueror
                { 17, 89263 },	-- Shoulders of the Shadowy Protector
                { 18, 89261 },	-- Shoulders of the Shadowy Vanquisher
                { 20, 87172 },	-- Darkmist Vortex
                { 21, 87167 },	-- Terror in the Mists
                { 23, 87166 },	-- Spiritsever
                { 24, 87170 },	-- Jin'ya, Orb of the Waterspeaker
                { 25, 87168 },	-- Taoren, the Soul Burner
                { 27, "ac6733" },
                { 28, "ac6824" },
            },
        },
        {	--ToESShaofFear
            EncounterJournalID = 709,
            [NORMAL_DIFF] = {
                { 1, 89887 },	-- Robes of Pinioned Eyes
                { 2, 86389 },	-- Dreadwoven Leggings of Failure
                { 3, 89886 },	-- Wrap of Instant Petrification
                { 4, 89839 },	-- Shadowgrip Girdle
                { 6, 86388 },	-- Essence of Terror
                { 8, 86387 },	-- Kilrak, Jaws of Terror
                { 9, 86386 },	-- Shin'ka, Execution of Dominion
                { 11, 87210, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chimera of Fear
                { 16, 89235 },	-- Helm of the Shadowy Conqueror
                { 17, 89236 },	-- Helm of the Shadowy Protector
                { 18, 89234 },	-- Helm of the Shadowy Vanquisher
                { 20, "ac6926" },
                { 21, "ac6825" },
            },
            [HEROIC_DIFF] = {
                { 1, 89949 },	-- Robes of Pinioned Eyes
                { 2, 87174 },	-- Dreadwoven Leggings of Failure
                { 3, 89950 },	-- Wrap of Instant Petrification
                { 4, 89951 },	-- Shadowgrip Girdle
                { 6, 87175 },	-- Essence of Terror
                { 8, 87173 },	-- Kilrak, Jaws of Terror
                { 9, 87176 },	-- Shin'ka, Execution of Dominion
                { 11, 87210, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Chimera of Fear
                { 16, 89259 },	-- Helm of the Shadowy Conqueror
                { 17, 89260 },	-- Helm of the Shadowy Protector
                { 18, 89258 },	-- Helm of the Shadowy Vanquisher
                { 20, "ac6734" },
                { 21, "ac6926" },
                { 22, "ac6825" },
            },
        },
        PATTERNS_ILVL_496,
        T14_SET,
        MOP_RAID1_AC_TABLE,
    }
}

data["ThroneofThunder"] = {
    EncounterJournalID = 362,
    MapID = 6738,
    ContentType = RAID_CONTENT,
    items = {
        {	--ToTJinrokh
            EncounterJournalID = 827,
            [NORMAL_DIFF] = {
                { 1, 94735, 96011 },	-- Drape of Booming Nights
                { 2, 94733, 96008 },	-- Fissure-Split Shoulderwraps
                { 3, 94731, 96009 },	-- Robes of Static Bursts
                { 4, 94737, 96006 },	-- Lightningweaver Gauntlets
                { 5, 94739, 96007 },	-- Al'set's Tormented Leggings
                { 6, 94724, 95998 },	-- Lightning-Eye Hood
                { 7, 94732, 96014 },	-- Infinitely Conducting Bracers
                { 8, 94725, 96000 },	-- Static-Shot Shoulderguards
                { 9, 94728, 95999 },	-- Spearman's Jingling Leggings
                { 10, 94736, 96015 },	-- Ghostbinder Greatboots
                { 11, 94723, 96002 },	-- Chestplate of Violent Detonation
                { 12, 94734, 96016 },	-- Ionized Yojamban Carapace
                { 13, 94727, 96003 },	-- Bracers of Constant Implosion
                { 14, 94726, 96001 },	-- Cloudbreaker Greatbelt
                { 16, 94738, 96010 },	-- Jin'rokh's Dreamshard
                { 17, 94729, 96005 },	-- Jin'rokh's Soulcrystal
                { 18, 95510, 95996 },	-- Sign of the Bloodied God
                { 19, 94512, 95997 },	-- Renataki's Soul Charm
                { 21, 94730, 96012 },	-- Soulblade of the Breaking Storm
                { 22, 94722, 96004 },	-- Worldbreaker's Stormscythe
                { 24, "ac8094" },
            },
            [HEROIC_DIFF] = {
                { 1, 96383, 96755 },	-- Drape of Booming Nights
                { 2, 96380, 96752 },	-- Fissure-Split Shoulderwraps
                { 3, 96381, 96753 },	-- Robes of Static Bursts
                { 4, 96378, 96750 },	-- Lightningweaver Gauntlets
                { 5, 96379, 96751 },	-- Al'set's Tormented Leggings
                { 6, 96370, 96742 },	-- Lightning-Eye Hood
                { 7, 96386, 96758 },	-- Infinitely Conducting Bracers
                { 8, 96372, 96744 },	-- Static-Shot Shoulderguards
                { 9, 96371, 96743 },	-- Spearman's Jingling Leggings
                { 10, 96387, 96759 },	-- Ghostbinder Greatboots
                { 11, 96374, 96746 },	-- Chestplate of Violent Detonation
                { 12, 96388, 96760 },	-- Ionized Yojamban Carapace
                { 13, 96375, 96747 },	-- Bracers of Constant Implosion
                { 14, 96373, 96745 },	-- Cloudbreaker Greatbelt
                { 16, 96382, 96754 },	-- Jin'rokh's Dreamshard
                { 17, 96377, 96749 },	-- Jin'rokh's Soulcrystal
                { 18, 96368, 96740 },	-- Sign of the Bloodied God
                { 19, 96369, 96741 },	-- Renataki's Soul Charm
                { 21, 96384, 96756 },	-- Soulblade of the Breaking Storm
                { 22, 96376, 96748 },	-- Worldbreaker's Stormscythe
                { 24, "ac8056" },
                { 25, "ac8094" },
            },
        },
        {	--ToTHorridon
            EncounterJournalID = 819,
            [NORMAL_DIFF] = {
                { 1, 94745, 96025 },	-- Horn-Rimmed Doomcloak
                { 2, 94748, 96017 },	-- Wastewalker's Sandblasted Drape
                { 3, 94752, 96027 },	-- Flamecaster's Burning Crown
                { 4, 94750, 96028 },	-- Vaccinator's Armwraps
                { 5, 94753, 96034 },	-- Spaulders of Dinomancy
                { 6, 94743, 96020 },	-- Bindings of Multiplicative Strikes
                { 7, 94756, 96033 },	-- Roots of Rampaging Earth
                { 8, 94741, 96021 },	-- Sul'lithuz Sandmail
                { 9, 94975, 96035 },	-- Legguards of Scintillating Scales
                { 10, 94744, 96024 },	-- Puncture-Proof Greathelm
                { 11, 94751, 96036 },	-- Armplates of the Vanquished Abomination
                { 12, 94742, 96022 },	-- Frozen Warlord's Bracers
                { 13, 94747, 96023 },	-- Bloodlord's Bloodsoaked Legplates
                { 16, 94754, 96030 },	-- Horridon's Tusk Fragment
                { 17, 94746, 96018 },	-- Talisman of Living Poison
                { 18, 95514, 96031 },	-- Petrified Eye of the Basilisk
                { 19, 94514, 96013 },	-- Horridon's Last Gasp
                { 20, 94526, 96026 },	-- Spark of Zandalar
                { 22, 94749, 96029 },	-- Dinomancer's Spiritbinding Spire
                { 23, 94740, 96019 },	-- Jalak's Maelstrom Staff
                { 24, 94755, 96032 },	-- Venomlord's Totemic Wand
                { 26, 93666, "mount" },	-- Spawn of Horridon
                { 28, "ac8038" },
            },
            [HEROIC_DIFF] = {
                { 1, 96397, 96769 },	-- Horn-Rimmed Doomcloak
                { 2, 96389, 96761 },	-- Wastewalker's Sandblasted Drape
                { 3, 96399, 96771 },	-- Flamecaster's Burning Crown
                { 4, 96400, 96772 },	-- Vaccinator's Armwraps
                { 5, 96406, 96778 },	-- Spaulders of Dinomancy
                { 6, 96392, 96764 },	-- Bindings of Multiplicative Strikes
                { 7, 96405, 96777 },	-- Roots of Rampaging Earth
                { 8, 96393, 96765 },	-- Sul'lithuz Sandmail
                { 9, 96407, 96779 },	-- Legguards of Scintillating Scales
                { 10, 96396, 96768 },	-- Puncture-Proof Greathelm
                { 11, 96408, 96780 },	-- Armplates of the Vanquished Abomination
                { 12, 96394, 96766 },	-- Frozen Warlord's Bracers
                { 13, 96395, 96767 },	-- Bloodlord's Bloodsoaked Legplates
                { 16, 96402, 96774 },	-- Horridon's Tusk Fragment
                { 17, 96390, 96762 },	-- Talisman of Living Poison
                { 18, 96403, 96775 },	-- Petrified Eye of the Basilisk
                { 19, 96385, 96757 },	-- Horridon's Last Gasp
                { 20, 96398, 96770 },	-- Spark of Zandalar
                { 22, 96401, 96773 },	-- Dinomancer's Spiritbinding Spire
                { 23, 96391, 96763 },	-- Jalak's Maelstrom Staff
                { 24, 96404, 96776 },	-- Venomlord's Totemic Wand
                { 26, 93666, "mount" },	-- Spawn of Horridon
                { 28, "ac8057" },
                { 29, "ac8038" },
            },
        },
        {	--ToTCouncil
            EncounterJournalID = 816,
            [NORMAL_DIFF] = {
                { 1, 94761, 96040 },	-- Zandalari Robes of the Final Rite
                { 2, 94762, 96039 },	-- Mar'li's Bloodstained Sandals
                { 3, 94765, 96043 },	-- Robes of Treacherous Ground
                { 4, 94763, 96044 },	-- Gaze of Gara'jal
                { 5, 94767, 96045 },	-- Loa-Ridden Bracers
                { 6, 94764, 96046 },	-- Overloaded Bladebreaker Cuirass
                { 8, 94766, 96048 },	-- Talisman of Angry Spirits
                { 9, 94523, 96037 },	-- Bad Juju
                { 10, 94516, 96049 },	-- Fortitude of the Zandalari
                { 11, 94513, 96041 },	-- Wushoolay's Final Choice
                { 16, 95575 },	-- Gauntlets of the Crackling Conqueror
                { 17, 95580 },	-- Gauntlets of the Crackling Protector
                { 18, 95570 },	-- Gauntlets of the Crackling Vanquisher
                { 20, 94760, 96042 },	-- Amun-Thoth, Sul's Spiritrending Talons
                { 21, 94759, 96038 },	-- Kura-Kura, Kazra'jin's Skullcleaver
                { 22, 94758, 96047 },	-- Zerat, Malakk's Soulburning Greatsword
                { 24, "ac8073" },
            },
            [HEROIC_DIFF] = {
                { 1, 96412, 96784 },	-- Zandalari Robes of the Final Rite
                { 2, 96411, 96783 },	-- Mar'li's Bloodstained Sandals
                { 3, 96415, 96787 },	-- Robes of Treacherous Ground
                { 4, 96416, 96788 },	-- Gaze of Gara'jal
                { 5, 96417, 96789 },	-- Loa-Ridden Bracers
                { 6, 96418, 96790 },	-- Overloaded Bladebreaker Cuirass
                { 8, 96420, 96792 },	-- Talisman of Angry Spirits
                { 9, 96409, 96781 },	-- Bad Juju
                { 10, 96421, 96793 },	-- Fortitude of the Zandalari
                { 11, 96413, 96785 },	-- Wushoolay's Final Choice
                { 16, 96600 },	-- Gauntlets of the Crackling Conqueror
                { 17, 96601 },	-- Gauntlets of the Crackling Protector
                { 18, 96599 },	-- Gauntlets of the Crackling Vanquisher
                { 20, 96414, 96786 },	-- Amun-Thoth, Sul's Spiritrending Talons
                { 21, 96410, 96782 },	-- Kura-Kura, Kazra'jin's Skullcleaver
                { 22, 96419, 96791 },	-- Zerat, Malakk's Soulburning Greatsword
                { 24, "ac8058" },
                { 25, "ac8073" },
            },
        },
        {	--ToTTortos
            EncounterJournalID = 825,
            [NORMAL_DIFF] = {
                { 1, 94774, 96059 },	-- Beakbreaker Greatcloak
                { 2, 94785, 96063 },	-- Shimmershell Cape
                { 3, 94782, 96061 },	-- Stonegaze Hood
                { 4, 94781, 96060 },	-- Azure Shell Bracers
                { 5, 94780, 96062 },	-- Crystal-Claw Gloves
                { 6, 94779, 96066 },	-- Robes of Concussive Shocks
                { 7, 94770, 96051 },	-- Rockfall Ribwraps
                { 8, 94786, 96065 },	-- Vampire Bat-Hide Bracers
                { 9, 94777, 96052 },	-- Grips of Vampiric Cruelty
                { 10, 94783, 96067 },	-- Spaulders of Quaking Fear
                { 11, 94775, 96053 },	-- Beady-Eye Bracers
                { 12, 94772, 96054 },	-- Quakestompers
                { 13, 94773, 96055 },	-- Shoulderguards of Centripetal Destruction
                { 14, 94771, 96056 },	-- Shell-Coated Wristplates
                { 15, 94787, 96069 },	-- Tortos' Shellseizers
                { 16, 94784, 96068 },	-- Refreshing Abalone Girdle
                { 18, 94776, 96057 },	-- Amulet of the Primal Turtle
                { 20, 94768, 96058 },	-- Shellsplitter Greataxe
                { 21, 94769, 96050 },	-- Shattered Tortoiseshell Longbow
                { 22, 94778, 96064 },	-- Tortos' Discarded Shell
                { 24, "ac8077" },
            },
            [HEROIC_DIFF] = {
                { 1, 96431, 96803 },	-- Beakbreaker Greatcloak
                { 2, 96435, 96807 },	-- Shimmershell Cape
                { 3, 96433, 96805 },	-- Stonegaze Hood
                { 4, 96432, 96804 },	-- Azure Shell Bracers
                { 5, 96434, 96806 },	-- Crystal-Claw Gloves
                { 6, 96438, 96810 },	-- Robes of Concussive Shocks
                { 7, 96423, 96795 },	-- Rockfall Ribwraps
                { 8, 96437, 96809 },	-- Vampire Bat-Hide Bracers
                { 9, 96424, 96796 },	-- Grips of Vampiric Cruelty
                { 10, 96439, 96811 },	-- Spaulders of Quaking Fear
                { 11, 96425, 96797 },	-- Beady-Eye Bracers
                { 12, 96426, 96798 },	-- Quakestompers
                { 13, 96427, 96799 },	-- Shoulderguards of Centripetal Destruction
                { 14, 96428, 96800 },	-- Shell-Coated Wristplates
                { 15, 96441, 96813 },	-- Tortos' Shellseizers
                { 16, 96440, 96812 },	-- Refreshing Abalone Girdle
                { 18, 96429, 96801 },	-- Amulet of the Primal Turtle
                { 20, 96430, 96802 },	-- Shellsplitter Greataxe
                { 21, 96422, 96794 },	-- Shattered Tortoiseshell Longbow
                { 22, 96436, 96808 },	-- Tortos' Discarded Shell
                { 24, "ac8059" },
                { 25, "ac8077" },
            },
        },
        {	--ToTMegaera
            EncounterJournalID = 821,
            [NORMAL_DIFF] = {
                { 1, 94801, 96079 },	-- Gleaming-Eye Shoulderpads
                { 2, 94804, 96080 },	-- Frostborn Wristwraps
                { 3, 94799, 96078 },	-- Sandals of Arcane Fury
                { 4, 94800, 96085 },	-- Hood of Smoldering Flesh
                { 5, 94791, 96072 },	-- Poisonblood Bladeshoulders
                { 6, 94797, 96087 },	-- Chain of Consuming Magic
                { 7, 94790, 96073 },	-- Grips of Cinderflesh
                { 8, 94802, 96086 },	-- Links of the Bifurcated Tongue
                { 9, 94789, 96075 },	-- Rot-Proof Greatplate
                { 10, 94792, 96074 },	-- Plated Toothbreaker Girdle
                { 11, 94798, 96088 },	-- Ice-Scored Treads
                { 16, 94793, 96077 },	-- Hydraskull Choker
                { 17, 94803, 96081 },	-- Megaera's Shining Eye
                { 18, 94794, 96071 },	-- Quadra-Head Brooch
                { 19, 94795, 96076 },	-- Spinescale Seal
                { 20, 94521, 96083 },	-- Breath of the Hydra
                { 21, 94520, 96084 },	-- Inscribed Bag of Hydra-Spawn
                { 23, 94788, 96070 },	-- Megaera's Poisoned Fang
                { 24, 94796, 96082 },	-- Fetish of the Hydra
                { 26, "ac8082" },
            },
            [HEROIC_DIFF] = {
                { 1, 96451, 96823 },	-- Gleaming-Eye Shoulderpads
                { 2, 96452, 96824 },	-- Frostborn Wristwraps
                { 3, 96450, 96822 },	-- Sandals of Arcane Fury
                { 4, 96457, 96829 },	-- Hood of Smoldering Flesh
                { 5, 96444, 96816 },	-- Poisonblood Bladeshoulders
                { 6, 96459, 96831 },	-- Chain of Consuming Magic
                { 7, 96445, 96817 },	-- Grips of Cinderflesh
                { 8, 96458, 96830 },	-- Links of the Bifurcated Tongue
                { 9, 96447, 96819 },	-- Rot-Proof Greatplate
                { 10, 96446, 96818 },	-- Plated Toothbreaker Girdle
                { 11, 96460, 96832 },	-- Ice-Scored Treads
                { 16, 96449, 96821 },	-- Hydraskull Choker
                { 17, 96453, 96825 },	-- Megaera's Shining Eye
                { 18, 96443, 96815 },	-- Quadra-Head Brooch
                { 19, 96448, 96820 },	-- Spinescale Seal
                { 20, 96455, 96827 },	-- Breath of the Hydra
                { 21, 96456, 96828 },	-- Inscribed Bag of Hydra-Spawn
                { 23, 96442, 96814 },	-- Megaera's Poisoned Fang
                { 24, 96454, 96826 },	-- Fetish of the Hydra
                { 26, "ac8060" },
                { 27, "ac8082" },
            },
        },
        {	--ToTJiKun
            EncounterJournalID = 828,
            [NORMAL_DIFF] = {
                { 1, 94812, 96089 },	-- Pinionfeather Greatcloak
                { 2, 94806, 96091 },	-- Robe of Midnight Down
                { 3, 94813, 96090 },	-- Cord of Cacophonous Cawing
                { 4, 94811, 96093 },	-- Featherflight Belt
                { 5, 94808, 96094 },	-- Grasp of the Ruthless Mother
                { 6, 94809, 96095 },	-- Crown of Potentiated Birth
                { 7, 94810, 96096 },	-- Talonrender Chestplate
                { 8, 94807, 96097 },	-- Egg-Shard Grips
                { 10, 95059, "mount" },	-- Clutch of Ji-Kun
                { 11, 94835, "pet1202" },	-- Ji-Kun Hatchling
                { 16, 95576 },	-- Leggings of the Crackling Conqueror
                { 17, 95581 },	-- Leggings of the Crackling Protector
                { 18, 95572 },	-- Leggings of the Crackling Vanquisher
                { 20, 94515, 96098 },	-- Fabled Feather of Ji-Kun
                { 21, 94527, 96099 },	-- Ji-Kun's Rising Winds
                { 23, 94805, 96092 },	-- Giorgio's Caduceus of Pure Moods
                { 25, "ac8097" },
            },
            [HEROIC_DIFF] = {
                { 1, 96461, 96833 },	-- Pinionfeather Greatcloak
                { 2, 96463, 96835 },	-- Robe of Midnight Down
                { 3, 96462, 96834 },	-- Cord of Cacophonous Cawing
                { 4, 96465, 96837 },	-- Featherflight Belt
                { 5, 96466, 96838 },	-- Grasp of the Ruthless Mother
                { 6, 96467, 96839 },	-- Crown of Potentiated Birth
                { 7, 96468, 96840 },	-- Talonrender Chestplate
                { 8, 96469, 96841 },	-- Egg-Shard Grips
                { 10, 95059, "mount" },	-- Clutch of Ji-Kun
                { 11, 94835, "pet1202" },	-- Ji-Kun Hatchling
                { 16, 96632 },	-- Leggings of the Crackling Conqueror
                { 17, 96633 },	-- Leggings of the Crackling Protector
                { 18, 96631 },	-- Leggings of the Crackling Vanquisher
                { 20, 96470, 96842 },	-- Fabled Feather of Ji-Kun
                { 21, 96471, 96843 },	-- Ji-Kun's Rising Winds
                { 23, 96464, 96836 },	-- Giorgio's Caduceus of Pure Moods
                { 25, "ac8061" },
                { 26, "ac8097" },
            },
        },
        {	--ToTDurumu
            EncounterJournalID = 818,
            [NORMAL_DIFF] = {
                { 1, 94929, 96113 },	-- Deadly Glare Cape
                { 2, 94822, 96108 },	-- Reinforced Mirror-Sheen Cloak
                { 3, 94928, 96112 },	-- Chilblain Spaulders
                { 4, 94925, 96110 },	-- Lifedrainer's Sordid Grip
                { 5, 94923, 96111 },	-- Leggings of Pulsing Blood
                { 6, 94816, 96101 },	-- Crimson Bloom Legguards
                { 7, 94927, 96116 },	-- Sandals of the Starving Eye
                { 8, 94818, 96103 },	-- Aberrant Chestguard of Torment
                { 9, 94926, 96117 },	-- Vein-Cover Bracers
                { 10, 94819, 96102 },	-- Links of the Disintegrator
                { 11, 94820, 96104 },	-- Caustic Spike Bracers
                { 12, 94821, 96107 },	-- Artery Rippers
                { 13, 94924, 96118 },	-- Iceshatter Gauntlets
                { 14, 94930, 96119 },	-- Legplates of Re-Emergence
                { 15, 94815, 96105 },	-- Legplates of the Dark Parasite
                { 16, 94817, 96106 },	-- Treads of the Blind Eye
                { 18, 94931, 96114 },	-- Durumu's Captive Eyeball
                { 19, 95511, 96109 },	-- Durumu's Severed Tentacle
                { 21, 94922, 96115 },	-- Ritual Dagger of the Mind's Eye
                { 22, 94814, 96100 },	-- Durumu's Baleful Gaze
                { 24, "ac8098" },
            },
            [HEROIC_DIFF] = {
                { 1, 96485, 96857 },	-- Deadly Glare Cape
                { 2, 96480, 96852 },	-- Reinforced Mirror-Sheen Cloak
                { 3, 96484, 96856 },	-- Chilblain Spaulders
                { 4, 96482, 96854 },	-- Lifedrainer's Sordid Grip
                { 5, 96483, 96855 },	-- Leggings of Pulsing Blood
                { 6, 96473, 96845 },	-- Crimson Bloom Legguards
                { 7, 96488, 96860 },	-- Sandals of the Starving Eye
                { 8, 96475, 96847 },	-- Aberrant Chestguard of Torment
                { 9, 96489, 96861 },	-- Vein-Cover Bracers
                { 10, 96474, 96846 },	-- Links of the Disintegrator
                { 11, 96476, 96848 },	-- Caustic Spike Bracers
                { 12, 96479, 96851 },	-- Artery Rippers
                { 13, 96490, 96862 },	-- Iceshatter Gauntlets
                { 14, 96491, 96863 },	-- Legplates of Re-Emergence
                { 15, 96477, 96849 },	-- Legplates of the Dark Parasite
                { 16, 96478, 96850 },	-- Treads of the Blind Eye
                { 18, 96486, 96858 },	-- Durumu's Captive Eyeball
                { 19, 96481, 96853 },	-- Durumu's Severed Tentacle
                { 21, 96487, 96859 },	-- Ritual Dagger of the Mind's Eye
                { 22, 96472, 96844 },	-- Durumu's Baleful Gaze
                { 24, "ac8062" },
                { 25, "ac8098" },
            },
        },
        {	--ToTPrimordius
            EncounterJournalID = 820,
            [NORMAL_DIFF] = {
                { 1, 94942, 96127 },	-- Hydra-Scale Bloodcloak
                { 2, 94951, 96131 },	-- Robes of Mutagenic Blood
                { 3, 94948, 96134 },	-- Bracers of Fragile Bone
                { 4, 94947, 96132 },	-- Helix-Breaker Gloves
                { 5, 94953, 96133 },	-- Leggings of Ebon Veins
                { 6, 94939, 96121 },	-- Gloves of Cushioned Air
                { 7, 94946, 96136 },	-- Leggings of the Malformed Sapling
                { 8, 94949, 96137 },	-- Clear-Mind Helm
                { 9, 94940, 96122 },	-- Bracers of Mutagenic Fervor
                { 10, 94943, 96123 },	-- Synapse-String Handguards
                { 11, 94941, 96126 },	-- Metabolically Boosted Shoulderplates
                { 12, 94950, 96139 },	-- Spaulders of Primordial Growth
                { 13, 94952, 96138 },	-- Bonemender Bracers
                { 14, 94938, 96124 },	-- Pathogenic Gauntlets
                { 15, 94944, 96125 },	-- Black Blood Legplates
                { 16, 95513, 96128 },	-- Band of the Scaled Tyrant
                { 17, 94519, 96129 },	-- Primordius' Talisman of Rage
                { 18, 94525, 96135 },	-- Stolen Relic of Zuldazar
                { 19, 94522, 96120 },	-- Talisman of Bloodlust
                { 21, 94937, 96130 },	-- Acid-Spine Bonemace
                { 22, 94945, 96140 },	-- Greatshield of the Gloaming
                { 24, 97960, "pet1244" },	-- Dark Quivering Blob
                { 26, "ac8037" },
            },
            [HEROIC_DIFF] = {
                { 1, 96499, 96871 },	-- Hydra-Scale Bloodcloak
                { 2, 96503, 96875 },	-- Robes of Mutagenic Blood
                { 3, 96506, 96878 },	-- Bracers of Fragile Bone
                { 4, 96504, 96876 },	-- Helix-Breaker Gloves
                { 5, 96505, 96877 },	-- Leggings of Ebon Veins
                { 6, 96493, 96865 },	-- Gloves of Cushioned Air
                { 7, 96508, 96880 },	-- Leggings of the Malformed Sapling
                { 8, 96509, 96881 },	-- Clear-Mind Helm
                { 9, 96494, 96866 },	-- Bracers of Mutagenic Fervor
                { 10, 96495, 96867 },	-- Synapse-String Handguards
                { 11, 96498, 96870 },	-- Metabolically Boosted Shoulderplates
                { 12, 96511, 96883 },	-- Spaulders of Primordial Growth
                { 13, 96510, 96882 },	-- Bonemender Bracers
                { 14, 96496, 96868 },	-- Pathogenic Gauntlets
                { 15, 96497, 96869 },	-- Black Blood Legplates
                { 16, 96500, 96872 },	-- Band of the Scaled Tyrant
                { 17, 96501, 96873 },	-- Primordius' Talisman of Rage
                { 18, 96507, 96879 },	-- Stolen Relic of Zuldazar
                { 19, 96492, 96864 },	-- Talisman of Bloodlust
                { 21, 96502, 96874 },	-- Acid-Spine Bonemace
                { 22, 96512, 96884 },	-- Greatshield of the Gloaming
                { 24, 97960, "pet1244" },	-- Dark Quivering Blob
                { 26, "ac8063" },
                { 27, "ac8037" },
            },
        },
        {	--ToTDarkAnimus
            EncounterJournalID = 824,
            [NORMAL_DIFF] = {
                { 1, 94960, 96145 },	-- Constantly Accelerating Cloak
                { 2, 94959, 96143 },	-- Hood of the Crimson Wake
                { 3, 94957, 96148 },	-- Anima-Ringed Fingers
                { 4, 94962, 96147 },	-- Worldbinder Leggings
                { 5, 94958, 96150 },	-- Crown of the Golden Golem
                { 6, 94956, 96149 },	-- Matter-Swapped Legplates
                { 8, 94961, 96141 },	-- Gore-Soaked Gear
                { 9, 94531, 96144 },	-- Cha-Ye's Essence of Brilliance
                { 10, 94518, 96151 },	-- Delicate Vial of the Sanguinaire
                { 16, 95574 },	-- Chest of the Crackling Conqueror
                { 17, 95579 },	-- Chest of the Crackling Protector
                { 18, 95569 },	-- Chest of the Crackling Vanquisher
                { 20, 94955, 96146 },	-- Athame of the Sanguine Ritual
                { 21, 94954, 96142 },	-- Hand of the Dark Animus
                { 23, 94152, "pet1183" },	-- Son of Animus
                { 25, "ac8081" },
            },
            [HEROIC_DIFF] = {
                { 1, 96517, 96889 },	-- Constantly Accelerating Cloak
                { 2, 96515, 96887 },	-- Hood of the Crimson Wake
                { 3, 96520, 96892 },	-- Anima-Ringed Fingers
                { 4, 96519, 96891 },	-- Worldbinder Leggings
                { 5, 96522, 96894 },	-- Crown of the Golden Golem
                { 6, 96521, 96893 },	-- Matter-Swapped Legplates
                { 8, 96513, 96885 },	-- Gore-Soaked Gear
                { 9, 96516, 96888 },	-- Cha-Ye's Essence of Brilliance
                { 10, 96523, 96895 },	-- Delicate Vial of the Sanguinaire
                { 16, 96567 },	-- Chest of the Crackling Conqueror
                { 17, 96568 },	-- Chest of the Crackling Protector
                { 18, 96566 },	-- Chest of the Crackling Vanquisher
                { 20, 96518, 96890 },	-- Athame of the Sanguine Ritual
                { 21, 96514, 96886 },	-- Hand of the Dark Animus
                { 23, 94152, "pet1183" },	-- Son of Animus
                { 25, "ac8064" },
                { 26, "ac8081" },
            },
        },
        {	--ToTIronQon
            EncounterJournalID = 817,
            [NORMAL_DIFF] = {
                { 1, 94970, 96154 },	-- Quet'zal's Crackling Cord
                { 2, 94966, 96155 },	-- Saddle-Scarred Leggings
                { 3, 94968, 96156 },	-- Dam'ren's Frozen Footguards
                { 4, 94967, 96159 },	-- Spurs of the Storm Cavalry
                { 5, 94969, 96160 },	-- Ro'shak's Molten Chain
                { 6, 94972, 96161 },	-- Rein-Binder's Fists
                { 8, 95512, 96157 },	-- Ro'shak's Remembrance
                { 16, 95578 },	-- Shoulders of the Crackling Conqueror
                { 17, 95583 },	-- Shoulders of the Crackling Protector
                { 18, 95573 },	-- Shoulders of the Crackling Vanquisher
                { 20, 94971, 96152 },	-- Iron Qon's Boot Knife
                { 21, 94964, 96162 },	-- Qon's Flaming Scimitar
                { 22, 94963, 96153 },	-- Voice of the Quilen
                { 23, 94965, 96158 },	-- Orb of Arcing Lightning
                { 25, "ac8087" },
            },
            [HEROIC_DIFF] = {
                { 1, 96526, 96898 },	-- Quet'zal's Crackling Cord
                { 2, 96527, 96899 },	-- Saddle-Scarred Leggings
                { 3, 96528, 96900 },	-- Dam'ren's Frozen Footguards
                { 4, 96531, 96903 },	-- Spurs of the Storm Cavalry
                { 5, 96532, 96904 },	-- Ro'shak's Molten Chain
                { 6, 96533, 96905 },	-- Rein-Binder's Fists
                { 8, 96529, 96901 },	-- Ro'shak's Remembrance
                { 16, 96700 },	-- Shoulders of the Crackling Conqueror
                { 17, 96701 },	-- Shoulders of the Crackling Protector
                { 18, 96699 },	-- Shoulders of the Crackling Vanquisher
                { 20, 96524, 96896 },	-- Iron Qon's Boot Knife
                { 21, 96534, 96906 },	-- Qon's Flaming Scimitar
                { 22, 96525, 96897 },	-- Voice of the Quilen
                { 23, 96530, 96902 },	-- Orb of Arcing Lightning
                { 25, "ac8065" },
                { 26, "ac8087" },
            },
        },
        {	--ToTTwinConsorts
            EncounterJournalID = 829,
            [NORMAL_DIFF] = {
                { 1, 94977, 96164 },	-- Robes of the Moon Lotus
                { 2, 94979, 96168 },	-- Bracers of the Midnight Comet
                { 3, 94978, 96169 },	-- Girdle of Night and Day
                { 4, 94757, 96173 },	-- Fingers of the Night
                { 5, 94976, 96170 },	-- Tidal Force Treads
                { 7, 94981, 96172 },	-- Moonjade Necklace
                { 8, 94980, 96165 },	-- Passionfire Choker
                { 9, 94529, 96171 },	-- Gaze of the Twins
                { 16, 95577 },	-- Helm of the Crackling Conqueror
                { 17, 95582 },	-- Helm of the Crackling Protector
                { 18, 95571 },	-- Helm of the Crackling Vanquisher
                { 20, 94974, 96167 },	-- Suen-Wo, Spire of the Falling Sun
                { 21, 94973, 96163 },	-- Wu-Lai, Bladed Fan of the Consorts
                { 22, 95515, 96166 },	-- Shield of Twinned Despair
                { 24, "ac8086" },
            },
            [HEROIC_DIFF] = {
                { 1, 96536, 96908 },	-- Robes of the Moon Lotus
                { 2, 96540, 96912 },	-- Bracers of the Midnight Comet
                { 3, 96541, 96913 },	-- Girdle of Night and Day
                { 4, 96545, 96917 },	-- Fingers of the Night
                { 5, 96542, 96914 },	-- Tidal Force Treads
                { 7, 96544, 96916 },	-- Moonjade Necklace
                { 8, 96537, 96909 },	-- Passionfire Choker
                { 9, 96543, 96915 },	-- Gaze of the Twins
                { 16, 96624 },	-- Helm of the Crackling Conqueror
                { 17, 96625 },	-- Helm of the Crackling Protector
                { 18, 96623 },	-- Helm of the Crackling Vanquisher
                { 20, 96539, 96911 },	-- Suen-Wo, Spire of the Falling Sun
                { 21, 96535, 96907 },	-- Wu-Lai, Bladed Fan of the Consorts
                { 22, 96538, 96910 },	-- Shield of Twinned Despair
                { 24, "ac8066" },
                { 25, "ac8086" },
            },
        },
        {	--ToTLeiShen
            EncounterJournalID = 832,
            [NORMAL_DIFF] = {
                { 1, 94993, 96185 },	-- Gloves of the Maimed Vizier
                { 2, 94990, 96184 },	-- Legwraps of Cardinality
                { 3, 94987, 96176 },	-- Fusion Slasher Chestguard
                { 4, 94991, 96191 },	-- Grips of Slicing Electricity
                { 5, 94986, 96177 },	-- Conduit-Breaker Chain Leggings
                { 6, 94992, 96192 },	-- Leggings of the Violent Gale
                { 7, 94984, 96178 },	-- Doomed Crown of Lei Shen
                { 8, 94989, 96193 },	-- Lei Shen's Grounded Carapace
                { 9, 95535, 96179 },	-- Legplates of the Lightning Throne
                { 10, 94985, 96180 },	-- Legplates of Whipping Ionization
                { 12, 94867, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Heart of the Thunder King
                { 16, 94994, 96188 },	-- Soul Prism of Lei Shen
                { 17, 94530, 96189 },	-- Lightning-Imbued Chalice
                { 18, 94532, 96174 },	-- Rune of Re-Origination
                { 19, 94528, 96183 },	-- Soul Barrier
                { 20, 94524, 96186 },	-- Unerring Vision of Lei Shen
                { 22, 94983, 96175 },	-- Shan-Dun, Breaker of Hope
                { 23, 94988, 96187 },	-- Torall, Rod of the Shattered Throne
                { 24, 94982, 96181 },	-- Uroe, Harbinger of Terror
                { 25, 95472, 96182 },	-- Ultimate Protection of the Emperor
                { 26, 95473, 96190 },	-- Lei Shen's Orb of Command
                { 28, "ac8090" },
            },
            [HEROIC_DIFF] = {
                { 1, 96557, 96929 },	-- Gloves of the Maimed Vizier
                { 2, 96556, 96928 },	-- Legwraps of Cardinality
                { 3, 96548, 96920 },	-- Fusion Slasher Chestguard
                { 4, 96563, 96935 },	-- Grips of Slicing Electricity
                { 5, 96549, 96921 },	-- Conduit-Breaker Chain Leggings
                { 6, 96564, 96936 },	-- Leggings of the Violent Gale
                { 7, 96550, 96922 },	-- Doomed Crown of Lei Shen
                { 8, 96565, 96937 },	-- Lei Shen's Grounded Carapace
                { 9, 96551, 96923 },	-- Legplates of the Lightning Throne
                { 10, 96552, 96924 },	-- Legplates of Whipping Ionization
                { 12, 94867, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Heart of the Thunder King
                { 16, 96560, 96932 },	-- Soul Prism of Lei Shen
                { 17, 96561, 96933 },	-- Lightning-Imbued Chalice
                { 18, 96546, 96918 },	-- Rune of Re-Origination
                { 19, 96555, 96927 },	-- Soul Barrier
                { 20, 96558, 96930 },	-- Unerring Vision of Lei Shen
                { 22, 96547, 96919 },	-- Shan-Dun, Breaker of Hope
                { 23, 96559, 96931 },	-- Torall, Rod of the Shattered Throne
                { 24, 96553, 96925 },	-- Uroe, Harbinger of Terror
                { 25, 96554, 96926 },	-- Ultimate Protection of the Emperor
                { 26, 96562, 96934 },	-- Lei Shen's Orb of Command
                { 28, "ac8067" },
                { 29, "ac8090" },
            },
        },
        {	--ToTRaden
            EncounterJournalID = 831,
            [HEROIC_DIFF] = {
                { 1, 95013 },	-- Black Night Thundercloak
                { 2, 95015 },	-- Grey Wind Mistcloak
                { 3, 95014 },	-- Red Sky Cloudcloak
                { 4, 95016 },	-- White Snow Skycloak
                { 5, 95017 },	-- Yellow Dawn Lightningcloak
                { 6, 95040 },	-- Robes of Nova
                { 7, 95039 },	-- Starburner Robes
                { 8, 94995 },	-- Detonation Cord
                { 9, 94996 },	-- Vita-Binder Wrap
                { 10, 95030 },	-- Leggings of the Discarded Warning
                { 11, 95031 },	-- Legguards of Surreal Visions
                { 12, 95004 },	-- Starwalker Sandals
                { 13, 95005 },	-- Treads of Delicate Fascia
                { 14, 95033 },	-- Chestguard of Coruscating Blades
                { 15, 95032 },	-- Robes of Contagious Time
                { 16, 94998 },	-- Strap of Murderous Strikes
                { 17, 94997 },	-- Worldbender Waistband
                { 18, 95028 },	-- Cosmicfire Legwraps
                { 19, 95029 },	-- Kilt of Perpetual Genuflection
                { 20, 95006 },	-- Roots of Pain
                { 21, 95007 },	-- Twist-Toe Tabi
                { 22, 95035 },	-- Chains of Counted Souls
                { 23, 95034 },	-- Scales of Shaped Flesh
                { 24, 95000 },	-- Jingling Fetishgirdle
                { 25, 94999 },	-- Longdraw Chain Belt
                { 26, 95027 },	-- Legguards of Awaked Repair
                { 27, 95026 },	-- Sparkstring Chain Leggings
                { 28, 95009 },	-- Treads of the Sanguine Volley
                { 29, 95008 },	-- World-Mote Sabatons
                { 101, 95038 },	-- Carapace of the Core
                { 102, 95036 },	-- Nova-Binder Breastplate
                { 103, 95037 },	-- Planet-Birthed Cuirass
                { 104, 95001 },	-- Bubbling Anima Belt
                { 105, 95002 },	-- Cracklesnap Clasp
                { 106, 95003 },	-- Flare-Forged Greatbelt
                { 107, 95025 },	-- Archaic Protector's Legguards
                { 108, 95023 },	-- Legplates of Lightning Blood
                { 109, 95024 },	-- Time-Lost Greaves
                { 110, 95010 },	-- Hypersensitive Sollerets
                { 111, 95011 },	-- Lightning-Walker Clawfeet
                { 112, 95012 },	-- Sabatons of the Superior Being
                { 116, 95020 },	-- Ra-den's Contemplative Loop
                { 117, 95018 },	-- Ra-den's Evolving Signet
                { 118, 95022 },	-- Ra-den's Ruinous Ring
                { 119, 95019 },	-- Ra-den's Summoning Band
                { 120, 95021 },	-- Ra-den's Swift Seal
                { 122, "ac8068" },
            },
        },
        {	--ToTShared
            name = AL["Shared Boss Loot"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 95061, 96235 },	-- Lost Shoulders of Fire
                { 2, 95067, 96237 },	-- Lost Shoulders of Fluidity
                { 3, 95066, 96236 },	-- Lost Shoulders of Healing
                { 4, 95065, 96240 },	-- Forgotten Mantle of the Moon
                { 5, 95062, 96241 },	-- Forgotten Mantle of the Sun
                { 6, 95060, 96242 },	-- Abandoned Spaulders of Arrowflight
                { 7, 95064, 96243 },	-- Abandoned Spaulders of Renewal
                { 8, 95068, 96246 },	-- Reconstructed Bloody Shoulderplates
                { 9, 95063, 96245 },	-- Reconstructed Furious Shoulderplates
                { 10, 95069, 96244 },	-- Reconstructed Holy Shoulderplates
                { 16, 95498, 96249 },	-- Bo-Ris, Horror in the Night
                { 17, 95507, 96234 },	-- Darkwood Spiritstaff
                { 18, 95502, 96248 },	-- Do-tharak, the Swordbreaker
                { 19, 95501, 96232 },	-- Fyn's Flickering Dagger
                { 20, 95505, 96247 },	-- Greatsword of Frozen Hells
                { 21, 95499, 96230 },	-- Invocation of the Dawn
                { 22, 95500, 96239 },	-- Jerthud, Graceful Hand of the Savior
                { 23, 95503, 96231 },	-- Miracoran, the Vehement Chord
                { 24, 95506, 96238 },	-- Nadagast's Exsanguinator
                { 25, 97126, 97128 },	-- Tia-Tia, the Scything Star
                { 26, 95504, 96233 },	-- Zeeg's Ancient Kegsmasher
                { 27, 95516, 96250 },	-- Visage of the Doomed
            },
            [HEROIC_DIFF] = {
                { 1, 96607, 96979 },	-- Lost Shoulders of Fire
                { 2, 96609, 96981 },	-- Lost Shoulders of Fluidity
                { 3, 96608, 96980 },	-- Lost Shoulders of Healing
                { 4, 96612, 96984 },	-- Forgotten Mantle of the Moon
                { 5, 96613, 96985 },	-- Forgotten Mantle of the Sun
                { 6, 96614, 96986 },	-- Abandoned Spaulders of Arrowflight
                { 7, 96615, 96987 },	-- Abandoned Spaulders of Renewal
                { 8, 96618, 96990 },	-- Reconstructed Bloody Shoulderplates
                { 9, 96617, 96989 },	-- Reconstructed Furious Shoulderplates
                { 10, 96616, 96988 },	-- Reconstructed Holy Shoulderplates
                { 16, 96621, 96993 },	-- Bo-Ris, Horror in the Night
                { 17, 96606, 96978 },	-- Darkwood Spiritstaff
                { 18, 96620, 96992 },	-- Do-tharak, the Swordbreaker
                { 19, 96604, 96976 },	-- Fyn's Flickering Dagger
                { 20, 96619, 96991 },	-- Greatsword of Frozen Hells
                { 21, 96602, 96974 },	-- Invocation of the Dawn
                { 22, 96611, 96983 },	-- Jerthud, Graceful Hand of the Savior
                { 23, 96603, 96975 },	-- Miracoran, the Vehement Chord
                { 24, 96610, 96982 },	-- Nadagast's Exsanguinator
                { 25, 97127, 97130 },	-- Tia-Tia, the Scything Star
                { 26, 96605, 96977 },	-- Zeeg's Ancient Kegsmasher
                { 27, 96622, 96994 },	-- Visage of the Doomed
            },
        },
        {	--ToTTrash
            name = AL["Trash Mobs"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 95207, 96333 },	-- Abandoned Zandalari Firecord
                { 2, 95208, 96334 },	-- Abandoned Zandalari Shadowgirdle
                { 3, 95224, 96337 },	-- Home-Warding Slippers
                { 4, 95223, 96335 },	-- Silentflame Sandals
                { 5, 95210, 96343 },	-- Abandoned Zandalari Moonstrap
                { 6, 95209, 96342 },	-- Abandoned Zandalari Silentbelt
                { 7, 95221, 96338 },	-- Deeproot Treads
                { 8, 95219, 96331 },	-- Spiderweb Tabi
                { 9, 95211, 96344 },	-- Abandoned Zandalari Arrowlinks
                { 10, 95212, 96345 },	-- Abandoned Zandalari Waterchain
                { 11, 95220, 96332 },	-- Scalehide Spurs
                { 12, 95222, 96339 },	-- Spiritbound Boots
                { 13, 95215, 96348 },	-- Abandoned Zandalari Bucklebreaker
                { 14, 95214, 96347 },	-- Abandoned Zandalari Goreplate
                { 15, 95213, 96346 },	-- Abandoned Zandalari Greatbelt
                { 16, 95218, 96351 },	-- Columnbreaker Stompers
                { 17, 95217, 96350 },	-- Locksmasher Greaves
                { 18, 95216, 96340 },	-- Vaultwalker Sabatons
                { 20, 95202, 96330 },	-- Necklace of the Terra-Cotta Archer
                { 21, 95203, 96336 },	-- Necklace of the Terra-Cotta Invoker
                { 22, 95204, 96341 },	-- Necklace of the Terra-Cotta Mender
                { 23, 95206, 96352 },	-- Necklace of the Terra-Cotta Protector
                { 24, 95205, 96349 },	-- Necklace of the Terra-Cotta Vanquisher
                { 26, 94125 },	-- Living Sandling
            },
        },
        T15_SET,
        MOP_RAID2_AC_TABLE,
    }
}

--[[
data["SiegeofOrgrimmar"] = {
    EncounterJournalID = 369,
    MapID = 6622,
    ContentType = RAID_CONTENT,
    items = {
        {	--SoOImmerseus
            EncounterJournalID = 852,
            npcId = 71543,
            [FLEX] = {
                { 1, 112425 },	-- Cloak of Misguided Power
                { 2, 112424 },	-- Hood of Swirling Senses
                { 3, 112423 },	-- Ichor-Dripping Shoulderpads
                { 4, 112422 },	-- Bolt-Burster Grips
                { 5, 112382 },	-- Hood of Blackened Tears
                { 6, 112429 },	-- Bracers of Purified Spirit
                { 7, 112428 },	-- Salt Water Sandals
                { 8, 112445 },	-- Soul-Soaked Gloves
                { 9, 112383 },	-- Puddle Punishers
                { 10, 112421 },	-- Pauldrons of Violent Eruption
                { 11, 112417 },	-- Chestplate of Congealed Corrosion
                { 12, 112420 },	-- Bracers of Sordid Sleep
                { 13, 112416 },	-- Bubble-Burst Bracers
                { 14, 112418 },	-- Corruption-Rotted Gauntlets
                { 15, 112447 },	-- Greatbelt of Living Waters
                { 16, 112419 },	-- Treads of Unchained Hate
                { 17, 112448 },	-- Waterwalker Greatboots
                { 19, 110761 },	-- Immerseus' Crystalline Eye
                { 20, 112427 },	-- Seal of Eternal Sorrow
                { 21, 112426 },	-- Purified Bindings of Immerseus
                { 23, 110785 },	-- Encapsulated Essence of Immerseus
                { 24, 110784 },	-- Trident of Corrupted Waters
                { 26, "ac8536" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 27, "ac8463" },
            },
        },
        {	--SoOFallenProtectors
            EncounterJournalID = 849,
            npcId = 71475,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 24, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112485 },	-- Gloomwrap Greatcloak
                { 2, 112488 },	-- Shoulderpads of Dou Dou Chong
                { 3, 112487 },	-- Robes of the Tendered Heart
                { 4, 112489 },	-- Lifebane Bracers
                { 5, 112486 },	-- Sha-Seared Sandals
                { 6, 112492 },	-- Shoulders of the Roiling Inferno
                { 7, 112479 },	-- Stonetoe's Tormented Treads
                { 8, 112494 },	-- Shoulderguards of Dark Meditations
                { 9, 112480 },	-- Grips of Unending Anguish
                { 10, 112493 },	-- Sabatons of Defilement
                { 11, 112496 },	-- Gaze of Echoing Despair
                { 12, 112481 },	-- Darkfallen Shoulderplates
                { 13, 112495 },	-- Grips of the Fallen Council
                { 14, 112483 },	-- Shockstriker Gauntlets
                { 15, 112482 },	-- Poisonbinder Girth
                { 16, 112490 },	-- Petrified Pennyroyal Ring
                { 17, 112484 },	-- Sorrowpath Signet
                { 18, 112476 },	-- Rook's Unlucky Talisman
                { 20, 112478 },	-- Death Lotus Crossbow
                { 21, 112477 },	-- Softfoot's Last Resort
                { 22, 112491 },	-- Purehearted Cricket Cage
                { 24, "ac8528" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 25, "ac8465" },
            },
        },
        {	--SoONorushen
            EncounterJournalID = 866,
            npcId = 72276,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 26, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112554 },	-- Drape of the Despairing Pit
                { 2, 112558 },	-- Rime-Rift Shoulders
                { 3, 112555 },	-- Bracers of Broken Causation
                { 4, 112556 },	-- Blight Hurlers
                { 5, 112557 },	-- Sash of the Last Guardian
                { 6, 112549 },	-- Robes of the Blackened Watcher
                { 7, 112562 },	-- Confident Grips
                { 8, 112548 },	-- Gloves of the Golden Protector
                { 9, 112561 },	-- Boots of Broken Reliance
                { 10, 112550 },	-- Quarantine Shoulderguards
                { 11, 112563 },	-- Bracers of Final Serenity
                { 12, 112551 },	-- Leggings of Unabashed Anger
                { 13, 112564 },	-- Shadow-Binder's Kilt
                { 14, 112552 },	-- Rage-Blind Greathelm
                { 15, 112545 },	-- Bracers of Blind Hatred
                { 16, 112565 },	-- Wristplates of Broken Doubt
                { 18, 112559 },	-- Untainted Guardian's Chain
                { 19, 112553 },	-- Reality Ripper Ring
                { 20, 112503 },	-- Fusion-Fire Core
                { 22, 112547 },	-- Norushen's Shortblade
                { 23, 112546 },	-- Xifeng, Longblade of the Titanic Guardian
                { 24, 112560 },	-- Norushen's Enigmatic Barrier
                { 26, "ac8532" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 27, "ac8466" },
            },
        },
        {	--SoOShaofPride
            EncounterJournalID = 867,
            npcId = 71734,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99678:0" },	-- Chest of the Cursed Conqueror
                { 17, "99679:0" },	-- Chest of the Cursed Protector
                { 18, "99677:0" },	-- Chest of the Cursed Vanquisher
                { 24, "104163:0", "pet1332" },	-- Gooey Sha-ling
                { 25, nil },
                { 27, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112952 },	-- Self-Reflecting Mask
                { 2, 112702 },	-- Crown of Boastful Words
                { 3, 112953 },	-- Greaves of Sublime Superiority
                { 5, 112955 },	-- Choker of the Final Word
                { 6, 112954 },	-- Necklace of Fading Light
                { 7, 112947 },	-- Assurance of Consequence
                { 8, 112948 },	-- Prismatic Prison of Pride
                { 16, 99743 },	-- Chest of the Cursed Conqueror
                { 17, 99744 },	-- Chest of the Cursed Protector
                { 18, 99742 },	-- Chest of the Cursed Vanquisher
                { 20, 112951 },	-- Gaze of Arrogance
                { 21, 112949 },	-- Greatsword of Pride's Fall
                { 22, 112950 },	-- Shield of Mockery
                { 24, "104162:0", "pet1331" },	-- Droplet of Y'Shaarj
                { 25, "104163:0", "pet1332" },	-- Gooey Sha-ling
                { 27, "ac8521" },
            },
            [HEROIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99686:0", false },	-- Chest of the Cursed Conqueror
                { 17, "99691:0", false },	-- Chest of the Cursed Protector
                { 18, "99696:0", false },	-- Chest of the Cursed Vanquisher
                { 25, nil },
                { 26, "ac8521" },
                { 27, nil },
            },
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = HEROIC_SOO_DIFF,
                { 16, "99715:0", false },	-- Chest of the Cursed Conqueror
                { 17, "99716:0", false },	-- Chest of the Cursed Protector
                { 18, "99714:0", false },	-- Chest of the Cursed Vanquisher
                { 27, "ac8467" },
            },
        },
        {	--SoOGalakras
            EncounterJournalID = 868,
            npcId = 72249,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 26, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112717 },	-- Flameslinger's Fiery Cowl
                { 2, 112719 },	-- Shoulderpads of Pulsing Protection
                { 3, 112716 },	-- Scalebane Bracers
                { 4, 112715 },	-- Bone-Inlaid Sandals
                { 5, 112718 },	-- Skydancer Boots
                { 6, 112707 },	-- Korgra's Venom-Soaked Gauntlets
                { 7, 112725 },	-- Dragonmaw Emergency Strap
                { 8, 112706 },	-- Unrepentant Heels
                { 9, 112712 },	-- Dagryn's Fuselight Bracers
                { 10, 112726 },	-- Grips of Tidal Force
                { 11, 112711 },	-- Cannoneer's Multipocket Gunbelt
                { 12, 112713 },	-- Thranok's Shattering Helm
                { 13, 112705 },	-- Krugruk's Rigid Shoulderplates
                { 14, 112704 },	-- Arcsmasher Bracers
                { 15, 112727 },	-- Smoldering Drakescale Bracers
                { 16, 112728 },	-- Windfire Legplates
                { 18, 112721 },	-- Extinguished Ember of Galakras
                { 19, 112714 },	-- Galakrond Control Band
                { 20, 112709 },	-- Swift Serpent Signet
                { 21, 112703 },	-- Evil Eye of Galakras
                { 23, 112710 },	-- Dagryn's Discarded Longbow
                { 24, 112723 },	-- Drakebinder Greatstaff
                { 26, "ac8530" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 27, "ac8468" },
            },
        },
        {	--SoOIronJuggernaut
            EncounterJournalID = 864,
            npcId = 71466,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 26, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112746 },	-- Shock Pulse Robes
                { 2, 112745 },	-- Bracers of the Broken Fault
                { 3, 112946 },	-- Earthripper Gloves
                { 4, 112743 },	-- Belt of Ominous Trembles
                { 5, 112744 },	-- Leggings of Furious Flame
                { 6, 112740 },	-- Ricocheting Shoulderguards
                { 7, 112749 },	-- Castlebreaker Bracers
                { 8, 112739 },	-- Laser Burn Bracers
                { 9, 112751 },	-- Cavemaker Wristguards
                { 10, 112734 },	-- Precision Cutters
                { 11, 112731 },	-- Minelayer's Padded Boots
                { 12, 112750 },	-- Treads of Autonomic Motion
                { 13, 112741 },	-- Earthbreaker's Steaming Chestplate
                { 14, 112733 },	-- Wall-Borer Bracers
                { 15, 112732 },	-- Tar-Coated Gauntlets
                { 16, 112735 },	-- Demolisher's Reinforced Belt
                { 17, 112752 },	-- Borer Drill Boots
                { 19, 112742 },	-- Juggernaut's Ignition Keys
                { 20, 112747 },	-- Laser-Slice Signet
                { 21, 112729 },	-- Juggernaut's Focusing Crystal
                { 23, 112736 },	-- Seismic Bore
                { 24, 112748 },	-- Juggernaut's Power Core
                { 26, "ac8520" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 27, "ac8469" },
            },
        },
        {	--SoODarkShaman
            EncounterJournalID = 856,
            npcId = 71859,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 25, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112764 },	-- Poisonmist Nightcloak
                { 2, 112766 },	-- Iron Wolf Hood
                { 3, 112765 },	-- Toxic Tornado Treads
                { 4, 112770 },	-- Darkfang Mask
                { 5, 112760 },	-- Damron's Belt of Darkness
                { 6, 112761 },	-- Riou's Vigilant Leggings
                { 7, 112762 },	-- Haromm's Horrifying Helm
                { 8, 112772 },	-- Shoulderguards of Foul Streams
                { 9, 112771 },	-- Belt of the Iron Prison
                { 10, 112774 },	-- Shoulderplates of Gushing Geysers
                { 11, 112755 },	-- Breastplate of Shamanic Mirrors
                { 12, 112773 },	-- Shackles of Stinking Slime
                { 13, 112763 },	-- Ashen Wall Girdle
                { 14, 112757 },	-- Wolf-Rider Spurs
                { 16, 112767 },	-- Ashflare Pendant
                { 17, 112756 },	-- Bloodclaw Band
                { 18, 112758 },	-- Ring of the Iron Tomb
                { 19, 112754 },	-- Haromm's Talisman
                { 20, 112768 },	-- Kardris' Toxic Totem
                { 22, 112759 },	-- Haromm's Frozen Crescent
                { 23, 112769 },	-- Kardris' Scepter
                { 25, "ac8453" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 26, "ac8470" },
            },
        },
        {	--SoONazgrim
            EncounterJournalID = 850,
            npcId = 71515,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99681:0" },	-- Gauntlets of the Cursed Conqueror
                { 17, "99667:0" },	-- Gauntlets of the Cursed Protector
                { 18, "99680:0" },	-- Gauntlets of the Cursed Vanquisher
                { 25, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112790 },	-- Spaulders of Kor'kron Fealty
                { 2, 112782 },	-- Sandals of Two Little Bees
                { 3, 112783 },	-- Shoulderguards of the Righteous Stand
                { 4, 112788 },	-- Robes of the Warrior's Fall
                { 5, 112789 },	-- Crown of Tragic Truth
                { 6, 112779 },	-- Ravager's Pathwalkers
                { 8, 112778 },	-- Nazgrim's Burnished Insignia
                { 16, 99746 },	-- Gauntlets of the Cursed Conqueror
                { 17, 99747 },	-- Gauntlets of the Cursed Protector
                { 18, 99745 },	-- Gauntlets of the Cursed Vanquisher
                { 20, 112787 },	-- Arcweaver Spell Sword
                { 21, 112785 },	-- Gar'tok, Strength of the Faithful
                { 22, 112780 },	-- Nazgrim's Gutripper
                { 23, 112781 },	-- Bulwark of the Fallen General
                { 25, "ac8448" },
            },
            [HEROIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99687:0", false },	-- Gauntlets of the Cursed Conqueror
                { 17, "99692:0", false },	-- Gauntlets of the Cursed Protector
                { 18, "99682:0", false },	-- Gauntlets of the Cursed Vanquisher
            },
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99721:0", false },	-- Gauntlets of the Cursed Conqueror
                { 17, "99722:0", false },	-- Gauntlets of the Cursed Protector
                { 18, "99720:0", false },	-- Gauntlets of the Cursed Vanquisher
                { 26, "ac8471" },
            },
        },
        {	--SoOMalkorok
            EncounterJournalID = 846,
            npcId = 71454,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 27, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112816 },	-- Black-Blooded Drape
                { 2, 112813 },	-- Hood of Perpetual Implosion
                { 3, 112814 },	-- Robes of Riven Dreams
                { 4, 112808 },	-- Miasmic Skullbelt
                { 5, 112794 },	-- Lazahk's Lost Shadowrap
                { 6, 112820 },	-- Bracers of Averted Fatality
                { 7, 112819 },	-- Boots of Perilous Infusion
                { 8, 112821 },	-- Ebon Blood Chestguard
                { 9, 112797 },	-- Wristguards of Ruination
                { 10, 112823 },	-- Terrorguard Chestplate
                { 11, 112793 },	-- Blood Rage Bracers
                { 12, 112807 },	-- Legplates of Willful Doom
                { 13, 112796 },	-- Malkorok's Giant Stompers
                { 16, 112803 },	-- Malkorok's Tainted Dog Tags
                { 17, 112795 },	-- Ring of Restless Energy
                { 18, 112817 },	-- Seal of Sullen Fury
                { 19, 112815 },	-- Frenzied Crystal of Rage
                { 20, 112792 },	-- Vial of Living Corruption
                { 22, 112805 },	-- Halberd of Inner Shadows
                { 23, 112806 },	-- Kor'kron Hand Cannon
                { 24, 112804 },	-- Malkorok's Skullcleaver
                { 25, 112818 },	-- Visage of the Monstrous
                { 27, "ac8538" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 28, "ac8472" },
            },
        },
        {	--SoOSpoils
            EncounterJournalID = 870,
            npcId = 71889,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 24, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112838 },	-- Mantid Vizier's Robes
                { 2, 112837 },	-- Avool's Ancestral Bracers
                { 3, 112833 },	-- Mantid Carapace Augments
                { 4, 112842 },	-- Klaxxi Grips of Rejuvenation
                { 5, 112843 },	-- Shado-Pan Reliquary Kilt
                { 6, 112827 },	-- Pandaren Roofsprinters
                { 7, 112836 },	-- Ancient Archer's Chestguard
                { 8, 112845 },	-- Bracers of the Pristine Purifier
                { 9, 112831 },	-- Arrowflight Girdle
                { 10, 112844 },	-- Chitin-Link Chain Belt
                { 11, 112832 },	-- Helm of the Night Watchman
                { 12, 112846 },	-- Plate Belt of the War-Healer
                { 13, 112834 },	-- Untarnishable Greatbelt
                { 14, 112847 },	-- Mogu Mindbender's Greaves
                { 15, 112826 },	-- Ominous Mogu Greatboots
                { 16, 112839 },	-- Lost Necklace of the Mogu Empress
                { 17, 112828 },	-- Seal of the Forgotten Kings
                { 18, 112825 },	-- Sigil of Rampage
                { 20, 112835 },	-- Enchanted Shao-Tien Saber
                { 21, 112841 },	-- Immaculately Preserved Wand
                { 22, 112829 },	-- Ancient Mogu Tower Shield
                { 24, "ac8529" },
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 25, "ac8478" },
            },
        },
        {	--SoOThok
            EncounterJournalID = 851,
            npcId = 71529,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99672:0" },	-- Helm of the Cursed Conqueror
                { 17, "99673:0" },	-- Helm of the Cursed Protector
                { 18, "99671:0" },	-- Helm of the Cursed Vanquisher
                { 24, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112866 },	-- Akolik's Acid-Soaked Robes
                { 2, 112854 },	-- Montak's Grips of Scorching Breath
                { 3, 112856 },	-- Icy Blood Chestplate
                { 5, 112851 },	-- Gleaming Eye of the Devilsaur
                { 6, 112855 },	-- Devilfang Band
                { 7, 112852 },	-- Signet of the Dinomancers
                { 8, 112849 },	-- Thok's Acid-Grooved Tooth
                { 9, 112850 },	-- Thok's Tail Tip
                { 16, 99749 },	-- Helm of the Cursed Conqueror
                { 17, 99750 },	-- Helm of the Cursed Protector
                { 18, 99748 },	-- Helm of the Cursed Vanquisher
                { 20, 112862 },	-- Britomart's Jagged Pike
                { 21, 112853 },	-- Hvitserk's Formidable Shanker
                { 22, 112861 },	-- Festering Primordial Globule
                { 24, "ac8527" },
            },
            [HEROIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99689:0", false },	-- Helm of the Cursed Conqueror
                { 17, "99694:0", false },	-- Helm of the Cursed Protector
                { 18, "99683:0", false },	-- Helm of the Cursed Vanquisher
            },
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99724:0", false },	-- Helm of the Cursed Conqueror
                { 17, "99725:0", false },	-- Helm of the Cursed Protector
                { 18, "99723:0", false },	-- Helm of the Cursed Vanquisher
                { 25, "ac8479" },
            },
        },
        {	--SoOBlackfuse
            EncounterJournalID = 865,
            npcId = 71504,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99669:0" },	-- Shoulders of the Cursed Conqueror
                { 17, "99670:0" },	-- Shoulders of the Cursed Protector
                { 18, "99668:0" },	-- Shoulders of the Cursed Vanquisher
                { 25, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112898 },	-- Fusespark Gloves
                { 2, 112896 },	-- Bomber's Blackened Wristwatch
                { 3, 112895 },	-- Bracers of Infinite Pipes
                { 4, 112890 },	-- Powder-Stained Totemic Treads
                { 5, 112882 },	-- Calixian Bladebreakers
                { 7, 112894 },	-- Blackfuse's Blasting Cord
                { 8, 112883 },	-- Asgorathian Blood Seal
                { 9, 112877 },	-- Dysmorphic Samophlange of Discontinuity
                { 10, 112879 },	-- Ticking Ebon Detonator
                { 16, 99755 },	-- Shoulders of the Cursed Conqueror
                { 17, 99756 },	-- Shoulders of the Cursed Protector
                { 18, 99754 },	-- Shoulders of the Cursed Vanquisher
                { 20, 112892 },	-- Lever of the Megantholithic Apparatus
                { 21, 112897 },	-- Siegecrafter's Forge Hammer
                { 23, "104158:0", "pet1322" },	-- Blackfuse Bombling
                { 25, "ac8543" },
            },
            [HEROIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99690:0", false },	-- Shoulders of the Cursed Conqueror
                { 17, "99695:0", false },	-- Shoulders of the Cursed Protector
                { 18, "99685:0", false },	-- Shoulders of the Cursed Vanquisher
            },
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99718:0", false },	-- Shoulders of the Cursed Conqueror
                { 17, "99719:0", false },	-- Shoulders of the Cursed Protector
                { 18, "99717:0", false },	-- Shoulders of the Cursed Vanquisher
                { 26, "ac8480" },
            },
        },
        {	--SoOParagons
            EncounterJournalID = 853,
            npcId = 71161,
            [RF_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99675:0" },	-- Leggings of the Cursed Conqueror
                { 17, "99676:0" },	-- Leggings of the Cursed Protector
                { 18, "99674:0" },	-- Leggings of the Cursed Vanquisher
                { 27, nil },
            },
            [NORMAL_DIFF] = {
                { 1, 112914 },	-- Bracers of Sonic Projection
                { 2, 112923 },	-- Amber Parasite Wraps
                { 3, 112919 },	-- Chestguard of Toxic Injections
                { 4, 112915 },	-- Gauntlets of Insane Calculations
                { 6, 112916 },	-- Iyyokuk's Hereditary Seal
                { 7, 112917 },	-- Kil'ruk's Band of Ascendancy
                { 8, 112913 },	-- Skeer's Bloodsoaked Talisman
                { 16, 99752 },	-- Leggings of the Cursed Conqueror
                { 17, 99753 },	-- Leggings of the Cursed Protector
                { 18, 99751 },	-- Leggings of the Cursed Vanquisher
                { 20, 112918 },	-- Hisek's Reserve Longbow
                { 21, 112921 },	-- Kil'ruk's Furious Blade
                { 22, 112920 },	-- Korven's Crimson Crescent
                { 23, 112922 },	-- Rik'kal's Bloody Scalpel
                { 25, "104165:0", "pet1334" },	-- Kovok
                { 27, "ac8531" },
            },
            [HEROIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99688:0", false },	-- Leggings of the Cursed Conqueror
                { 17, "99693:0", false },	-- Leggings of the Cursed Protector
                { 18, "99684:0", false },	-- Leggings of the Cursed Vanquisher
            },
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 16, "99712:0", false },	-- Leggings of the Cursed Conqueror
                { 17, "99713:0", false },	-- Leggings of the Cursed Protector
                { 18, "99726:0", false },	-- Leggings of the Cursed Vanquisher
                { 28, "ac8481" },
            },
        },
        {	--SoOGarrosh
            EncounterJournalID = 869,
            npcId = 71865,
            [RF_SOO_DIFF] = {
                { 1, 112937 },	-- Ebon Ritual Hood
                { 2, 112936 },	-- Belt of the Broken Pact
                { 3, 112926 },	-- Kor'kron Elite Skullmask
                { 4, 112942 },	-- Hopeglow Spaulders
                { 5, 112929 },	-- Cord of Black Dreams
                { 6, 112941 },	-- Seal of Karmic Return
                { 7, 112943 },	-- Cowl of Smoking Dreams
                { 8, 112930 },	-- Penetrating Gaze of Y'Shaarj
                { 9, 112927 },	-- Shoulderguards of Intended Power
                { 10, 112931 },	-- Chestguard of Relentless Tyranny
                { 11, 112928 },	-- Greathelm of the Warchief
                { 12, 112945 },	-- Mantle of Looming Darkness
                { 13, 112934 },	-- Spaulders of the Fallen Warchief
                { 14, 112944 },	-- Chestplate of Fallen Passion
                { 15, 112933 },	-- Legplates of Unthinking Strife
                { 16, "105861:0" },	-- Essence of the Cursed Conqueror
                { 17, "105860:0" },	-- Essence of the Cursed Protector
                { 18, "105862:0" },	-- Essence of the Cursed Vanquisher
                { 20, 112938 },	-- Black Blood of Y'Shaarj
                { 21, 112924 },	-- Curse of Hubris
                { 23, 112939 },	-- Horned Mace of the Old Ones
                { 24, 112932 },	-- Kor'kron Spire of Supremacy
                { 25, 112925 },	-- Xal'atoh, Desecrated Image of Gorehowl
                { 26, 112940 },	-- Revelations of Y'Shaarj
            },
            [NORMAL_DIFF] = {
                { 1, 112937 },	-- Ebon Ritual Hood
                { 2, 112936 },	-- Belt of the Broken Pact
                { 3, 112926 },	-- Kor'kron Elite Skullmask
                { 4, 112942 },	-- Hopeglow Spaulders
                { 5, 112929 },	-- Cord of Black Dreams
                { 6, 112941 },	-- Seal of Karmic Return
                { 7, 112943 },	-- Cowl of Smoking Dreams
                { 8, 112930 },	-- Penetrating Gaze of Y'Shaarj
                { 9, 112927 },	-- Shoulderguards of Intended Power
                { 10, 112931 },	-- Chestguard of Relentless Tyranny
                { 11, 112928 },	-- Greathelm of the Warchief
                { 12, 112945 },	-- Mantle of Looming Darkness
                { 13, 112934 },	-- Spaulders of the Fallen Warchief
                { 14, 112944 },	-- Chestplate of Fallen Passion
                { 15, 112933 },	-- Legplates of Unthinking Strife
                { 16, 105864 },	-- Essence of the Cursed Conqueror
                { 17, 105863 },	-- Essence of the Cursed Protector
                { 18, 105865 },	-- Essence of the Cursed Vanquisher
                { 20, 112938 },	-- Black Blood of Y'Shaarj
                { 21, 112924 },	-- Curse of Hubris
                { 23, 112939 },	-- Horned Mace of the Old Ones
                { 24, 112932 },	-- Kor'kron Spire of Supremacy
                { 25, 112925 },	-- Xal'atoh, Desecrated Image of Gorehowl
                { 26, 112940 },	-- Revelations of Y'Shaarj
                { 101, 105672 },	-- Hellscream's Cleaver
                { 102, 105679 },	-- Hellscream's Decapitator
                { 103, 105678 },	-- Hellscream's Doomblade
                { 104, 105673 },	-- Hellscream's Pig Sticker
                { 105, 105671 },	-- Hellscream's Razor
                { 106, 105677 },	-- Hellscream's War Staff
                { 107, 105670 },	-- Hellscream's Warbow
                { 108, 105675 },	-- Hellscream's Warmace
                { 109, 105674 },	-- Hellscream's Barrier
                { 110, 105680 },	-- Hellscream's Shield Wall
                { 111, 105676, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Hellscream's Tome of Destruction
                { 116, "ac8537" },
            },
            [HEROIC_SOO_DIFF] = {
                GetItemsFromDiff = NORMAL_DIFF,
                { 14, 112935 },	-- Tusks of Mannoroth
                { 15, 112944 },	-- Chestplate of Fallen Passion
                { 16, 112933 },	-- Legplates of Unthinking Strife
                { 17, nil },
                { 18, "105858:0", false },	-- Essence of the Cursed Conqueror
                { 19, "105857:0", false },	-- Essence of the Cursed Protector
                { 20, "105859:0", false },	-- Essence of the Cursed Vanquisher
                { 21, nil },
                { 22, 112938 },	-- Black Blood of Y'Shaarj
                { 23, 112924 },	-- Curse of Hubris
                { 24, nil },
                { 25, 112939 },	-- Horned Mace of the Old Ones
                { 26, 112932 },	-- Kor'kron Spire of Supremacy
                { 27, 112925 },	-- Xal'atoh, Desecrated Image of Gorehowl
                { 28, 112940 },	-- Revelations of Y'Shaarj
                { 101, "104404:0", false },	-- Hellscream's Cleaver
                { 102, "104405:0", false },	-- Hellscream's Decapitator
                { 103, "104401:0", false },	-- Hellscream's Doomblade
                { 104, "104403:0", false },	-- Hellscream's Pig Sticker
                { 105, "104400:0", false },	-- Hellscream's Razor
                { 106, "104406:0", false },	-- Hellscream's War Staff
                { 107, "104399:0", false },	-- Hellscream's Warbow
                { 108, "104402:0", false },	-- Hellscream's Warmace
                { 109, "104409:0", false },	-- Hellscream's Barrier
                { 110, "104407:0", false },	-- Hellscream's Shield Wall
                { 111, "104408:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Hellscream's Tome of Destruction
                { 117, [ATLASLOOT_IT_ALLIANCE] = "ac8679", [ATLASLOOT_IT_HORDE] = "ac8680" },
            },
            [MYTHIC_SOO_DIFF] = {
                GetItemsFromDiff = HEROIC_SOO_DIFF,
                { 18, "105867:0", false },	-- Essence of the Cursed Conqueror
                { 19, "105866:0", false },	-- Essence of the Cursed Protector
                { 20, "105868:0", false },	-- Essence of the Cursed Vanquisher
                { 30, "104253:0", "mount" },	-- Kor'kron Juggernaut
                { 101, "105685:0", false },	-- Hellscream's Cleaver
                { 102, "105692:0", false },	-- Hellscream's Decapitator
                { 103, "105691:0", false },	-- Hellscream's Doomblade
                { 104, "105686:0", false },	-- Hellscream's Pig Sticker
                { 105, "105684:0", false },	-- Hellscream's Razor
                { 106, "105690:0", false },	-- Hellscream's War Staff
                { 107, "105683:0", false },	-- Hellscream's Warbow
                { 108, "105688:0", false },	-- Hellscream's Warmace
                { 109, "105687:0", false },	-- Hellscream's Barrier
                { 110, "105693:0", false },	-- Hellscream's Shield Wall
                { 111, "105689:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Hellscream's Tome of Destruction
                { 118, "ac8482" },
            },
        },
        {	--SoOShared
            name = AL["Shared Boss Loot"],
            ExtraList = true,
            [RF_SOO_DIFF] = {
                { 1, "104271:0" },	-- Coalesced Turmoil
                { 2, "104275:0" },	-- Twisted Treasures of the Vale
                { 3, 113224 },	-- Aeth's Swiftcinder Cloak
                { 4, 113231 },	-- Brave Niunai's Cloak
                { 5, 113226 },	-- Cape of the Alpha
                { 6, 113230 },	-- Drape of the Omega
                { 7, 113223 },	-- Turtleshell Greatcloak
                { 16, 113225 },	-- Kalaena's Arcane Handwraps
                { 17, 113218 },	-- Seebo's Sainted Touch
                { 18, 113220 },	-- Crimson Gauntlets of Death
                { 19, 113221 },	-- Siid's Silent Stranglers
                { 20, 113222 },	-- Keengrip Arrowpullers
                { 21, 113227 },	-- Marco's Crackling Gloves
                { 22, 113228 },	-- Gauntlets of Discarded Time
                { 23, 113219 },	-- Romy's Reliable Grips
                { 24, 113229 },	-- Zoid's Molten Gauntlets
            },
        },
        {	--SoOTrash
            name = AL["Trash Mobs"],
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 113224, false },	-- Aeth's Swiftcinder Cloak
                { 2, 113231, false },	-- Brave Niunai's Cloak
                { 3, 113226, false },	-- Cape of the Alpha
                { 4, 113230, false },	-- Drape of the Omega
                { 5, 113223, false },	-- Turtleshell Greatcloak
                { 7, 113225, false },	-- Kalaena's Arcane Handwraps
                { 8, 113218, false },	-- Seebo's Sainted Touch
                { 9, 113220, false },	-- Crimson Gauntlets of Death
                { 10, 113221, false },	-- Siid's Silent Stranglers
                { 11, 113222, false },	-- Keengrip Arrowpullers
                { 12, 113227, false },	-- Marco's Crackling Gloves
                { 13, 113228, false },	-- Gauntlets of Discarded Time
                { 14, 113219, false },	-- Romy's Reliable Grips
                { 15, 113229, false },	-- Zoid's Molten Gauntlets
                { 16, "105745:0", false },	-- Kor'kron Dark Shaman Cowl
                { 17, "105747:0", false },	-- Kor'kron Dark Shaman Shoulder
                { 18, "105743:0", false },	-- Kor'kron Dark Shaman Vestment
                { 19, "105748:0", false },	-- Kor'kron Dark Shaman Bracers
                { 20, "105744:0", false },	-- Kor'kron Dark Shaman Gloves
                { 21, "105741:0", false },	-- Kor'kron Dark Shaman Belt
                { 22, "105746:0", false },	-- Kor'kron Dark Shaman Kilt
                { 23, "105742:0", false },	-- Kor'kron Dark Shaman Treads
            },
            [HEROIC_SOO_DIFF] = NORMAL_DIFF,
            [MYTHIC_SOO_DIFF] = NORMAL_DIFF,
        },
        T16_SET,
        {	--ACPage
            name = AL["Achievements"],
            TableType = AC_ITTYPE,
            ExtraList = true,
            CoinTexture = "Achievement",
            [NORMAL_DIFF] = {
                { 1, 8454 },
                { 2, 8536 },
                { 3, 8532 },
                { 4, 8530 },
                { 5, 8453 },
                { 6, 8538 },
                { 7, 8527 },
                { 8, 8531 },
                { 17, 8528 },
                { 18, 8521 },
                { 19, 8520 },
                { 20, 8448 },
                { 21, 8529 },
                { 22, 8543 },
                { 23, 8537 },
                { 10, 8458 },
                { 25, 8459 },
                { 11, 8461 },
                { 26, 8462 },
            },
            [HEROIC_DIFF] = {
                { 1, 8463 },
                { 2, 8465 },
                { 3, 8466 },
                { 4, 8467 },
                { 5, 8468 },
                { 6, 8469 },
                { 7, 8470 },
                { 16, 8471 },
                { 17, 8472 },
                { 18, 8478 },
                { 19, 8479 },
                { 20, 8480 },
                { 21, 8481 },
                { 22, 8482 },
            },
        },
    },
}
--]]
