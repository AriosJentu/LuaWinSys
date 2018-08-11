-------------------------------------------------------

CurrentTheme = Themes.Light.Blue
DefaultColors = CurrentTheme

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

-------------------------------------------------------

local EditorFrame = GuiStaticImage.create(0, 0, 1, 1, pane, true)

local TitleBack = GuiStaticImage.create(Width/2-301, 0, 602, 31, pane, false, EditorFrame)
local TitleShadHorz = GuiStaticImage.create(0, 0, 602, 30, pane, false, TitleBack)
local TitleShadVert = GuiStaticImage.create(1, 0, 600, 31, pane, false, TitleBack)
local TitleBlock = GuiStaticImage.create(1, 0, 600, 30, pane, false, TitleBack)

local LeftBack = GuiStaticImage.create(0, Height/2-301, 171, 602, pane, false, EditorFrame)
local LeftShadHorz = GuiStaticImage.create(0, 1, 171, 600, pane, false, LeftBack)
local LeftShadVert = GuiStaticImage.create(0, 0, 170, 602, pane, false, LeftBack)
local LeftBlock = GuiStaticImage.create(0, 1, 170, 600, pane, false, LeftBack)

local RightBack = GuiStaticImage.create(Width-251, Height/2-301, 251, 602, pane, false, EditorFrame)
local RightShadHorz = GuiStaticImage.create(0, 1, 251, 600, pane, false, RightBack)
local RightShadVert = GuiStaticImage.create(1, 0, 250, 602, pane, false, RightBack)
local RightBlock = GuiStaticImage.create(1, 0, 250, 600, pane, false, RightBack)

-------------------------------------------------------

local WidgetList = CustomTableView.create(-1, -1, 170, 300, false, LeftBlock)
WidgetList:setColorScheme(CurrentTheme)
WidgetList:setIndentation(2)

local Column = WidgetList:addColumn("Tools and Widgets")
WidgetList:setColumnWidth(Column, 170)

local SelectTool = WidgetList:addLine()
WidgetList:setSelectedLine(SelectTool)
WidgetList:setLineHeight(SelectTool, 30)

local Cell = WidgetList:getCell(SelectTool, Column)
WidgetList:setCellText(SelectTool, Column, "Select Tool")
Cell:setAlign("center", "center")

-------------------------------------------------------

local PropertiesList = GuiStaticImage.create(0, 0, 250, 300, pane, false, RightBlock)
local PropertiesListDiv = GuiStaticImage.create(0, 299, 250, 1, pane, false, PropertiesList)

local PropertiesHeader = GuiStaticImage.create(0, 0, 250, 23, pane, false, PropertiesList)
local PropertiesHeaderDiv = GuiStaticImage.create(0, 22, 250, 1, pane, false, PropertiesList)

local PropertiesLabel = CustomLabel.create(0, 0, 1, 1, "Properties", true, PropertiesHeader)
local PropertiesScroll = CustomScrollPane.create(0, 23, 250, 276, false, PropertiesList)

PropertiesList:setColor("FFDDDDDD")
PropertiesListDiv:setColor("FFAAAAAA")
PropertiesHeader:setColor("FF"..CurrentTheme.SubMain)
PropertiesHeaderDiv:setColor("33000000")

PropertiesLabel:setAlign("center", "center")
PropertiesLabel:setColor("FFFFFF")

-------------------------------------------------------

local TitleAnimation = 2
local LeftAnimation = 2
local RightAnimation = 2

local Finished = {false, false, false}

-------------------------------------------------------

EditorFrame:setColor("0")
EditorFrame:setVisible(false)

-------------------------------------------------------

TitleShadHorz:setEnabled(false)
TitleShadVert:setEnabled(false)

LeftShadHorz:setEnabled(false)
LeftShadVert:setEnabled(false)

RightShadHorz:setEnabled(false)
RightShadVert:setEnabled(false)

-------------------------------------------------------

