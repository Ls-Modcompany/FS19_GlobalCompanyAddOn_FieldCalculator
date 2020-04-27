
Gc_Gui_AddOn_FieldCalculatorSeed = {}
local Gc_Gui_AddOn_FieldCalculatorSeed_mt = Class(Gc_Gui_AddOn_FieldCalculatorSeed)
Gc_Gui_AddOn_FieldCalculatorSeed.xmlFilename = g_currentModDirectory .. "gui/GcMain_FieldCalculatorSeed.xml"
Gc_Gui_AddOn_FieldCalculatorSeed.debugIndex = g_company.debug:registerScriptName("Gc_Gui_AddOn_FieldCalculatorSeed")

function Gc_Gui_AddOn_FieldCalculatorSeed:new()
	local self = setmetatable({}, Gc_Gui_AddOn_FieldCalculatorSeed_mt)    
	self.name = "AddOnFieldCalculatorSeed"
	
	return self
end

function Gc_Gui_AddOn_FieldCalculatorSeed:keyEvent(unicode, sym, modifier, isDown, eventUsed) 
    if not g_company.gui.guis["gcAddOnFieldCalculatorSeed"].canExit and sym == 27 and not isDown then
        self:onClickClose()
    end
end

function Gc_Gui_AddOn_FieldCalculatorSeed:onClose() end
function Gc_Gui_AddOn_FieldCalculatorSeed:onCreate() end
function Gc_Gui_AddOn_FieldCalculatorSeed:update(dt) end

function Gc_Gui_AddOn_FieldCalculatorSeed:onOpen()
    g_depthOfFieldManager:setBlurState(true)
    self.manualClose = false
    self:setData(self.fieldId)
end

function Gc_Gui_AddOn_FieldCalculatorSeed:onClickClose()
    g_depthOfFieldManager:setBlurState(false)
	g_company.gui:setCanExit("gcAddOnFieldCalculatorSeed", true)
    g_company.gui:closeActiveGui("gc_main", false)
end

function Gc_Gui_AddOn_FieldCalculatorSeed:loadTable()
	self.gui_fieldList:removeElements()

    for _,fruit in pairs(g_fruitTypeManager:getFruitTypes()) do
        if fruit.allowsSeeding then
            self.currentFruit = fruit
            self.gui_fieldList:createItem()
        end        
	end
end

function Gc_Gui_AddOn_FieldCalculatorSeed:setData(fieldId)
    self.gui_header:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_seedshead"),fieldId))
    self.fieldId = fieldId
    for _,field in pairs(g_fieldManager.fields) do
        if field.fieldId == fieldId then
            self.fieldArea = field.fieldArea * 10000
            self:loadTable()
            return
        end
    end    
end

function Gc_Gui_AddOn_FieldCalculatorSeed:onCreateFruit(element)
    if self.currentFruit ~= nil then
        element:setText(g_fillTypeManager:getFillTypeByName(self.currentFruit.name).title)
	end
end

function Gc_Gui_AddOn_FieldCalculatorSeed:onCreateLiter(element)
    if self.currentFruit ~= nil then        
        element:setText(string.format(g_company.languageManager:getText("GlobalCompanyAddOn_FieldCalculator_gui_liter"), g_i18n:formatNumber(self.fieldArea*self.currentFruit.seedUsagePerSqm)))
    end
end