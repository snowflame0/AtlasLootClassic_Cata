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
if AtlasLoot:GameVersion_LT(AtlasLoot.CATA_VERSION_NUM) then
    return
end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CATA_VERSION_NUM)

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

data["CookingVendorCata"] = {
    name = format(AL["'%s' Vendor"], ALIL["Cooking"]),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.COOKING_VENDOR,
    items = {{
        name = AL["Recipe"],
        [VENDOR_DIFF] = {
            { 1, 65406 }, -- Recipe: Whitecrest Gumbo
            { 2, 65407 }, -- Recipe: Lavascale Fillet
            { 3, 65409 }, -- Recipe: Lavascale Minestrone
            { 4, 65410 }, -- Recipe: Salted Eye
            { 5, 65411 }, -- Recipe: Broiled Mountain Trout
            { 6, 65412 }, -- Recipe: Lightly Fried Lurker
            { 7, 65413 }, -- Recipe: Seasoned Crab
            { 8, 65414 }, -- Recipe: Starfire Espresso
            { 9, 65408 }, -- Recipe: Feathered Lure
            { 10, 65415 }, -- Recipe: Highland Spirits
            { 11, 65416 }, -- Recipe: Lurker Lunch
            { 12, 65417 }, -- Recipe: Pickled Guppy
            { 13, 65418 }, -- Recipe: Hearty Seafood Soup
            { 14, 65419 }, -- Recipe: Tender Baked Turtle
            { 16, 65420 }, -- Recipe: Mushroom Sauce Mudfish
            { 17, 65421 }, -- Recipe: Severed Sagefish Head
            { 18, 65422 }, -- Recipe: Delicious Sagefish Tail
            { 19, 65423 }, -- Recipe: Fish Fry
            { 20, 68688 }, -- Recipe: Scalding Murglesnout
            { 21, 65424 }, -- Recipe: Blackbelly Sushi
            { 22, 65425 }, -- Recipe: Skewered Eel
            { 23, 65426 }, -- Recipe: Baked Rockfish
            { 24, 65427 }, -- Recipe: Basilisk Liverdog
            { 25, 65428 }, -- Recipe: Grilled Dragon
            { 26, 65429 }, -- Recipe: Beer-Basted Crocolisk
            { 27, 65430 }, -- Recipe: Crocolisk Au Gratin
            { 28, 65431 }, -- Recipe: Chocolate Cookie
            { 29, 65432 }, -- Recipe: Fortune Cookie
            { 30, 65433 }, -- Recipe: South Island Iced Tea
        }
    }, {
        name = AL["Misc"],
        [VENDOR_DIFF] = {
            { 1, 68689 }, -- Imported Supplies
            { 16, 65513 }, -- Crate of Tasty Meat
        }
    }, {
        name = AL["Guild"],
        ExtraList = true;
        [VENDOR_DIFF] = {
            { 1, 62799 }, -- Recipe: Broiled Dragon Feast
            { 2, "ac5467"}, -- Set the Oven to "Cataclysmic"
            { 16, 62800 }, -- Recipe: Seafood Magnifique Feast
            { 17, "ac5036"}, -- That's a Lot of Bait
        }
    }}
}

