-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.MOP_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.MOP_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local PRIME_GLYPHS_DIFF = data:AddDifficulty(ALIL["Prime Glyphs"], "primeglyphs", 0)
local MAJOR_GLYPHS_DIFF = data:AddDifficulty(ALIL["Major Glyphs"], "majorglyphs", 0)
local MINOR_GLYPHS_DIFF = data:AddDifficulty(ALIL["Minor Glyphs"], "minorglyphs", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)

local GEM_FORMAT1 = ALIL["Gems"].." - %s"

data["AlchemyMoP"] = {
    name = ALIL["Alchemy"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ALCHEMY_LINK,
    items = {
        {
            name = AL["Flasks"],
            [NORMAL_DIFF] = {
                { 1, 114772 }, -- Flask of Falling Leaves
                { 2, 114769 }, -- Flask of Spring Blossoms
                { 3, 114770 }, -- Flask of the Earth
                { 4, 114771 }, -- Flask of the Warm Sun
                { 5, 114773 }, -- Flask of Winter's Bites
                { 16, 114786 }, -- Alchemist's Flask
            },
        },
        {
            name = AL["Transmutes"],
            [NORMAL_DIFF] = {
                { 1, 114784 }, -- Transmute: Primordial Ruby
                { 2, 114778 }, -- Transmute: Sun's Radiance
                { 3, 114766 }, -- Transmute: River's Heart
                { 4, 114776 }, -- Transmute: Vermilion Onyx
                { 5, 114777 }, -- Transmute: Imperial Amethyst
                { 6, 114767 }, -- Transmute: Wild Jade
                { 8, 114781 }, -- Transmute: Primal Diamond
                { 16, 114780 }, -- Transmute: Living Steel
                { 17, 130326 }, -- Riddle of Steel
                { 18, 114783 }, -- Transmute: Trillium Bar
            },
        },
        {
            name = AL["Healing/Mana Potions"],
            [NORMAL_DIFF] = {
                { 1, 114752 }, -- Master Healing Potion
                { 2, 114775 }, -- Master Mana Potion
                { 3, 114782 }, -- Potion of Focus
                { 16, 114751 }, -- Alchemist's Rejuvenation
            },
        },
        {
            name = AL["Util Potions"],
            [NORMAL_DIFF] = {
                { 1, 114760 }, -- Potion of Mogu Power
                { 2, 114757 }, -- Potion of the Jade Serpent
                { 3, 114753 }, -- Potion of the Mountains
                { 4, 114765 }, -- Virmen's Bite
            },
        },
        {
            name = AL["Elixirs"],
            [NORMAL_DIFF] = {
                { 1, 114764 }, -- Elixir of Peace
                { 2, 114762 }, -- Elixir of Perfection
                { 3, 114759 }, -- Elixir of the Rapids
                { 4, 114756 }, -- Elixir of Weaponry
                { 5, 114754 }, -- Mad Hozen Elixir
                { 6, 114758 }, -- Monk's Elixir
                { 16, 114763 }, -- Elixir of Mirrors
                { 17, 114755 }, -- Mantid Elixir
            },
        },
        {
            name = AL["Stones"],
            [NORMAL_DIFF] = {
                { 1, 136197 }, -- Zen Alchemist Stone
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 114774 }, -- Darkwater Potion
                { 2, 114779 }, -- Potion of Luck
                { 16, 114761 }, -- Desecrated Oil
            },
        }
    },
}

data["BlacksmithingMoP"] = {
    name = ALIL["Blacksmithing"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.BLACKSMITHING_LINK,
    items = {
        { -- Daggers
            name = AL["Weapons"].." - "..ALIL["Daggers"],
            [NORMAL_DIFF] = {
                { 1, 122648 }, -- Masterwork Ghost Shard
                { 2, 122641 }, -- Ghost Shard
            }
        },
        { -- Axes
            name = AL["Weapons"].." - "..AL["Axes"],
            [NORMAL_DIFF] = {
                { 1, "INV_axe_04", nil, ALIL["One-Handed Axes"] },
                { 2, 138878 }, -- "Black Planar Edge, Reborn"
                { 3, 138880 }, -- "Wicked Edge of the Planes, Reborn"
                { 4, 138876 }, -- "The Planar Edge, Reborn"
                { 5, 122644 }, -- Masterwork Forgewire Axe
                { 6, 122637 }, -- Forgewire Axe
                { 16, "INV_axe_09", nil, ALIL["Two-Handed Axes"] },
                { 17, 138881 }, -- "Bloodmoon, Reborn"
                { 18, 138879 }, -- "Mooncleaver, Reborn"
                { 19, 138877 }, -- "Lunar Crescent, Reborn"
                { 20, 122647 }, -- Masterwork Spiritblade Decimator
                { 21, 122640 }, -- Spiritblade Decimator
            }
        },
        { -- Maces
            name = AL["Weapons"].." - "..AL["Maces"],
            [NORMAL_DIFF] = {
                { 1, "INV_mace_04", nil, ALIL["One-Handed Maces"] },
                { 2, 138885 }, -- "Dragonmaw, Reborn"
                { 3, 138886 }, -- "Dragonstrike, Reborn"
                { 4, 138882 }, -- "Drakefist Hammer, Reborn"
                { 5, 122646 }, -- Masterwork Phantasmal Hammer
                { 6, 122639 }, -- Phantasmal Hammer
                { 16, "INV_mace_07", nil, ALIL["Two-Handed Maces"] },
                { 17, 138884 }, -- "Deep Thunder, Reborn"
                { 18, 138887 }, -- "Stormherald, Reborn"
                { 19, 138883 }, -- "Thunder, Reborn"
            }
        },
        { -- Swords
            name = AL["Weapons"].." - "..AL["Swords"],
            [NORMAL_DIFF] = {
                { 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
                { 2, 138892 }, -- "Blazefury, Reborn"
                { 3, 138890 }, -- "Blazeguard, Reborn"
                { 4, 138888 }, -- "Fireguard, Reborn"
                { 5, 122645 }, -- Masterwork Ghost-Forged Blade
                { 6, 122638 }, -- Ghost-Forged Blade
                { 16, "INV_sword_19", nil, ALIL["Two-Handed Swords"] },
                { 17, 138893 }, -- "Lionheart Executioner, Reborn"
                { 18, 138891 }, -- "Lionheart Champion, Reborn"
                { 19, 138889 }, -- "Lionheart Blade, Reborn"
            }
        },
        { -- Shield
            name = AL["Weapons"].." - "..ALIL["Shield"],
            [NORMAL_DIFF] = {
                { 1, 122642 }, -- Masterwork Lightsteel Shield
                { 2, 122643 }, -- Masterwork Spiritguard Shield
                { 3, 122635 }, -- Lightsteel Shield
                { 4, 122636 }, -- Spiritguard Shield
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [PLATE_DIFF] = {
                { 1, 137767 }, -- Haunted Steel Headcover
                { 2, 137771 }, -- Haunted Steel Headguard
                { 3, 137769 }, -- Haunted Steel Greathelm
                { 4, 122616 }, -- Contender's Revenant Helm
                { 5, 122624 }, -- Contender's Spirit Helm
                { 6, 122600 }, -- Masterwork Ghost-Forged Helm
                { 7, 122608 }, -- Masterwork Lightsteel Helm
                { 8, 122592 }, -- Masterwork Spiritguard Helm
                { 9, 122576 }, -- Ghost-Forged Helm
                { 10, 122584 }, -- Lightsteel Helm
                { 11, 122568 }, -- Spiritguard Helm
            },
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [PLATE_DIFF] = {
                { 1, 122617 }, -- Contender's Revenant Shoulders
                { 2, 122625 }, -- Contender's Spirit Shoulders
                { 3, 122601 }, -- Masterwork Ghost-Forged Shoulders
                { 4, 122609 }, -- Masterwork Lightsteel Shoulders
                { 5, 122593 }, -- Masterwork Spiritguard Shoulders
                { 6, 122577 }, -- Ghost-Forged Shoulders
                { 7, 122585 }, -- Lightsteel Shoulders
                { 8, 122569 }, -- Spiritguard Shoulders
            },
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [PLATE_DIFF] = {
                { 1, 126854 }, -- Chestplate of Limitless Faith
                { 2, 126852 }, -- Ornate Battleplate of the Master
                { 3, 126850 }, -- Unyielding Bloodplate
                { 4, 122653 }, -- Breastplate of Ancient Steel
                { 5, 122649 }, -- Ghost Reaver's Breastplate
                { 6, 122651 }, -- Living Steel Breastplate
                { 7, 122618 }, -- Contender's Revenant Breastplate
                { 8, 122626 }, -- Contender's Spirit Breastplate
                { 9, 122602 }, -- Masterwork Ghost-Forged Breastplate
                { 10, 122610 }, -- Masterwork Lightsteel Breastplate
                { 11, 122594 }, -- Masterwork Spiritguard Breastplate
                { 12, 122578 }, -- Ghost-Forged Breastplate
                { 13, 122586 }, -- Lightsteel Breastplate
                { 14, 122570 }, -- Spiritguard Breastplate
            },
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [PLATE_DIFF] = {
                { 1, 122621 }, -- Contender's Revenant Bracers
                { 2, 122629 }, -- Contender's Spirit Bracers
                { 3, 122605 }, -- Masterwork Ghost-Forged Bracers
                { 4, 122613 }, -- Masterwork Lightsteel Bracers
                { 5, 122597 }, -- Masterwork Spiritguard Bracers
                { 6, 122581 }, -- Ghost-Forged Bracers
                { 7, 122589 }, -- Lightsteel Bracers
                { 8, 122573 }, -- Spiritguard Bracers
            },
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [PLATE_DIFF] = {
                { 1, 126853 }, -- Bloodforged Warfists
                { 2, 126851 }, -- Gauntlets of Battle Command
                { 3, 126855 }, -- Gauntlets of Unbound Devotion
                { 4, 122654 }, -- Gauntlets of Ancient Steel
                { 5, 122650 }, -- Ghost Reaver's Gauntlets
                { 6, 122652 }, -- Living Steel Gauntlets
                { 7, 122619 }, -- Contender's Revenant Gauntlets
                { 8, 122627 }, -- Contender's Spirit Gauntlets
                { 9, 122603 }, -- Masterwork Ghost-Forged Gauntlets
                { 10, 122611 }, -- Masterwork Lightsteel Gauntlets
                { 11, 122595 }, -- Masterwork Spiritguard Gauntlets
                { 12, 122579 }, -- Ghost-Forged Gauntlets
                { 13, 122571 }, -- Spiritguard Gauntlets
                { 14, 122587 }, -- Lightsteel Gauntlets
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [PLATE_DIFF] = {
                { 1, 142968 }, -- Avenger's Trillium Waistplate
                { 2, 142963 }, -- Blessed Trillium Belt
                { 3, 142967 }, -- Protector's Trillium Waistguard
                { 4, 122623 }, -- Contender's Revenant Belt
                { 5, 122631 }, -- Contender's Spirit Belt
                { 6, 122607 }, -- Masterwork Ghost-Forged Belt
                { 7, 122615 }, -- Masterwork Lightsteel Belt
                { 8, 122599 }, -- Masterwork Spiritguard Belt
                { 9, 122583 }, -- Ghost-Forged Belt
                { 10, 122575 }, -- Spiritguard Belt
                { 11, 122591 }, -- Lightsteel Belt
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [PLATE_DIFF] = {
                { 1, 142958 }, -- Protector's Trillium Legguards
                { 2, 142959 }, -- Avenger's Trillium Legplates
                { 3, 142954 }, -- Blessed Trillium Greaves
                { 4, 122620 }, -- Contender's Revenant Legplates
                { 5, 122628 }, -- Contender's Spirit Legplates
                { 6, 122604 }, -- Masterwork Ghost-Forged Legplates
                { 7, 122596 }, -- Masterwork Spiritguard Legplates
                { 8, 122612 }, -- Masterwork Lightsteel Legplates
                { 9, 122580 }, -- Ghost-Forged Legplates
                { 10, 122588 }, -- Lightsteel Legplates
                { 11, 122572 }, -- Spiritguard Legplates
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [PLATE_DIFF] = {
                { 1, 137766 }, -- Haunted Steel Greaves
                { 2, 137768 }, -- Haunted Steel Treads
                { 3, 137770 }, -- Haunted Steel Warboots
                { 4, 122622 }, -- Contender's Revenant Boots
                { 5, 122630 }, -- Contender's Spirit Boots
                { 6, 122606 }, -- Masterwork Ghost-Forged Boots
                { 7, 122614 }, -- Masterwork Lightsteel Boots
                { 8, 122598 }, -- Masterwork Spiritguard Boots
                { 9, 122582 }, -- Ghost-Forged Boots
                { 10, 122590 }, -- Lightsteel Boots
                { 11, 122574 }, -- Spiritguard Boots
            },
        },
        { -- Enhancements
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 122632 }, -- Living Steel Belt Buckle
                { 5, 114112 }, -- Socket Gloves
                { 16, 131928 }, -- Ghost Iron Shield Spike
                { 18, 131929 }, -- Living Steel Weapon Chain
                { 20, 113263 }, -- Socket Bracer
            }
        },
        { -- Misc
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 122633 }, -- Ghostly Skeleton Key
                { 16, 126869 }, -- Folded Ghost Iron
                { 17, 138646 }, -- Lightning Steel Ingot
                { 18, 143255 }, -- Balanced Trillium Ingot
                { 19, 146921 }, -- Accelerated Balanced Trillium Ingot
            }
        },
    }
}

data["EnchantingMoP"] = {
    name = ALIL["Enchanting"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ENCHANTING_LINK,
    items = {
        {
            name = ALIL["Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104440 }, -- Enchant Weapon - Colossus
                { 2, 104434 }, -- Enchant Weapon - Dancing Steel
                { 3, 104430 }, -- Enchant Weapon - Elemental Force
                { 4, 104427 }, -- Enchant Weapon - Jade Spirit
                { 5, 104442 }, -- Enchant Weapon - River's Song
                { 6, 104425 }, -- Enchant Weapon - Windsong
            }
        },
        {
            name = ALIL["Cloak"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104398 }, -- Enchant Cloak - Accuracy
                { 2, 104401 }, -- Enchant Cloak - Greater Protection
                { 3, 104404 }, -- Enchant Cloak - Superior Critical Strike
                { 4, 104403 }, -- Enchant Cloak - Superior Intellect
            }
        },
        {
            name = ALIL["Chest"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104395 }, -- Enchant Chest - Glorious Stats
                { 2, 104393 }, -- Enchant Chest - Mighty Spirit
                { 3, 104392 }, -- Enchant Chest - Super Resilience
                { 4, 104397 }, -- Enchant Chest - Superior Stamina
            }
        },
        {
            name = ALIL["Feet"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104409 }, -- Enchant Boots - Blurred Speed
                { 2, 104407 }, -- Enchant Boots - Greater Haste
                { 3, 104408 }, -- Enchant Boots - Greater Precision
                { 4, 104414 }, -- Enchant Boots - Pandaren's Step
            }
        },
        {
            name = ALIL["Hand"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104416 }, -- Enchant Gloves - Greater Haste
                { 2, 104419 }, -- Enchant Gloves - Super Strength
                { 3, 104417 }, -- Enchant Gloves - Superior Expertise
                { 4, 104420 }, -- Enchant Gloves - Superior Mastery
            }
        },
        {
            name = ALIL["Off Hand"] .. "/" .. ALIL["Shield"] .. " - " .. AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104445 }, -- Enchant Off-Hand - Major Intellect
                { 2, 130758 }, -- Enchant Shield - Greater Parry
            }
        },
        {
            name = ALIL["Wrist"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 104390 }, -- Enchant Bracer - Exceptional Strength
                { 2, 104391 }, -- Enchant Bracer - Greater Agility
                { 3, 104385 }, -- Enchant Bracer - Major Dodge
                { 4, 104338 }, -- Enchant Bracer - Mastery
                { 5, 104389 }, -- Enchant Bracer - Super Intellect
            }
        },
        {
            name = AL["Ring"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 103461 }, -- Enchant Ring - Greater Agility
                { 2, 103462 }, -- Enchant Ring - Greater Intellect
                { 3, 103463 }, -- Enchant Ring - Greater Stamina
                { 4, 103465 }, -- Enchant Ring - Greater Strength
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 116498 }, -- Ethereal Shard
                { 2, 118238 }, -- Ethereal Shatter
                { 3, 118237 }, -- Mysterious Diffusion
                { 4, 116497 }, -- Mysterious Essence
                { 5, 116499 }, -- Sha Crystal
                { 6, 118239 }, -- Sha Shatter
            }
        },
    }
}