TitleBack:setColor("0")
TitleShadHorz:setColor("22000000")
TitleShadVert:setColor("22000000")
TitleBlock:setColor("FFEEEEEE")

LeftBack:setColor("0")
LeftShadHorz:setColor("22000000")
LeftShadVert:setColor("22000000")
LeftBlock:setColor("FFEEEEEE")

RightBack:setColor("0")
RightShadHorz:setColor("22000000")
RightShadVert:setColor("22000000")
RightBlock:setColor("FFEEEEEE")

-------------------------------------------------------

addEventHandler("onClientRender", root, function()

	if TitleAnimation == 1 then --Open

		local x, y = TitleBack:getPosition(false)

		y = y + 6

		if y > 0 then y = 0 end

		TitleBack:setPosition(x, y, false)

		if y == 0 then
			TitleAnimation = 0
			Finished[1] = true
		end

	elseif TitleAnimation == 2 then --Close

		local x, y = TitleBack:getPosition(false)

		y = y - 6

		if y < -32 then y = -32 end

		TitleBack:setPosition(x, y, false)

		if y == -32 then
			TitleAnimation = 0
			Finished[1] = true

			------------------

			if Finished[3] and Finished[2] then
				EditorFrame:setVisible(false)
			end
		end

	end


	if LeftAnimation == 1 then --Open

		local x, y = LeftBack:getPosition(false)

		x = x + 19

		if x > 0 then x = 0 end

		LeftBack:setPosition(x, y, false)

		if x == 0 then
			LeftAnimation = 0
			Finished[2] = true
		end

	elseif LeftAnimation == 2 then --Close

		local x, y = LeftBack:getPosition(false)

		x = x - 19

		if x < -172 then x = -172 end

		LeftBack:setPosition(x, y, false)

		if x == -172 then
			LeftAnimation = 0
			Finished[2] = true

			------------------	

			if Finished[1] and Finished[3] then
				EditorFrame:setVisible(false)
			end
		end

	end


	if RightAnimation == 1 then --Open

		local x, y = RightBack:getPosition(false)

		x = x - 23

		if x < Width-251 then x = Width-251 end

		RightBack:setPosition(x, y, false)

		if x == Width-251 then
			RightAnimation = 0
			Finished[3] = true
		end

	elseif RightAnimation == 2 then --Close

		local x, y = RightBack:getPosition(false)

		x = x + 23

		if x > Width then x = Width end

		RightBack:setPosition(x, y, false)

		if x == Width then
			RightAnimation = 0
			Finished[3] = true

			------------------	

			if Finished[1] and Finished[2] then
				EditorFrame:setVisible(false)
			end

		end

	end

end)

function toggleEditor()

	Finished = {false, false, false}
	
	if not EditorFrame:getVisible() then
		EditorFrame:setVisible(true)
		TitleAnimation = 1
		LeftAnimation = 1
		RightAnimation = 1
		showCursor(true)
	else
		TitleAnimation = 2
		LeftAnimation = 2
		RightAnimation = 2
		showCursor(false)
	end
end

addCommandHandler("ceditor", toggleEditor)
bindKey("F3", "up", toggleEditor)

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
local Widgets = {}
local Types = {}
local Sorted = set({"Variable Name", "Position X", "Position Y", "Width", "Height", "Visible", "Enabled", "Color Scheme"})

