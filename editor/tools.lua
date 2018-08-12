--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

themes = {

	["Default"] = DefaultColors,

	["Dark Red"] = Themes.Dark.Red,
	["Dark Green"] = Themes.Dark.Green,
	["Dark Blue"] = Themes.Dark.Blue,
	["Dark Purple"] = Themes.Dark.Purple,
	["Dark Gray"] = Themes.Dark.Gray,

	["Light Red"] = Themes.Light.Red,
	["Light Green"] = Themes.Light.Green,
	["Light Blue"] = Themes.Light.Blue,
	["Light Purple"] = Themes.Light.Purple,
	["Light Gray"] = Themes.Light.Gray,
}

WidgetProperties = {}

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--Tools

Tool = {}
Tool.__index = Tool
SortedProperties = set()
PropertiesTypes = {}

function Tool.create(tool, class, classname)

	local id = #Tool+1

	Tool[id] = setmetatable({}, Tool)

	----------------------------------------------------------------------------------------------------------------------------------
	--Basic Properties

	Tool[id].Tool = tool

	if class then
	
		Tool[id].Class = class
		Tool[id].ClassName = classname

		Tool[id].Properties = {}

		------------------------------------------------------------------------------------------------------------------------------
		--Properties List

		Tool[id]:addProperty("Variable Name", "edit", tool)

		Tool[id]:addProperty("Position X", "spin", {0, 0, Width}, "setPosition", "getPosition")
		Tool[id]:addProperty("Position Y", "spin", {0, 0, Height}, "setPosition", "getPosition")
		
		Tool[id]:addProperty("Width", "spin", {0, 0, Width}, "setSize", "getSize")
		Tool[id]:addProperty("Height", "spin", {0, 0, Height}, "setSize", "getSize")
		
		Tool[id]:addProperty("Visible", "check", true, "setVisible", "getVisible")
		Tool[id]:addProperty("Enabled", "check", true, "setEnabled", "getEnabled")

		Tool[id]:addProperty("Color Scheme", "combo", {Value=themes}, "setColorScheme", "getColorScheme")
	end

	----------------------------------------------------------------------------------------------------------------------------------
	--GUI Interface

	local ToolItem = WidgetList:addLine()
	WidgetList:setLineHeight(ToolItem, 30)

	local Cell = WidgetList:getCell(ToolItem, Column)
	WidgetList:setCellText(ToolItem, Column, (class and "Create " or "")..tool)
	Cell:setAlign("center", "center")

	----------------------------------------------------------------------------------------------------------------------------------
	--Returns
	return Tool[id]

end

function Tool.addProperty(self, name, type, value, setfunc, getfunc)

	self.Properties[name] = {}
	self.Properties[name].Type = type
	self.Properties[name].Value = value

	if setfunc and self.Class[setfunc] then self.Properties[name].Set = self.Class[setfunc] end
	if getfunc and self.Class[getfunc] then self.Properties[name].Get = self.Class[getfunc] end

	SortedProperties:append(name)
	PropertiesTypes[name] = {type=type, vals=value}

end

function Tool.removeProperty(self, name)
	self.Properties[name] = nil
end

SelectTool = Tool.create("Select Tool")