data["EngineeringMoP"] = {
    name = ALIL["Engineering"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ENGINEERING_LINK,
    items = {
        {
            name = AL["Armor"].." - "..ALIL["Head"],
            [NORMAL_DIFF] = {
                { 1, 127117 }, -- Lightweight Retinal Armor
                { 3, 127118 }, -- Agile Retinal Armor
                { 4, 127119 }, -- Camouflage Retinal Armor
                { 6, 127120 }, -- Deadly Retinal Armor
                { 7, 127121 }, -- Energized Retinal Armor
                { 9, 127123 }, -- Reinforced Retinal Armor
                { 10, 127122 }, -- Specialized Retinal Armor
                { 16, 131211 }, -- Flashing Tinker's Gear
                { 17, 131212 }, -- Fractured Tinker's Gear
                { 18, 131213 }, -- Precise Tinker's Gear
                { 19, 131214 }, -- Quick Tinker's Gear
                { 20, 131215 }, -- Rigid Tinker's Gear
                { 21, 131216 }, -- Smooth Tinker's Gear
                { 22, 131217 }, -- Sparkling Tinker's Gear
                { 23, 131218 }, -- Subtle Tinker's Gear
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Trinket"],
            [NORMAL_DIFF] = {
                { 1, 127134 }, -- Ghost Iron Dragonling
            }
        },
        {
            name = ALIL["Weapon"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 127115 }, -- Lord Blastington's Scope of Doom
                { 2, 127116 }, -- Mirror Scope
            }
        },
        {
            name = AL["Weapons"],
            [NORMAL_DIFF] = {
                { 1, 127136 }, -- Big Game Hunter
                { 2, 127137 }, -- Long-Range Trillium Sniper
            }
        },
        {
            name = AL["Mounts"] .. " / " .. AL["Pets"],
            [NORMAL_DIFF] = {
                { 1, 127138 }, -- Depleted-Kyparium Rocket
                { 2, 127139 }, -- Geosynchronous World Spinner
                { 3, 139192 }, -- Sky Golem
                { 16, 127135 }, -- Mechanical Pandaren Dragonling
                { 17, 139196 }, -- Pierre
                { 18, 143714 }, -- Rascal-Bot
            }
        },
        {
            name = ALIL["Parts"],
            [NORMAL_DIFF] = {
                { 1, 127113 }, -- Ghost Iron Bolts
                { 2, 127114 }, -- High-Explosive Gunpowder
                { 3, 131563 }, -- Tinker's Kit
                { 4, 139176 }, -- Jard's Peculiar Energy Source
            }
        },
        {
            name = ALIL["Explosives"],
            [NORMAL_DIFF] = {
                { 1, 127127 }, -- G91 Landshark
                { 2, 127124 }, -- Locksmith's Powderkeg
            }
        },
        {
            name = ALIL["Engineering"].." - "..AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 109077 }, -- Incendiary Fireworks Launcher
                { 2, 126392 }, -- Goblin Glider
                { 3, 126731 }, -- Synapse Springs
                { 4, 108789 }, -- Phase Fingers
                { 5, 109099 }, -- Watergliding Jets
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 127131 }, -- Thermal Anvil
                { 2, 127128 }, -- "Goblin Dragon Gun, Mark II"
                { 3, 127130 }, -- Mist-Piercing Goggles
                { 16, 127132 }, -- Wormhole Generator: Pandaria
                { 17, 139197 }, -- Advanced Refrigeration Unit
                { 18, 127129 }, -- Blingtron 4000
                { 6, 131256 }, -- Autumn Flower Firework
                { 7, 128260 }, -- Celestial Firework
                { 8, 128261 }, -- Grand Celebration Firework
                { 9, 131258 }, -- Jade Blossom Firework
                { 10, 128262 }, -- Serpent's Heart Firework
                { 11, 131353 }, -- Pandaria Fireworks
            }
        },
    }
}

