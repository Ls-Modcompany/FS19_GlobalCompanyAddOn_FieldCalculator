--
-- GlobalCompany - AddOn - FieldCalculator
--
-- @Interface: --
-- @Author: LS-Modcompany / kevink98
-- @Date: 14.04.2020
-- @Version: 1.0.0.0
--
-- @Support: LS-Modcompany
--
-- Changelog:
--
-- 	v1.0.0.0 (14.04.2020):
-- 		- initial Script Fs19 (kevink98)
--
-- Notes:
--
--
-- ToDo:
-- 
--
--

GC_AddOnFieldCalculator = {}
GC_AddOnFieldCalculator._mt = Class(GC_AddOnFieldCalculator);
InitObjectClass(GC_AddOnFieldCalculator, "GC_AddOnFieldCalculator");

source(g_currentModDirectory .. "gui/GcMain_FieldCalculator.lua")
source(g_currentModDirectory .. "gui/GcMain_FieldCalculatorSeed.lua")

function GC_AddOnFieldCalculator:initGlobalCompany(customEnvironment, baseDirectory, xmlFile)
	if (g_company == nil) or (GC_AddOnFieldCalculator.isInitiated ~= nil) then
		return;
	end

	GC_AddOnFieldCalculator.debugIndex = g_company.debug:registerScriptName("GC_AddOnFieldCalculator");
	GC_AddOnFieldCalculator.modName = customEnvironment;
	GC_AddOnFieldCalculator.baseDirectory = baseDirectory
	GC_AddOnFieldCalculator.isInitiated = true;
	g_company.addOnFieldCalculator = GC_AddOnFieldCalculator

	g_company.addInit(GC_AddOnFieldCalculator, GC_AddOnFieldCalculator.init);	
end

function GC_AddOnFieldCalculator:init()
	GC_AddOnFieldCalculator.isServer = g_server ~= nil
	GC_AddOnFieldCalculator.isClient = g_dedicatedServerInfo == nil
	GC_AddOnFieldCalculator.isMultiplayer = g_currentMission.missionDynamicInfo.isMultiplayer	
		
	if GC_AddOnFieldCalculator.isClient then
		g_company.gui:registerUiElements("g_gcAddOnFieldCalculator_menuIcon", GC_AddOnFieldCalculator.baseDirectory .. "images/menuIcon.dds")
		g_company.gui:loadGuiTemplates(GC_AddOnFieldCalculator.baseDirectory .. "gui/guiTemplates.xml")
		g_company.gui:loadGui(Gc_Gui_AddOn_FieldCalculator, "gcAddOnFieldCalculator")		
		g_company.gui:loadGui(Gc_Gui_AddOn_FieldCalculatorSeed, "gcAddOnFieldCalculatorSeed", true, true)		

		g_company.gui:registerSiteForGcMenu("g_gcAddOnFieldCalculator_menuIcon", "icon_addOnFieldCalculator_menuIcon", g_company.gui:getGui("gcAddOnFieldCalculator"))
	end	
end