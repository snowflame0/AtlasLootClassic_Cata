-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
    local d = C_Map.GetAreaInfo(id)
    return d or ("GetAreaInfo" .. id)
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.MOP_VERSION_NUM) then
    return
end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.MOP_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

-- local RAIDFINDER_DIFF = data:AddDifficulty("Raid Finder", nil, nil, nil, true)
local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
-- local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
local VENDOR_DIFF_P1 = data:AddDifficulty(AL["Vendor"] .. " - " .. AL["P1"], "vendor", 0)
local VENDOR_DIFF_P2 = data:AddDifficulty(AL["Vendor"] .. " - " .. AL["P2"], "vendor", 0)

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
    HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
    ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
    LOAD_DIFF = HORDE_DIFF
else
    ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
    HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
    LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Item", "Achievement")

-- local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
-- local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
-- local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
-- local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local SUPERIOR_QUALITY = "|cff0070dd%s|r"
local EPIC_QUALITY = "|cffa335ee%s|r"
local BOA_QUALITY = "|cff00ccff%s|r"
local LEGENDARY_QUALITY = "|cffff8000%s|r"
--local BLUE = "|cff0070dd%s|r"
-- local GREY = "|cff999999%s|r"
-- local GREEN = "|cff66cc33%s|r"
-- local RED = "|cffcc6666%s|r"
-- local PURPLE = "|cffa335ee%s|r"
-- local WHIT = "|cffffffff%s|r"