data["InscriptionMoP"] = {
    name = ALIL["Inscription"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.INSCRIPTION_LINK,
    items = {
        {
            name = ALIL["Armor"].." - "..ALIL["Off Hand"],
            [NORMAL_DIFF] = {
                { 1, 86640 }, -- Lord Rottington's Pressed Wisp Book
                { 2, 86616 }, -- Book of Blood
                { 16, 86643 }, -- Battle Tome
                { 17, 86642 }, -- Divine Companion
                { 18, 86641 }, -- Dungeoneering Guide
            }
        },
        {
            name = ALIL["Armor"].." - "..ALIL["Relic"],
            [NORMAL_DIFF] = {
                { 1, 86647 }, -- Etched Horn
                { 2, 86648 }, -- Manual of the Planes
                { 3, 86649 }, -- Runed Dragonscale
                { 5, 99547 }, -- Vicious Charm of Triumph
                { 6, 99548 }, -- Vicious Eyeball of Dominance
                { 7, 99549 }, -- Vicious Jawbone of Conquest
                { 16, 86650 }, -- Notched Jawbone
                { 17, 86653 }, -- Silver Inlaid Leaf
                { 18, 86652 }, -- Tattooed Eyeball
            }
        },
        {
            name = AL["Glyphs"].." - "..ALIL["DEATHKNIGHT"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57214 }, -- Glyph of Death and Decay
                { 2, 64266 }, -- Glyph of Death Coil
                { 3, 59340 }, -- Glyph of Death Strike
                { 4, 57216 }, -- Glyph of Frost Strike
                { 5, 57219 }, -- Glyph of Icy Touch
                { 6, 57208 }, -- Glyph of Heart Strike
                { 16, 64300 }, -- Glyph of Howling Blast
                { 17, 57220 }, -- Glyph of Obliterate
                { 18, 57222 }, -- Glyph of Raise Dead
                { 19, 57223 }, -- Glyph of Rune Strike
                { 20, 57224 }, -- Glyph of Scourge Strike
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57207 }, -- Glyph of Anti-Magic Shell
                { 2, 59339 }, -- Glyph of Blood Boil
                { 3, 57210 }, -- Glyph of Bone Shield
                { 4, 57211 }, -- Glyph of Chains of Ice
                { 5, 64297 }, -- Glyph of Dancing Rune Weapon
                { 6, 96284 }, -- Glyph of Dark Succor
                { 7, 57213 }, -- Glyph of Death Grip
                { 16, 64298 }, -- Glyph of Hungering Cold
                { 17, 57221 }, -- Glyph of Pestilence
                { 18, 57226 }, -- Glyph of Pillar of Frost
                { 19, 59338 }, -- Glyph of Rune Tap
                { 20, 57225 }, -- Glyph of Strangulate
                { 21, 57227 }, -- Glyph of Vampiric Blood
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 57209 }, -- Glyph of Blood Tap
                { 2, 57228 }, -- Glyph of Death Gate
                { 3, 57215 }, -- Glyph of Death's Embrace
                { 4, 57217 }, -- Glyph of Horn of Winter
                { 5, 57229 }, -- Glyph of Path of Frost
                { 6, 57230 }, -- Glyph of Resilient Grip
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["DRUID"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64268 }, -- Glyph of Berserk
                { 2, 56957 }, -- Glyph of Bloodletting
                { 3, 56948 }, -- Glyph of Insect Swarm
                { 4, 94402 }, -- Glyph of Lacerate
                { 5, 56949 }, -- Glyph of Lifebloom
                { 6, 56950 }, -- Glyph of Mangle
                { 7, 56951 }, -- Glyph of Moonfire
                { 8, 56954 }, -- Glyph of Regrowth
                { 16, 56955 }, -- Glyph of Rejuvenation
                { 17, 56956 }, -- Glyph of Rip
                { 18, 64307 }, -- Glyph of Savage Roar
                { 19, 64313 }, -- Glyph of Starsurge
                { 20, 56959 }, -- Glyph of Starfire
                { 21, 56960 }, -- Glyph of Swiftmend
                { 22, 94401 }, -- Glyph of Tiger's Fury
                { 23, 56963 }, -- Glyph of Wrath
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 64256 }, -- Glyph of Barkskin
                { 2, 48121 }, -- Glyph of Entangling Roots
                { 3, 94403 }, -- Glyph of Faerie Fire
                { 4, 94404 }, -- Glyph of Feral Charge
                { 5, 67600 }, -- Glyph of Ferocious Bite
                { 6, 62162 }, -- Glyph of Focus
                { 7, 56943 }, -- Glyph of Frenzied Regeneration
                { 8, 56945 }, -- Glyph of Healing Touch
                { 9, 56946 }, -- Glyph of Hurricane
                { 16, 56947 }, -- Glyph of Innervate
                { 17, 56961 }, -- Glyph of Maul
                { 18, 64258 }, -- Glyph of Monsoon
                { 19, 56952 }, -- Glyph of Pounce
                { 20, 56953 }, -- Glyph of Rebirth
                { 21, 56944 }, -- Glyph of Solar Beam
                { 22, 56958 }, -- Glyph of Starfall
                { 23, 58289 }, -- Glyph of Thorns
                { 24, 64270 }, -- Glyph of Wild Growth
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58286 }, -- Glyph of Aquatic Form
                { 2, 58287 }, -- Glyph of Challenging Roar
                { 3, 59315 }, -- Glyph of Dash
                { 4, 58296 }, -- Glyph of Mark of the Wild
                { 5, 95215 }, -- Glyph of the Treant
                { 6, 56965 }, -- Glyph of Typhoon
                { 7, 58288 }, -- Glyph of Unburdened Rebirth
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["HUNTER"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 56994 }, -- Glyph of Aimed Shot
                { 2, 56995 }, -- Glyph of Arcane Shot
                { 3, 64271 }, -- Glyph of Chimera Shot
                { 4, 64273 }, -- Glyph of Explosive Shot
                { 5, 57012 }, -- Glyph of Kill Command
                { 16, 64304 }, -- Glyph of Kill Shot
                { 17, 57008 }, -- Glyph of Rapid Fire
                { 18, 57009 }, -- Glyph of Serpent Sting
                { 19, 57011 }, -- Glyph of Steady Shot
                { 20, 57006 }, -- Glyph of the Dazzled Prey
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 56999 }, -- Glyph of Bestial Wrath
                { 2, 56998 }, -- Glyph of Concussive Shot
                { 3, 57000 }, -- Glyph of Deterrence
                { 4, 57001 }, -- Glyph of Disengage
                { 5, 57002 }, -- Glyph of Freezing Trap
                { 6, 57003 }, -- Glyph of Ice Trap
                { 7, 57005 }, -- Glyph of Immolation Trap
                { 8, 64253 }, -- Glyph of Master's Call
                { 16, 56997 }, -- Glyph of Mending
                { 17, 57004 }, -- Glyph of Misdirection
                { 18, 64246 }, -- Glyph of Raptor Strike
                { 19, 64249 }, -- Glyph of Scatter Shot
                { 20, 57007 }, -- Glyph of Silencing Shot
                { 21, 57010 }, -- Glyph of Snake Trap
                { 22, 56996 }, -- Glyph of Trap Launcher
                { 22, 57014 }, -- Glyph of Wyvern Sting
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58297 }, -- Glyph of Aspect of the Pack
                { 2, 58302 }, -- Glyph of Feign Death
                { 3, 58301 }, -- Glyph of Lesser Proportion
                { 4, 58299 }, -- Glyph of Revive Pet
                { 5, 58298 }, -- Glyph of Scare Beast
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["MAGE"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64276 }, -- Glyph of Arcane Barrage
                { 2, 56991 }, -- Glyph of Arcane Blast
                { 3, 56971 }, -- Glyph of Arcane Missiles
                { 4, 56988 }, -- Glyph of Cone of Cold
                { 5, 64274 }, -- Glyph of Deep Freeze
                { 6, 56975 }, -- Glyph of Fireball
                { 7, 56977 }, -- Glyph of Frostbolt
                { 16, 61677 }, -- Glyph of Frostfire
                { 17, 56980 }, -- Glyph of Ice Lance
                { 18, 94000 }, -- Glyph of Living Bomb
                { 19, 56984 }, -- Glyph of Mage Armor
                { 20, 56986 }, -- Glyph of Molten Armor
                { 21, 56978 }, -- Glyph of Pyroblast
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 56972 }, -- Glyph of Arcane Power
                { 2, 56990 }, -- Glyph of Blast Wave
                { 3, 56973 }, -- Glyph of Blink
                { 4, 56989 }, -- Glyph of Dragon's Breath
                { 5, 56974 }, -- Glyph of Evocation
                { 6, 56976 }, -- Glyph of Frost Nova
                { 7, 98398 }, -- Glyph of Frost Armor
                { 16, 64257 }, -- Glyph of Ice Barrier
                { 17, 56979 }, -- Glyph of Ice Block
                { 18, 56981 }, -- Glyph of Icy Veins
                { 19, 56983 }, -- Glyph of Invisibility
                { 20, 71101 }, -- Glyph of Mana Shield
                { 21, 56987 }, -- Glyph of Polymorph
                { 22, 64275 }, -- Glyph of Slow
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58303 }, -- Glyph of Arcane Brilliance
                { 2, 95710 }, -- Glyph of Armors
                { 3, 58306 }, -- Glyph of Conjuring
                { 4, 64314 }, -- Glyph of Mirror Image
                { 5, 58308 }, -- Glyph of Slow Fall
                { 6, 58307 }, -- Glyph of the Monkey
                { 7, 58310 }, -- Glyph of the Penguin
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["PALADIN"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57024 }, -- Glyph of Crusader Strike
                { 2, 57029 }, -- Glyph of Divine Favor
                { 3, 57025 }, -- Glyph of Exorcism
                { 4, 64278 }, -- Glyph of Hammer of the Righteous
                { 5, 64254 }, -- Glyph of Holy Shock
                { 6, 57030 }, -- Glyph of Judgement
                { 16, 57034 }, -- Glyph of Seal of Insight
                { 17, 59561 }, -- Glyph of Seal of Truth
                { 18, 64308 }, -- Glyph of Shield of the Righteous
                { 19, 64279 }, -- Glyph of Templar's Verdict
                { 20, 57026 }, -- Glyph of Word of Glory
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 64277 }, -- Glyph of Beacon of Light
                { 2, 57020 }, -- Glyph of Cleansing
                { 3, 57023 }, -- Glyph of Consecration
                { 4, 59560 }, -- Glyph of Dazing Shield
                { 5, 64305 }, -- Glyph of Divine Plea
                { 6, 57022 }, -- Glyph of Divine Protection
                { 7, 57031 }, -- Glyph of Divinity
                { 8, 57019 }, -- Glyph of Focused Shield
                { 9, 57027 }, -- Glyph of Hammer of Justice
                { 16, 57028 }, -- Glyph of Hammer of Wrath
                { 17, 59559 }, -- Glyph of Holy Wrath
                { 18, 57035 }, -- Glyph of Light of Dawn
                { 19, 57033 }, -- Glyph of Rebuke
                { 20, 57032 }, -- Glyph of Righteousness
                { 21, 64251 }, -- Glyph of Salvation
                { 22, 57021 }, -- Glyph of the Ascetic Crusader
                { 23, 95825 }, -- Glyph of the Long Word
                { 24, 57036 }, -- Glyph of Turn Evil
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58311 }, -- Glyph of Blessing of Kings
                { 2, 58314 }, -- Glyph of Blessing of Might
                { 3, 58312 }, -- Glyph of Insight
                { 4, 58316 }, -- Glyph of Justice
                { 5, 58313 }, -- Glyph of Lay on Hands
                { 6, 58315 }, -- Glyph of Truth
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["PRIEST"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64280 }, -- Glyph of Dispersion
                { 2, 57186 }, -- Glyph of Flash Heal
                { 3, 64281 }, -- Glyph of Guardian Spirit
                { 4, 57189 }, -- Glyph of Lightwell
                { 5, 57200 }, -- Glyph of Mind Flay
                { 6, 64282 }, -- Glyph of Penance
                { 16, 57193 }, -- Glyph of Power Word: Barrier
                { 17, 57194 }, -- Glyph of Power Word: Shield
                { 18, 57195 }, -- Glyph of Prayer of Healing
                { 19, 57197 }, -- Glyph of Renew
                { 20, 57199 }, -- Glyph of Shadow Word: Death
                { 21, 57192 }, -- Glyph of Shadow Word: Pain
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57181 }, -- Glyph of Circle of Healing
                { 2, 64259 }, -- Glyph of Desperation
                { 3, 57183 }, -- Glyph of Dispel Magic
                { 4, 64283 }, -- Glyph of Divine Accuracy
                { 5, 57184 }, -- Glyph of Fade
                { 6, 57185 }, -- Glyph of Fear Ward
                { 7, 57187 }, -- Glyph of Holy Nova
                { 8, 57188 }, -- Glyph of Inner Fire
                { 16, 57190 }, -- Glyph of Mass Dispel
                { 17, 57202 }, -- Glyph of Prayer of Mending
                { 18, 57191 }, -- Glyph of Psychic Horror
                { 19, 57196 }, -- Glyph of Psychic Scream
                { 20, 57198 }, -- Glyph of Scourge Imprisonment
                { 21, 57201 }, -- Glyph of Smite
                { 22, 64309 }, -- Glyph of Spirit Tap
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58317 }, -- Glyph of Fading
                { 2, 58318 }, -- Glyph of Fortitude
                { 3, 58319 }, -- Glyph of Levitate
                { 4, 107907 }, -- Glyph of Shadow
                { 5, 58320 }, -- Glyph of Shackle Undead
                { 6, 58321 }, -- Glyph of Shadow Protection
                { 7, 58322 }, -- Glyph of Shadowfiend
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["ROGUE"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57112 }, -- Glyph of Adrenaline Rush
                { 2, 57114 }, -- Glyph of Backstab
                { 3, 57120 }, -- Glyph of Eviscerate
                { 4, 57126 }, -- Glyph of Hemorrhage
                { 5, 64285 }, -- Glyph of Killing Spree
                { 6, 64260 }, -- Glyph of Mutilate
                { 16, 57124 }, -- Glyph of Revealing Strike
                { 17, 57128 }, -- Glyph of Rupture
                { 18, 64286 }, -- Glyph of Shadow Dance
                { 19, 57131 }, -- Glyph of Sinister Strike
                { 20, 57132 }, -- Glyph of Slice and Dice
                { 21, 64284 }, -- Glyph of Vendetta
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57113 }, -- Glyph of Ambush
                { 2, 57115 }, -- Glyph of Blade Flurry
                { 3, 92579 }, -- Glyph of Blind
                { 4, 64303 }, -- Glyph of Cloak of Shadows
                { 5, 57116 }, -- Glyph of Crippling Poison
                { 6, 57117 }, -- Glyph of Deadly Throw
                { 7, 57119 }, -- Glyph of Evasion
                { 8, 57121 }, -- Glyph of Expose Armor
                { 9, 64315 }, -- Glyph of Fan of Knives
                { 16, 57122 }, -- Glyph of Feint
                { 17, 57123 }, -- Glyph of Garrote
                { 18, 57125 }, -- Glyph of Gouge
                { 19, 57130 }, -- Glyph of Kick
                { 20, 57127 }, -- Glyph of Preparation
                { 21, 57129 }, -- Glyph of Sap
                { 22, 57133 }, -- Glyph of Sprint
                { 23, 64310 }, -- Glyph of Tricks of the Trade
                { 24, 94711 }, -- Glyph of Vanish
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58323 }, -- Glyph of Blurred Speed
                { 2, 58324 }, -- Glyph of Distract
                { 3, 58325 }, -- Glyph of Pick Lock
                { 4, 58326 }, -- Glyph of Pick Pocket
                { 5, 58328 }, -- Glyph of Poisons
                { 6, 58327 }, -- Glyph of Safe Fall
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["SHAMAN"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64261 }, -- Glyph of Earth Shield
                { 2, 57236 }, -- Glyph of Earthliving Weapon
                { 3, 64288 }, -- Glyph of Feral Spirit
                { 4, 57237 }, -- Glyph of Fire Elemental Totem
                { 5, 57239 }, -- Glyph of Flame Shock
                { 6, 57240 }, -- Glyph of Flametongue Weapon
                { 7, 57234 }, -- Glyph of Lava Burst
                { 8, 57249 }, -- Glyph of Lava Lash
                { 16, 57245 }, -- Glyph of Lightning Bolt
                { 17, 64289 }, -- Glyph of Riptide
                { 18, 57235 }, -- Glyph of Shocking
                { 19, 57248 }, -- Glyph of Stormstrike
                { 20, 101057 }, -- Glyph of Unleashed Lightning
                { 21, 57251 }, -- Glyph of Water Shield
                { 22, 57252 }, -- Glyph of Windfury Weapon
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57232 }, -- Glyph of Chain Heal
                { 2, 57233 }, -- Glyph of Chain Lightning
                { 3, 57250 }, -- Glyph of Elemental Mastery
                { 4, 57238 }, -- Glyph of Fire Nova
                { 5, 57241 }, -- Glyph of Frost Shock
                { 6, 59326 }, -- Glyph of Ghost Wolf
                { 7, 57247 }, -- Glyph of Grounding Totem
                { 8, 57242 }, -- Glyph of Healing Stream Totem
                { 16, 57243 }, -- Glyph of Healing Wave
                { 17, 64316 }, -- Glyph of Hex
                { 18, 57246 }, -- Glyph of Lightning Shield
                { 19, 64262 }, -- Glyph of Shamanistic Rage
                { 20, 64247 }, -- Glyph of Stoneclaw Totem
                { 21, 64287 }, -- Glyph of Thunder
                { 22, 57244 }, -- Glyph of Totemic Recall
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58329 }, -- Glyph of Astral Recall
                { 2, 58330 }, -- Glyph of Renewed Life
                { 3, 58332 }, -- Glyph of the Arctic Wolf
                { 4, 57253 }, -- Glyph of Thunderstorm
                { 5, 58331 }, -- Glyph of Water Breathing
                { 6, 58333 }, -- Glyph of Water Walking
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["WARLOCK"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 57260 }, -- Glyph of Bane of Agony
                { 2, 64294 }, -- Glyph of Chaos Bolt
                { 3, 57258 }, -- Glyph of Conflagrate
                { 4, 57259 }, -- Glyph of Corruption
                { 5, 57263 }, -- Glyph of Felguard
                { 6, 64291 }, -- Glyph of Haunt
                { 7, 57268 }, -- Glyph of Immolate
                { 16, 57269 }, -- Glyph of Imp
                { 17, 57257 }, -- Glyph of Incinerate
                { 18, 71102 }, -- Glyph of Lash of Pain
                { 19, 64318 }, -- Glyph of Metamorphosis
                { 20, 57272 }, -- Glyph of Shadowburn
                { 21, 57276 }, -- Glyph of Unstable Affliction
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57261 }, -- Glyph of Death Coil
                { 2, 64317 }, -- Glyph of Demonic Circle
                { 3, 57262 }, -- Glyph of Fear
                { 4, 57264 }, -- Glyph of Felhunter
                { 5, 57266 }, -- Glyph of Healthstone
                { 6, 57267 }, -- Glyph of Howl of Terror
                { 7, 64248 }, -- Glyph of Life Tap
                { 16, 57275 }, -- Glyph of Seduction
                { 17, 57271 }, -- Glyph of Shadow Bolt
                { 18, 64311 }, -- Glyph of Shadowflame
                { 19, 64250 }, -- Glyph of Soul Link
                { 20, 57270 }, -- Glyph of Soul Swap
                { 21, 57274 }, -- Glyph of Soulstone
                { 22, 57277 }, -- Glyph of Voidwalker
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58338 }, -- Glyph of Curse of Exhaustion
                { 2, 58337 }, -- Glyph of Drain Soul
                { 3, 58340 }, -- Glyph of Eye of Kilrogg
                { 4, 57265 }, -- Glyph of Health Funnel
                { 5, 58341 }, -- Glyph of Ritual of Souls
                { 6, 58339 }, -- Glyph of Subjugate Demon
                { 7, 58336 }, -- Glyph of Unending Breath
            },
        },
        {
            name = AL["Glyphs"].." - "..ALIL["WARRIOR"],
            [PRIME_GLYPHS_DIFF] = {
                { 1, 64295 }, -- Glyph of Bladestorm
                { 2, 57156 }, -- Glyph of Bloodthirst
                { 3, 57155 }, -- Glyph of Devastate
                { 4, 57160 }, -- Glyph of Mortal Strike
                { 5, 57161 }, -- Glyph of Overpower
                { 16, 57172 }, -- Glyph of Raging Blow
                { 17, 57165 }, -- Glyph of Revenge
                { 18, 57152 }, -- Glyph of Shield Slam
                { 19, 57163 }, -- Glyph of Slam
            },
            [MAJOR_GLYPHS_DIFF] = {
                { 1, 57154 }, -- Glyph of Cleaving
                { 2, 89815 }, -- Glyph of Colossus Smash
                { 3, 94405 }, -- Glyph of Death Wish
                { 4, 57158 }, -- Glyph of Heroic Throw
                { 5, 94406 }, -- Glyph of Intercept
                { 6, 57159 }, -- Glyph of Intervene
                { 7, 57157 }, -- Glyph of Piercing Howl
                { 8, 57162 }, -- Glyph of Rapid Charge
                { 16, 57164 }, -- Glyph of Resonating Power
                { 17, 64252 }, -- Glyph of Shield Wall
                { 18, 64296 }, -- Glyph of Shockwave
                { 19, 64302 }, -- Glyph of Spell Reflection
                { 20, 57167 }, -- Glyph of Sunder Armor
                { 21, 57168 }, -- Glyph of Sweeping Strikes
                { 22, 57170 }, -- Glyph of Victory Rush
            },
            [MINOR_GLYPHS_DIFF] = {
                { 1, 58342 }, -- Glyph of Battle
                { 2, 58343 }, -- Glyph of Berserker Rage
                { 3, 57153 }, -- Glyph of Bloody Healing
                { 4, 68166 }, -- Glyph of Command
                { 5, 58345 }, -- Glyph of Demoralizing Shout
                { 6, 58347 }, -- Glyph of Enduring Victory
                { 7, 64255 }, -- Glyph of Furious Sundering
                { 8, 64312 }, -- Glyph of Intimidating Shout
                { 9, 58344 }, -- Glyph of Long Charge
                { 10, 58346 }, -- Glyph of Thunder Clap
            },
        },
        {
            name = AL["Cards"],
            [NORMAL_DIFF] = {
                { 1, 86615 }, -- Darkmoon Card of Destruction
                { 16, 86609 }, -- Mysterious Fortune Card
            }
        },
        {
            name = AL["Ink"],
            [NORMAL_DIFF] = {
                { 1, 86005 }, -- Inferno Ink
                { 2, 86004 }, -- Blackfallow Ink
            }
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 86403 }, -- Felfire Inscription
                { 2, 86402 }, -- Inscription of the Earth Prince
                { 3, 86401 }, -- Lionsmane Inscription
                { 4, 86375 }, -- Swiftsteel Inscription
            },
        },
        {
            name = AL["Scrolls"],
            [NORMAL_DIFF] = {
                { 1, 85785 }, -- Runescroll of Fortitude II
                { 16, 89370 }, -- Scroll of Agility IX
                { 17, 89369 }, -- Scroll of Strength IX
                { 18, 89372 }, -- Scroll of Stamina IX
                { 19, 89371 }, -- Scroll of Spirit IX
                { 20, 89373 }, -- Scroll of Protection IX
                { 21, 89368 }, -- Scroll of Intellect IX
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 89367 }, -- Adventurer's Journal
                { 3, 92027 }, -- Dust of Disappearance
                { 4, 92026 }, -- Vanishing Powder
                { 16, [ATLASLOOT_IT_ALLIANCE] = 89244, [ATLASLOOT_IT_HORDE] = 86654 }, -- Forged Documents
                { 18, 86646 }, -- Origami Beetle
                { 19, 86645 }, -- Origami Rock
                { 20, 86644 }, -- Origami Slime
            }
        },
    }
}

