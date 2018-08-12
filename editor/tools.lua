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

CurrentTool = nil
CurrentObject = nil

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
	Tool[id].Drawable = true
	Tool[id].Select = not (class and true or false)
	Tool[id].Properties = {}

	if class then
	
		Tool[id].Class = class
		Tool[id].ClassName = classname


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

	WidgetList:addEvent("onClientGUIClick", function()
		local toolname = WidgetList:getCellText(WidgetList:getSelectedLine(), 1)
		if toolname == Tool[id].Tool or toolname == "Create "..Tool[id].Tool then
			CurrentTool = Tool[id]
			Tool[id]:showProperties()
		end
	end)

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

function Tool.showProperties(self)
	
	for _, v in pairs(WidgetProperties) do
		v.Canvas:setVisible(false)
		v.Canvas:setPosition(0, 0, false)
	end

	if self.Select then

	else

		local index = 0

		for _, prop in pairs(SortedProperties) do

			if self.Properties[prop] then

				WidgetProperties[prop].Canvas:setVisible(true)

				WidgetProperties[prop].Canvas:setPosition(0, 2+index*30, false)

				index = index + 1
				if WidgetProperties[prop].Type == "button" then
					index = index + 1
				end
			end
		end

		PropertiesScroll:update()

	end
end


SelectTool = Tool.create("Select Tool")
SelectTool.Drawable = false

CurrentTool = SelectTool