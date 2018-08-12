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

EditorFrame = GuiStaticImage.create(0, 0, 1, 1, pane, true)

TitleBack = GuiStaticImage.create(Width/2-301, 0, 602, 31, pane, false, EditorFrame)
local TitleShadHorz = GuiStaticImage.create(0, 0, 602, 30, pane, false, TitleBack)
local TitleShadVert = GuiStaticImage.create(1, 0, 600, 31, pane, false, TitleBack)
TitleBlock = GuiStaticImage.create(1, 0, 600, 30, pane, false, TitleBack)

LeftBack = GuiStaticImage.create(0, Height/2-301, 171, 602, pane, false, EditorFrame)
local LeftShadHorz = GuiStaticImage.create(0, 1, 171, 600, pane, false, LeftBack)
local LeftShadVert = GuiStaticImage.create(0, 0, 170, 602, pane, false, LeftBack)
LeftBlock = GuiStaticImage.create(0, 1, 170, 600, pane, false, LeftBack)

RightBack = GuiStaticImage.create(Width-251, Height/2-301, 251, 602, pane, false, EditorFrame)
local RightShadHorz = GuiStaticImage.create(0, 1, 251, 600, pane, false, RightBack)
local RightShadVert = GuiStaticImage.create(1, 0, 250, 602, pane, false, RightBack)
RightBlock = GuiStaticImage.create(1, 0, 250, 600, pane, false, RightBack)

-------------------------------------------------------

WidgetList = CustomTableView.create(-1, -1, 170, 300, false, LeftBlock)
WidgetList:setColorScheme(CurrentTheme)
WidgetList:setIndentation(2)

Column = WidgetList:addColumn("Tools and Widgets")
WidgetList:setColumnWidth(Column, 170)

SelectTool = WidgetList:addLine()
WidgetList:setSelectedLine(SelectTool)
WidgetList:setLineHeight(SelectTool, 30)

Cell = WidgetList:getCell(SelectTool, Column)
WidgetList:setCellText(SelectTool, Column, "Select Tool")
Cell:setAlign("center", "center")

-------------------------------------------------------

PropertiesList = GuiStaticImage.create(0, 0, 250, 300, pane, false, RightBlock)
local PropertiesListDiv = GuiStaticImage.create(0, 299, 250, 1, pane, false, PropertiesList)

PropertiesHeader = GuiStaticImage.create(0, 0, 250, 23, pane, false, PropertiesList)
local PropertiesHeaderDiv = GuiStaticImage.create(0, 22, 250, 1, pane, false, PropertiesList)

PropertiesLabel = CustomLabel.create(0, 0, 1, 1, "Properties", true, PropertiesHeader) 
PropertiesScroll = CustomScrollPane.create(0, 23, 250, 276, false, PropertiesList)

PropertiesList:setColor("FFDDDDDD")
PropertiesListDiv:setColor("FFAAAAAA")
PropertiesHeader:setColor("FF"..CurrentTheme.SubMain)
PropertiesHeaderDiv:setColor("33000000")

PropertiesLabel:setAlign("center", "center")
PropertiesLabel:setColor("FFFFFF")

-------------------------------------------------------

TitleAnimation = 2
LeftAnimation = 2
RightAnimation = 2

Finished = {false, false, false}

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