function addWidget(name, class, properties)

	Widgets[name] = {}
	Widgets[name].Name = class
	Widgets[name].Properties = {
		["Variable Name"]	= "",
		["Position X"] 		= {0, 0, Width},
		["Position Y"] 		= {0, 0, Height},
		["Width"] 			= {0, 0, Width},
		["Height"] 			= {0, 0, Height},
		["Visible"] 		= true,
		["Enabled"] 		= true,
		["Color Scheme"]	= {Values=themes}
	}


	for k, v in pairs(properties) do
		Widgets[name].Properties[k] = v
		Sorted:append(k)
	end

	local Tool = WidgetList:addLine()
	WidgetList:setLineHeight(Tool, 30)

	local Cell = WidgetList:getCell(Tool, Column)
	WidgetList:setCellText(Tool, Column, "Create "..name)
	Cell:setAlign("center", "center")

	for k, v in pairs(Widgets[name].Properties) do

		local ntype = ""
		local values = nil
		if type(v) == "table" and v.Values == nil then
			if tonumber(v[1]) and tonumber(v[2]) and tonumber(v[3]) then
				ntype = "spin"
				values = v
			else
				ntype = "button"
				values = v
			end
		elseif type(v) == "table" and v.Values then
			ntype = "combo"
			values = v.Values
		elseif type(v) == "string" then
			ntype = "edit"
		elseif type(v) == "boolean" then
			ntype = "check"
		end

		Types[k] = {type=ntype, vals=values}
	end
end

function removeWidgetProperty(name, property) 
	Widgets[name].Properties[property] = nil
end

function removeWidgetProperties(name) 
	Widgets[name].Properties = {}
end

function addWidgetProperties(name, properties)
	Widgets[name].Properties = properties
end


--CheckBox for [Property = Bool]
--EditBox for [Property = String]
--Combobox for [Property = {Values = {table of values}}]
--Spinner for [Property = {value, minimal, maximal}]
--Buttons = {"Button1", "Button2"}

addWidget("Window", "CustomWindow", {
	["Title"] 					= "Title",
	["Movable"] 				= true,
	["Enabled Close Button"] 	= false,
	["Side Bar Size"] 			= {0, 0, Width},
	["Side Bar Position"] 		= "top",
})

addWidget("Scroll Pane", "CustomScrollPane", {
	["Inversed Vertical Scrolling"] 	= false,
	["Inversed Horizontal Scrolling"] 	= false,
	["Horizontal Scrolling with mouse"] = false,
	["Scroll Speed"] 					= {10, 2, 20},
})

addWidget("Button", "CustomButton", {
	["Text"] 	= "Button",
	["Image"] 	= "",
})

addWidget("Progress Bar", "CustomProgressBar", {
	["Progress"] = {0, 0, 100},
})
removeWidgetProperty("Progress Bar", "Enabled")

addWidget("Scroll Bar", "CustomScrollBar", {
	["Scroller Length"] = {5, 5, 100},
	["Scroll Speed"] 	= {2, 2, 30},
	["Progress"] 		= {0, 0, 100},
})

addWidget("Edit Box", "CustomEdit", {
	["Text"] 			= "Edit Box",
	["Read Only"] 		= false,
	["Maximal Length"] 	= {144, 1, 10000},
	["Masked"] 			= false,
	["Is On Side Bar"] 	= false,
})

addWidget("Memo Box", "CustomMemo", {
	["Text"] 		= "Memo Box",
	["Read Only"] 	= false,
})

addWidget("Spinner Box", "CustomSpinner", {
	["Text"] 			= "0",
	["Read Only"] 		= false,
	["Minimal Value"] 	= {0, -10000, 10000},
	["Maximal Value"] 	= {100, -10000, 10000},
	["Step"] 			= {1, 0.01, 1000},
})

addWidget("Check Box", "CustomCheckBox", {
	["Text"] 	= "Check Box",
	["Checked"] = false,
})

addWidget("Combo Box", "CustomComboBox", {
	["Text"] 			= "Check Box",
	["Maximal Height"] 	= {30, 30, Height-50},
	["Items"] 			= {"Add Item", "Remove Item"}
})

addWidget("Tabbed Panel", "CustomTabPanel", {
	["Tabs"] 				= {"Add Tab", "Remove Tab"},
	["Minimal Tabs Length"] = {100, 50, Width},
	["Tab Text"]			= "Tab",
	["Enabled Tab"]			= true,
	["Visible Tab"] 		= true,
})