data["CookingVendorMoP"] = {
    name = format(AL["'%s' Vendor"], ALIL["Cooking"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.COOKING_VENDOR,
    items = {
        {
            name = AL["Recipe"],
            [VENDOR_DIFF] = {
                { 1,  75017 }, -- Recipe: Great Pandaren Banquet
            }
        },
    }
}

data["ValorPointsMoP"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, AL["Valor Points"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.VALOR_POINTS,
     items = {
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"] .. " / " .. ALIL["Leather"],
        [VENDOR_DIFF] = { -- Cloth
            { 1,  77147 }, -- Hood of Hidden Flesh
            { 2,  77122 }, -- Robes of Searing Shadow
            { 3,  77324 }, -- Chronoboost Bracers
            { 4,  77159 }, -- Clockwinder's Immaculate Gloves
            { 5,  77179 }, -- Tentacular Belt
            { 6,  77176 }, -- Kavan's Forsaken Treads
            { 8,  77146 }, -- Soulgaze Cowl
            { 9,  77121 }, -- Lightwarper Vestments
            { 10, 77323 }, -- Bracers of the Black Dream
            { 11, 77157 }, -- The Hands of Gilly
            { 12, 77187 }, -- Vestal's Irrepressible Girdle
            { 13, 77177 }, -- Splinterfoot Sandals
            -- Leather
            { 16, 77149 }, -- Helmet of Perpetual Rebirth
            { 17, 77127 }, -- Decaying Herbalist's Robes
            { 18, 77320 }, -- Luminescent Bracers
            { 19, 77160 }, -- Fungus-Born Gloves
            { 20, 77181 }, -- Belt of Universal Curing
            { 21, 77172 }, -- Boots of Fungoid Growth
            { 23, 77148 }, -- Nocturnal Gaze
            { 24, 77126 }, -- Shadowbinder Chestguard
            { 25, 77322 }, -- Bracers of Manifold Pockets
            { 26, 77161 }, -- Lightfinger Handwraps
            { 27, 77180 }, -- Belt of Hidden Keys
            { 28, 77173 }, -- Rooftop Griptoes
            }
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = { -- Mail
            { 1,  77151 }, -- Wolfdream Circlet
            { 2,  77125 }, -- Ghostworld Chestguard
            { 3,  77319 }, -- Bracers of the Spectral Wolf
            { 4,  77163 }, -- Gloves of Ghostly Dreams
            { 5,  77183 }, -- Girdle of Shamanic Fury
            { 6,  77174 }, -- Sabatons of the Graceful Spirit
            { 8,  77150 }, -- Zeherah's Dragonskull Crown
            { 9,  77124 }, -- Dragonflayer Vest
            { 10, 77321 }, -- Dragonbelly Bracers
            { 11, 77162 }, -- Arrowflick Gauntlets
            { 12, 77182 }, -- Cord of Dragon Sinew
            { 13, 77175 }, -- Boneshard Boots
            }
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = { -- Plate
            { 1,  77153 }, -- Glowing Wings of Hope
            { 2,  77123 }, -- Shining Carapace of Glory
            { 3,  77316 }, -- Flashing Bracers of Warmth
            { 4,  77164 }, -- Gleaming Grips of Mending
            { 5,  77184 }, -- Blinding Girdle of Truth
            { 6,  77169 }, -- Silver Sabatons of Fury
            { 8,  77155 }, -- Visage of Petrification
            { 9,  77119 }, -- Bones of the Damned
            { 10, 77317 }, -- Heartcrusher Wristplates
            { 11, 77165 }, -- Grimfist Crushers
            { 12, 77185 }, -- Demonbone Waistguard
            { 13, 77170 }, -- Kneebreaker Boots
            { 16, 77156 }, -- Jaw of Repudiation
            { 17, 77120 }, -- Chestplate of the Unshakable Titan
            { 18, 77318 }, -- Bracers of Unrelenting Excellence
            { 19, 77166 }, -- Gauntlets of Feathery Blows
            { 20, 77186 }, -- Forgesmelter Waistplate
            { 21, 77171 }, -- Bladeshatter Treads
            }
        },
        {
        name = ALIL["Armor"] .. " - " .. AL["Accessories"],
        [VENDOR_DIFF] = { -- Plate
            { 1,  77095 }, -- Batwing Cloak
            { 2,  77097 }, -- Dreamcrusher Drape
            { 3,  77099 }, -- Indefatigable Greatcloak
            { 4,  77098 }, -- Nanoprecise Cape
            { 5,  77096 }, -- Woundlicker Cover
            { 7,  77091 }, -- Cameo of Terrible Memories
            { 8,  77092 }, -- Guardspike Choker
            { 9,  77090 }, -- Necklace of Black Dragon's Teeth
            { 10, 77088 }, -- Opal of the Secret Order
            { 11, 77089 }, -- Threadlinked Chain
            { 13, 77081 }, -- Gutripper Shard
            { 14, 77083 }, -- Lightning Spirit in a Bottle
            { 15, 77082 }, -- Mindbender Lens
            { 16, 77109 }, -- Band of Reconstruction
            { 17, 77111 }, -- Emergency Descent Loop
            { 18, 77110 }, -- Ring of Torn Flesh
            { 19, 77108 }, -- Seal of the Grand Architect
            { 20, 77112 }, -- Signet of the Resolute
            { 22, 77114 }, -- Bottled Wishes
            { 23, 77117 }, -- Fire of the Deep
            { 24, 77113 }, -- Kiroptyric Sigil
            { 25, 77115 }, -- Reflection of the Light
            { 26, 77116 }, -- Rotting Skull
            { 28, 77080 }, -- Ripfang Relic
            { 29, 77084 }, -- Stoutheart Talisman
            }
        },
    }
}

data["JusticePointsMoP"] = {
    name = format(AL["'%s' Vendor"], format(SUPERIOR_QUALITY, AL["Justice Points"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.JUSTICE_POINTS,
     items = {
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [VENDOR_DIFF] = { -- Mage
            { 1,  60244 }, -- Firelord's Robes
            { 2,  60247 }, -- Firelord's Gloves
            { 3,  60245 }, -- Firelord's Leggings
            -- Warlock
            { 5,  60251 }, -- Shadowflame Robes
            { 6,  60248 }, -- Shadowflame Handwraps
            { 7,  60250 }, -- Shadowflame Leggings
            -- Priest
            { 16, 60259 }, -- Mercurial Robes
            { 17, 60275 }, -- Mercurial Handwraps
            { 18, 60261 }, -- Mercurial Legwraps
            { 20, 60254 }, -- Mercurial Vestment
            { 21, 60257 }, -- Mercurial Gloves
            { 22, 60255 }, -- Mercurial Leggings
            -- Misc
            { 9,  58485 }, -- Melodious Slippers
            { 10, 58486 } -- Slippers of Moving Waters
        },
        [VENDOR_DIFF_P1] = {
            -- Head
            { 1,  58155 }, -- Cowl of Pleasant Gloom
            { 16, 58161 }, -- Mask of New Snow
            -- Shoulder
            { 3,  58157 }, -- Meadow Mantle
            { 18, 58162 }, -- Summer Song Shoulderwraps
            -- Chest
            { 5,  58153 }, -- Robes of Embalmed Darkness
            { 20, 58159 }, -- Musk Rose Robes
            -- Hands
            { 7,  58158 }, -- Gloves of the Painless Midnight
            { 22, 58163 }, -- Gloves of Purification
            -- Waist
            { 9,  57921 }, -- Incense Infused Cummerbund
            { 24, 57922 }, -- Belt of the Falling Rain
            -- Legs
            { 11, 58154 }, -- Pensive Legwraps
            { 26, 58160 } -- Leggings of Charity
        },
        [VENDOR_DIFF_P2] = { -- Mage
            { 1,  71289 }, -- Firehawk Robes
            { 2,  71286 }, -- Firehawk Gloves
            { 3,  71288 }, -- Firehawk Leggings
            -- Warlock
            { 5,  71284 }, -- Balespider's Robes
            { 6,  71281 }, -- Balespider's Handwraps
            { 7,  71283 }, -- Balespider's Leggings
            -- Priest
            { 16, 71274 }, -- Robes of the Cleansing Flame
            { 17, 71271 }, -- Handwraps of the Cleansing Flame
            { 18, 71273 }, -- Legwraps of the Cleansing Flame
            { 20, 71279 }, -- Vestment of the Cleansing Flame
            { 21, 71276 }, -- Gloves of the Cleansing Flame
            { 22, 71278 }, -- Leggings of the Cleansing Flame
            -- Misc
            { 9,  71265 }, -- Emberflame Bracers
            { 10, 71266 } -- Firesoul Wristguards
            }
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [VENDOR_DIFF] = { -- Druid
            { 1,  60276 }, -- Stormrider's Robes
            { 2,  60280 }, -- Stormrider's Handwraps
            { 3,  60278 }, -- Stormrider's Legwraps
            { 5,  60287 }, -- Stormrider's Raiment
            { 6,  60290 }, -- Stormrider's Grips
            { 7,  60288 }, -- Stormrider's Legguards
            { 9,  60281 }, -- Stormrider's Vestment
            { 10, 60285 }, -- Stormrider's Gloves
            { 11, 60283 }, -- Stormrider's Leggings
            -- Rouge
            { 16, 60301 }, -- Wind Dancer's Tunic
            { 17, 60298 }, -- Wind Dancer's Gloves
            { 18, 60300 }, -- Wind Dancer's Legguards
            -- Misc
            { 13, 58482 }, -- Treads of Fleeting Joy
            { 14, 58484 } -- Fading Violet Sandals
        },
        [VENDOR_DIFF_P1] = { -- Head
            { 1,  58150 }, -- Cluster of Stars
            { 16, 58133 }, -- Mask of Vines
            -- Shoulder
            { 3,  58151 }, -- Somber Shawl
            { 18, 58134 }, -- Embrace of the Night
            -- Chest
            { 5,  58139 }, -- Chestguard of Forgetfulness
            { 20, 58131 }, -- Tunic of Sinking Envy
            -- Hands
            { 7,  58152 }, -- Blessed Hands of Elune
            { 22, 58138 }, -- Sticky Fingers
            -- Waist
            { 9,  57919 }, -- Thatch Eave Vines
            { 24, 57918 }, -- Sash of Musing
            -- Legs
            { 11, 58140 }, -- Leggings of Late Blooms
            { 26, 58132 } -- Leggings of the Burrowing Mole
        },
        [VENDOR_DIFF_P2] = { -- Druid
            { 1,  71105 }, -- Obsidian Arborweave Tunic
            { 2,  71102 }, -- Obsidian Arborweave Handwraps
            { 3,  71104 }, -- Obsidian Arborweave Legwraps
            { 5,  71100 }, -- Obsidian Arborweave Raiment
            { 6,  71097 }, -- Obsidian Arborweave Grips
            { 7,  71099 }, -- Obsidian Arborweave Legguards
            { 9,  71110 }, -- Obsidian Arborweave Vestment
            { 10, 71107 }, -- Obsidian Arborweave Gloves
            { 11, 71109 }, -- Obsidian Arborweave Leggings
            -- Rouge
            { 16, 71045 }, -- Dark Phoenix Tunic
            { 17, 71046 }, -- Dark Phoenix Gloves
            { 18, 71048 }, -- Dark Phoenix Legguards
            -- Misc
            { 13, 71262 }, -- Smolderskull Bindings
            { 14, 71130 } -- Flamebinder Bracers
            }
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = { -- Shaman
            { 1,  60313 }, -- Hauberk of the Raging Elements
            { 2,  60314 }, -- Gloves of the Raging Elements
            { 3,  60316 }, -- Kilt of the Raging Elements
            { 5,  60309 }, -- Tunic of the Raging Elements
            { 6,  60312 }, -- Handwraps of the Raging Elements
            { 7,  60310 }, -- Legwraps of the Raging Elements
            { 9,  60318 }, -- Cuirass of the Raging Elements
            { 10, 60319 }, -- Grips of the Raging Elements
            { 11, 60321 }, -- Legguards of the Raging Elements
            -- Rouge
            { 16, 60304 }, -- Lightning-Charged Tunic
            { 17, 60307 }, -- Lightning-Charged Gloves
            { 18, 60305 }, -- Lightning-Charged Legguards
            -- Misc
            { 13, 58199 }, -- Moccasins of Verdurous Glooms
            { 14, 58481 } -- Boots of the Perilous Seas
        },
        [VENDOR_DIFF_P1] = { -- Head
            { 1,  58128 }, -- Helm of the Inward Eye
            { 16, 58123 }, -- Willow Mask
            -- Shoulder
            { 3,  58129 }, -- Seafoam Mantle
            { 18, 58124 }, -- Wrap of the Valley Glades
            -- Chest
            { 5,  58126 }, -- Vest of the Waking Dream
            { 20, 58121 }, -- Vest of the True Companion
            -- Hands
            { 7,  58130 }, -- Gleaning Gloves
            { 22, 58125 }, -- Gloves of the Passing Night
            -- Waist
            { 9,  57917 }, -- Belt of the Still Stream
            { 24, 57916 }, -- Belt of the Dim Forest
            -- Legs
            { 11, 58127 }, -- Leggings of Soothing Silence
            { 26, 58122 } -- Hillside Striders
        },
        [VENDOR_DIFF_P2] = { -- Shaman
            { 1,  71294 }, -- Erupting Volcanic Hauberk
            { 2,  71292 }, -- Erupting Volcanic Gloves
            { 3,  71291 }, -- Erupting Volcanic Kilt
            { 5,  71296 }, -- Erupting Volcanic Tunic
            { 6,  71297 }, -- Erupting Volcanic Handwraps
            { 7,  71299 }, -- Erupting Volcanic Legwraps
            { 9,  71301 }, -- Erupting Volcanic Cuirass
            { 10, 71302 }, -- Erupting Volcanic Grips
            { 11, 71304 }, -- Erupting Volcanic Legguards
            -- Rouge
            { 16, 71054 }, -- Flamewalker's Tunic
            { 17, 71050 }, -- Flamewalker's Gloves
            { 18, 71052 }, -- Flamewalker's Legguards
            -- Misc
            { 13, 71263 }, -- Bracers of Misting Ash
            { 14, 71264 } -- Bracers of Forked Lightning
            }
        },
        {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = { -- Paladin
            { 1,  60360 }, -- Reinforced Sapphirium Breastplate
            { 2,  60363 }, -- Reinforced Sapphirium Gloves
            { 3,  60361 }, -- Reinforced Sapphirium Greaves
            { 4,  60344 }, -- Reinforced Sapphirium Battleplate
            { 5,  60345 }, -- Reinforced Sapphirium Gauntlets
            { 6,  60347 }, -- Reinforced Sapphirium Legplates
            { 7,  60354 }, -- Reinforced Sapphirium Chestguard
            { 8,  60355 }, -- Reinforced Sapphirium Handguards
            { 9,  60357 }, -- Reinforced Sapphirium Legguards
            -- Warrior
            { 11, 60323 }, -- Earthen Battleplate
            { 12, 60326 }, -- Earthen Gauntlets
            { 13, 60324 }, -- Earthen Legplates
            { 16, 60329 }, -- Earthen Chestguard
            { 17, 60332 }, -- Earthen Handguards
            { 18, 60330 }, -- Earthen Legguards
            -- DK
            { 20, 60339 }, -- Magma Plated Battleplate
            { 21, 60340 }, -- Magma Plated Gauntlets
            { 22, 60342 }, -- Magma Plated Legplates
            { 24, 60349 }, -- Magma Plated Chestguard
            { 25, 60350 }, -- Magma Plated Handguards
            { 26, 60352 }, -- Magma Plated Legguards
            -- Misc
            { 28, 58197 }, -- Rock Furrow Boots
            { 29, 58198 }, -- Eternal Pathfinders
            { 30, 58195 } -- Woe Breeder's Boots
        },
        [VENDOR_DIFF_P1] = {
            -- Head
            { 1,  58103 }, -- Helm of the Proud
            { 2,  58098 }, -- Helm of Easeful Death
            { 3,  58108 }, -- Crown of the Blazing Sun
            -- Shoulder
            { 5,  58104 }, -- Sunburnt Pauldrons
            { 6,  58100 }, -- Pauldrons of the High Requiem
            { 7,  58109 }, -- Pauldrons of the Forlorn
            -- Chest
            { 9,  58101 }, -- Chestplate of the Steadfast
            { 10, 58096 }, -- Breastplate of Raging Fury
            { 11, 58106 }, -- Chestguard of Dancing Waves
            -- Hands
            { 16, 58105 }, -- Numbing Handguards
            { 17, 58099 }, -- Reaping Gauntlets
            { 18, 58110 }, -- Gloves of Curious Conscience
            -- Waist
            { 20, 57914 }, -- Girdle of the Mountains
            { 21, 57913 }, -- Beech Green Belt
            { 22, 57915 }, -- Belt of Barred Clouds
            -- Legs
            { 24, 58102 }, -- Greaves of Splendor
            { 25, 58097 }, -- Greaves of Gallantry
            { 26, 58107 } -- Legguards of the Gentle
        },
        [VENDOR_DIFF_P2] = { -- Paladin
            { 1,  71091 }, -- Immolation Breastplate
            { 2,  71092 }, -- Immolation Sapphirium Gloves
            { 3,  71094 }, -- Immolation Sapphirium Greaves
            { 4,  71063 }, -- Immolation Sapphirium Battleplate
            { 5,  71064 }, -- Immolation Sapphirium Gauntlets
            { 6,  71066 }, -- Immolation Sapphirium Legplates
            { 7,  70950 }, -- Immolation Sapphirium Chestguard
            { 8,  70949 }, -- Immolation Sapphirium Handguards
            { 9,  70947 }, -- Immolation Sapphirium Legguards
            -- DK
            { 11, 71058 }, -- Elementium Deathplate Breastplate
            { 12, 71059 }, -- Elementium Deathplate Gauntlets
            { 13, 71061 }, -- Elementium Deathplate Greaves
            { 16, 70955 }, -- Elementium Deathplate Chestguard
            { 17, 70953 }, -- Elementium Deathplate Handguards
            { 18, 70952 }, -- Elementium Deathplate Legguards
            -- Warrior
            { 20, 71068 }, -- Battleplate of the Molten Giant
            { 21, 71069 }, -- Gauntlets of the Molten Giant
            { 22, 71071 }, -- Legplates of the Molten Giant
            { 24, 70945 }, -- Chestguard of the Molten Giant
            { 25, 70943 }, -- Handguards of the Molten Giant
            { 26, 70942 }, -- Legguards of the Molten Giant
            -- Misc
            { 28, 71260 }, -- Bracers of Imperious Truths
            { 29, 70937 }, -- Bracers of Regal Force
            { 30, 71261 } -- Gigantform Bracers
            }
        },
        {
        name = ALIL["Cloak"],
        [VENDOR_DIFF_P1] = {
            { 1, 58192 }, -- Gray Hair Cloak
            { 2, 58190 }, -- Floating Web
            { 4, 58191 }, -- Viewless Wings
            { 16, 58193 }, -- Haunt of Flies
            { 17, 58194 }, -- Heavenly Breeze
            }
        },
        {
            name = AL["Ranged Weapons"],
        [VENDOR_DIFF_P2] = {
            { 1, 71218 }, -- Deflecting Star
            { 2, 71154 }, -- Giantslicer
            { 4, 71152 }, -- Morningstar Shard
            { 16, 71151 }, -- Trail of Embers
            { 17, 71150 }, -- Scorchvine Wand
             }
        },
        {
        name = ALIL["Off Hand"] .. "/" .. ALIL["Shield"],
        [VENDOR_DIFF_P1] = {
            { 1, 57927 }, -- Throat Slasher
            { 2, 57928 }, -- Windslicer
            { 3, 57929 }, -- Dawnblaze Blade
            { 5, 57926 }, -- Shield of the Four Grey Towers
            { 6, 57925 }, -- Shield of the Mists
            { 8, 57924 }, -- Apple-Bent Bough
            { 9, 57923 } -- Hermit's Lamp
            }
        },
        {
        name = ALIL["Neck"],
        [VENDOR_DIFF_P1] = {
        { 1, 57932 }, -- The Lustrous Eye
        { 2, 57934 }, -- Celadon Pendant
        { 3, 57933 }, -- String of Beaded Bubbles
        { 4, 57931 }, -- Amulet of Dull Dreaming
        { 5, 57930 } -- Pendant of Quiet Breath
    },
        [VENDOR_DIFF_P2] = {
        { 1,  70935 }, -- Stoneheart Necklace
        { 2,  71212 }, -- Stoneheart Choker
        { 4,  71129 }, -- Necklace of Smoke Signals
        { 16,  71213 }, -- Amulet of Burning Brilliance
        { 17,  71214 }, -- Firemind Pendant
            }
        },
        {
        name = ALIL["Finger"],
        [VENDOR_DIFF] = {
            { 1, 58189 }, -- Twined Band of Flowers
            { 2, 58188 }, -- Band of Secret Names
            { 3, 58185 }, -- Band of Bees
            { 4, 68812 }, -- Hornet-Sting Band
            { 5, 58187 } -- Ring of the Battle Anthem
        },
        [VENDOR_DIFF_P2] = {
            { 1,  70940 }, -- Deflecting Brimstone Band
            { 2,  71208 }, -- Serrated Brimstone Signet
            { 4, 71209 }, -- Splintered Brimstone Seal
            { 16,  71210 }, -- Crystalline Brimstone Ring
            { 17, 71211 }, -- Soothing Brimstone Circle
            }
        },
        {
        name = ALIL["Relic"],
        [VENDOR_DIFF] = {
            { 1, 64673 }, -- Throat Slasher
            { 2, 64674 }, -- Windslicer
            { 3, 64671 }, -- Dawnblaze Blade
            { 4, 64676 }, -- Shield of the Four Grey Towers
            { 5, 64672 } -- Shield of the Mists
        },
        [VENDOR_DIFF_P2] = {
            { 1, 70939 }, -- Deathclutch Figurine
            { 2, 71147 }, -- Relic of the Elemental Lords
            { 4, 71146 }, -- Covenant of the Flame
            { 16, 71148 }, -- Soulflame Vial
            { 17, 71149 }, -- Singed Plume of Aviana
            }
        },
        {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 58180 }, -- License to Slay
            { 2, 58181 }, -- Fluid Death
            { 3, 58183 }, -- Soul Casket
            { 4, 58184 }, -- Core of Ripeness
            { 5, 58182 } -- Bedrock Talisman
            }
        },
        {
        name = AL["Misc"],
        [VENDOR_DIFF_P1] = {
            { 1, 52185 }, -- Elementium Ore
            { 2, 53010 }, -- Embersilk Cloth
            { 3, 52976 }, -- Savage Leather
            { 4, 52721 }, -- Heavenly Shard
            { 5, 52555 }, -- Hypnotic Dust
            { 6, 68813 }, -- Satchel of Freshly-Picked Herbs
            { 7, 52719 } -- Greater Celestial Essence
            }
        }
    }
}

-- shared!
data["WorldEpicsMoP"] = {
    name = AL["World Epics"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.WORLD_EPICS,
    items = {
        {
            name = AL["World Epics"],
            [NORMAL_ITTYPE] = {
                { 1,  90583 }, -- Don Guerrero's Glorious Choker
                { 2,  90590 }, -- Dorian's Necklace of Burgeoning Dreams
                { 3,  90591 }, -- Ring of the Shipwrecked Prince
                { 4,  90589 }, -- Dirl's Drafty Drape
                { 5,  90571 }, -- Scroll of Whispered Secrets
                { 6,  90575 }, -- Sutiru's Brazen Bulwark
                { 8,  90573 }, -- Wang's Unshakable Smile
                { 9,  90588 }, -- Rittsyn's Ruinblasters
                { 10,  90574 }, -- Etoshia's Elegant Gloves
                { 12,  90585 }, -- Vulajin's Vicious Breastplate
                { 14,  90572 }, -- Kilt of Pandaren Promises
                { 16,  90579 }, -- Legplates of Durable Dreams
                { 17,  90577 }, -- Boblet's Bouncing Hauberk
            }
        }
    }
}

data["MountsMoP"] = {
    name = ALIL["Mounts"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.MOUNTS,
     items = {
        -- TODO: Add missing mounts, more vendor ones, and rep ones
        {
            name = AL["Vendor"],
            [NORMAL_DIFF] = {
                {1, 84101} -- Reins of the Grand Expedition Yak
            },
        },
        {
            name = AL["Drops"], -- Drops
            [NORMAL_DIFF] = {
                { 1,  95059 }, -- Clutch of Ji-Kun
                { 2,  104253 }, -- Kor'kron Juggernaut
                { 3,  87777 }, -- Reins of the Astral Cloud Serpent
                { 4,  94228 }, -- Reins of the Cobalt Primordial Direhorn
                { 5,  87771 }, -- Reins of the Heavenly Onyx Cloud Serpent
                { 6,  95057 }, -- Reins of the Thundering Cobalt Cloud Serpent
                { 7, 89783 }, -- Son of Galleon's Saddle
                { 8, 93666 }, -- Spawn of Horridon
            }
        },
        {
            name = AL["Crafting"],
            [NORMAL_DIFF] = {
                { 1, 95416 }, -- Sky Golem
                { 2, 82453 }, -- Jeweled Onyx Panther
                { 3, 87251 }, -- Geosynchronous World Spinner
                { 4, 87250 }, -- Depleted-Kyparium Rocket
                { 5, 83087 }, -- Ruby Panther
                { 6, 83088 }, -- Jade Panther
                { 7, 83089 }, -- Sunstone Panther
                { 8, 83090 }, -- Sapphire Panther
            }
        },
        {
            name = ALIL["Achievements"],
            TableType = AC_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = 93385, 7928, [ATLASLOOT_IT_HORDE] = 93386, 7929 },
                { 2, [ATLASLOOT_IT_ALLIANCE] = 98259, 8304, [ATLASLOOT_IT_HORDE] = 98104, 8302 },
                { 3, [ATLASLOOT_IT_ALLIANCE] = 89785, 6828, [ATLASLOOT_IT_HORDE] = 81559, 6827 },
                { 4, [ATLASLOOT_IT_ALLIANCE] = 91802, 7860, [ATLASLOOT_IT_HORDE] = 91802, 7862 },
                { 5,  104246, 8398 }, -- Reins of the Kor'kron War Wolf
                { 6,  85666, 6682 }, -- Reins of the Thundering Jade Cloud Serpent
                { 7,  87773, 6932 }, -- Reins of the Heavenly Crimson Cloud Serpent
                { 8,  87769, 6927 }, -- Reins of the Crimson Cloud Serpent
                { 9,  93662, 8124 }, -- Reins of the Armored Skyscreamer
                { 10, 104208, 8454 }, -- Reins of Galakras
                { 11, 98618, 8345 }, -- Hearthsteed
            }
        },
    }
}

data["CompanionsMoP"] = {
    name = ALIL["Companions"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.COMPANIONS,
     items = {
        {
        name = AL["Drops"],
        [NORMAL_DIFF] = {
            { 1,  93040 }, -- Anubisath Idol
            { 2,  86563 }, -- Aqua Strider
            { 3, 104156 }, -- Ashleaf Spriteling
            { 4,  93035 }, -- Ashstone Core
            { 5, 104157 }, -- Azure Crane Chick
            { 6, 104158 }, -- Blackfuse Bombling
            { 7, 104202 }, -- Bonkers
            { 8,  93038 }, -- Chrominius
            { 9,  97554 }, -- Coilfang Stalker
            { 10, 93034 }, -- Corefire Imp
            { 11, 104160 }, -- Dandelion Frolicker
            { 12, 91040 }, -- Darkmoon Eye
            { 13, 80008 }, -- Darkmoon Rabbit
            { 14, 104161 }, -- Death Adder Hatchling
            { 15, 93037 }, -- Death Talon Whelpguard
            { 16, 94573 }, -- Direhorn Runt
            { 17, 104162 }, -- Droplet of Y'Shaarj
            { 18, 97551 }, -- Fiendish Imp
            { 19, 97961 }, -- Filthling
            { 20, 93032 }, -- Fungal Abomination
            { 21, 93030 }, -- Giant Bone Spider
            { 22, 104163 }, -- Gooey Sha-ling
            { 23, 86564 }, -- Grinder
            { 24, 104291 }, -- Gu'chi Swarmling
            { 25, 104169 }, -- Gulp Froglet
            { 26, 93033 }, -- Harbinger of Flame
            { 27, 104307 }, -- Jadefire Spirit
            { 28, 104164 }, -- Jademist Dancer
            { 29, 94835 }, -- Ji-Kun Hatchling
            { 30, 104165 }, -- Kovok
            { 101, 97556 }, -- Lesser Voidcaller
            { 102, 97548 }, -- Lil' Bad Wolf
            { 103, 103670 }, -- Lil' Bling
            { 104, 97959 }, -- Living Fluid
            { 105, 94125 }, -- Living Sandling
            { 106, 97549 }, -- Menagerie Custodian
            { 107, 93041 }, -- Mini Mindslayer
            { 108, 101570 }, -- Moon Moon
            { 109, 97550 }, -- Netherspace Abyssal
            { 110, 104166 }, -- Ominous Flame
            { 111, 97557 }, -- Phoenix Hawk Hatchling
            { 112, 97555 }, -- Pocket Reaver
            { 113, 89587 }, -- Porcupette
            { 114, 94574 }, -- Pygmy Direhorn
            { 115, 104159 }, -- Ruby Droplet
            { 116, 104167 }, -- Skunky Alemental
            { 117, 94152 }, -- Son of Animus
            { 118, 94595 }, -- Spawn of G'nathus
            { 119, 104168 }, -- Spineclaw Crab
            { 120, 93029 }, -- Stitched Pup
            { 121, 94124 }, -- Sunreaver Micro-Sentry
            { 122, 97553 }, -- Tainted Waveling
            { 123, 85220 }, -- Terrible Turnip
            { 124, 97552 }, -- Tideskipper
            { 125, 93036 }, -- Untamed Hatchling
            { 126, 93039 }, -- Viscidus Globule
            { 127, 97960 }, -- Viscous Horror
            { 128, 95422 }, -- Zandalari Anklerender
            { 129, 95423 }, -- Zandalari Footslasher
            { 130, 94126 }, -- Zandalari Kneebiter
            { 201, 95424 }, -- Zandalari Toenibbler
            }
        },
        {
        name = AL["Vendor"],
        [NORMAL_DIFF] = {
            { 1,  102145 }, -- Chi-Chi, Hatchling of Chi-Ji
            { 2,  93025 }, -- Clock'em
            { 3,  91003 }, -- Darkmoon Hatchling
            { 4,  97821 }, -- Gahz'rooki
            { 5,  104295 }, -- Harmonious Porcupette
            { 6,  88148 }, -- Jade Crane Chick
            { 7,  85447 }, -- Tiny Goldfish
            { 8,  103637 }, -- Vengeful Porcupette
            { 9,  101771 }, -- Xu-Fu, Cub of Xuen
            { 10, 102147 }, -- Yu'la, Broodling of Yu'lon
            { 11, 102146 }, -- Zao, Calfling of Niuzao
            }
        },
        {
        name = AL["World Events"],
        [NORMAL_DIFF] = {
            { 1, 46831 }, -- Macabre Marionette
            { 2, 104317 }, -- Rotten Helper Box
            }
        },
        {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            { 1,  85578, "ac7500" }, -- Feral Vermling
            { 2,  89686, "ac7521" }, -- Jade Tentacle
            { 3,  93031, "ac7934" }, -- Mr. Bigglesworth
            { 4,  94191, "ac8300" }, -- Stunted Direhorn
            { 5,  97558, "ac8293" }, -- Tito
            { 16, 89736, "ac7501" }, -- Venus
            }
        },
        {
        name = ALIL["Quests"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            { 1,  84105 }, -- Fishy
            { 2,  94210 }, -- Mountain Panda
            { 3,  92799 }, -- Pandaren Air Spirit
            { 4,  92800 }, -- Pandaren Earth Spirit
            { 5,  92798 }, -- Pandaren Fire Spirit
            { 6,  90173 }, -- Pandaren Water Spirit
            { 7,  85222 }, -- Red Cricket
            { 8,  94025 }, -- Red Panda
            { 9,  94209 }, -- Snowy Panda
            { 10, 94190 }, -- Spectral Porcupette
            { 11, 94208 }, -- Sunfur Panda
            }
        },
        {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {
            { 1, 94933 }, -- Tiny Blue Carp
            { 2, 94934 }, -- Tiny Green Carp
            { 3, 94932 }, -- Tiny Red Carp
            { 4, 94935 }, -- Tiny White Carp
            }
        },
        {
        name = AL["Crafting"],
        [NORMAL_DIFF] = {
            { 1,  89368 }, -- Chi-Ji Kite
            { 2,  90900 }, -- Imperial Moth
            { 3,  90902 }, -- Imperial Silkworm
            { 4,  82774 }, -- Jade Owl
            { 5,  87526 }, -- Mechanical Pandaren Dragonling
            { 6,  94903 }, -- Pierre
            { 7, 100905 }, -- Rascal-Bot
            { 8,  82775 }, -- Sapphire Cub
            { 9,  89367 }, -- Yu'lon Kite
            }
        },
        {
        name = AL["Misc"], -- Misc
            [NORMAL_DIFF] = {
            { 1,  85871 }, -- Lucky Quilen Cub
            },
        }
    }
}

data["TabardsMoP"] = {
    name = ALIL["Tabard"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.TABARDS,
    items = {
        {
            name = AL["Factions"],
            CoinTexture = "Reputation",
            [ALLIANCE_DIFF] = {
                { 1, 89401 }, -- Anglers Tabard
                { 2, 89784 }, -- Tillers Tabard
                { 3, 89795 }, -- Lorewalkers Tabard
                { 4, 89796 }, -- Order of the Cloud Serpent Tabard
                { 5, 89797 }, -- Golden Lotus Tabard
                { 6, 89798 }, -- Klaxxi Tabard
                { 7, 89799 }, -- August Celestials Tabard
                { 8, 89800 }, -- Shado-Pan Tabard
                { 9, 97131 }, -- Shado-Pan Assault Tabard
                { 10, 83079 }, -- Tushui Tabard
                { 11, 95591 }, -- Kirin Tor Offensive Tabard
            },
            [HORDE_DIFF] = {
                GetItemsFromDiff = ALLIANCE_DIFF,
                { 10, 83080 }, -- Huojin Tabard
                { 11, 95592 }, -- Sunreaver Onslaught Tabard
            }
        },
        {
            name = AL["PvP"],
            CoinTexture = "PvP",
            [NORMAL_DIFF] = {
                { 1, 98162 }, -- Tyrannical Gladiator's Tabard
                { 2, 101697 }, -- Grievous Gladiator's Tabard
                { 3, 103636 }, -- Prideful Gladiator's Tabard
            },
        }
    }
}

data["LegendarysMoP"] = {
    name = format(LEGENDARY_QUALITY, AL["Legendaries"]),
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.LEGENDARYS,
     items = {
        {
        name = AL["Legendaries"],
        [NORMAL_DIFF] = {
            { 1, 102245 }, -- Qian-Le, Courage of Niuzao
            { 2, 102246 }, -- Xing-Ho, Breath of Yu'lon
            { 3, 102247 }, -- Jina-Kang, Kindness of Chi-Ji
            { 4, 102248 }, -- Fen-Yu, Fury of Xuen
            { 5, 102249 }, -- Gong-Lu, Strength of Xuen
            { 6, 102250 }, -- Qian-Ying, Fortitude of Niuzao
            }
        }
    }
}

data["HeirloomMoP"] = {
    name = format(BOA_QUALITY, ALIL["Heirloom"]),
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.HEIRLOOM,
    items = {
        {
            name = ALIL["Armor"],
            [NORMAL_DIFF] = {
            -- Chest
                { 1,  93860 }, -- Bloodstained Dreadmist Robe
                { 2,  93863 }, -- Supple Shadowcraft Tunic
                { 3,  93865 }, -- Majestic Ironfeather Breastplate
                { 4,  93888 }, -- Furious Deathdealer Breastplate
                { 5,  93885 }, -- Awakened Vest of Elements
                { 6,  93891 }, -- Gleaming Breastplate of Valor
                { 7,  93892 }, -- Brushed Breastplate of Might
            -- Shoulder
                { 9,  93859 }, -- Bloodstained Dreadmist Mantle
                { 10, 93861 }, -- Prestigious Sunderseer Mantle
                { 11, 93862 }, -- Supple Shadowcraft Spaulders
                { 12, 93864 }, -- Majestic Ironfeather Shoulders
                { 13, 93867 }, -- Superior Stormshroud Shoulders
                { 14, 93866 }, -- Wild Feralheart Spaulders
                { 15, 93887 }, -- Grand Champion Herod's Shoulder
                { 16, 93876 }, -- Awakened Pauldrons of Elements
                { 17, 93886 }, -- Adorned Beastmaster's Mantle
                { 18, 93889 }, -- Venerated Pauldrons of The Five Thunders
                { 19, 93890 }, -- Gleaming Spaulders of Valor
                { 20, 93893 }, -- Brushed Pauldrons of Might
                { 21, 93894 }, -- Immaculate Lightforge Spaulders
            -- Off-hand
                { 23, 93902 }, -- Flamescarred Draconian Deflector
                { 24, 93903 }, -- Weathered Observer's Shield
                { 25, 93904 }, -- Musty Tome of the Lost
            -- Legs
                { 27, 62029 }, -- Tattered Dreadmist Leggings
                { 28, 62026 }, -- Stained Shadowcraft Pants
                { 29, 62027 }, -- Preened Wildfeather Leggings
                { 30, 62024 }, -- Tarnished Leggings of Destruction
                { 101, 62025 }, -- Mystical Kilt of Elements
                { 102, 62023 }, -- Polished Legplates of Valor
                { 103, 69888 }, -- Burnished Legplates of Might
            }
        },
        {
            name = ALIL["Weapon"],
            [NORMAL_DIFF] = {
                { 1, 93843 }, -- Hardened Arcanite Reaper
                { 2, 93855 }, -- War-Torn Ancient Bone Bow
                { 3, 93853 }, -- Pious Aurastone Hammer
                { 4, 93847 }, -- Crushing Mass of McGowan
                { 5, 93846 }, -- Re-Engineered Lava Dredger
                { 6, 93845 }, -- Gore-Steeped Skullforge Reaver
                { 7, 93856 }, -- Noble Dal'Rend's Sacred Charge
                { 8, 93854 }, -- Scholarly Headmaster's Charge
                { 9, 93857 }, -- Vengeful Heartseeker
                { 11, 93841 }, -- Smoothbore Dwarven Hand Cannon
                { 12, 93850 }, -- The Sanctified Hammer of Grace
                { 13, 93848 }, -- Battle-Hardened Thrash Blade
                { 14, 93851 }, -- Battle-Forged Truesilver Champion
                { 15, 93849 }, -- Elder Staff of Jordan
                { 16, 93852 }, -- Deadly Scarlet Kris
            }
        },
        {
            name = ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 93896 }, -- Forceful Hand of Justice
                { 2, 93897 }, -- Piercing Eye of the Beast
                { 4, 93898 }, -- Bequeathed Insignia of the Horde
                { 5, 93899 }, -- Bequeathed Insignia of the Alliance
                { 6, 93900 }, -- Inherited Mark of Tyranny
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 245963 }, -- Tome of Four Winds Flight
                { 3, 86558 }, -- Rolling Pin
                { 4, 86559 }, -- Frying Pan
                { 5, 86468 }, -- Apron
            }
        }
    }
}