data["JewelcraftingMoP"] = {
    name = ALIL["Jewelcrafting"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.JEWELCRAFTING_LINK,
    items = {
        {
            name = ALIL["Jewelcrafting"].." - "..ALIL["Gems"],
            [NORMAL_DIFF] = {
                { 1, 122676 }, -- Brilliant Serpent's Eye
                { 2, 122675 }, -- Bold Serpent's Eye
                { 3, 122674 }, -- Delicate Serpent's Eye
                { 4, 122685 }, -- Flashing Serpent's Eye
                { 5, 122683 }, -- Precise Serpent's Eye
                { 7, 122684 }, -- Fractured Serpent's Eye
                { 8, 122680 }, -- Smooth Serpent's Eye
                { 9, 122679 }, -- Subtle Serpent's Eye
                { 10, 122682 }, -- Quick Serpent's Eye
                { 16, 122681 }, -- Rigid Serpent's Eye
                { 17, 122677 }, -- Sparkling Serpent's Eye
                { 18, 122678 }, -- Solid Serpent's Eye
                { 20, 136270 }, -- Lucent Serpent's Eye
                { 21, 136269 }, -- Resplendent Serpent's Eye
                { 22, 136272 }, -- Willful Serpent's Eye
                { 24, 136274 }, -- Assassin's Serpent's Eye
                { 25, 136275 }, -- Mysterious Serpent's Eye
                { 26, 136273 }, -- Tense Serpent's Eye
            }
        },
        {
            name = AL["Armor"].." - "..ALIL["Neck"],
            [NORMAL_DIFF] = {
                { 1, 122670 }, -- Golembreaker Amulet
                { 2, 122669 }, -- Reflection of the Sea
                { 3, 122672 }, -- Skymage Circle
                { 4, 122673 }, -- Tiger Opal Pendant
                { 5, 122671 }, -- Widow Chain
                { 6, 122662 }, -- Shadowfire Necklace
            }
        },
        {
            name = AL["Armor"].." - "..AL["Ring"],
            [NORMAL_DIFF] = {
                { 1, 122668 }, -- Band of Blood
                { 2, 122664 }, -- Heart of the Earth
                { 3, 122667 }, -- Lionsfall Ring
                { 4, 122666 }, -- Lord's Signet
                { 5, 122665 }, -- Roguestone Shadowband
                { 6, 122661 }, -- Ornate Band
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Meta"]),
            [NORMAL_DIFF] = {
                { 1, 107753 }, -- Agile Primal Diamond
                { 2, 107754 }, -- Austere Primal Diamond
                { 3, 107756 }, -- Burning Primal Diamond
                { 4, 107757 }, -- Destructive Primal Diamond
                { 5, 107758 }, -- Effulgent Primal Diamond
                { 6, 107759 }, -- Ember Primal Diamond
                { 7, 107760 }, -- Enigmatic Primal Diamond
                { 16, 107762 }, -- Eternal Primal Diamond
                { 17, 107763 }, -- Fleet Primal Diamond
                { 18, 107764 }, -- Forlorn Primal Diamond
                { 19, 107765 }, -- Impassive Primal Diamond
                { 20, 107766 }, -- Powerful Primal Diamond
                { 21, 107767 }, -- Reverberating Primal Diamond
                { 22, 107768 }, -- Revitalizing Primal Diamond
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Red"]),
            [NORMAL_DIFF] = {
                { 1, 107705 }, -- Bold Primordial Ruby
                { 2, 107706 }, -- Brilliant Primordial Ruby
                { 3, 107707 }, -- Delicate Primordial Ruby
                { 4, 107708 }, -- Flashing Primordial Ruby
                { 5, 107709 }, -- Precise Primordial Ruby
                { 16, 107622 }, -- Bold Pandarian Garnet
                { 17, 107623 }, -- Brilliant Pandarian Garnet
                { 18, 107624 }, -- Delicate Pandarian Garnet
                { 19, 107625 }, -- Flashing Pandarian Garnet
                { 20, 107626 }, -- Precise Pandarian Garnet
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Yellow"]),
            [NORMAL_DIFF] = {
                { 1, 107710 }, -- Fractured Sun's Radiance
                { 2, 107711 }, -- Mystic Sun's Radiance
                { 3, 107712 }, -- Quick Sun's Radiance
                { 4, 107713 }, -- Smooth Sun's Radiance
                { 5, 107714 }, -- Subtle Sun's Radiance
                { 16, 107640 }, -- Fractured Sunstone
                { 17, 107641 }, -- Mystic Sunstone
                { 18, 107642 }, -- Quick Sunstone
                { 19, 107643 }, -- Smooth Sunstone
                { 20, 107644 }, -- Subtle Sunstone
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Blue"]),
            [NORMAL_DIFF] = {
                { 1, 106947 }, -- Rigid River's Heart
                { 2, 106950 }, -- Solid River's Heart
                { 3, 106949 }, -- Sparkling River's Heart
                { 4, 106948 }, -- Stormy River's Heart
                { 16, 107617 }, -- Rigid Lapis Lazuli
                { 17, 107619 }, -- Solid Lapis Lazuli
                { 18, 107620 }, -- Sparkling Lapis Lazuli
                { 19, 107621 }, -- Stormy Lapis Lazuli
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Orange"]),
            [NORMAL_DIFF] = {
                { 1, 107715 }, -- Adept Vermilion Onyx
                { 2, 107716 }, -- Artful Vermilion Onyx
                { 3, 107717 }, -- Champion's Vermilion Onyx
                { 4, 107718 }, -- Crafty Vermilion Onyx
                { 5, 107719 }, -- Deadly Vermilion Onyx
                { 6, 107720 }, -- Deft Vermilion Onyx
                { 7, 107721 }, -- Fierce Vermilion Onyx
                { 8, 107722 }, -- Fine Vermilion Onyx
                { 9, 107723 }, -- Inscribed Vermilion Onyx
                { 10, 107724 }, -- Keen Vermilion Onyx
                { 11, 107725 }, -- Lucent Vermilion Onyx
                { 16, 107726 }, -- Polished Vermilion Onyx
                { 17, 107727 }, -- Potent Vermilion Onyx
                { 18, 107728 }, -- Reckless Vermilion Onyx
                { 19, 107729 }, -- Resolute Vermilion Onyx
                { 20, 107730 }, -- Resplendent Vermilion Onyx
                { 21, 107731 }, -- Skillful Vermilion Onyx
                { 22, 107732 }, -- Splendid Vermilion Onyx
                { 23, 107733 }, -- Stalwart Vermilion Onyx
                { 24, 107734 }, -- Tenuous Vermilion Onyx
                { 25, 107735 }, -- Wicked Vermilion Onyx
                { 26, 107736 }, -- Willful Vermilion Onyx
                { 101, 107645 }, -- Adept Tiger Opal
                { 102, 107646 }, -- Artful Tiger Opal
                { 103, 107647 }, -- Champion's Tiger Opal
                { 104, 107648 }, -- Crafty Tiger Opal
                { 105, 107649 }, -- Deadly Tiger Opal
                { 106, 107650 }, -- Deft Tiger Opal
                { 107, 107651 }, -- Fierce Tiger Opal
                { 108, 107652 }, -- Fine Tiger Opal
                { 109, 107653 }, -- Inscribed Tiger Opal
                { 110, 107654 }, -- Keen Tiger Opal
                { 111, 107655 }, -- Lucent Tiger Opal
                { 116, 107656 }, -- Polished Tiger Opal
                { 117, 107657 }, -- Potent Tiger Opal
                { 118, 107658 }, -- Reckless Tiger Opal
                { 119, 107659 }, -- Resolute Tiger Opal
                { 120, 107660 }, -- Resplendent Tiger Opal
                { 121, 107661 }, -- Skillful Tiger Opal
                { 122, 107662 }, -- Splendid Tiger Opal
                { 123, 107663 }, -- Stalwart Tiger Opal
                { 124, 107665 }, -- Tenuous Tiger Opal
                { 125, 107666 }, -- Wicked Tiger Opal
                { 126, 107667 }, -- Willful Tiger Opal
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Green"]),
            [NORMAL_DIFF] = {
                { 1, 106960 }, -- Balanced Wild Jade
                { 2, 106957 }, -- Effulgent Wild Jade
                { 3, 107737 }, -- Energized Wild Jade
                { 4, 107738 }, -- Forceful Wild Jade
                { 5, 107739 }, -- Jagged Wild Jade
                { 6, 106955 }, -- Lightning Wild Jade
                { 7, 106953 }, -- Misty Wild Jade
                { 8, 107740 }, -- Nimble Wild Jade
                { 9, 106954 }, -- Piercing Wild Jade
                { 16, 107742 }, -- Puissant Wild Jade
                { 17, 107743 }, -- Radiant Wild Jade
                { 18, 107744 }, -- Regal Wild Jade
                { 19, 106956 }, -- Sensei's Wild Jade
                { 20, 107745 }, -- Shattered Wild Jade
                { 21, 107746 }, -- Steady Wild Jade
                { 22, 106962 }, -- Turbid Wild Jade
                { 23, 106961 }, -- Vivid Wild Jade
                { 24, 106958 }, -- Zen Wild Jade
                { 101, 107598 }, -- Balanced Alexandrite
                { 102, 107599 }, -- Effulgent Alexandrite
                { 103, 107600 }, -- Energized Alexandrite
                { 104, 107601 }, -- Forceful Alexandrite
                { 105, 107602 }, -- Jagged Alexandrite
                { 106, 107604 }, -- Lightning Alexandrite
                { 107, 107605 }, -- Misty Alexandrite
                { 108, 107606 }, -- Nimble Alexandrite
                { 109, 107607 }, -- Piercing Alexandrite
                { 116, 107608 }, -- Puissant Alexandrite
                { 117, 107609 }, -- Radiant Alexandrite
                { 118, 107610 }, -- Regal Alexandrite
                { 119, 107611 }, -- Sensei's Alexandrite
                { 120, 107612 }, -- Shattered Alexandrite
                { 121, 107613 }, -- Steady Alexandrite
                { 122, 107614 }, -- Turbid Alexandrite
                { 123, 107615 }, -- Vivid Alexandrite
                { 124, 107616 }, -- Zen Alexandrite
            }
        },
        {
            name = format(GEM_FORMAT1, ALIL["Purple"]),
            [NORMAL_DIFF] = {
                { 1, 107693 }, -- Accurate Imperial Amethyst
                { 2, 130657 }, -- Assassin's Imperial Amethyst
                { 3, 107694 }, -- Defender's Imperial Amethyst
                { 4, 107695 }, -- Etched Imperial Amethyst
                { 5, 107696 }, -- Glinting Imperial Amethyst
                { 6, 107697 }, -- Guardian's Imperial Amethyst
                { 7, 107698 }, -- Mysterious Imperial Amethyst
                { 8, 107699 }, -- Purified Imperial Amethyst
                { 9, 107700 }, -- Retaliating Imperial Amethyst
                { 10, 107701 }, -- Shifting Imperial Amethyst
                { 11, 107702 }, -- Sovereign Imperial Amethyst
                { 12, 130658 }, -- Tense Imperial Amethyst
                { 13, 107703 }, -- Timeless Imperial Amethyst
                { 14, 107704 }, -- Veiled Imperial Amethyst
                { 16, 107627 }, -- Accurate Roguestone
                { 17, 130656 }, -- Assassin's Roguestone
                { 18, 107628 }, -- Defender's Roguestone
                { 19, 107630 }, -- Etched Roguestone
                { 20, 107631 }, -- Glinting Roguestone
                { 21, 107632 }, -- Guardian's Roguestone
                { 22, 107633 }, -- Mysterious Roguestone
                { 23, 107634 }, -- Purified Roguestone
                { 24, 107635 }, -- Retaliating Roguestone
                { 25, 107636 }, -- Shifting Roguestone
                { 26, 107637 }, -- Sovereign Roguestone
                { 27, 130655 }, -- Tense Roguestone
                { 28, 107638 }, -- Timeless Roguestone
                { 29, 107639 }, -- Veiled Roguestone
            }
        },
        {
            name = AL["Research"],
            [NORMAL_DIFF] = {
                { 1, 131686 }, -- Primordial Ruby
                { 2, 131695 }, -- Sun's Radiance
                { 3, 131593 }, -- River's Heart
                { 4, 131690 }, -- Vermilion Onyx
                { 5, 131691 }, -- Imperial Amethyst
                { 6, 131688 }, -- Wild Jade
                { 16, 131759 }, -- Secrets of the Stone
            }
        },
        {
            name = AL["Mounts"].." / "..AL["Pets"],
            [NORMAL_DIFF] = {
                { 1, 120045 }, -- Jeweled Onyx Panther
                { 2, 121844 }, -- Jade Panther
                { 3, 121843 }, -- Sunstone Panther
                { 4, 121841 }, -- Ruby Panther
                { 5, 121842 }, -- Sapphire Panther
                { 16, 131898 }, -- Sapphire Cub
                { 17, 131897 }, -- Jade Owl
            }
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 140050 }, -- Serpent's Heart
                { 3, 122663 }, -- Scrying Roguestone
                { 16, 140060 }, -- Primal Diamond
            }
        },
                {
            name = AL["Raw Gems"],
            TableType = NORMAL_ITTYPE,
            ExtraList = true,
            [NORMAL_DIFF] = {
                { 1, 76132 }, -- Primal Diamond
                { 3, 76131 }, -- Primordial Ruby
                { 4, 76142 }, -- Sun's Radiance
                { 5, 76138 }, -- River's Heart
                { 6, 76140 }, -- Vermilion Onyx
                { 7, 76139 }, -- Wild Jade
                { 8, 76141 }, -- Imperial Amethyst
                { 16, 76734 }, -- Serpent's Eye
                { 18, 76136 }, -- Pandarian Garnet
                { 19, 76134 }, -- Sunstone
                { 20, 76133 }, -- Lapis Lazuli
                { 21, 76130 }, -- Tiger Opal
                { 22, 76137 }, -- Alexandrite
                { 23, 76135 }, -- Roguestone
            }
        },
    }
}

data["LeatherworkingMoP"] = {
    name = ALIL["Leatherworking"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.LEATHERWORKING_LINK,
    items = {
        { -- Cloak
            name = AL["Armor"].." - "..ALIL["Cloak"],
            [NORMAL_DIFF] = {
                { 1, 78475 },	-- Razor-Edged Cloak
                { 2, 78476 },	-- Twilight Dragonscale Cloak
                { 3, 99536 },   -- Vicious Fur Cloak
                { 4, 99535 },	-- Vicious Hide Cloak
                { 5, 78439 },	-- Cloak of War
                { 6, 78438 },	-- Cloak of Beasts
                { 7, 78405 },	-- Hardened Scale Cloak
                { 8, 78380 },	-- Savage Cloak
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [LEATHER_DIFF] = {
                { 1, 78480 },	-- Bloodied Wyrmhide Helm
                { 2, 78469 },	-- Bloodied Leather Helm
                { 3, 78424 },	-- Darkbrand Helm
            },
            [MAIL_DIFF] = {
                { 1, 78484 },	-- Bloodied Scale Helm
                { 2, 78474 },	-- Bloodied Dragonscale Helm
                { 3, 78432 },	-- Tsunami Helm
            },
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [LEATHER_DIFF] = {
                { 1, 78464 },	-- Bloodied Wyrmhide Shoulders
                { 2, 78455 },	-- Bloodied Leather Shoulders
                { 3, 78411 },	-- Darkbrand Shoulders
            },
            [MAIL_DIFF] = {
                { 1, 78470 },	-- Bloodied Scale Shoulders
                { 2, 78451 },	-- Bloodied Dragonscale Shoulders
                { 3, 78415 },	-- Tsunami Shoulders
            },
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [LEATHER_DIFF] = {
                { 1, 78487 },	-- Chestguard of Nature's Fury
                { 2, 78488 },	-- Assassin's Chestplate
                { 3, 78481 },	-- Bloodied Leather Chest
                { 4, 78467 },	-- Bloodied Wyrmhide Chest
                { 5, 78428 },	-- Darkbrand Chestguard
            },
            [MAIL_DIFF] = {
                { 1, 78489 },	-- Twilight Scale Chestguard
                { 2, 78490 },	-- Dragonkiller Tunic
                { 3, 78486 },	-- Bloodied Dragonscale Chest
                { 4, 78483 },	-- Bloodied Scale Chest
                { 5, 78423 },	-- Tsunami Chestguard
            },
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [LEATHER_DIFF] = {
                { 1, 101940 },	-- Bladeshadow Wristguards
                { 2, 101937 },	-- Bracers of Flowing Serenity
                { 3, 78444 },	-- Bloodied Wyrmhide Bracers
                { 4, 78446 },	-- Bloodied Leather Bracers
                { 5, 78398 },	-- Darkbrand Bracers
            },
            [MAIL_DIFF] = {
                { 1, 101939 },	-- Thundering Deathscale Wristguards
                { 2, 101941 },	-- Bracers of the Hunter-Killer
                { 3, 78448 },	-- Bloodied Scale Bracers
                { 4, 78450 },	-- Bloodied Dragonscale Bracers
                { 5, 78388 },	-- Tsunami Bracers
            },
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [LEATHER_DIFF] = {
                { 1, 99446 },	-- Clutches of Evil
                { 2, 99447 },	-- Heavenly Gloves of the Moon
                { 3, 78452 },	-- Bloodied Wyrmhide Gloves
                { 4, 78447 },	-- Bloodied Leather Gloves
                { 5, 78399 },	-- Darkbrand Gloves
            },
            [MAIL_DIFF] = {
                { 1, 99445 },	-- Gloves of Unforgiving Flame
                { 2, 99443 },	-- Dragonfire Gloves
                { 3, 78459 },	-- Bloodied Dragonscale Gloves
                { 4, 78449 },	-- Bloodied Scale Gloves
                { 5, 78406 },	-- Tsunami Gloves
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [LEATHER_DIFF] = {
                { 1, 78460 },	-- Lightning Lash
                { 2, 78461 },	-- Belt of Nefarious Whispers
                { 3, 78468 },	-- Bloodied Leather Belt
                { 4, 78445 },	-- Bloodied Wyrmhide Belt
                { 5, 78416 },	-- Darkbrand Belt
            },
            [MAIL_DIFF] = {
                { 1, 78462 },	-- Stormleather Sash
                { 2, 78463 },	-- Corded Viper Belt
                { 3, 78473 },	-- Bloodied Dragonscale Belt
                { 4, 78457 },	-- Bloodied Scale Belt
                { 5, 78396 },	-- Tsunami Belt
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [LEATHER_DIFF] = {
                { 1, 101933 },	-- Leggings of Nature's Champion
                { 2, 101935 },	-- Bladeshadow Leggings
                { 3, 78482 },	-- Bloodied Leather Legs
                { 4, 78479 },	-- Bloodied Wyrmhide Legs
                { 5, 78433 },	-- Darkbrand Leggings
            },
            [MAIL_DIFF] = {
                { 1, 101936 },	-- Rended Earth Leggings
                { 2, 101934 },	-- Deathscale Leggings
                { 3, 78485 },	-- Bloodied Dragonscale Legs
                { 4, 78471 },	-- Bloodied Scale Legs
                { 5, 78427 },	-- Tsunami Leggings
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [LEATHER_DIFF] = {
                { 1, 99457 },	-- Treads of the Craft
                { 2, 99458 },	-- Ethereal Footfalls
                { 3, 78454 },	-- Bloodied Leather Boots
                { 4, 78453 },	-- Bloodied Wyrmhide Boots
                { 5, 78407 },	-- Darkbrand Boots
            },
            [MAIL_DIFF] = {
                { 1, 99455 },	-- Earthen Scale Sabatons
                { 2, 99456 },	-- Footwraps of Quenched Fire
                { 3, 78456 },	-- Bloodied Scale Boots
                { 4, 78458 },	-- Bloodied Dragonscale Boots
                { 5, 78410 },	-- Tsunami Boots
            },
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 85068 },	-- Charscale Leg Reinforcements
                { 2, 78478 },	-- Charscale Leg Armor
                { 3, 78420 },	-- Twilight Leg Armor
                { 5, 85067 },	-- Dragonbone Leg Reinforcements
                { 6, 78477 },	-- Dragonscale Leg Armor
                { 7, 78419 },	-- Scorched Leg Armor
                { 9, 101600 },	-- Drakehide Leg Reinforcements
                { 10, 101599 },	-- Drakehide Leg Armor
                { 16, 85007 },	-- Draconic Embossment - Stamina
                { 17, 85008 },	-- Draconic Embossment - Agility
                { 18, 85009 },	-- Draconic Embossment - Strength
                { 19, 85010 },	-- Draconic Embossment - Intellect
                { 21, 78437 },	-- Heavy Savage Armor Kit
                { 22, 78379 },	-- Savage Armor Kit
            },
        },
        {
            name = ALIL["Bag"],
            [NORMAL_DIFF] = {
                { 1, 100583 },	-- Royal Scribe's Satchel
                { 3, 100586 },	-- Triple-Reinforced Mining Bag
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 78436 },	-- Heavy Savage Leather
                { 2, 84950 },	-- Savage Leather
            },
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 949 }, -- The Dark Brand
                { 2, 950 }, -- The Big Wave
            },
        }
    }
}

data["TailoringMoP"] = {
    name = ALIL["Tailoring"],
    ContentType = PROF_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.TAILORING_LINK,
    items = {
        { -- Cloak
            name = AL["Armor"].." - "..ALIL["Cloak"],
            [NORMAL_DIFF] = {
                { 1, 137907 }, -- Crafted Dreadful Gladiator's Cape of Cruelty
                { 2, 137908 }, -- Crafted Dreadful Gladiator's Cape of Prowess
                { 3, 137936 }, -- Crafted Dreadful Gladiator's Cloak of Alacrity
                { 4, 137937 }, -- Crafted Dreadful Gladiator's Cloak of Prowess
                { 5, 137918 }, -- Crafted Dreadful Gladiator's Drape of Cruelty
                { 6, 137920 }, -- Crafted Dreadful Gladiator's Drape of Meditation
                { 7, 137919 }, -- Crafted Dreadful Gladiator's Drape of Prowess
                { 16, 143053 }, -- Crafted Malevolent Gladiator's Cape of Cruelty
                { 17, 143054 }, -- Crafted Malevolent Gladiator's Cape of Prowess
                { 18, 143082 }, -- Crafted Malevolent Gladiator's Cloak of Alacrity
                { 19, 143083 }, -- Crafted Malevolent Gladiator's Cloak of Prowess
                { 20, 143064 }, -- Crafted Malevolent Gladiator's Drape of Cruelty
                { 21, 143066 }, -- Crafted Malevolent Gladiator's Drape of Meditation
                { 22, 143065 }, -- Crafted Malevolent Gladiator's Drape of Prowess
            }
        },
        { -- Head
            name = AL["Armor"].." - "..ALIL["Head"],
            [NORMAL_DIFF] = {
                { 1, 138598 }, -- Falling Blossom Cowl
                { 2, 138600 }, -- Falling Blossom Hood
                { 3, 125539 }, -- Contender's Satin Cowl
                { 4, 125531 }, -- Contender's Silk Cowl
                { 5, 125523 }, -- Windwool Hood
                { 16, 137939 }, -- Crafted Dreadful Gladiator's Felweave Cowl
                { 17, 137927 }, -- Crafted Dreadful Gladiator's Mooncloth Helm
                { 18, 137932 }, -- Crafted Dreadful Gladiator's Satin Hood
                { 19, 137922 }, -- Crafted Dreadful Gladiator's Silk Cowl
                { 21, 143085 }, -- Crafted Malevolent Gladiator's Felweave Cowl
                { 22, 143073 }, -- Crafted Malevolent Gladiator's Mooncloth Helm
                { 23, 143078 }, -- Crafted Malevolent Gladiator's Satin Hood
                { 24, 143068 }, -- Crafted Malevolent Gladiator's Silk Cowl
            }
        },
        { -- Shoulder
            name = AL["Armor"].." - "..ALIL["Shoulder"],
            [NORMAL_DIFF] = {
                { 1, 125540 }, -- Contender's Satin Amice
                { 2, 125532 }, -- Contender's Silk Amice
                { 3, 125524 }, -- Windwool Shoulders
                { 16, 137942 }, -- Crafted Dreadful Gladiator's Felweave Amice
                { 17, 137930 }, -- Crafted Dreadful Gladiator's Mooncloth Mantle
                { 18, 137935 }, -- Crafted Dreadful Gladiator's Satin Mantle
                { 19, 137925 }, -- Crafted Dreadful Gladiator's Silk Amice
                { 21, 143088 }, -- Crafted Malevolent Gladiator's Felweave Amice
                { 22, 143076 }, -- Crafted Malevolent Gladiator's Mooncloth Mantle
                { 23, 143081 }, -- Crafted Malevolent Gladiator's Satin Mantle
                { 24, 143071 }, -- Crafted Malevolent Gladiator's Silk Amice
            }
        },
        { -- Chest
            name = AL["Armor"].." - "..ALIL["Chest"],
            [NORMAL_DIFF] = {
                { 1, 125558 }, -- Robe of Eternal Rule
                { 2, 125560 }, -- Legacy of the Emperor
                { 3, 125549 }, -- Robes of Creation
                { 4, 125547 }, -- Spelltwister's Grand Robe
                { 5, 125541 }, -- Contender's Satin Raiment
                { 6, 125533 }, -- Contender's Silk Raiment
                { 7, 125525 }, -- Windwool Tunic
                { 16, 137941 }, -- Crafted Dreadful Gladiator's Felweave Raiment
                { 17, 137929 }, -- Crafted Dreadful Gladiator's Mooncloth Robe
                { 18, 137934 }, -- Crafted Dreadful Gladiator's Satin Robe
                { 19, 137924 }, -- Crafted Dreadful Gladiator's Silk Robe
                { 21, 143087 }, -- Crafted Malevolent Gladiator's Felweave Raiment
                { 22, 143075 }, -- Crafted Malevolent Gladiator's Mooncloth Robe
                { 23, 143080 }, -- Crafted Malevolent Gladiator's Satin Robe
                { 24, 143070 }, -- Crafted Malevolent Gladiator's Silk Robe
            }
        },
        { -- Wrist
            name = AL["Armor"].." - "..ALIL["Wrist"],
            [NORMAL_DIFF] = {
                { 1, 125544 }, -- Contender's Satin Cuffs
                { 2, 125536 }, -- Contender's Silk Cuffs
                { 3, 125528 }, -- Windwool Bracers
                { 16, 137916 }, -- Crafted Dreadful Gladiator's Cuffs of Prowess
                { 17, 137917 }, -- Crafted Dreadful Gladiator's Cuffs of Meditation
                { 18, 137915 }, -- Crafted Dreadful Gladiator's Cuffs of Accuracy
                { 20, 143062 }, -- Crafted Malevolent Gladiator's Cuffs of Prowess
                { 21, 143063 }, -- Crafted Malevolent Gladiator's Cuffs of Meditation
                { 22, 143061 }, -- Crafted Malevolent Gladiator's Cuffs of Accuracy
            }
        },
        { -- Hand
            name = AL["Armor"].." - "..ALIL["Hand"],
            [NORMAL_DIFF] = {
                { 1, 125559 }, -- Imperial Silk Gloves
                { 2, 125561 }, -- Touch of the Light
                { 3, 125550 }, -- Gloves of Creation
                { 4, 125548 }, -- Spelltwister's Gloves
                { 5, 125542 }, -- Contender's Satin Handwraps
                { 6, 125534 }, -- Contender's Silk Handwraps
                { 7, 125526 }, -- Windwool Gloves
                { 16, 137938 }, -- Crafted Dreadful Gladiator's Felweave Handguards
                { 17, 137926 }, -- Crafted Dreadful Gladiator's Mooncloth Gloves
                { 18, 137931 }, -- Crafted Dreadful Gladiator's Satin Gloves
                { 19, 137921 }, -- Crafted Dreadful Gladiator's Silk Handguards
                { 21, 143084 }, -- Crafted Malevolent Gladiator's Felweave Handguards
                { 22, 143072 }, -- Crafted Malevolent Gladiator's Mooncloth Gloves
                { 23, 143077 }, -- Crafted Malevolent Gladiator's Satin Gloves
                { 24, 143067 }, -- Crafted Malevolent Gladiator's Silk Handguards
            },
        },
        { -- Waist
            name = AL["Armor"].." - "..ALIL["Waist"],
            [NORMAL_DIFF] = {
                { 1, 142964 }, -- Belt of the Night Sky
                { 2, 142960 }, -- White Cloud Belt
                { 3, 125546 }, -- Contender's Satin Belt
                { 4, 125538 }, -- Contender's Silk Belt
                { 5, 125530 }, -- Windwool Belt
                { 16, 137911 }, -- Crafted Dreadful Gladiator's Cord of Meditation
                { 17, 137909 }, -- Crafted Dreadful Gladiator's Cord of Cruelty
                { 18, 137910 }, -- Crafted Dreadful Gladiator's Cord of Accuracy
                { 20, 143057 }, -- Crafted Malevolent Gladiator's Cord of Meditation
                { 21, 143055 }, -- Crafted Malevolent Gladiator's Cord of Cruelty
                { 22, 143056 }, -- Crafted Malevolent Gladiator's Cord of Accuracy
            },
        },
        { -- Legs
            name = AL["Armor"].." - "..ALIL["Legs"],
            [NORMAL_DIFF] = {
                { 1, 142955 }, -- Leggings of the Night Sky
                { 2, 142951 }, -- White Cloud Leggings
                { 3, 125543 }, -- Contender's Satin Pants
                { 4, 125535 }, -- Contender's Silk Pants
                { 5, 125527 }, -- Windwool Pants
                { 16, 137940 }, -- Crafted Dreadful Gladiator's Felweave Trousers
                { 17, 137928 }, -- Crafted Dreadful Gladiator's Mooncloth Leggings
                { 18, 137933 }, -- Crafted Dreadful Gladiator's Satin Leggings
                { 19, 137923 }, -- Crafted Dreadful Gladiator's Silk Trousers
                { 21, 143086 }, -- Crafted Malevolent Gladiator's Felweave Trousers
                { 22, 143074 }, -- Crafted Malevolent Gladiator's Mooncloth Leggings
                { 23, 143079 }, -- Crafted Malevolent Gladiator's Satin Leggings
                { 24, 143069 }, -- Crafted Malevolent Gladiator's Silk Trousers
            },
        },
        { -- Feet
            name = AL["Armor"].." - "..ALIL["Feet"],
            [NORMAL_DIFF] = {
                { 1, 138599 }, -- Falling Blossom Sandals
                { 2, 138597 }, -- Falling Blossom Treads
                { 3, 125545 }, -- Contender's Satin Footwraps
                { 4, 125537 }, -- Contender's Silk Footwraps
                { 5, 125529 }, -- Windwool Boots
                { 16, 137914 }, -- Crafted Dreadful Gladiator's Treads of Meditation
                { 17, 137912 }, -- Crafted Dreadful Gladiator's Treads of Cruelty
                { 18, 137913 }, -- Crafted Dreadful Gladiator's Treads of Alacrity
                { 20, 143060 }, -- Crafted Malevolent Gladiator's Treads of Meditation
                { 21, 143058 }, -- Crafted Malevolent Gladiator's Treads of Cruelty
                { 22, 143059 }, -- Crafted Malevolent Gladiator's Treads of Alacrity
            },
        },
        {
            name = AL["Enhancements"],
            [NORMAL_DIFF] = {
                { 1, 125496 }, -- Master's Spellthread
                { 2, 125555 }, -- Greater Cerulean Spellthread
                { 3, 125553 }, -- Cerulean Spellthread
                { 5, 125482 }, -- Darkglow Embroidery
                { 6, 125481 }, -- Lightweave Embroidery
                { 7, 125483 }, -- Swordguard Embroidery
                { 16, 125497 }, -- Sanctified Spellthread
                { 17, 125554 }, -- Greater Pearlescent Spellthread
                { 18, 125552 }, -- Pearlescent Spellthread
            },
        },
        {
            name = ALIL["Bag"],
            [NORMAL_DIFF] = {
                { 1, 125556 }, -- Royal Satchel
            },
        },
        {
            name = AL["Misc"],
            [NORMAL_DIFF] = {
                { 1, 125557 }, -- Imperial Silk
                { 2, 130325 }, -- Song of Harmony
                { 4, 125551 }, -- Bolt of Windwool Cloth
                { 16, 143011 }, -- Celestial Cloth
                { 17, 146925 }, -- Accelerated Celestial Cloth
            },
        },
        { -- Sets
            name = AL["Sets"],
            ExtraList = true,
            TableType = SET_ITTYPE,
            [NORMAL_DIFF] = {
                { 1, 1121 },
                { 16, 50001117 },
                { 17, 50001112 },
                { 18, 50001146 },
                { 19, 50001109 },
                { 21, 50011117 },
                { 22, 50011112 },
                { 23, 50011146 },
                { 24, 50011109 },
            },
        }
    }
}

data["MiningMoP"] = {
    name = ALIL["Mining"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.MINING_LINK,
    items = {
        {
            name = AL["Zen Master"],
            [NORMAL_DIFF] = {
                { 1, 102165 }, -- Smelt Ghost Iron
                { 2, 102167 }, -- Smelt Trillium
                { 16, "i72092" }, -- Ghost Iron Ore
                { 17, "i72093" }, -- Kyparite
                { 19, "i72094" }, -- Black Trillium Ore
                { 18, "i72103" }, -- White Trillium Ore

            }
        },
    }
}

data["HerbalismMoP"] = {
    name = ALIL["Herbalism"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.HERBALISM_LINK,
    items = {
        {
            name = AL["Zen Master"],
            [NORMAL_DIFF] = {
                { 1,  72234 }, -- Green Tea Leaf
                { 2,  72237 }, -- Rain Poppy
                { 3,  72235 }, -- Silkweed
                { 4,  79010 }, -- Snow Lily
                { 5,  79011 }, -- Fool's Cap
                { 7,  72238 }, -- Golden Lotus
            }
        },
    }
}

data["SkinningMoP"] = {
    name = ALIL["Skinning"],
    ContentType = PROF_GATH_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.SKINNING_LINK,
    items = {
        {
            name = AL["Zen Master"],
            [NORMAL_DIFF] = {
                { 1, 72162 }, -- Sha-Touched Leather
                { 2, 72120 }, -- Mist-Touched Leather
                { 4, 79101 }, -- Prismatic Scale
                { 16, 72163 }, -- Magnificent Hide
            }
        },
    }
}

data["ArchaeologyMoP"] = {
    name = ALIL["Archaeology"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.ARCHAEOLOGY_LINK,
    items = {
        {
            name = AL["Mantid"],
            [NORMAL_DIFF] = {
                { 1, 139786 }, -- Mantid Sky Reaver
                { 2, 139787 }, -- Sonic Pulse Generator
            },
        },
        {
            name = AL["Mogu"],
            [NORMAL_DIFF] = {
                { 1, 113993 }, -- Anatomical Dummy
                { 2, 113992 }, -- Quilen Statuette
            },
        },
        {
            name = AL["Pandaren"],
            [NORMAL_DIFF] = {
                { 1, 113980 }, -- Umbrella of Chi-Ji
                { 2, 113981 }, -- Spear of Xuen
            },
        },
    }
}

data["CookingMoP"] = {
    name = ALIL["Cooking"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.COOKING_LINK,
    items = {
        {
            name = ALIL["Feast"],
            [NORMAL_DIFF] = {
                { 1, 105190 }, -- Pandaren Banquet
                { 2, 105194 }, -- Great Pandaren Banquet
                { 4, 125602 }, -- Banquet of the Brew
                { 5, 125603 }, -- Great Banquet of the Brew
                { 6, 125141 }, -- Banquet of the Grill
                { 7, 125142 }, -- Great Banquet of the Grill
                { 8, 125600 }, -- Banquet of the Oven
                { 9, 125601 }, -- Great Banquet of the Oven
                { 10, 125596 }, -- Banquet of the Pot
                { 11, 125597 }, -- Great Banquet of the Pot
                { 12, 125598 }, -- Banquet of the Steamer
                { 13, 125599 }, -- Great Banquet of the Steamer
                { 14, 125594 }, -- Banquet of the Wok
                { 15, 125595 }, -- Great Banquet of the Wok
                { 16, 145038 }, -- Noodle Cart Kit
                { 17, 145167 }, -- Grand Noodle Cart Kit
                { 18, 145061 }, -- Deluxe Noodle Cart Kit
                { 19, 145170 }, -- Grand Deluxe Noodle Cart Kit
                { 20, 145062 }, -- Pandaren Treasure Noodle Cart Kit
                { 21, 145197 }, -- Grand Pandaren Treasure Noodle Cart Kit
            },
        },
        {
            name = ALIL["Way of the Brew"],
            [NORMAL_DIFF] = {
                { 1, 124052 }, -- Ginseng Tea
                { 2, 124053 }, -- Jade Witch Brew
                { 3, 124054 }, -- Mad Brewer's Breakfast
                { 4, 126655 }, -- Banana Infused Rum
                { 5, 126654 }, -- Four Senses Brew
                { 16, 125602 }, -- Banquet of the Brew
                { 17, 125603 }, -- Great Banquet of the Brew
            },
        },
        {
            name = ALIL["Way of the Grill"],
            [NORMAL_DIFF] = {
                { 1, 104298 }, -- Charbroiled Tiger Steak
                { 2, 104299 }, -- Eternal Blossom Fish
                { 3, 104300 }, -- Black Pepper Ribs and Shrimp
                { 4, 145311 }, -- Fluffy Silkfeather Omelet
                { 16, 125141 }, -- Banquet of the Grill
                { 17, 125142 }, -- Great Banquet of the Grill
            },
        },
        {
            name = ALIL["Way of the Oven"],
            [NORMAL_DIFF] = {
                { 1, 104310 }, -- Wildfowl Roast
                { 2, 104311 }, -- Twin Fish Platter
                { 3, 104312 }, -- Chun Tian Spring Rolls
                { 4, 145310 }, -- Stuffed Lushrooms
                { 16, 125600 }, -- Banquet of the Oven
                { 17, 125601 }, -- Great Banquet of the Oven
            },
        },
        {
            name = ALIL["Way of the Pot"],
            [NORMAL_DIFF] = {
                { 1, 104304 }, -- Swirling Mist Soup
                { 2, 104305 }, -- Braised Turtle
                { 3, 104306 }, -- Mogu Fish Stew
                { 4, 145307 }, -- Spiced Blossom Soup
                { 16, 125596 }, -- Banquet of the Pot
                { 17, 125597 }, -- Great Banquet of the Pot
            },
        },
        {
            name = ALIL["Way of the Steamer"],
            [NORMAL_DIFF] = {
                { 1, 104307 }, -- Shrimp Dumplings
                { 2, 104308 }, -- Fire Spirit Salmon
                { 3, 104309 }, -- Steamed Crab Surprise
                { 4, 145309 }, -- Farmer's Delight
                { 16, 125598 }, -- Banquet of the Steamer
                { 17, 125599 }, -- Great Banquet of the Steamer
            },
        },
        {
            name = ALIL["Way of the Wok"],
            [NORMAL_DIFF] = {
                { 1, 104301 }, -- Sauteed Carrots
                { 2, 104302 }, -- Valley Stir Fry
                { 3, 104303 }, -- Sea Mist Rice Noodles
                { 4, 145305 }, -- Seasoned Pomfruit Slices
                { 16, 125594 }, -- Banquet of the Wok
                { 17, 125595 }, -- Great Banquet of the Wok
            },
        },
        {
            name = AL["Low Level Recipes"],
            [NORMAL_DIFF] = {
                { 1, 125117 }, -- Sliced Peaches
                { 2, 125067 }, -- Perfectly Cooked Instant Noodles
                { 3, 124225 }, -- Toasted Fish Jerky
                { 4, 124227 }, -- Dried Needle Mushrooms
                { 5, 124223 }, -- Pounded Rice Cake
                { 6, 124224 }, -- Yak Cheese Curds
                { 7, 124226 }, -- Dried Peaches
                { 8, 124228 }, -- Boiled Silkworm Pupa
                { 9, 125078 }, -- Roasted Barley Tea
                { 16, 104237 }, -- Golden Carp Consomme
                { 17, 104297 }, -- Fish Cake
                { 18, 124233 }, -- Blanched Needle Mushrooms
                { 19, 124229 }, -- Red Bean Bun
                { 20, 124234 }, -- Skewered Peanut Chicken
                { 21, 124231 }, -- Green Curry Fish
                { 22, 124232 }, -- Peach Pie
                { 23, 124230 }, -- Tangy Yogurt
            },
        },
        {
            name = ALIL["Food"],
            [NORMAL_DIFF] = {
                { 1, 125120 }, -- Spicy Salmon
                { 2, 125123 }, -- Spicy Vegetable Chips
                { 3, 125080 }, -- Pearl Milk Tea
                { 4, 125121 }, -- Wildfowl Ginseng Soup
                { 5, 124029 }, -- Viseclaw Soup
                { 6, 124032 }, -- Krasarang Fritters
                { 7, 125122 }, -- Rice Pudding
                { 8, 145308 }, -- Mango Ice
            }
        },
    }
}

data["FirstAidMoP"] = {
    name = ALIL["First Aid"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = PROF_ITTYPE,
    CorrespondingFields = private.FIRSTAID_LINK,
    items = {
        {
            name = ALIL["First Aid"],
            [NORMAL_DIFF] = {
                { 1, 102697 }, -- Windwool Bandage
                { 2, 102698 }, -- Heavy Windwool Bandage
                { 3, 102699 }, -- Heavy Windwool Bandage
            }
        },
    }
}

data["FishingMoP"] = {
    name = ALIL["Fishing"],
    ContentType = PROF_SEC_CONTENT,
    LoadDifficulty = NORMAL_DIFF,
    TableType = NORMAL_ITTYPE,
    CorrespondingFields = private.FISHING_LINK,
    items = {
        {
            name = AL["Fish"],
            [NORMAL_DIFF] = {
                { 1, 74866 }, -- Golden Carp
                { 2, 74856 }, -- Jade Lungfish
                { 3, 74857 }, -- Giant Mantis Shrimp
                { 4, 74859 }, -- Emperor Salmon
                { 5, 74860 }, -- Redbelly Mandarin
                { 6, 74861 }, -- Tiger Gourami
                { 7, 74863 }, -- Jewel Danio
                { 8, 74864 }, -- Reef Octopus
                { 9, 74865 }, -- Krasarang Paddlefish
            }
        },
    }
}
