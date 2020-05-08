
Gc_Gui_AddOn_FieldCalculator = {}
local Gc_Gui_AddOn_FieldCalculator_mt = Class(Gc_Gui_AddOn_FieldCalculator)
Gc_Gui_AddOn_FieldCalculator.xmlFilename = g_currentModDirectory .. "gui/GcMain_FieldCalculator.xml"
Gc_Gui_AddOn_FieldCalculator.debugIndex = g_company.debug:registerScriptName("Gc_Gui_AddOn_FieldCalculator")

function Gc_Gui_AddOn_FieldCalculator:new()
	local self = setmetatable({}, Gc_Gui_AddOn_FieldCalculator_mt)    
	self.name = "AddOnFieldCalculator"
	
	return self
end

function Gc_Gui_AddOn_FieldCalculator:keyEvent(unicode, sym, modifier, isDown, eventUsed) 
	if sym == 13 and not isDown then
		self:onClickOpenSeed();
	end
end
function Gc_Gui_AddOn_FieldCalculator:onClose() end
function Gc_Gui_AddOn_FieldCalculator:onCreate() end
function Gc_Gui_AddOn_FieldCalculator:update(dt) end

function Gc_Gui_AddOn_FieldCalculator:onOpen()
	self:loadTable()
	self.currentSelectId = nil
	self.gui_btn_seed:setVisible(false)
	self.gui_btn_seedText:setVisible(false)
end

function Gc_Gui_AddOn_FieldCalculator:onClickClose()
    g_company.gui:closeActiveGui()
end

function Gc_Gui_AddOn_FieldCalculator:loadTable()
	self.gui_fieldList:removeElements()

	for _,field in pairs(g_fieldManager.fields) do
		self.currentFieldId = field.fieldId
		self.currentFieldArea = field.fieldArea
		local item = self.gui_fieldList:createItem()
		item.fieldId = field.fieldId
	end
end

function Gc_Gui_AddOn_FieldCalculator:onSelect(element)
	self.currentSelectId = element.fieldId
	self.gui_btn_seed:setVisible(true)
	self.gui_btn_seedText:setVisible(true)
end

function Gc_Gui_AddOn_FieldCalculator:onCreateField(element)
	if self.currentFieldId ~= nil then
		element:setText(self.currentFieldId)
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateFieldSize(element)
	if self.currentFieldId ~= nil then
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_header_fieldSize2"), g_i18n:formatNumber(self.currentFieldArea, 2)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateLime(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("LIME").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateFertilizer(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("FERTILIZER").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateLiquidFertilizer(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("LIQUIDFERTILIZER").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateHerbizid(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("HERBICIDE").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateManure(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("MANURE").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateLiquidManure(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("LIQUIDMANURE").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onCreateDigestate(element)
	if self.currentFieldArea ~= nil then
		local litersPerSecond = g_sprayTypeManager:getSprayTypeByName("DIGESTATE").litersPerSecond
		element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(litersPerSecond * self.currentFieldArea * 36000)))
	end
end

function Gc_Gui_AddOn_FieldCalculator:onClickOpenSeed()
    g_company.gui:setCanExit("gcAddOnFieldCalculatorSeed", false)
	g_company.gui:closeActiveGui("gcAddOnFieldCalculatorSeed", false, self.currentSelectId)    
end