local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI
local ModelFrame = {}
AtlasLoot.GUI.ModelFrame = ModelFrame
local AL = AtlasLoot.Locales
local Model = AtlasLoot.Data.Model

-- lua
local next = next

if not HasAlternateForm then
	function HasAlternateForm()
		return false
	end
end

-- //\\
local MAX_CREATURES_PER_ENCOUNTER = 9
local BUTTON_COUNT = 0

ModelFrame.SelectedCreature = nil
local Creatures = {}

local cache = {}
local buttons = {}

local function GetButtonFromCache()
	local frame = next(cache)
	if frame then
		cache[frame] = nil
	end
	return frame
end

local function ClearButtonList()
	for i = 1, #buttons do
		local button = buttons[i]
		cache[button] = true
		button.info = nil
		button:Hide()
		buttons[i] = nil
	end
end

function ModelFrame.ButtonOnClick(self)
	if ModelFrame.SelectedCreature then
		ModelFrame.SelectedCreature:Enable()
	end

	ModelFrame.frame:SetPosition(0,0,0)
	ModelFrame.SelectedCreature = self
	self:Disable()

	--- Temporary workaround: STILL BROKEN in game SetDisplayInfo
	--- Looks up NpcID in Data/Model.lua table because SetDisplayInfo() has been
	--- broken for over a year AND calls SetCreature() function twice with
	--- a small delay in between calls because SetCreature() is also bugged
	--- may cause models to appear glitchy and has a small load time,
	--- it is what it is...
	--- :)
	local NpcID = Model:GetNpcID(self.displayInfo)
	if not NpcID then
		ModelFrame.frame:ClearModel()
		return
	end

	ModelFrame.frame:SetCreature(NpcID, self.displayInfo)
	C_Timer.After(1, function()
		ModelFrame.frame:SetCreature(NpcID, self.displayInfo)
	end)
	--- End Workaround
end

function ModelFrame:AddButton(name, desc, displayInfo)
	local button = GetButtonFromCache()
	if not button then
		BUTTON_COUNT = BUTTON_COUNT + 1
		local frameName = "AtlasLoot-GUI-ModelFrame-Button"..BUTTON_COUNT

		button = CreateFrame("Button", frameName, ModelFrame.frame, "AtlasLootCreatureButtonTemplate")
	end
	button:Show()
	buttons[#buttons+1] = button
	button.displayInfo = displayInfo
	button.name = name
	button.description = desc
	SetPortraitTextureFromCreatureDisplayID(button.creature, displayInfo)

	if #buttons == 1 then
		button:SetPoint("TOPLEFT", ModelFrame.frame, "TOPLEFT", 0, -10)
		ModelFrame.ButtonOnClick(button)
	else
		button:SetPoint("TOPLEFT", buttons[#buttons-1], "BOTTOMLEFT")
	end

	return button
end

function ModelFrame:Create()
	if self.frame then return end
	local frameName = "AtlasLoot_GUI-ModelFrame"

	self.frame = CreateFrame("PlayerModel", frameName, GUI.frame, "ModelWithControlsTemplate")
	local frame = self.frame
	frame:ClearAllPoints()
	frame:SetParent(GUI.frame)
	frame:SetPoint("TOPLEFT", GUI.frame.contentFrame.itemBG)
	frame:SetWidth(560)
	frame:SetHeight(450)
	frame.minZoom = 0.0
	frame.maxZoom = 1.0
	frame.Refresh = ModelFrame.Refresh
	frame.Clear = ModelFrame.Clear
	frame:Hide()

	frame:SetCamDistanceScale(3)
end

function ModelFrame:Show()
	if not ModelFrame.frame then ModelFrame:Create() end
	if not ModelFrame.frame:IsShown() or GUI.frame.contentFrame.shownFrame ~= ModelFrame.frame then
		GUI:HideContentFrame()
		ModelFrame.frame:Show()
		GUI.frame.contentFrame.shownFrame = ModelFrame.frame
	end
	if self.DisplayIDs then
		self:SetDisplayID(self.DisplayIDs)
	else
		return GUI.ItemFrame:Show()
	end
end

function ModelFrame:Refresh()
	if not ModelFrame.frame then ModelFrame:Create() end
	ModelFrame:Show()
end

--[[
	table = {
		{displayID, "name", "info"},
	}
]]--
function ModelFrame:SetDisplayID(displayID)
	if not self.frame then ModelFrame:Create() end
	ClearButtonList()
	ModelFrame.frame:ClearModel()
	wipe(Creatures)
	ModelFrame.SelectedCreature = nil
	if not displayID then
		ModelFrame.frame:Hide()
		return
	end
	for k,v in ipairs(displayID) do
		ModelFrame:AddButton(v[2], v[3], v[1])
	end
end

function ModelFrame.Clear()
	ClearButtonList()
	ModelFrame.frame:Hide()
end