addWidget("Label", "CustomLabel", {
	["Text"] 				= "Label",
	["Color"] 				= "EEEEEE",
	["Schematical Color"]	= false,
	["Hoverable"]			= false,
	["Vertical Align"]		= {Values={["Top"]="top", ["Center"]="center", ["Bottom"]="bottom"}},
	["Horizontal Align"]	= {Values={["Left"]="left", ["Center"]="center", ["Right"]="right"}},
	["Font"]				= {Values=Fonts},
	["Font size"]			= {9, 8, 100},
})

addWidget("Dialog", "CustomDialog", {})
removeWidgetProperties("Dialog")
addWidgetProperties("Dialog", {
	["Color Scheme"] = {Values=themes}
})

addWidget("Tool Tip", "CustomToolTip", {})
removeWidgetProperties("Tool Tip")

addWidget("Loading Bar", "CustomLoading", {
	["Progress"] = {0, 0, 100},
	["Animated"] = false,
})
removeWidgetProperty("Loading Bar", "Width")
removeWidgetProperty("Loading Bar", "Height")

addWidget("Table View", "CustomTableView", {
	["Lines"] 				= {"Add Line", "Remove Line"},
	["Columns"] 			= {"Add Column", "Remove Column"},
	["Indentation"] 		= {5, 0, 20},
	["Title Bar Visible"] 	= true,
	["Line Height"]			= {22, 22, 100},
	["Column Width"]		= {50, 50, Width},
	["Column Title"]		= "Column",
	["Cell Text"]			= "",
})

local WidgetProperties = {}

local index = 0
for _, name in pairs(Sorted) do

	WidgetProperties[name] = {}
	local types = Types[name].type
	print(name)

	local width = 190
	if types == "button" or types == "spin" then
		width = 140
	elseif types == "edit" or types == "combo" then
		width = 120
	end

	local height = 30
	if types == "button" then height = 60 end

	WidgetProperties[name].Canvas = GuiStaticImage.create(0, 2 + index*30, 250, height-2, pane, false, PropertiesScroll)
	WidgetProperties[name].Divider = GuiStaticImage.create(0, height-3, 250, 1, pane, false, WidgetProperties[name].Canvas)
	WidgetProperties[name].Label = CustomLabel.create(0, 0, width-2, height-2, name, false, WidgetProperties[name].Canvas)

	if types == "check" then
		
		WidgetProperties[name].Check = CustomCheckBox.create(width, 0, 250-width, height, "", false, WidgetProperties[name].Canvas)

	elseif types == "edit" then
		
		WidgetProperties[name].Edit = CustomEdit.create(width, 0, 250-width, height-3, "", false, WidgetProperties[name].Canvas)

	elseif types == "spin" then

		WidgetProperties[name].Spin = CustomSpinner.create(width, 0, 250-width, height-3, false, WidgetProperties[name].Canvas)
		
		WidgetProperties[name].Spin:setMinimal(Types[name].vals[2])
		WidgetProperties[name].Spin:setMaximal(Types[name].vals[3])

	elseif types == "combo" then

		WidgetProperties[name].Combo = CustomComboBox.create(width+2, 1, 245-width, height-6, "Select", false, WidgetProperties[name].Canvas)

		local s = 0
		for v in pairs(Types[name].vals) do
			WidgetProperties[name].Combo:addItem(v)
			s = s+1
		end

		WidgetProperties[name].Combo:setMaxHeight(30*s)

	elseif types == "button" then

		WidgetProperties[name].Add = CustomButton.create(width+2, 2, 245-width, 24, Types[name].vals[1], false, WidgetProperties[name].Canvas)
		WidgetProperties[name].Add = CustomButton.create(width+2, 30, 245-width, 24, Types[name].vals[2], false, WidgetProperties[name].Canvas)

	end

	WidgetProperties[name].Canvas:setColor("FFEEEEEE")
	WidgetProperties[name].Divider:setColor("33000000")

	WidgetProperties[name].Label:setAlign("center", "right")

	WidgetProperties[name].Divider:setEnabled(false)
	WidgetProperties[name].Label:setEnabled(false)

	index = index + math.floor(height/30)

	print(types, "::", name)
end