data["ValorPointsCata"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, AL["Valor Points"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    ContentPhaseCata = 4,
    CorrespondingFields = private.VALOR_POINTS,
    items = { {
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
    }, {
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
    }, {
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
    }, {
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

data["JusticePointsCata"] = {
    name = format(AL["'%s' Vendor"], format(SUPERIOR_QUALITY, AL["Justice Points"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.JUSTICE_POINTS,
    items = { {
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
    }, {
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
    }, {
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
    }, {
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
    }, {
        name = ALIL["Cloak"],
        [VENDOR_DIFF_P1] = {
            { 1, 58192 }, -- Gray Hair Cloak
            { 2, 58190 }, -- Floating Web
            { 4, 58191 }, -- Viewless Wings
            { 16, 58193 }, -- Haunt of Flies
            { 17, 58194 }, -- Heavenly Breeze
        }
    }, {
            name = ALIL["Ranged Weapons"],
        [VENDOR_DIFF_P2] = {
            { 1, 71218 }, -- Deflecting Star
            { 2, 71154 }, -- Giantslicer
            { 4, 71152 }, -- Morningstar Shard
            { 16, 71151 }, -- Trail of Embers
            { 17, 71150 }, -- Scorchvine Wand
         }
    }, {
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
    }, {
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
    }, {
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
    }, {
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
    }, {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 58180 }, -- License to Slay
            { 2, 58181 }, -- Fluid Death
            { 3, 58183 }, -- Soul Casket
            { 4, 58184 }, -- Core of Ripeness
            { 5, 58182 } -- Bedrock Talisman
        }
    }, {
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
    } }
}

data["ObsidianFragments"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, AL["Obsidian Fragment"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [VENDOR_DIFF] = {
            { 1, 78381 }, -- Mosswrought Shoulderguards
            { 3, 78398 }, -- Cord of the Slain Champion
            { 5, 78457 }, -- Jaglespur Jackboots
            { 7, 78425 }, -- Bracers of the Banished
            { 9, 78380 }, -- Robe of Glowing Stone
            { 11, 78466 }, -- Gloves of Liquid Smoke
            { 16, 239111 }, -- Satchel of the Flickering Cowl
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [VENDOR_DIFF] = {
            { 1, 78375 }, -- Underdweller's Spaulders
            { 3, 78395 }, -- Belt of Flayed Skin
            { 4, 78428 }, -- Girdle of the Grostesque
            { 6, 78408 }, -- Interrogators Bloody Footpads
            { 7, 78442 }, -- Treads of Sordid Screams
            { 9, 78454 }, -- Shaadow Wing Armbands
            { 10, 78384 }, -- Mycosynth Wristguards
            { 12, 78467 }, -- Molten Blood Footpads
            { 16, 239113 }, -- Satchel of the Flickering Wristbands
            { 17, 239220 }, -- Satchel of the Flickering Shoulderpads
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = {
            { 1, 78443 }, -- Imperfect Specimens
            { 3, 78455 }, -- Belt of the Beloved Compainion
            { 4, 78385 }, -- Girdle of the Shattered Stone
            { 6, 78423 }, -- Treads of Dormant Dreams
            { 7, 78411 }, -- Mindstrainer Treads
            { 9, 78438 }, -- Bracers of Looming Darkness
            { 10, 78400 }, -- Grotesquely Writhing Bracers
            { 12, 78376 }, -- Sporebeard Gauntlets
            { 14, 78468 }, -- Belt of Shattered Elementium
            { 16, 239112 }, -- Satchel of the Flickering Shoulders
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = {
            { 1, 78378 }, -- Brackenshell Shoulderplates
            { 3, 78444 }, -- Dragonfracture Belt
            { 4, 78460 }, -- Gorionas Collar
            { 5, 78424 }, -- Runescriven Demon Collar
            { 7, 78386 }, -- Pillarfoot Greaves
            { 8, 78439}, -- Stillheart Warboots
            { 9, 78396 }, -- Treads of Crushed Flesh
            { 11, 78412 }, -- Heartblood Wristplates
            { 12, 78397 }, -- Graveheart Bracers
            { 13, 78377 }, -- Rockhide Bracers
            { 15, 78469 }, -- Gauntlets of the Golden Thorn
            { 16, 78470 }, -- Backbreaker Spaulders
            { 18, 239114 }, -- Satchel of the Flickering Handguards
        }
    },
    {
        name = ALIL["Weapon"],
        [VENDOR_DIFF] = {
            { 1,70733 }, -- Alysra's Razor
            { 2,78483 }, -- Blade of the Unmaker
            { 3,78422 }, -- Electrowing Dagger
            { 4,71779 }, -- Avool's Incendiary Shanker
            { 5,71787 }, -- Entrail Disgorger
            { 6,71013 }, -- Feeding Frenzy
            { 7,78484 }, -- Rathrak the Poisonous Mind

            { 9,78488 }, -- Souldrinker
            { 10,78481 },-- No'kaled
            { 11,78485 },-- Maw of the Dragonlord
            { 12,71776 },-- Eye of Purification
            { 13,71785 },-- Firethorn Mindslicer
            { 14,71312 },-- Gatecrasher
            { 15,71355 },-- Ko'gun
            { 16,70922 },-- Mandible of Beth'tilac
            { 17,71782 },-- Shatterskull Bonecrusher

            { 19,78486 }, -- Ti'tahk
            { 20,69897 },-- Fandral's Flamescythe
            { 21,71039 },-- Funeral Pyre
            { 22,71798 },-- Sho'ravon
            { 23,71775 },-- Smoldering Censer of Purity

            { 25,71353 },-- Arathar, the Eye of Flame
            { 26,78480 }, -- Vishanka
            { 27,70991 },-- Arbalest of Erupting Fury
            { 28,78374 },-- Razor Saronite Chip
            { 29,78399 },-- Finger of Zon'ozz
            { 30,71347 },-- Stinger of the Flaming Scorpion

            { 101,78487 }, -- Gurthalak
            { 102,71352 },-- Sulfuras
            { 103,71780 },-- Zoid's Firelit Greatsword
            { 104,71014 },-- Skullstealer Greataxe

            { 106,78482 }, -- Kiril
        }
    },
    {
        name = ALIL["Off Hand"] .. "/" .. ALIL["Shield"],
        [VENDOR_DIFF] = {
            { 1, 78458 }, -- Timepiece of bronze
            { 2, 78456 }, -- Blackhorns
            { 4, 78441 }, -- Ledger
        }
    },
    {
        name = ALIL["Neck"],
        [VENDOR_DIFF] = {
            { 1, 78382 }, -- Petrified Fungal Heart
        }
    },
    {
        name = ALIL["Finger"],
        [VENDOR_DIFF] = {
            { 1, 78440 }, -- Curled Twilight Claw
            { 2, 78497 }, -- Breathstealer Band
            { 4, 78496 }, -- Signet of Suturing
            { 5, 78495 }, -- Infinite Loop
            { 6, 78427 }, -- Ring of the Riven
            { 8, 78498 }, -- Hardheart Ring
            { 10, 78494 }, -- Seal of Primordial Shadow
            { 11, 78421 }, -- Signet of Grasping Mouths
        }
    },
    {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 69149 }, -- Eye of Blazing Power
            { 2, 69111 }, -- Jaws of Defeat
            { 3, 69109 }, -- Scales of Life
            { 4, 69138 }, -- Spidersilk Spindle
            { 5, 69112 }, -- The Hungerer
            { 6, 69113 }, -- Apparatus of Khaz'goroth
            { 7, 69139 }, -- Necromantic Focus
            { 8, 69150 }, -- Matrix Restabilizer
            { 9, 69110 }, -- Variable Pulse Lightning Capacitor
            { 10, 69167 }, -- Vessel of Acceleration
            { 12, 77977 }, -- Eye of Unmaking
            { 13, 77976 }, -- Heart of Unliving
            { 14, 77975 }, -- Will of Unbinding
            { 15, 77974 }, -- Wrath of Unchaining
            { 16, 77978 }, -- Resolved of Undying
            { 18, 77969 }, -- Seal of the Seven Signs
            { 19, 77971 }, -- Insignia of the Corrupted Mind
            { 20, 77970 }, -- Soulshifter Vortex
            { 21, 77972 }, -- Creche of the Final Dragon
            { 22, 77973 }, -- Starcatcher Compass
            { 23, 77982 }, -- Bone-link Fetish
            { 24, 77980 }, -- Cunning of the Cruel
            { 25, 77983 }, -- Indomitble Pride
            { 26, 77979 }, -- Vial of Shadows
            { 27, 77981 }, -- Windward Heart
         }
    },
    {
        name = AL["Token"] .. " - " .. AL["Dragon Soul"],
        [VENDOR_DIFF] = {
            -- T13 iLvl384 Tokens
            { 1, 78869 },
            { 2, 78870 },
            { 3, 78868 },
            { 5, 78875 },
            { 6, 78876 },
            { 7, 78874 },
            { 9, 78863 },
            { 10, 78864 },
            { 11, 78862 },
            { 16, 78866 },
            { 17, 78867 },
            { 18, 78865 },
            { 20, 78872 },
            { 21, 78873 },
            { 22, 78871 },
        }
    },
    {
        name = AL["Token"] .. " - " .. AL["Firelands"],
        [VENDOR_DIFF] = {
            { 1, 71675 }, -- Helm of the Fiery Conqueror
            { 2, 71682 }, -- Helm of the Fiery Protector
            { 3, 71668 }, -- Helm of the Fiery Vanquisher
            { 16, 71681 }, -- Mantle of the Fiery Conqueror
            { 17, 71688 }, -- Mantle of the Fiery Protector
            { 18, 71674 }, -- Mantle of the Fiery Vanquisher
        }
    },
    {
        name = AL["Misc"],
        [VENDOR_DIFF] = {
            { 1, 71617 }, -- Crystallized Firestone
            { 16, "c396", [ATLASLOOT_IT_AMOUNT1] = 10 }, -- Valor Points
            { 17, 234446 }, -- Commendation of Service
            { 18, "c3148", [ATLASLOOT_IT_AMOUNT1] = 1}, -- Fissure Stone Fragment
        }
    },
    }
}

data["FissureStoneFragments"] = {
    name = format(AL["'%s' Vendor"], format(EPIC_QUALITY, AL["Fissure Stone Fragment"])),
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {{
        name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
        [VENDOR_DIFF] = {
            { 1, 60237 }, -- Crown of the Twilight Queen
            { 3, 65043 }, -- Mantle of Nefarius
            { 5, 65019 }, -- Shadowblaze Robes
            { 7, 60238 }, -- Bracers of the Dark Mother
            { 8, 65056 }, -- Bracers of the Burningeye
            { 9, 65138 }, -- Bracers of the Bronze Dragonflight
            { 16, 232965 }, -- Satchel of the Soul Breath Belt
            { 18, 232966 }, -- Satchel of the Soul Breath Leggings
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
        [VENDOR_DIFF] = {
            { 1, 60231 }, -- Belt of the Fallen Brood
            { 2, 65057 }, -- Belt of the Nightmare
            { 4, 65021 }, -- Manacles of the Sleeping Beast
            { 5, 65050 }, -- Parasitic Bands
            { 7, 60236 }, -- Nightmare Rider's Boots
            { 16, 232950 }, -- Satchel of the Gale Rouser Belt
            { 17, 232973 }, -- Satchel of the Wind Stalker Belt
            { 19, 232951 }, -- Satchel of the Gale Rouser Leggings
            { 20, 232974 }, -- Satchel of the Wind Stalker Leggings
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
        [VENDOR_DIFF] = {
            { 1, 65074 }, -- Spaulders of the Scarred Lady
            { 3, 60230 }, -- Twilight Scale Leggings
            { 5, 65028 }, -- Chimaeron Armguards
            { 6, 65068 }, -- Chaos Beast Bracers
            { 8, 60235 }, -- Boots of Az'galada
            { 16, 232952 }, -- Satchel of the Lightning Well Belt
            { 17, 232967 }, -- Satchel of the Star Chaser Belt
            { 19, 232953 }, -- Satchel of the Lightning Well Legguards
            { 20, 232968 }, -- Satchel of the Star Chaser Legguards
        }
    },
    {
        name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
        [VENDOR_DIFF] = {
            { 1, 65027 }, -- Pauldrons of the Apocalypse
            { 3, 60228 }, -- Bracers of the Mat'redor
            { 4, 60234 }, -- Bindings of Bleak Betrayal
            { 5, 65085 }, -- Electron Inductor Coils
            { 6, 65143 }, -- Bracers of Impossible Strength
            { 7, 65127}, -- Shackles of the End of Days
            { 9, 65022 }, -- Belt of the Blackhand
            { 11, 60229 }, -- War-Torn Crushers
            { 16, 232963 }, -- Satchel of the Sky Strider Belt
            { 17, 232969 }, -- Satchel of the Tempest Keeper Belt
            { 18, 232971 }, -- Satchel of the Thunder Wall Belt
            { 20, 232964 }, -- Satchel of the Sky Strider Greaves
            { 21, 232970 }, -- Satchel of the Tempest Keeper Leggings
            { 22, 232972 }, -- Satchel of the Thunder Wall Greaves
        }
    },
    {
        name = AL["Cloak"],
        [VENDOR_DIFF] = {
            { 1, 60232 }, -- Shroud of Endless Grief
            { 2, 65018 }, -- Shadow of Dread
            { 16, 232947 }, -- Satchel of the Cloudburst Cloak
            { 17, 232955 }, -- Satchel of the Mistral Drape
            { 18, 232957 }, -- Satchel of the Permafrost Cape
            { 19, 232962 }, -- Satchel of the Planetary Drape
        }
    },
    {
        name = ALIL["Weapon"],
        [VENDOR_DIFF] = {
            { 1, 63679 }, -- Reclaimed Ashkandi, Greatsword of the Brotherhood
            { 2, 59330 }, -- Shalug'doom, the Axe of Unmaking
            { 3, 59492 }, -- Akirus the Worm Breaker
            { 5, 59474 }, -- Malevolence
            { 7, 59333 }, -- Lava Spine
            { 9, 63533 }, -- Fang of Twilight
            { 11, 59347 }, -- Mace of Acrid Death
            { 13, 59443 }, -- Crul'korak, the Lighting's Arc
            { 16, 59122 }, -- Organic Lifeform Inverter
            { 17, 59494 }, -- Uhn'agh Fash, the Darkest Betrayal
            { 19, 59341 }, -- Incineratus
            { 20, 63536 }, -- Blade of the Witching Hour
            { 22, 63680 }, -- Twilight's Hammer
            { 23, 59459 }, -- Andoros, Fist of the Dragon King
            { 25, 59320 }, -- Themios the Darkbringer
            { 26, 63532 }, -- Dragonheart Piercer
            { 28, 59314 }, -- Pip's Solution Agitator
        }
    },
    {
        name = ALIL["Off Hand"] .. "/" .. ALIL["Shield"],
        [VENDOR_DIFF] = {
            { 1, 59484 }, -- Book of Binding Will
            { 2, 59513 }, -- Scepter of Ice
            { 16, 59444 }, -- Akmin-Kurai, Dominion's Shield
            { 17, 59327 }, -- Kingdom's Heart
        }
    },
    {
        name = ALIL["Neck"],
        [VENDOR_DIFF] = {
            { 1, 60227 }, -- Caelestrasz's Will
            { 2, 65025 }, -- Rage of Ages
            { 16, 232948 }, -- Satchel of the Cloudburst Necklace
            { 17, 232956 }, -- Satchel of the Mistral Pendant
            { 18, 232958 }, -- Satchel of the Permafrost Choker
            { 19, 232960 }, -- Satchel of the Planetary Amulet
        }
    },
    {
        name = ALIL["Finger"],
        [VENDOR_DIFF] = {
            { 1, 60226 }, -- Dargonax's Signet
            { 16, 232949 }, -- Satchel of the Cloudburst Ring
            { 17, 232954 }, -- Satchel of the Mistral Circle
            { 18, 232959 }, -- Satchel of the Permafrost Signet
            { 19, 232961 }, -- Satchel of the Planetary Band
        }
    },
    {
        name = ALIL["Trinket"],
        [VENDOR_DIFF] = {
            { 1, 65048 }, -- Symbiotic Worm
            { 2, 65109 }, -- Vial of Stolen Memories
            { 4, 65072 }, -- Heart of Rage
            { 5, 65118 }, -- Crushing Weight
            { 7, 65026 }, -- Prestor's Talisman of Machination
            { 8, 65140 }, -- Essence of the Cyclone
            { 16, 65053 }, -- Bell of Enraging Resonance
            { 17, 65105 }, -- Theralion's Mirror
            { 18, 65110 }, -- Heart of Ignacious
            { 20, 60233 }, -- Shard of Woe
            { 21, 65124 }, -- Fall of Mortality
            { 22, 65029 }, -- Vial of Ancient Remedies
        }
    },
    {
        name = AL["Token"],
        [VENDOR_DIFF] = {
            { 1, 64315 }, -- Mantle of the Forlorn Conqueror
            { 2, 64316 }, -- Mantle of the Forlorn Protector
            { 3, 64314 }, -- Mantle of the Forlorn Vanquisher
            { 16, 63683 }, -- Helm of the Forlorn Conqueror
            { 17, 63684 }, -- Helm of the Forlorn Protector
            { 18, 63682 }, -- Helm of the Forlorn Vanquisher
        }
    },
    {
        name = AL["Misc"],
        [VENDOR_DIFF] = {
            { 1, 234446 }, -- Commendation of Service
        }
    },
    }
}

data["MoltenFront"] = {
    name = AL["Molten Front"],
    ContentType = VENDOR_CONTENT,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    ContentPhaseCata = 2.5,
    items = {
        { -- Favors of the World Tree
            name = AL["Favors of the World Tree"],
            [VENDOR_DIFF] = {
                { 1,  70108 }, -- Pyrelord Greaves
                { 3,  70107 }, -- Fireheart Necklace
                { 16,  70106 }, -- Nightweaver's Amulet
                { 17,  70105 }, -- Matoclaw's Band
            }
        },
        { -- Additional Armaments
            name = AL["Additional Armaments"],
            [VENDOR_DIFF] = {
                { 1, 70116 }, -- Gauntlets of Living Obsidium
                { 2, 70118 }, -- Widow's Clutches
                { 4, 70120 }, -- Rickety Belt
                { 5, 70117 }, -- Belt of Living Obsidium
                { 6, 70114 }, -- Fireplume Girdle
                { 16, 70115 }, -- Fiery Treads
                { 18, 70121 }, -- Ricket's Gun Show
                { 20, 70119 }, -- Meteorite Ring
                { 22, 70144 }, -- Ricket's Magnetic Fireball
            }
        },
        { -- Calling the Ancients
            name = AL["Calling the Ancients"],
            [VENDOR_DIFF] = {
                { 1, 70122 }, -- Aviana's Grips
                { 3, 70123 }, -- Lancer's Greaves
                { 5, 70126 }, -- Nemesis Shell Band
                { 6, 70127 }, -- Lylagar Horn Ring
                { 7, 70124 }, -- Spirit Fragment Band
                { 9, 70141 }, -- Dwyer's Caber
                { 16, 70125 }, -- Relic of Lo'Gosh
                { 17, 70128 }, -- Relic of Tortolla
                { 19, 70140 }, -- Hyjal Bear Cub
                { 20, 70159 }, -- Mylune's Call
        }
        },
        { -- Filling the Moonwell
            name = AL["Filling the Moonwell"],
            [VENDOR_DIFF] = {
                { 1,  70113 }, -- Moon Blessed Band
                { 2,  70110 }, -- Band of Glittering Lights
                { 4,  70112 }, -- Globe of Moonlight
                { 6,  70142 }, -- Moonwell Chalice
                { 7,  70143 }, -- Moonwell Phial
                { 16, 70109 }, -- Relic of Elune's Shadow
                { 17, 70111 }, -- Relic of Elune's Light
                { 19, 70160 }, -- Crimson Lasher
                { 20, 70161 }, -- Mushroom Chair
            }
        },
        { -- Patterns
            name = AL["Patterns"],
            ExtraList = true,
            [VENDOR_DIFF] = {
                { 1, "INV_SWORD_DRAENEI_05", nil, AL["Additional Armaments"] },
                { 2,  70177 }, -- Schematic: Flintlocke's Woodchucker
                { 3,  71078 }, -- Schematic: Extreme-Impact Hole Puncher
                { 5,  70166 }, -- Plans: Brainsplinter
                { 6,  70167 }, -- Plans: Masterwork Elementium Spellblade
                { 7,  70168 }, -- Plans: Lightforged Elementium Hammer
                { 8,  70169 }, -- Plans: Elementium-Edged Scalper
                { 9,  70170 }, -- Plans: Pyrium Spellward
                { 10,  70171 }, -- Plans: Unbreakable Guardian
                { 11,  70172 }, -- Plans: Masterwork Elementium Deathblade
                { 12, 70173 }, -- Plans: Witch-Hunter's Harvester
                { 16, "INV_MISC_HEAD_ELF_02", nil, AL["Filling the Moonwell"] },
                { 17,  70174 }, -- Pattern: Royal Scribe's Satchel
                { 19,  70175 }, -- Pattern: Triple-Reinforced Mining Bag
                { 18,  70176 }, -- Pattern: Luxurious Silk Gem Bag
            }
        },
        { -- Misc
            name = AL["Misc"],
            [VENDOR_DIFF] = {
                { 1, "INV_ELEMENTAL_PRIMAL_FIRE", nil, AL["All Quests Done"] },
                { 2,  AtlasLoot:GetRetByFaction(70149, 70152) },
                { 3,  AtlasLoot:GetRetByFaction(70154, 70145) },
                { 4,  AtlasLoot:GetRetByFaction(70150, 70148) },
                { 5,  AtlasLoot:GetRetByFaction(70153, 70147) },
                { 6,  AtlasLoot:GetRetByFaction(70151, 70146) },
                { 7,  AtlasLoot:GetRetByFaction(71088, 71087) },
                { 17, 71631 }, -- Zen'Vorka's Cache
                { 18, 34955 }, -- Scorched Stone
                { 20, 69213 }, -- Flameward Hippogryph
                { 21, 71259 }, -- Leyara's Locket
                { 23, "ac5879" },
                { 24, "ac5866" },
                { 25, "ac5859" },
            },
        },
    },
}

-- shared!
data["WorldEpicsCata"] = {
    name = AL["World Epics"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.WORLD_EPICS,
    items = { {
        name = AL["World Epics"],
        [NORMAL_ITTYPE] = {
            { 1,  67131 }, -- Ritssyn's Ruminous Drape
            { 2,  67141 }, -- Corefire Legplates
            { 3,  67130 }, -- Dorian's Lost Necklace
            { 4,  67140 }, -- Drape of Inimitable Fate
            { 5,  67134 }, -- Dory's Finery
            { 6,  67137 }, -- Don Rodrigo's Fabulous Necklace
            { 7,  67139 }, -- Blauvelt's Family Crest
            { 8,  67136 }, -- Gilnean Ring of Ruination
            { 9,  67144 }, -- Pauldrons of Edward the Odd
            { 10, 67148 }, -- Kilt of Trollish Dreams
            { 11, 67129 }, -- Signet of High Arcanist Savor
            { 12, 67135 }, -- Morrie's Waywalker Wrap
            { 13, 67133 }, -- Dizze's Whirling Robe
            { 14, 67138 }, -- Buc-Zakai Choker
            { 15, 67150 }, -- Arrowsinger Legguards
            { 16, 67149 }, -- Heartbound Tome
            { 17, 67145 }, -- Blockade's Lost Shield
            { 18, 67143 }, -- Icebone Hauberk
            { 19, 67147 }, -- Je'Tze's Sparkling Tiara
            { 20, 67146 }, -- Woundsplicer Handwraps
            { 21, 67132 }, -- Grips of the Failed Immortal
            { 22, 67142 }, -- Zom's Electrostatic Cloak
        }
    } }
}

data["Weapon Sets"] = {
    name = format(AL["%s Sets"], AL["Weapons"]),
    ContentType = SET_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = SET_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    items = {
        { -- Misc
            name = AL["Weapons"],
            [NORMAL_DIFF] = {
                { 1, 951 }, -- Agony and Torment / 359
                { 2, 1089 }, -- Jaws of Retribution / 397
                { 3, 1088 }, -- Maw of Oblivion / 406
                { 4, 1087 }, -- Fangs of the Father / 416
            }
        } }
}

data["MountsCata"] = {
    name = ALIL["Mounts"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.MOUNTS,
    items = {
        {
            name = AL["PvP"],
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = 70909, [ATLASLOOT_IT_HORDE] = 70910 }, -- Vicious War Steed / Vicious War Wolf
                { 2, 71339 }, -- Vicious Gladiator's Twilight Drake
                { 3, 71954 },  -- Ruthless Gladiator's Twilight Drake
            }
        },
        {
            name = AL["Drops"], -- Drops
            [NORMAL_DIFF] = {
                { 1, 63043 }, -- Reins of the Vitreous Stone Drake
                { 2,  63042 }, -- Reins of the Phosphorescent Stone Drake
                { 4,  63040 }, -- Reins of the Drake of the North Wind
                { 5,  63041 }, -- Reins of the Drake of the South Wind
                { 7,  69224 }, -- Smoldering Egg of Millagazor
                { 8,  71665 }, -- Flametalon of Alysrazor
                { 10, 77067 }, -- Reins of the Blazing Drake
                { 11, 77069 }, -- Life-Binder's Handmaiden
                { 12, 78919 }, -- Experiment 12-B
                { 14, 68823 }, -- Armored Razzashi Raptor
                { 15, 68824 }, -- Swift Zulian Panther
                { 16, 69747 }, -- Amani Battle Bear
                { 18, 67151 }, -- Reins of Poseidus
            }
        },
        {
            name = AL["Crafting"],
            [NORMAL_DIFF] = {
                { 1, 65891 }, -- Vial of the Sands
                { 3, 60954 }, -- Fossilized Raptor
                { 5, 64883 }, -- Scepter of Azj'Aqir
            }
        },
        {
            name = AL["Factions"],
            [NORMAL_DIFF] = {
                { 1, [ATLASLOOT_IT_ALLIANCE] = 63039, [ATLASLOOT_IT_HORDE] = 65356 },
                { 2, [ATLASLOOT_IT_ALLIANCE] = 64998, [ATLASLOOT_IT_HORDE] = 64999 },
            }
        },
        {
            name = AL["Darkmoon Faire"],
            [NORMAL_DIFF] = {
                { 1, 73766 }, -- Darkmoon Dancing Bear
                { 2, 72140 }, -- Swift Forest Strider
            }
        },
        {
            name = ALIL["Achievements"],
            TableType = AC_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 62900, 4845 }, -- Reins of the Volcanic Stone Drake
                { 2, 62901, 4853 }, -- Reins of the Drake of the East Wind
                { 3, 69230, 5828 }, -- Corrupted Egg of Millagazor
                { 4, 77068, 6169 }, -- Reins of the Twilight Harbinger
            }
        }
    }
}

data["CompanionsCata"] = {
    name = ALIL["Companions"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.COMPANIONS,
    items = { {
        name = AL["Drops"],
        [NORMAL_DIFF] = {
            { 1,  64403 }, -- Fox Kit
            { 2,  64494 }, -- Tiny Shale Spider
            { 3,  68673 }, -- Smolderweb Egg
            { 16, 61387 }, -- Grubs bag
            { 17, 66076 }, -- Mr Grubbs
        }
    }, {
        name = AL["Vendor"],
        [NORMAL_DIFF] = {
            { 1,  70140 },                                                   -- Hyjal Bear Cub
            { 2,  70160 },                                                   -- Crimson Lasher
            { 3,  73905 },                                                   -- Darkmoon Zep
            { 4,  [ATLASLOOT_IT_ALLIANCE] = 63355, [ATLASLOOT_IT_HORDE] = 64996 }, -- Rustberg Gull
            { 5,  69239 },                                                   -- Winterspring Cub
            { 6,  73903 },                                                   -- Darkmoon Tonk
            { 7,  74981 },                                                   -- Darkmoon Cub
            { 8,  75042 },                                                   -- Flimsy Yellow Ballon
            { 9,  75040 },                                                   -- Flimsy Darkmoon Ballon
            { 10, 75041 },                                                   -- Flimsy Green Balloon
            { 11, 73762 },                                                   -- Darkmoon Balloon
            { 12, 73764 },                                                   -- Darkmoon Monkey
            { 13, 73764 },                                                   -- Darkmoon Turtle
        }
    }, {
        name = AL["World Events"],
        [NORMAL_DIFF] = {
            { 1, 71076 }, -- Creepy Crate
            { 2, 70908 }, -- Feline Familiar
            { 4, 73797 }, -- Lump of Coal
            { 6, 74611 }, -- Festival Lantern
        }
    }, {
        name = ALIL["Achievements"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            { 1,  63398, "ac5144" }, -- Armadillo Pup
            { 2,  65361, "ac5031" }, -- Guild Page Ally
            { 3,  65362, "ac5179" }, -- Guild Page Horde
            { 4,  65363, "ac5201" }, -- Guild Herald Ally
            { 5,  65364, "ac5201" }, -- Guild Herald Horde
            { 16, 71387, "ac5877" }, -- Brilliant Kaliri
            { 6,  60869, "ac5449" }, -- Pebbles
            { 7,  63138 },      -- Dark Phoenix Hatchling
            { 8,  71033, "ac5840" }, -- Lil Tarecgosa
            { 17, 71140, "ac5876" }, -- Nuts'
        }
    }, {
        name = ALIL["Quests"],
        TableType = AC_ITTYPE,
        [NORMAL_DIFF] = {
            { 1,  69251 },                                                   -- Lashtail Hatchling
            { 2,  66080 },                                                   -- Tiny Flamefly
            { 3,  69648 },                                                   -- Legs
            { 4,  68833 },                                                   -- Panther Cub
            { 5,  66067 },                                                   -- Sunflower
            { 6,  46325 },                                                   -- Withers
            { 7,  66073 },                                                   -- Snail
            { 8,  [ATLASLOOT_IT_ALLIANCE] = 72042, [ATLASLOOT_IT_HORDE] = 72045 }, -- A/H Balloons
            { 9,  65661 },                                                   -- Blue mini jouster
            { 10, 65661 },                                                   -- Gold mini jouster
        }
    }, {
        name = ALIL["Fishing"],
        [NORMAL_DIFF] = {
            { 1, 73953 }, -- Sea pony
        }
    }, {
        name = ALIL["Crafting"],
        [NORMAL_DIFF] = {
            { 1,  67274 }, -- Enchanted Lantern
            { 2,  67275 }, -- Magic Lamp
            { 3,  60847 }, -- Crawling Claw
            { 4,  67282 }, -- Elementium Geode
            { 5,  59597 }, -- Personal World Destroyer
            { 6,  60216 }, -- De-Weaponized Mechanical Companion
            { 7,  69821 }, -- Pterrordax Hatchling
            { 8,  60955 }, -- Fossilized Hatchling
            { 9,  69824 }, -- Voodoo Figurine
            { 10, 64372 }, -- Clockwork Gnome
        }
    }, {              -- Misc
        name = AL["Misc"],
        [NORMAL_DIFF] = {},
    } }
}

data["TabardsCata"] = {
    name = ALIL["Tabard"],
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.TABARDS,
    items = { {
        name = AL["Factions"],
        CoinTexture = "Reputation",
        [ALLIANCE_DIFF] = {
            { 1, 65904 }, -- Tabard of the Ramkahen
            { 2, 65905 }, -- Tabard of the Earthen Ring
            { 3, 65906 }, -- Tabard of the Guardians of Hyjal
            { 4, 65907 }, -- Tabard of Therazane
            { 5, 65908 }, -- Tabard of the Wildhammer Clan
        },
        [HORDE_DIFF] = {
            { 1, 65904 }, -- Tabard of the Ramkahen
            { 2, 65905 }, -- Tabard of the Earthen Ring
            { 3, 65906 }, -- Tabard of the Guardians of Hyjal
            { 4, 65907 }, -- Tabard of Therazane
            { 5, 65909 }, -- Tabard of the Dragonmaw Clan
        }
    }, {
        name = AL["Guild"],
        [NORMAL_DIFF] = {
            { 1, 5976 }, -- Guild Tabard
            { 2, 69209 }, -- Illustrious Guild Tabard
            { 3, 69210 }, -- Renowned Guild Tabard
        }
    }, {
        name = AL["PvP"],
        CoinTexture = "PvP",
        [ALLIANCE_DIFF] = {
            { 1, 63379 }, -- Baradin's Wardens Tabard
        },
        [HORDE_DIFF] = {
            {1 , 63378 }, -- Hellscream's Reach Tabard
        }
    }, {
        name = AL["Misc"],
        CoinTexture = "Misc",
        [NORMAL_DIFF] = {
            { 1, 35280 }, -- Tabard of Summer Flames
            { 2, 35279 }, -- Tabard of Summer Skies
        }
    } }
}

data["LegendarysCata"] = {
    name = format(LEGENDARY_QUALITY, AL["Legendaries"]),
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.LEGENDARYS,
    items = { {
        name = AL["Legendaries"],
        [NORMAL_DIFF] = {
            { 1,  71086, "ac5839" }, -- Dragonwrath, Tarecgosa's Rest
            { 16, 77949, "ac6181" }, -- Golad, Twilight of Aspects
            { 17, 77950, "ac6181" } -- Tiriosh, Nightmare of Ages
        }
    } }
}

data["HeirloomCata"] = {
    name = format(BOA_QUALITY, ALIL["Heirloom"]),
    ContentType = COLLECTIONS_CONTENT,
    LoadDifficulty = LOAD_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.HEIRLOOM,
    items = { {
        name = ALIL["Armor"],
        [NORMAL_DIFF] = {
            -- Cloak
            { 1,  62039 }, -- Inherited Cape of the Black Baron
            { 2,  62038 }, -- Worn Stoneskin Gargoyle Cape
            { 3,  62040 }, -- Ancient Bloodmoon Cloak
            { 4,  69892 }, -- Ripped Sandstorm Cloak
            -- Head
            { 16, 69887 }, -- Burnished Helm of Might
            { 17, 61931 }, -- Polished Helm of Valor
            { 18, 61936 }, -- Mystical Coif of Elements
            { 19, 61935 }, -- Tarnished Raging Berserker's Helm
            { 20, 61942 }, -- Preened Tribal War Feathers
            { 21, 61937 }, -- Stained Shadowcraft Cap
            { 22, 61958 } -- Tattered Dreadmist Mask
        }
    } }
}

data["LunarFestivalCata"] = {
    name = AL["Lunar Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.LUNAR_FESTIVAL,
    items = {
        { -- LunarFestival1
            name = AL["Lunar Festival"],
            [NORMAL_DIFF] = {
                { 1,  21100 }, -- Coin of Ancestry
                { 2,  74610 }, -- Lunar Lantern
                { 3,  74611 }, -- Festival Lantern
                { 6,  21157 }, -- Festive Green Dress
                { 7,  21538 }, -- Festive Pink Dress
                { 8,  21539 }, -- Festive Purple Dress
                { 9,  21541 }, -- Festive Black Pant Suit
                { 10, 21544 }, -- Festive Blue Pant Suit
                { 11, 21543 }, -- Festive Teal Pant Suit
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

data["ValentinesdayCata"] = {
    name = AL["Love is in the Air"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.VALENTINES_DAY,
    items = { {                                                                       -- Valentineday
        name = AL["Love is in the Air"],
        [NORMAL_DIFF] = { { 1, 22206 },                                               -- Bouquet of Red Roses
            { 3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] }, { 4, 22279 }, -- Lovely Black Dress
            { 5,  72146 },                                                            -- Swift Lovebird
            { 6,  22235 },                                                            -- Truesilver Shafted Arrow
            { 7,  22200 },                                                            -- Silver Shafted Arrow
            { 8,  34480 },                                                            -- Romantic Picnic Basket
            { 9,  22261 },                                                            -- Love Fool
            { 10, 22218 },                                                            -- Handful of Rose Petals
            { 11, 21813 },                                                            -- Bag of Candies
            { 13, "INV_Box_02", nil, AL["Box of Chocolates"] }, { 14, 22237 },        -- Dark Desire
            { 15, 22238 },                                                            -- Very Berry Cream
            { 16, 22236 },                                                            -- Buttermilk Delight
            { 17, 22239 },                                                            -- Sweet Surprise
            { 18, 22276 },                                                            -- Lovely Red Dress
            { 19, 22278 },                                                            -- Lovely Blue Dress
            { 20, 22280 },                                                            -- Lovely Purple Dress
            { 21, 22277 },                                                            -- Red Dinner Suit
            { 22, 22281 },                                                            -- Blue Dinner Suit
            { 23, 22282 }                                                             -- Purple Dinner Suit
        }
    }, {                                                                              -- SFKApothecaryH
        name = C_Map_GetAreaInfo(209) .. " - " .. AL["Apothecary Hummel"],
        [NORMAL_DIFF] = { { 1, 238334 },                                              -- Heartbreak Charm
            { 2,  238335 },                                                           -- Winking Eye of Love
            { 3,  238336 },                                                           -- Sweet Perfume Broach
            { 4,  238337 },                                                           -- Choker of the Pure Heart
            { 5,  238338 },                                                           -- Shard of Pirouetting Happiness
            { 7,  49641 },                                                            -- Faded Lovely Greeting Card
            { 8,  49715 },                                                            -- Forever-Lovely Rose
            { 9,  50250 },                                                            -- X-45 Heartbreaker
            { 10, 50446 },                                                            -- Toxic Wasteling
            { 11, 50471 },                                                            -- The Heartbreaker
            { 12, 50741 }                                                             -- Vile Fumigator's Mask
        }
    } }
}

data["NoblegardenCata"] = {
    name = AL["Noblegarden"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.NOBLEGARDEN,
    items = { {
            name = AL["Noblegarden"] .. " " .. AL["Vendor"],
            [NORMAL_DIFF] = {
                { 1,  44818 }, -- Noblegarden Egg
                { 2,  45073 }, -- Spring Flowers
                { 3,  44792 }, -- Blossoming Branch
                { 5,  44800 }, -- Spring Robes
                { 6,  19028 }, -- Elegant Dress
                { 7,  6833 }, -- White Tux Shirt
                { 8,  6835 }, -- Black Tux Pants
                { 16, 44803 }, -- Spring Circlet
                { 17, 74282 }, -- Spring Circlet Black
                { 18, 74283 }, -- Spring Circlet Pink
                { 20, 44794 }, -- Spring Rabbit Foot
                { 21, 72145 }, -- Swift Springstrider
            },
        },
    },
}

data["MidsummerFestivalCata"] = {
    name = AL["Midsummer Festival"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.MIDSUMMER_FESTIVAL,
    items = { {
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
    }, {
        name = C_Map_GetAreaInfo(3717) .. " - " .. AL["Ahune"],
        [NORMAL_DIFF] = {
            { 1,  54536 }, -- Satchel of Chilled Goods
            { 3,  248747 }, -- Frostscythe of Lord Ahune
            { 4,  248750 }, -- Shroud of Winter's Chill
            { 5,  248748 }, -- The Frost Lord's War Cloak
            { 6,  248752 }, -- Icebound Cloak
            { 7,  248751 }, -- Cloak of the Frigid Winds
            { 8,  248749 }, -- The Frost Lord's Battle Shroud
            { 10, 35723 }, -- Shards of Ahune
            { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
            { 18, 53641 }, -- Ice Chip
            { 20, 35557 }, -- Huge Snowball
        }
    } }
}

data["BrewfestCata"] = {
    name = AL["Brewfest"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
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
                {17, 32233}, -- Wolpertinger's Tankard
                {19, 37599}, -- "Brew of the Month" Club Membership Form
                {21, 37750}, -- Fresh Brewfest Hops
                {22, 39477}, -- Fresh Dwarven Brewfest Hops
                {23, 39476}, -- Fresh Goblin Brewfest Hops
                {24, 37816} -- Preserved Brewfest Hops
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
                { 1, 232017 }, -- Bitter Balebrew Charm
                { 2,  232016 }, -- Bubbling Brightbrew Charm
                { 3,  232012 }, -- Coren's Chromium Coaster
                { 4,  232013 }, -- Mithril Pocketwatch
                { 5,  232014 }, -- Ancient Pickled Egg
                { 6,  232015 }, -- Brawler's Souvenir
                { 8,  232030 }, -- Direbrew's Bloody Shanker
                { 9,  232031 }, -- Tankard O' Terror
                {16, 33977}, -- Swift Brewfest Ram
                {17, 37828}, -- Great Brewfest Kodo
                {19, 37863}, -- Direbrew's Remote
                {21, 38280} -- Direbrew's Dire Brew
            }
        }
    }
}

data["HalloweenCata"] = {
    name = AL["Hallow's End"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
    CorrespondingFields = private.HALLOWEEN,
    items = { {                  -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Misc"],
        [NORMAL_DIFF] = { { 1, 20400 }, -- Pumpkin Bag
            { 3,  70722 }, -- Little Wickerman
            { 4,  70908 }, -- Feline Familiar
            { 5,  71076 }, -- Creepy Crate
            { 16, 33226 }, -- Tricky Treat
        }
    }, {                         -- Halloween1
        name = AL["Hallow's End"] .. " - " .. AL["Wands"],
        [NORMAL_DIFF] = { { 1, 20410 }, -- Hallowed Wand - Bat
            { 2, 20409 },        -- Hallowed Wand - Ghost
            { 3, 20399 },        -- Hallowed Wand - Leper Gnome
            { 4, 20398 },        -- Hallowed Wand - Ninja
            { 5, 20397 },        -- Hallowed Wand - Pirate
            { 6, 20413 },        -- Hallowed Wand - Random
            { 7, 20411 },        -- Hallowed Wand - Skeleton
            { 8, 20414 }         -- Hallowed Wand - Wisp
        }
    }, {                         -- Halloween3
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
    }, {                         -- SMHeadlessHorseman
        name = C_Map_GetAreaInfo(796) .. " - " .. AL["Headless Horseman"],
        [NORMAL_DIFF] = {
            { 1,  71327 }, -- Band of Ghoulish Glee
            { 2,  71328 }, -- The Horseman's Signet
            { 3,  71329 }, -- Wicked Witch's Ring
            { 4,  71330 }, -- Seal of the Petrified Pumpkin
            { 5,  71326 }, -- The Horseman's Horrific Helmet
            { 6,  71325 }, -- The Horseman's Sinister Saber
            { 8,  33292 }, -- Hallowed Helm
            { 10, 34068 }, -- Weighted Jack-o'-Lantern
            { 12, 33277 }, -- Tome of Thomas Thomson
            { 16, 37012 }, -- The Horseman's Reins
            { 18, 37011 }, -- Magic Broom               60% ground
            { 20, 33154 } -- Sinister Squashling
        }
    } }
}

data["WinterVeilCata"] = {
    name = AL["Feast of Winter Veil"],
    ContentType = WORLD_EVENT_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    gameVersion = AtlasLoot.CATA_VERSION_NUM,
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
                { 1,  66540 }, -- Miniature Winter Veil Tree
                { 3,  34425 }, -- Clockwork Rocket Bot
                { 4,  54436 }, -- Blue Clockwork Rocket Bot
                { 5,  73797 }, -- Lump of Coal
                { 7,  46709 }, -- MiniZep Controller
                { 8,  44606 }, -- Toy Train Set
                { 9,  37710 }, -- Crashin' Thrashin' Racer Controller
                { 10,  54437 }, -- Tiny Green Ragdoll
                { 11, 54438 }, -- Tiny Blue Ragdoll
                { 13,  46725 }, -- Red Rider Air Rifle
                { 14, 34498 }, -- Paper Zeppelin Kit
                { 15, 44599 }, -- Zippy Copper Racer
                { 16, 44601 }, -- Heavy Copper Racer
                { 17, 44481 }, -- Grindgear Toy Gorilla
                { 18, 44482 }, -- Trusty Copper Racer
            },
        },
    },
}