data["LunarFestivalMoP"] = {
    name = AL["Lunar Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.LUNAR_FESTIVAL,
    items = {
        { -- LunarFestival1
            name = AL["Lunar Festival"],
            [NORMAL_DIFF] = {
                { 1,  21100 }, -- Coin of Ancestry
                { 2,  74610 }, -- Lunar Lantern
                { 3,  74611 }, -- Festival Lantern
                { 5,  89999 }, -- Everlasting Alliance Firework
                { 6,  90000 }, -- Everlasting Horde Firework
                { 8,  21157 }, -- Festive Green Dress
                { 9,  21538 }, -- Festive Pink Dress
                { 10,  21539 }, -- Festive Purple Dress
                { 11,  21541 }, -- Festive Black Pant Suit
                { 12, 21544 }, -- Festive Blue Pant Suit
                { 13, 21543 }, -- Festive Teal Pant Suit
            },
        },
        {
            name = AL["Lunar Festival Fireworks Pack"],
            [NORMAL_DIFF] = {
                { 1,  21558 }, -- Small Blue Rocket
                { 2,  21559 }, -- Small Green Rocket
                { 3,  21557 }, -- Small Red Rocket
                { 4,  21561 }, -- Small White Rocket
                { 5,  21562 }, -- Small Yellow Rocket
                { 7,  21537 }, -- Festival Dumplings
                { 8,  21713 }, -- Elune's Candle
                { 16, 21589 }, -- Large Blue Rocket
                { 17, 21590 }, -- Large Green Rocket
                { 18, 21592 }, -- Large Red Rocket
                { 19, 21593 }, -- Large White Rocket
                { 20, 21595 }, -- Large Yellow Rocket
            }
        },
        {
            name = AL["Lucky Red Envelope"],
            [NORMAL_DIFF] = {
                { 1,  21540 }, -- Elune's Lantern
                { 2,  21536 }, -- Elune Stone
                { 16, 21744 }, -- Lucky Rocket Cluster
                { 17, 21745 }, -- Elder's Moonstone
            }
        },
        { -- LunarFestival2
            name = AL["Plans"],
            [NORMAL_DIFF] = {
                { 1,  21722 }, -- Pattern: Festival Dress
                { 3,  21738 }, -- Schematic: Firework Launcher
                { 5,  21724 }, -- Schematic: Small Blue Rocket
                { 6,  21725 }, -- Schematic: Small Green Rocket
                { 7,  21726 }, -- Schematic: Small Red Rocket
                { 9,  21727 }, -- Schematic: Large Blue Rocket
                { 10, 21728 }, -- Schematic: Large Green Rocket
                { 11, 21729 }, -- Schematic: Large Red Rocket
                { 16, 21723 }, -- Pattern: Festive Red Pant Suit
                { 18, 21737 }, -- Schematic: Cluster Launcher
                { 20, 21730 }, -- Schematic: Blue Rocket Cluster
                { 21, 21731 }, -- Schematic: Green Rocket Cluster
                { 22, 21732 }, -- Schematic: Red Rocket Cluster
                { 24, 21733 }, -- Schematic: Large Blue Rocket Cluster
                { 25, 21734 }, -- Schematic: Large Green Rocket Cluster
                { 26, 21735 }, -- Schematic: Large Red Rocket Cluster
            },
        },
    },
}

data["ValentinesdayMoP"] = {
    name = AL["Love is in the Air"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.VALENTINES_DAY,
    items = {
        { -- Valentineday
        name = AL["Love is in the Air"],
        [NORMAL_DIFF] = {
            { 1, 22206 }, -- Bouquet of Red Roses
            { 3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] },
            { 4, 22279 }, -- Lovely Black Dress
            { 5,  72146 }, -- Swift Lovebird
            { 6,  22235 }, -- Truesilver Shafted Arrow
            { 7,  22200 }, -- Silver Shafted Arrow
            { 8,  34480 }, -- Romantic Picnic Basket
            { 9,  22261 }, -- Love Fool
            { 10, 22218 }, -- Handful of Rose Petals
            { 11, 21813 }, -- Bag of Candies
            { 13, "INV_Box_02", nil, AL["Box of Chocolates"] },
            { 14, 22237 }, -- Dark Desire
            { 15, 22238 }, -- Very Berry Cream
            { 16, 22236 }, -- Buttermilk Delight
            { 17, 22239 }, -- Sweet Surprise
            { 18, 22276 }, -- Lovely Red Dress
            { 19, 22278 }, -- Lovely Blue Dress
            { 20, 22280 }, -- Lovely Purple Dress
            { 21, 22277 }, -- Red Dinner Suit
            { 22, 22281 }, -- Blue Dinner Suit
            { 23, 22282 }  -- Purple Dinner Suit
            }
        },
        { -- SFKApothecaryH
        name = C_Map_GetAreaInfo(209) .. " - " .. AL["Apothecary Hummel"],
        [NORMAL_DIFF] = {
            { 1,  93391 }, -- Heartbreak Charm
            { 2,  93392 }, -- Winking Eye of Love
            { 3,  93393 }, -- Sweet Perfume Broach
            { 4,  93394 }, -- Choker of the Pure Heart
            { 5,  93395 }, -- Shard of Pirouetting Happiness
            { 7,  49641 }, -- Faded Lovely Greeting Card
            { 8,  49715 }, -- Forever-Lovely Rose
            { 9,  50250 }, -- X-45 Heartbreaker
            { 10, 50446 }, -- Toxic Wasteling
            { 11, 50471 }, -- The Heartbreaker
            { 12, 50741 }  -- Vile Fumigator's Mask
            }
        }
    }
}

data["MidsummerFestivalMoP"] = {
    name = AL["Midsummer Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.MIDSUMMER_FESTIVAL,
    items = {
        {
        name = AL["Midsummer Festival"],
        [NORMAL_DIFF] = {
            { 1,  23083 }, -- Captured Flame
            { 2,  34686 }, -- Brazier of Dancing Flames
            { 4,  23324 }, -- Mantle of the Fire Festival
            { 5,  23323 }, -- Crown of the Fire Festival
            { 6,  34683 }, -- Sandals of Summer
            { 7,  34685 }, -- Vestment of Summer
            { 9,  23247 }, -- Burning Blossom
            { 10, 34599 }, -- Juggling Torch
            { 11, 34684 }, -- Handful of Summer Petals
            { 12, 23246 }, -- Fiery Festival Brew
            { 16, 23215 }, -- Bag of Smorc Ingredients
            { 17, 23211 }, -- Toasted Smorc
            { 18, 23435 }, -- Elderberry Pie
            { 19, 23327 }, -- Fire-toasted Bun
            { 20, 23326 } -- Midsummer Sausage
            }
        },
        {
        name = C_Map_GetAreaInfo(3717) .. " - " .. AL["Ahune"],
        [NORMAL_DIFF] = {
                { 1, 54536 }, -- Satchel of Chilled Goods
                { 2, 95426 }, -- Frostscythe of Lord Ahune
                { 4, 95425 }, -- Cloak of the Frigid Winds
                { 5, 95427 }, -- Icebound Cloak
                { 6, 95428 }, -- Shroud of Winter's Chill
                { 7, 95429 }, -- The Frost Lord's Battle Shroud
                { 8, 95430 }, -- The Frost Lord's War Cloak
                { 10, 35723 }, -- Shards of Ahune
                { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 18, 53641 }, -- Ice Chip
                { 20, 35557 }, -- Huge Snowball
            }
        }
    }
}

data["BrewfestMoP"] = {
    name = AL["Brewfest"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.BREWFEST,
    items = {
        {
        name = AL["Brewfest"],
          [NORMAL_DIFF] = {
                {1, 37829}, -- Brewfest Prize Token
                {3, 33968}, -- Blue Brewfest Hat
                {4, 33864}, -- Brown Brewfest Hat
                {5, 33967}, -- Green Brewfest Hat
                {6, 33969}, -- Purple Brewfest Hat
                {7, 33863}, -- Brewfest Dress
                {8, 33862}, -- Brewfest Regalia
                {9, 33966}, -- Brewfest Slippers
                {10, 33868}, -- Brewfest Boots
                {12, 33047}, -- Belbi's Eyesight Enhancing Romance Goggles (Alliance)
                {13, 34008}, -- Blix's Eyesight Enhancing Romance Goggles (Horde)
                {15, 33927}, -- Brewfest Pony Keg
                {16, 90427}, -- Pandaren Brewpack
                {18, 32233}, -- Wolpertinger's Tankard
                {20, 37599}, -- "Brew of the Month" Club Membership Form
                {22, 37750}, -- Fresh Brewfest Hops
                {24, 39477}, -- Fresh Dwarven Brewfest Hops
                {24, 39476}, -- Fresh Goblin Brewfest Hops
                {25, 37816} -- Preserved Brewfest Hops
            }
        },
        {
            name = AL["Food"],
            [NORMAL_DIFF] = {
                {1, 33043}, -- The Essential Brewfest Pretzel
                {3, 34017}, -- Small Step Brew
                {4, 34018}, -- long Stride Brew
                {5, 34019}, -- Path of Brew
                {6, 34020}, -- Jungle River Water
                {7, 34021}, -- Brewdoo Magic
                {8, 34022}, -- Stout Shrunken Head
                {9, 33034}, -- Gordok Grog
                {10, 33035}, -- Ogre Mead
                {11, 33036} -- Mudder's Milk
            }
        },
        {
            name = C_Map_GetAreaInfo(1584) .. " - " .. AL["Coren Direbrew"],
            [NORMAL_DIFF] = {
                { 1,  87576 }, -- Bitterest Balebrew Charm
                { 2,  87575 }, -- Bubbliest Brightbrew Charm
                { 3,  87574 }, -- Coren's Cold Chromium Coaster
                { 4,  87572 }, -- Mithril Wristwatch
                { 5,  87573 }, -- Thousand-Year Pickled Egg
                { 6,  87571 }, -- Brawler's Statue
                { 8,  107217 }, -- Direbrew's Bloodied Shanker
                { 9,  107218 }, -- Tremendous Tankard O' Terror
                {16, 33977}, -- Swift Brewfest Ram
                {17, 37828}, -- Great Brewfest Kodo
                {19, 37863}, -- Direbrew's Remote
                {21, 38280} -- Direbrew's Dire Brew
            }
        }
    }
}

data["HalloweenMoP"] = {
    name = AL["Hallow's End"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.HALLOWEEN,
    items = {
        { -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Misc"],
        [NORMAL_DIFF] = { { 1, 20400 }, -- Pumpkin Bag
            { 3,  70722 }, -- Little Wickerman
            { 4,  70908 }, -- Feline Familiar
            { 5,  71076 }, -- Creepy Crate
            { 16, 33226 }, -- Tricky Treat
            }
        },
        { -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Wands"],
        [NORMAL_DIFF] = { { 1, 20410 }, -- Hallowed Wand - Bat
            { 2, 20409 }, -- Hallowed Wand - Ghost
            { 3, 20399 }, -- Hallowed Wand - Leper Gnome
            { 4, 20398 }, -- Hallowed Wand - Ninja
            { 5, 20397 }, -- Hallowed Wand - Pirate
            { 6, 20413 }, -- Hallowed Wand - Random
            { 7, 20411 }, -- Hallowed Wand - Skeleton
            { 8, 20414 } -- Hallowed Wand - Wisp
            }
        },
        { -- Halloween3
        name = AL["Hallow's End"] .. " - " .. AL["Masks"],
        [NORMAL_DIFF] = { { 1, 20561 }, -- Flimsy Male Dwarf Mask
            { 2,  20391 }, -- Flimsy Male Gnome Mask
            { 3,  20566 }, -- Flimsy Male Human Mask
            { 4,  20564 }, -- Flimsy Male Nightelf Mask
            { 5,  20570 }, -- Flimsy Male Orc Mask
            { 6,  20572 }, -- Flimsy Male Tauren Mask
            { 7,  20568 }, -- Flimsy Male Troll Mask
            { 8,  20573 }, -- Flimsy Male Undead Mask
            { 9,  49216 }, -- Worgen Male Mask
            { 10, 49210 }, -- Goblin Male Mask
            { 12, 69188 }, -- Murloc Male Mask
            { 13, 69190 }, -- Naga Male Mask
            { 14, 69193 }, -- Ogre Male Mask
            { 15, 69195 }, -- Vrykul Male Mask
            { 16, 20562 }, -- Flimsy Female Dwarf Mask
            { 17, 20392 }, -- Flimsy Female Gnome Mask
            { 18, 20565 }, -- Flimsy Female Human Mask
            { 19, 20563 }, -- Flimsy Female Nightelf Mask
            { 20, 20569 }, -- Flimsy Female Orc Mask
            { 21, 20571 }, -- Flimsy Female Tauren Mask
            { 22, 20567 }, -- Flimsy Female Troll Mask
            { 23, 20574 }, -- Flimsy Female Undead Mask
            { 24, 49215 }, -- Worgen Female Mask
            { 25, 49212 }, -- Goblin Female Mask
            { 27, 69187 }, -- Murloc Female Mask
            { 28, 69189 }, -- Naga Female Mask
            { 29, 69192 }, -- Ogre Female Mask
            { 30, 69194 }, -- Vrykul Female Mask
            }
        },
        { -- SMHeadlessHorseman
        name = C_Map_GetAreaInfo(796) .. " - " .. AL["Headless Horseman"],
        [NORMAL_DIFF] = {
                { 1, 88168 }, -- Seal of Ghoulish Glee
                { 2, 88169 }, -- The Horseman's Ring
                { 3, 88166 }, -- Wicked Witch's Signet
                { 4, 88167 }, -- Band of the Petrified Pumpkin
                { 5, 87569 }, -- The Horseman's Horrific Hood
                { 6, 87570 }, -- The Horseman's Sinister Slicer
                { 8, 33292 }, -- Hallowed Helm
                { 10, 34068 }, -- Weighted Jack-o'-Lantern
                { 12, 33277 }, -- Tome of Thomas Thomson
                { 16, 37012 }, -- The Horseman's Reins
                { 18, 37011 }, -- Magic Broom
                { 20, 33154 }, -- Sinister Squashling
            }
        }
    }
}

data["DayoftheDeadMoP"] = {
    name = AL["Day of the Dead"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.DAY_OF_THE_DEAD,
    items = {
        { -- DayoftheDead
        name = AL["Day of the Dead"],
            [NORMAL_DIFF] = {
                {1, 46831}, -- Macabre Marionette
                {3, 46710}, -- Recipe: Bread of the Dead
                {5, 46690}, -- Candy Skull
                {6, 46711}, -- Spirit Candle
                {7, 46718}, -- Orange Marigold
                {8, 46860}, -- Whimsical Skull Mask
                {9, 46861} -- Bouquet of Orange Marigolds
            }
        }
    }
}

data["WinterVeilMoP"] = {
    name = AL["Feast of Winter Veil"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.MOP_VERSION_NUM,
    CorrespondingFields = private.WINTER_VEIL,
    items = {
        { -- Winterviel1
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 21525 }, -- Green Winter Hat
                { 2, 21524 }, -- Red Winter Hat
                { 3, 17712 }, -- Winter Veil Disguise Kit
                { 4, 17202 }, -- Snowball
                { 5, 21212 }, -- Fresh Holly
                { 6, 21519 }, -- Mistletoe
            },
        },
        {
            name = AL["Gaily Wrapped Present"],
            [NORMAL_DIFF] = {
                { 1, 21301 }, -- Green Helper Box
                { 2, 21308 }, -- Jingling Bell
                { 3, 21305 }, -- Red Helper Box
                { 4, 21309 }, -- Snowman Kit
            },
        },
        {
            name = AL["Festive Gift"],
            [NORMAL_DIFF] = {
                { 1, 21328 }, -- Wand of Holiday Cheer
            },
        },
        {
            name = AL["Smokywood Pastures Special Gift"],
            [NORMAL_DIFF] = {
                { 1,  17706 }, -- Plans: Edge of Winter
                { 2,  17725 }, -- Formula: Enchant Weapon - Winter's Might
                { 3,  17720 }, -- Schematic: Snowmaster 9000
                { 4,  17722 }, -- Pattern: Gloves of the Greatfather
                { 5,  17709 }, -- Recipe: Elixir of Frost Power
                { 6,  17724 }, -- Pattern: Green Holiday Shirt
                { 16, 21325 }, -- Mechanical Greench
                { 17, 21213 }, -- Preserved Holly
            },
        },
        {
            name = AL["Gently Shaken Gift"],
            [NORMAL_DIFF] = {
                { 1, 21235 }, -- Winter Veil Roast
                { 2, 21241 }, -- Winter Veil Eggnog
            },
        },
        {
            name = AL["Smokywood Pastures"],
            [NORMAL_DIFF] = {
                { 1,  17201 }, -- Recipe: Egg Nog
                { 2,  17200 }, -- Recipe: Gingerbread Cookie
                { 3,  34413 }, -- Recipe: Hot Apple Cider
                { 4,  34261 }, -- Pattern: Green Winter Clothes
                { 5,  34262 }, -- Pattern: Winter Boots
                { 6,  17344 }, -- Candy Cane
                { 7,  17406 }, -- Holiday Cheesewheel
                { 8,  17407 }, -- Graccu's Homemade Meat Pie
                { 9,  17408 }, -- Spicy Beefstick
                { 10, 34410 }, -- Honeyed Holiday Ham
                { 11, 17404 }, -- Blended Bean Brew
                { 12, 17405 }, -- Green Garden Tea
                { 13, 34412 }, -- Sparkling Apple Cider
                { 14, 17196 }, -- Holiday Spirits
                { 15, 17403 }, -- Steamwheedle Fizzy Spirits
                { 16, 17402 }, -- Greatfather's Winter Ale
                { 17, 17194 }, -- Holiday Spices
                { 18, 17303 }, -- Blue Ribboned Wrapping Paper
                { 19, 17304 }, -- Green Ribboned Wrapping Paper
                { 20, 17307 }, -- Purple Ribboned Wrapping Paper
            },
        },
        {
            name = AL["Stolen Present"],
            [NORMAL_DIFF] = {
                { 1,  93625 }, -- Miniature Winter Veil Tree
                { 3,  104317 }, -- Rotten Helper Box
                { 4,  34425 }, -- Clockwork Rocket Bot
                { 5,  54436 }, -- Blue Clockwork Rocket Bot
                { 6,  73797 }, -- Lump of Coal
                { 8,  104318 }, -- Crashin' Thrashin' Flyer Controller
                { 9,  46709 }, -- MiniZep Controller
                { 10,  44606 }, -- Toy Train Set
                { 11,  90883 }, -- The Pigskin
                { 12,  90888 }, -- Foot Ball
                { 13,  37710 }, -- Crashin' Thrashin' Racer Controller
                { 14, 54437 }, -- Tiny Green Ragdoll
                { 15, 54438 }, -- Tiny Blue Ragdoll
                { 17,  46725 }, -- Red Rider Air Rifle
                { 18, 34498 }, -- Paper Zeppelin Kit
                { 19, 44599 }, -- Zippy Copper Racer
                { 20, 44601 }, -- Heavy Copper Racer
                { 21, 44481 }, -- Grindgear Toy Gorilla
                { 22, 44482 }, -- Trusty Copper Racer
            },
        },
    },
}
