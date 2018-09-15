CONTENT = "LuaWinSys" --Resource name with files

function comparetypes(object, metatable)
	return getmetatable(object) == metatable
end

function multiplecompare(object, types)
	local bool = false
	for _, v in pairs(types) do
		bool = bool or comparetypes(object, v)
	end
	return bool
end

--------------------------------------------------------------------------------------------------------------------
---Comparators

function compareAppend(object, ...)

	local args = {...}
	local par = args[#args]
	if multiplecompare(par, {CustomWindow, CustomScrollPane, CustomLabel}) then
		par:addElement(object)
	end
end

function compareDefaults(parent)
	return multiplecompare(parent, {
		CustomWindow, 
		CustomScrollPane, 
		CustomButton, 
		CustomLabel, 
		CustomProgressBar, 
		CustomComboBox, 
		CustomCheckBox, 
		CustomTabPanel
	})
end

function getCWType(object)
	if multiplecompare(object, {
		CustomWindow, 
		CustomScrollPane, 
		CustomButton, 
		CustomEdit, 
		CustomMemo, 
		CustomSpinner, 
		CustomLabel, 
		CustomProgressBar, 
		CustomScrollBar, 
		CustomComboBox, 
		CustomDialog, 
		CustomLoading, 
		CustomTooltip, 
		CustomCheckBox, 
		CustomTableView, 
		CustomTabPanel
	}) then
		return getmetatable(object)
	else
		return nil
	end
end

function isCWElement(object)
	return multiplecompare(object, {
		CustomWindow, 
		CustomScrollPane, 
		CustomButton, 
		CustomEdit, 
		CustomMemo, 
		CustomSpinner, 
		CustomLabel, 
		CustomProgressBar, 
		CustomScrollBar, 
		CustomComboBox, 
		CustomDialog, 
		CustomLoading, 
		CustomTooltip, 
		CustomCheckBox, 
		CustomTableView, 
		CustomTabPanel
	}) 
end

--------------------------------------------------------------------------------------------------------------------

function string:split(sep)

	local tab = {}
	local a = self:find(sep)

	while a ~= nil do

		tab[#tab+1] = self:sub(1, a-1)
		
		self = self:sub(a+sep:len(), self:len())
		a = self:find(sep)
	end

	tab[#tab+1] = self
	
	return tab
end

function fromHEXToRGB(color)
	--this function replace color from HEX, and return R, G and B parameters (from 0 to 255)
	--Example: fromHEXToRGB("6600FF"); returns 102, 0, 255
    if tostring(color):len() == 8 then return tonumber(color:sub(3, 4), 16), tonumber(color:sub(5, 6), 16), tonumber(color:sub(7, 8), 16), tonumber(color:sub(1, 2), 16)
    elseif tostring(color):len() == 6 then return tonumber(color:sub(1, 2), 16), tonumber(color:sub(3, 4), 16), tonumber(color:sub(5, 6), 16)
    end
end

function proceedColor(main, red, green, dark)

	if not dark then dark = false end

	local MainColor = main --"5278e2"--"AA3C39"
	local RedColor = red --"4667d0" --"B13232"
	local GreenColor = green --"46c169" --"2D8633"

	local r, g, b = fromHEXToRGB(MainColor)
	r = r-16
	g = g-16
	b = b-16

	ar = r-64
	ag = g-64
	ab = b-64

	lr = r+64
	lg = g+64
	lb = b+64

	fr = lr+16
	fg = lg+16
	fb = lb+16

	if r < 0 then r = 0 end
	if g < 0 then g = 0 end
	if b < 0 then b = 0 end

	if r > 255 then r = 255 end
	if g > 255 then g = 255 end
	if b > 255 then b = 255 end

	if ar < 0 then ar = 0 end
	if ag < 0 then ag = 0 end
	if ab < 0 then ab = 0 end

	if ar > 255 then ar = 255 end
	if ag > 255 then ag = 255 end
	if ab > 255 then ab = 255 end

	if lb < 0 then lb = 0 end
	if lg < 0 then lg = 0 end
	if lb < 0 then lb = 0 end

	if lr > 255 then lr = 255 end
	if lg > 255 then lg = 255 end
	if lb > 255 then lb = 255 end

	if fb < 0 then fb = 0 end
	if fg < 0 then fg = 0 end
	if fb < 0 then fb = 0 end

	if fb > 255 then fb = 255 end
	if fg > 255 then fg = 255 end
	if fb > 255 then fb = 255 end

	local SubMainColor = string.format("%.2x%.2x%.2x", r, g, b)
	local DarkMainColor = string.format("%.2x%.2x%.2x", ar, ag, ab)
	local LightMainColor = string.format("%.2x%.2x%.2x", lr, lg, lb)
	local SuperLightMainColor = string.format("%.2x%.2x%.2x", fr, fg, fb)

	r, g, b = fromHEXToRGB(RedColor)
	r = r+32
	g = g+32
	b = b+32

	if r > 255 then r = 255 end
	if g > 255 then g = 255 end
	if b > 255 then b = 255 end

	local RedLightColor = string.format("%.2x%.2x%.2x", r, g, b)

	r, g, b = fromHEXToRGB(GreenColor)
	r = r+32
	g = g+32
	b = b+32

	if r > 255 then r = 255 end
	if g > 255 then g = 255 end
	if b > 255 then b = 255 end

	local GreenLightColor = string.format("%.2x%.2x%.2x", r, g, b)

	return {

		Main = MainColor,
		Red = RedColor,
		Green = GreenColor,
		SubMain = SubMainColor,
		DarkMain = DarkMainColor,
		LightMain = LightMainColor,
		SuperLightMain = SuperLightMainColor,
		RedLight = RedLightColor,
		GreenLight = GreenLightColor,
		DarkTheme = dark
	}

end

RedColorsDark = proceedColor("f94f4f", "ef2d2d", "46c169", true) --Red Theme
RedColors = proceedColor("f94f4f", "ef2d2d", "46c169", false) --Red Theme

GreenColors = proceedColor("4aba48", "347a34", "6bd06a", false) --Green Theme
GreenColorsDark = proceedColor("4aba48", "347a34", "42aa41", true) --Green Theme

BlueColors = proceedColor("5278e2", "4667d0", "46c169", false) --Blue Theme
BlueColorsDark = proceedColor("5278e2", "4667d0", "46c169", true) --Blue Theme

PurpleColors = proceedColor("743597", "582A72", "9741C6", false) --Purple Theme
PurpleColorsDark = proceedColor("A53FC5", "200F26", "7E3396", true) --Purple Theme

GrayColors = proceedColor("999999", "777777", "BBBBBB", false) --Gray Theme
GrayColorsDark = proceedColor("222222", "555555", "999999", true) --Gray Theme

DefaultColors = RedColors

Themes = {
	
	Dark = {
		Red = RedColorsDark,
		Green = GreenColorsDark,
		Blue = BlueColorsDark,
		Purple = PurpleColorsDark,
		Gray = GrayColorsDark,
	},

	Light = {
		Red = RedColors,
		Green = GreenColors,
		Blue = BlueColors,
		Purple = PurpleColors,
		Gray = GrayColors,
	}
}

--------------------------

pane = ":"..CONTENT.."/images/pane.png"
Width, Height = guiGetScreenSize() 

Images = {
	Cross = ":"..CONTENT.."/images/cross.png",
	Point = ":"..CONTENT.."/images/point.png",
	Check = ":"..CONTENT.."/images/check.png",
	Down = ":"..CONTENT.."/images/down.png",
	Next = ":"..CONTENT.."/images/next.png",
	Prev = ":"..CONTENT.."/images/prev.png",
	Round = ":"..CONTENT.."/images/round.png",
	Loading = ":"..CONTENT.."/images/loading.png",
}

addEventHandler("onClientResourceStart", root, function()
	guiSetInputMode("no_binds_when_editing")
end)

--Fonts
Fonts = {

	OpenSansBold = ":"..CONTENT.."/fonts/OSB.ttf",
	OpenSansBoldItalic = ":"..CONTENT.."/fonts/OSBI.ttf",

	OpenSansSemiBold = ":"..CONTENT.."/fonts/OSSB.ttf",
	OpenSansSemiBoldItalic = ":"..CONTENT.."/fonts/OSSBI.ttf",

	OpenSansExtraBold = ":"..CONTENT.."/fonts/OSEB.ttf",
	OpenSansExtraBoldItalic = ":"..CONTENT.."/fonts/OSEBI.ttf",

	OpenSansItalic = ":"..CONTENT.."/fonts/OSI.ttf",

	OpenSansLight = ":"..CONTENT.."/fonts/OSL.ttf",
	OpenSansLightItalic = ":"..CONTENT.."/fonts/OSLI.ttf",
	OpenSansRegular = ":"..CONTENT.."/fonts/OSR.ttf",

	SeguiReg = ":"..CONTENT.."/fonts/SUIR.ttf",
	SeguiLig = ":"..CONTENT.."/fonts/SUIL.ttf",

	HelvetRegular = ":"..CONTENT.."/fonts/HR.ttf",
	HelvetThin = ":"..CONTENT.."/fonts/HT.ttf",

	RobotoThin = ":"..CONTENT.."/fonts/thin.ttf",
	Mono = ":"..CONTENT.."/fonts/mono.ttf"
}

function guiGetOnScreenPosition(element)
	local x, y = guiGetPosition(element, false)
	local child = element
	for i = 0, 100 do
		if getElementParent(child).type ~= "guiroot" then
			local x1, y1 = guiGetPosition(getElementParent(child), false)
			--outputDebugString(tostring(x1).." "..tostring(x))
			x, y = x+x1, y+y1 
			child = getElementParent(child)
		else break end
	end
	return x, y
end

function fromPropertyToHEX(element)
    if getElementType(element) ~= "gui-staticimage" then return false end
    local str = guiGetProperty(element, "ImageColours"):sub(4, 11)
    local str2 = str:sub(3, 8)
    return str, str2
end

function fromRGBToHEX(r, g, b, a, inversed)
	if a then
		
		if inversed then
			r, g, b, a = a, r, g, b
		end

		return string.format("%.2x%.2x%.2x%.2x", r, g, b, a)
	else
		return string.format("%.2x%.2x%.2x", r, g, b)
	end
end

--Element for onClientGUIMouseUp
BackForMouse = GuiStaticImage.create(0, 0, 1, 1, pane, true)
BackForMouse:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")
BackForMouse:setVisible(false)

addEventHandler("onClientGUIMouseEnter", root, function()
	if BackForMouse:getVisible() then
		BackForMouse:moveToBack()
	end	
end)

addEventHandler("onClientGUIMouseLeave", root, function()
	if BackForMouse:getVisible() then
		BackForMouse:moveToBack()
	end
end)

addEventHandler("onClientGUIClick", root, function()
	if BackForMouse:getVisible() then
		BackForMouse:moveToBack()
	end
end)

local createImage = GuiStaticImage.create
GuiStaticImage.create = function(x, y, w, h, image, rel, par)
	
	local oldpar = par
	if compareDefaults(par) then
		par = par:getFrame()
	end

	local obj = createImage(x, y, w, h, image, rel, par)

	if multiplecompare(oldpar, {CustomWindow, CustomScrollPane, CustomLabel}) then
		oldpar:addElement(obj)
	end

	return obj

end

function GuiStaticImage.setColor(self, color)
	self:setProperty("ImageColours", string.format("tl:%s tr:%s bl:%s br:%s", color, color, color, color))
end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Windows----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Windows = {}
function guiCreateCustomWindow(x, y, w, h, title, relative, parent)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #Windows+1

	local nw, nh = Width, Height
	if relative then

		if parent then
			nw, nh = parent:getSize(false)
		end

		x = math.floor(x*nw)
		y = math.floor(y*nh)
		w = math.floor(w*nw)
		h = math.floor(h*nh)

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then

		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main part of window
	Windows[id] = {}
	Windows[id].SchemeElements = {}
	Windows[id].Canvas = GuiStaticImage.create(x-2, y-2, w+4, h+4, pane, false, parent)
	Windows[id].ColorScheme = DefaultColors

	if oldparent and oldparent.ColorScheme ~= nil then
		Windows[id].ColorScheme = oldparent.ColorScheme
	end

	Windows[id].MaxX = nw
	Windows[id].MaxY = nh
	Windows[id].SideBlockLocation = "none"
	Windows[id].SideBlockLength = 0

	--Shadows
	Windows[id].Shadows = {}
	Windows[id].Shadows.Central = GuiStaticImage.create(1, 1, w+2, h+2, pane, false, Windows[id].Canvas)
	Windows[id].Shadows.Vertical = GuiStaticImage.create(2, 0, w, h+4, pane, false, Windows[id].Canvas)
	Windows[id].Shadows.Horizontal = GuiStaticImage.create(0, 2, w+4, h, pane, false, Windows[id].Canvas)

	--Size editors
	Windows[id].SizeEdits = {}
	Windows[id].SizeEdits.LeftTop = GuiStaticImage.create(0, 0, 5, 5, pane, false, Windows[id].Canvas)
	Windows[id].SizeEdits.RightTop = GuiStaticImage.create(w-1, 0, 5, 5, pane, false, Windows[id].Canvas)
	Windows[id].SizeEdits.LeftBottom = GuiStaticImage.create(0, h-1, 5, 5, pane, false, Windows[id].Canvas)
	Windows[id].SizeEdits.RightBottom = GuiStaticImage.create(w-1, h-1, 5, 5, pane, false, Windows[id].Canvas)

	Windows[id].SizeEdits.Left = GuiStaticImage.create(0, 5, 5, h-6, pane, false, Windows[id].Canvas)
	Windows[id].SizeEdits.Right = GuiStaticImage.create(w-1, 5, 5, h-6, pane, false, Windows[id].Canvas)
	Windows[id].SizeEdits.Top = GuiStaticImage.create(5, 0, w-6, 5, pane, false, Windows[id].Canvas)
	Windows[id].SizeEdits.Bottom = GuiStaticImage.create(5, h-1, w-6, 5, pane, false, Windows[id].Canvas)

	Windows[id].ResizeCells = {
		Windows[id].SizeEdits.LeftTop,
		Windows[id].SizeEdits.Top, 
		Windows[id].SizeEdits.RightTop,

		Windows[id].SizeEdits.Left,
		Windows[id].SizeEdits.Right,

		Windows[id].SizeEdits.LeftBottom,
		Windows[id].SizeEdits.Bottom, 
		Windows[id].SizeEdits.RightBottom
	}

	--Frame
	Windows[id].Frame = GuiStaticImage.create(2, 2, w, h, pane, false, Windows[id].Canvas)

	--Dialog shadow
	Windows[id].Dialog = GuiStaticImage.create(0, 0, 1, 1, pane, true, Windows[id].Frame)
	
	--Title
	Windows[id].Top = GuiStaticImage.create(0, 0, w, 22, pane, false, Windows[id].Frame)
	--Windows[id].Divider = GuiStaticImage.create(0, 21, w, 1, pane, false, Windows[id].Top)
	Windows[id].CloseMain = GuiStaticImage.create(0, 0, 21, 21, Images.Cross, false, Windows[id].Frame)
	Windows[id].Cross = GuiStaticImage.create(0, 0, 21, 21, Images.Point, false, Windows[id].CloseMain)
	Windows[id].Title = GuiLabel.create(0, 0, w, 19, title or "Window", false, Windows[id].Frame)

	Windows[id].Close = GuiStaticImage.create(0, 0, 21, 21, pane, false, Windows[id].Top)
	
	Windows[id].SideBlock = GuiStaticImage.create(0, 0, 0, 0, pane, false, Windows[id].Frame)
	
	Windows[id].AlterTitle = GuiLabel.create(0, 0, w, 19, title or "Window", false, Windows[id].SideBlock)
	Windows[id].CloseAlter = GuiStaticImage.create(0, 0, 21, 21, Images.Cross, false, Windows[id].SideBlock)
	Windows[id].CrossAlter = GuiStaticImage.create(0, 0, 21, 21, Images.Point, false, Windows[id].CloseAlter)


	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties
	Windows[id].Canvas:setColor("0")
	
	for _, Shadow in pairs(Windows[id].Shadows) do
		Shadow:setColor("22000000")
		Shadow:setEnabled(false)
	end

	FrameColor = "EEEEEE"
	if Windows[id].ColorScheme.DarkTheme then FrameColor = "444444" end

	TextColor = "444444"
	if Windows[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	frmcol = "FF"..FrameColor
	txtcol = "FF"..TextColor
	whitecol = "FFFFFFFF"

	for _, v in pairs(Windows[id].SizeEdits) do
		v:setProperty("AlwaysOnTop", "True")
		v:setColor("0")
		v:setEnabled(false)
	end

	Windows[id].Frame:setColor(frmcol)
	Windows[id].Top:setColor("0")
	Windows[id].Top:setProperty("AlwaysOnTop", "True")

	Windows[id].Close:setColor("0")
	Windows[id].CloseMain:setColor("0")
	Windows[id].CloseAlter:setColor("0")
	Windows[id].Dialog:setColor("0")
	Windows[id].Cross:setColor(txtcol)
	Windows[id].CrossAlter:setColor(whitecol)
	Windows[id].SideBlock:setColor("FF"..Windows[id].ColorScheme.SubMain)
	
	Windows[id].Title:setEnabled(false)
	Windows[id].AlterTitle:setEnabled(false)

	Windows[id].Title:setFont(GuiFont.create(Fonts.OpenSansRegular, 9))
	Windows[id].Title:setColor(fromHEXToRGB(TextColor))
	Windows[id].Title:setHorizontalAlign("center")
	Windows[id].Title:setVerticalAlign("center")

	Windows[id].AlterTitle:setFont(GuiFont.create(Fonts.OpenSansRegular, 9))
	Windows[id].AlterTitle:setColor(fromHEXToRGB("FFFFFF"))
	Windows[id].AlterTitle:setHorizontalAlign("center")
	Windows[id].AlterTitle:setVerticalAlign("center")

	Windows[id].Close:setVisible(false)
	Windows[id].Cross:setEnabled(false)
	Windows[id].Dialog:setVisible(false)
	Windows[id].SideBlock:setEnabled(false)
	Windows[id].CloseMain:setVisible(false)
	Windows[id].CloseAlter:setVisible(false)

	Windows[id].Frame:bringToFront()
	Windows[id].Enabled = true

	------------------------------------------------------------------------------------------------------------------------------------------
	--Params
	Windows[id].Movable = true
	Windows[id].Sizable = false
	Windows[id].MoveCursorPositions = {X = 0, Y = 0}
	Windows[id].SizeCursorPositions = {X = 0, Y = 0}
	Windows[id].ResizingCalc = {X = 0, Y = 0, W = 0, H = 0}
	Windows[id].Animation = "none" --"open", "close", "move", "size"
	Windows[id].ResizeType = 0 --1 to 8, like grid, but without middle cell

	Windows[id].Positions = {X = x, Y = y}

	Windows[id].MinimalSizes = {W = 10, H = 10}
	Windows[id].MaximalSizes = {W = Width, H = Height}

	------------------------------------------------------------------------------------------------------------------------------------------
	--Functions

	Windows[id].DialogAnimation = 0 -- 1 - hide; 2 - show
	Windows[id].DialogList = {}

	Windows[id].ShowDialog = function(bool)

		Windows[id].DialogAnimation = bool and 2 or 1
		Windows[id].Dialog:setProperty("AlwaysOnTop", "True")
		Windows[id].Top:setProperty("AlwaysOnTop", "False")
		Windows[id].Dialog:setVisible(true)
		Windows[id].Frame:bringToFront()
		Windows[id].Dialog:bringToFront()

		if bool == false then
			for _, v in pairs(Windows[id].DialogList) do
				v.Dialog:close()
			end
		end

	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	Windows[id].Event = {}

	--Animation Rendering
	Windows[id].Event.Render = {}
	Windows[id].Event.Render.Name = "onClientRender"
	Windows[id].Event.Render.Function = function()
		if Windows[id].Animation == "open" then
			
			Windows[id].Canvas:setEnabled(false)

			local _, y = Windows[id].Canvas:getPosition(false)
			local self_y = Windows[id].Positions.Y

			if y >= self_y+140 then y = y-35
			elseif y >= self_y+80 then y = y-20
			elseif y >= self_y+50 then y = y-12
			elseif y >= self_y+20 then y = y-8
			elseif y >= self_y+8 then y = y-4
			elseif y >= self_y+2 then y= y-2
			elseif y >= self_y-2 then y= y-1
			end

			if y <= self_y-2 then y = self_y-2 end

			Windows[id].Canvas:setPosition(Windows[id].Positions.X-2, y, false)
			if y == self_y-2 then			
				Windows[id].Animation = "none"
				Windows[id].Canvas:setEnabled(Windows[id].Enabled)
			end

		elseif Windows[id].Animation == "close" then
			
			Windows[id].Canvas:setEnabled(false)

			local _, y = Windows[id].Canvas:getPosition(false)
			local self_y = Windows[id].Positions.Y

			if y >= self_y+150 then y = y+35
			elseif y >= self_y+80 then y = y+20
			elseif y >= self_y+50 then y = y+12
			elseif y >= self_y+20 then y = y+8
			elseif y >= self_y+8 then y = y+4
			elseif y >= self_y+2 then y= y+2
			elseif y >= self_y-2 then y= y+1
			end

			if y >= Windows[id].MaxY then y = Windows[id].MaxY end

			Windows[id].Canvas:setPosition(Windows[id].Positions.X-2, y, false)
			if y == Windows[id].MaxY then
				Windows[id].Canvas:setVisible(false)
				Windows[id].Canvas:setEnabled(Windows[id].Enabled)
				Windows[id].Animation = "none"
			end

		end

		if Windows[id].DialogAnimation == 2 then

			local alpha = fromPropertyToHEX(Windows[id].Dialog)
			alpha = tonumber(alpha:sub(1, 2), 16)

			if alpha == 120 then

				Windows[id].DialogAnimation = 0
			
			else

				alpha = alpha + 4

				if alpha >= 120 then alpha = 120 end
				local color = string.format("%.2x000000", alpha)
				Windows[id].Dialog:setColor(color)

			end

		elseif Windows[id].DialogAnimation == 1 then
			
			local alpha = fromPropertyToHEX(Windows[id].Dialog)
			alpha = tonumber(alpha:sub(1, 2), 16)

			if alpha == 0 then

				Windows[id].DialogAnimation = 0
				Windows[id].Dialog:setVisible(false)
				Windows[id].Dialog:setProperty("AlwaysOnTop", "False")
				Windows[id].Top:setProperty("AlwaysOnTop", "True")
				Windows[id].Frame:bringToFront()
				triggerEvent("onClientGUIMouseUp", Windows[id].Dialog)

			else

				alpha = alpha - 4

				if alpha <= 0 then alpha = 0 end
				local color = string.format("%.2x000000", alpha)
				Windows[id].Dialog:setColor(color)

			end

		end
	end

	--Close button click
	Windows[id].Event.Click = {}
	Windows[id].Event.Click.Name = "onClientGUIClick"
	Windows[id].Event.Click.Function = function()
		if source == Windows[id].Close then
			Windows[id].Animation = "close"
			triggerEvent("onCustomWindowClose", Windows[id].Canvas, Windows[id].Canvas)
		end

		if source == Windows[id].Dialog then
			Windows[id].ShowDialog(false)
		end
	end

	--Close button and sides resizers hover
	Windows[id].Event.Enter = {}
	Windows[id].Event.Enter.Name = "onClientMouseEnter"
	Windows[id].Event.Enter.Function = function()
		if source == Windows[id].Close then

			Windows[id].CloseMain:setColor("FF"..Windows[id].ColorScheme.Red)
			Windows[id].CloseAlter:setColor("FFFFFFFF")
		end

		for i, rsblock in pairs(Windows[id].ResizeCells) do
			if source == rsblock then
				rsblock:setColor("22000000")
			end
		end

	end


	--Close button and sides resizers leave
	Windows[id].Event.Leave = {}
	Windows[id].Event.Leave.Name = "onClientMouseLeave"
	Windows[id].Event.Leave.Function = function()

		Windows[id].CloseMain:setColor("0")
		Windows[id].CloseAlter:setColor("0")

		for i, rsblock in pairs(Windows[id].ResizeCells) do
			rsblock:setColor("0")
		end
	end

	local BFMState = BackForMouse:getVisible()

	--Window move and resize - hold
	Windows[id].Event.MouseDown = {}
	Windows[id].Event.MouseDown.Name = "onClientGUIMouseDown"
	Windows[id].Event.MouseDown.Function = function(button, x, y)

		BFMState = BackForMouse:getVisible()

		if Windows[id].Movable and button == "left" and (source == Windows[id].Top or source == Windows[id].Dialog) then
			
			Windows[id].Animation = "move"
			
			local ax, ay = Windows[id].Canvas:getPosition(false)
			Windows[id].MoveCursorPositions = {X = x-ax, Y = y-ay}

		end

		if Windows[id].Sizable and button == "left" then

			for i, rsblock in pairs(Windows[id].ResizeCells) do
				if source == rsblock then

					Windows[id].Animation = "size"
					Windows[id].ResizeType = i

					local w, h = Windows[id]:getSize(false)
					local sx, sy = Windows[id]:getPosition(false)
					Windows[id].ResizingCalc = {X = sx, Y = sy, W = w, H = h}
					
					Windows[id].SizeCursorPositions = {X = x, Y = y}
					
					BackForMouse:setVisible(true)	

					break
				end
			end
		end
	end


	--Windows move and resize - relax
	Windows[id].Event.MouseUp = {}
	Windows[id].Event.MouseUp.Name = "onClientGUIMouseUp"
	Windows[id].Event.MouseUp.Function = function()
		
		if source == Windows[id].Top or source == Windows[id].Dialog or Windows[id].Animation == "size" then
			Windows[id].Animation = "none"
			Windows[id].MoveCursorPositions = {X = 0, Y = 0}
			Windows[id].SizeCursorPositions = {X = 0, Y = 0}
			Windows[id].ResizingCalc = {X = 0, Y = 0, W = 0, H = 0}

			local x, y = Windows[id].Canvas:getPosition(false)
			Windows[id].Positions = {X = x+2, Y = y+2}
			Windows[id].ResizeType = 0

		end

		BackForMouse:setVisible(BFMState)	
	end
	

	--Window move - moving, resize - resizing
	Windows[id].Event.CursorMove = {}
	Windows[id].Event.CursorMove.Name = "onClientCursorMove"
	Windows[id].Event.CursorMove.Function = function(_, _, cx, cy)

		if Windows[id].Animation == "move" then
			local ax, ay = Windows[id].MoveCursorPositions.X, Windows[id].MoveCursorPositions.Y
			Windows[id].Canvas:setPosition(cx-ax, cy-ay, false)

			triggerEvent("onClientGUIMove", Windows[id].Canvas)

			return
		end

		if Windows[id].Animation == "size" then

			local x, y = Windows[id].ResizingCalc.X, Windows[id].ResizingCalc.Y
			local w, h = Windows[id].ResizingCalc.W, Windows[id].ResizingCalc.H
			local ax, ay = Windows[id].SizeCursorPositions.X, Windows[id].SizeCursorPositions.Y

			local nx, ny, nw, nh = x, y, w, h

			local t = Windows[id].ResizeType
			local coordxedit = 0
			local coordyedit = 0

			if t == 8 or t == 5 or t == 3 then
				nw = w+(cx-ax)
			end

			if t == 8 or t == 7 or t == 6 then
				nh = h+(cy-ay)
			end

			if t == 1 or t == 2 or t == 3 then
				ny = y+(cy-ay)
				nh = h-(cy-ay)
				coordyedit = 1
			end

			if t == 1 or t == 4 or t == 6 then
				nx = x+(cx-ax)
				nw = w-(cx-ax)
				coordxedit = 1
			end

			if nw < Windows[id].MinimalSizes.W then nx = x + (w-Windows[id].MinimalSizes.W)*coordxedit end
			if nw > Windows[id].MaximalSizes.W then nx = x + (w-Windows[id].MinimalSizes.W)*coordxedit end

			if nh < Windows[id].MinimalSizes.H then ny = y + (h-Windows[id].MinimalSizes.H)*coordyedit end
			if nh > Windows[id].MaximalSizes.H then ny = y + (h-Windows[id].MinimalSizes.H)*coordyedit end

			Windows[id]:setPosition(nx, ny, false)
			Windows[id]:setSize(nw, nh, false)

			BackForMouse:setVisible(true)

			triggerEvent("onClientGUISize", Windows[id].Canvas)
		end
	end

	addEventHandler(Windows[id].Event.Render.Name, root, Windows[id].Event.Render.Function)
	addEventHandler(Windows[id].Event.Click.Name, root, Windows[id].Event.Click.Function)
	addEventHandler(Windows[id].Event.Enter.Name, root, Windows[id].Event.Enter.Function)
	addEventHandler(Windows[id].Event.Leave.Name, root, Windows[id].Event.Leave.Function)
	addEventHandler(Windows[id].Event.MouseDown.Name, root, Windows[id].Event.MouseDown.Function)
	addEventHandler(Windows[id].Event.MouseUp.Name, root, Windows[id].Event.MouseUp.Function)
	addEventHandler(Windows[id].Event.CursorMove.Name, root, Windows[id].Event.CursorMove.Function)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending

	return Windows[id]
end


----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions

function cwSetCloseEnabled(window, boolean)

	window.CloseMain:setVisible(boolean or false)
	window.CloseAlter:setVisible(boolean or false)

	return window.Close:setVisible(boolean or false)
end

function cwSetEnabled(window, boolean)
	if boolean then
		window.Frame:bringToFront()
	else
		window.Frame:moveToBack()
	end
	window.Enabled = boolean or false
	return window.Canvas:setEnabled(boolean or false)
end

function cwSetVisible(window, boolean)
	return window.Canvas:setVisible(boolean or false)
end

function cwSetSize(window, w, h, relative)
	
	if relative then

		w = math.floor(w*Width)
		h = math.floor(h*Height)

	end

	if w < window.MinimalSizes.W then w = window.MinimalSizes.W end
	if w > window.MaximalSizes.W then w = window.MaximalSizes.W end

	if h < window.MinimalSizes.H then h = window.MinimalSizes.H end
	if h > window.MaximalSizes.H then h = window.MaximalSizes.H end 


	window.Canvas:setSize(w+4, h+4, false)

	window.Shadows.Central:setSize(w+2, h+2, false)
	window.Shadows.Vertical:setSize(w, h+4, false)
	window.Shadows.Horizontal:setSize(w+4, h, false)

	window.Frame:setSize(w, h, false)
	window.Top:setSize(w, 22, false)
	--window.Divider:setSize(w, 1, false)
	window.Title:setSize(w, 19, false)
	window.AlterTitle:setSize(w, 19, false)

	window.Close:setPosition(w-21, 0, false)



	local location = window.SideBlockLocation 
	local length = window.SideBlockLength 

	local sw, sh = w, h
	x, y = 0, 0


	if location == "top" or location == "bottom" then
		y = (location == "bottom") and sh-length or 0
		sh = length
	end

	if location == "left" or location == "right" then
		x = (location == "right") and sw-length or 0
		sw = length
	end

	if location == "none" then
		sw, sh = 0, 0
	end

	window.SideBlock:setPosition(x, y, false)
	window.SideBlock:setSize(sw, sh, false)
	window.AlterTitle:setPosition(-x, -y, false)
	window.CloseAlter:setPosition(-x, -y, false)
	
	window.SizeEdits.RightTop:setPosition(w-1, 0, false)
	window.SizeEdits.LeftBottom:setPosition(0, h-1, false)
	window.SizeEdits.RightBottom:setPosition(w-1, h-1, false)
	window.SizeEdits.Right:setPosition(w-1, 5, false)
	window.SizeEdits.Bottom:setPosition(5, h-1, false)

	window.SizeEdits.Left:setSize(5, h-6, false)
	window.SizeEdits.Right:setSize(5, h-6, false)
	window.SizeEdits.Top:setSize(w-6, 5, false)
	window.SizeEdits.Bottom:setSize(w-6, 5, false)

end

function cwSetPosition(window, x, y, rel, replace)
	if replace ~= true and replace ~= false then
		replace = true
	end

	if rel then

		x = math.floor(x*Width)
		y = math.floor(y*Height)

	end

	if replace then
		window.Positions.X = x
		window.Positions.Y = y
	end
	return window.Canvas:setPosition(x-2, y-2, false)

end

function cwSetTitle(window, text)
	window.Title:setText(text)
	window.AlterTitle:setText(text)
end

function cwSetMovable(window, bool)
	window.Movable = bool or false
end

function cwSetSizable(window, bool)
	window.Sizable = bool or false

	for _, v in pairs(window.SizeEdits) do
		v:setEnabled(window.Sizable)
	end
end

function cwSetMinimalWidth(window, w)
	window.MinimalSizes.W = w
	local w, h = window:getSize(false)
	window:setSize(w, h, false)
end

function cwSetMinimalHeight(window, h)
	window.MinimalSizes.H = h
	local w, h = window:getSize(false)
	window:setSize(w, h, false)
end

function cwSetMinimalSize(window, w, h)
	cwSetMinimalWidth(window, w)
	cwSetMinimalHeight(window, h)
end

function cwSetMaximalWidth(window, w)
	window.MaximalSizes.W = w
	local w, h = window:getSize(false)
	window:setSize(w, h, false)
end

function cwSetMaximalHeight(window, h)
	window.MaximalSizes.H = h
	local w, h = window:getSize(false)
	window:setSize(w, h, false)
end

function cwSetMaximalSize(window, w, h)
	cwSetMaximalWidth(window, w)
	cwSetMaximalHeight(window, h)
end

function cwShowBar(window, location, length)

	if location ~= "none" and location ~= "top" and location ~= "bottom" and location ~= "left" and location ~= "right" then
		location = "none"
	end

	window.SideBlockLocation = location
	window.SideBlockLength = length

	w, h = cwGetSize(window, false)
	x, y = 0, 0

	if location == "top" or location == "bottom" then

		if location == "bottom" then
			y = h-length
		end

		h = length
	end

	if location == "left" or location == "right" then

		if location == "right" then
			x = w-length
		end

		w = length
	end

	if location == "none" then
		w, h = 0, 0
	end

	window.SideBlock:setPosition(x, y, false)
	window.SideBlock:setSize(w, h, false)
	window.AlterTitle:setPosition(-x, -y, false)
	window.CloseAlter:setPosition(-x, -y, false)

end

function cwSetSideBarLength(window, length)
	cwShowBar(window, window.SideBlockLocation, length)
end

function cwSetSideBarLocation(window, location)
	cwShowBar(window, location, window.SideBlockLength)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function cwBringToFront(window)
	window.Canvas:bringToFront()
end

function cwMoveToBack(window)
	window.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function cwGetSize(window, rel)

	if rel then

		local w, h = window.Frame:getSize(false)
		return w/Width, h/Height

	else
		return window.Frame:getSize(false)
	end
end

function cwGetRealSize(window, rel)
	return window.Canvas:getSize(rel or false)
end

function cwGetPosition(window, rel)
	x, y = window.Canvas:getPosition(false)
	x, y = x+2, y+2

	if rel then
		x = x/Width
		y = y/Height
	end

	return x, y
end

function cwGetTitle(window)
	return window.Title:getText()
end

function cwGetVisible(window)
	return window.Canvas:getVisible()
end

function cwGetEnabled(window)
	return window.Canvas:getEnabled()
end

function cwGetCloseEnabled(window)
	return window.Close:getVisible()
end

function cwGetMovable(window)
	return window.Movable
end

function cwGetSizable(window)
	return window.Sizable
end

function cwGetMinimalWidth(window) return window.MinimalSizes.W end
function cwGetMinimalHeight(window)	return window.MinimalSizes.H end
function cwGetMinimalSize(window) return cwGetMinimalWidth(window), cwGetMinimalHeight(window) end

function cwGetMaximalWidth(window) return window.MaximalSizes.W end
function cwGetMaximalHeight(window)	return window.MaximalSizes.H end
function cwSetMaximalSize(window) return cwGetMaximalWidth(window), cwGetMaximalHeight(window) end

---

function cwGetFrame(window)
	return window.Frame
end

function cwGetHeader(window)
	return window.Top
end

function cwGetDialog(window)
	return window.Dialog
end


----------------------------------------------------------------------------------------------------------------------------------------------
--Animated functions
function cwOpen(window)

	local x = window.Positions.X
	cwSetPosition(window, x, Height, false, false)
	
	cwSetVisible(window, true)
	window.Animation = "open"
	window.Canvas:bringToFront()
	--window.Frame:bringToFront()
end

function cwClose(window)
	if cwGetVisible(window) then
		window.Animation = "close"
	end
end

function cwShowDialog(window, bool)
	window.ShowDialog(bool)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme Functions

function cwSetColorScheme(window, scheme)

	window.ColorScheme = scheme

	FrameColor = "EEEEEE"
	if window.ColorScheme.DarkTheme then FrameColor = "444444" end

	TextColor = "444444"
	if window.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	ncolor = "FFFFFFFF"
	frmcol = "FF"..FrameColor
	txtcol = "FF"..TextColor

	window.SideBlock:setColor("FF"..window.ColorScheme.SubMain)

	window.Frame:setColor(frmcol)
	window.Cross:setColor(txtcol)
	window.Title:setColor(fromHEXToRGB(TextColor))

	for _, v in ipairs(window.SchemeElements) do

		if v.ColorScheme then
			v:setColorScheme(scheme)
		end

	end

end

function cwGetColorScheme(window)
	return window.ColorScheme
end

function cwAddSchemeElement(window, element)

	cnt = #window.SchemeElements
	window.SchemeElements[cnt+1] = element

	if element.ColorScheme then
		element:setColorScheme(window.ColorScheme)
	end
end

function cwAddSchemeElements(window, elements)

	for _, v in ipairs(elements) do

		cnt = #window.SchemeElements
		window.SchemeElements[cnt+1] = v
		v:setColorScheme(window.ColorScheme)

	end
end

function cwAddEvent(window, event, func)
	
	local f = function(...)
		if source == window.Frame or source == window.Canvas or source == window.Top or source == window.Dialog then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end

function cwRemoveEvent(window, event, func)
	removeEventHandler(event, root, func)
end

function cwDestroy(window)

	for _, v in pairs(window.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	for _, v in pairs(window.SchemeElements) do
		if getType(v) then
			v:destroy()
		else
			destroyElement(v)
		end
	end

	destroyElement(window.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP functions

CustomWindow = {}
CustomWindow.__index = CustomWindow
CustomWindow.ClassName = "CustomWindow"

function CustomWindow.create(...)

	local self = setmetatable(guiCreateCustomWindow(...), CustomWindow)

	compareAppend(self, ...)
	return self
end

function CustomWindow.setCloseEnabled(self, ...) return cwSetCloseEnabled(self, ...) end
function CustomWindow.setEnabled(self, ...) return cwSetEnabled(self, ...) end
function CustomWindow.setVisible(self, ...) return cwSetVisible(self, ...) end
function CustomWindow.setSize(self, ...) return cwSetSize(self, ...) end
function CustomWindow.setPosition(self, ...) return cwSetPosition(self, ...) end
function CustomWindow.setText(self, ...) return cwSetTitle(self, ...) end
function CustomWindow.setTitle(self, ...) return cwSetTitle(self, ...) end
function CustomWindow.setMovable(self, ...) return cwSetMovable(self, ...) end
function CustomWindow.setSizable(self, ...) return cwSetSizable(self, ...) end
function CustomWindow.setMinimalWidth(self, ...) return cwSetMinimalWidth(self, ...) end
function CustomWindow.setMinimalHeight(self, ...) return cwSetMinimalHeight(self, ...) end
function CustomWindow.setMinimalSize(self, ...) return cwSetMinimalSize(self, ...) end
function CustomWindow.setMaximalWidth(self, ...) return cwSetMaximalWidth(self, ...) end
function CustomWindow.setMaximalHeight(self, ...) return cwSetMaximalHeight(self, ...) end
function CustomWindow.setMaximalSize(self, ...) return cwSetMaximalSize(self, ...) end
function CustomWindow.setSideBarLength(self, ...) return cwSetSideBarLength(self, ...) end
function CustomWindow.setSideBarPosition(self, ...) return cwSetSideBarLocation(self, ...) end

function CustomWindow.bringToFront(self) return cwBringToFront(self) end
function CustomWindow.moveToBack(self) return cwMoveToBack(self) end

function CustomWindow.getCloseEnabled(self, ...) return cwGetCloseEnabled(self, ...) end
function CustomWindow.getEnabled(self, ...) return cwGetEnabled(self, ...) end
function CustomWindow.getVisible(self, ...) return cwGetVisible(self, ...) end
function CustomWindow.getSize(self, ...) return cwGetSize(self, ...) end
function CustomWindow.getRealSize(self, ...) return cwGetRealSize(self, ...) end
function CustomWindow.getPosition(self, ...) return cwGetPosition(self, ...) end
function CustomWindow.getText(self, ...) return cwGetTitle(self, ...) end
function CustomWindow.getTitle(self, ...) return cwGetTitle(self, ...) end
function CustomWindow.getMovable(self, ...) return cwGetMovable(self, ...) end
function CustomWindow.getSizable(self, ...) return cwGetSizable(self, ...) end
function CustomWindow.getMinimalWidth(self, ...) return cwGetMinimalWidth(self, ...) end
function CustomWindow.getMinimalHeight(self, ...) return cwGetMinimalHeight(self, ...) end
function CustomWindow.getMinimalSize(self, ...) return cwGetMinimalSize(self, ...) end
function CustomWindow.getMaximalWidth(self, ...) return cwGetMaximalWidth(self, ...) end
function CustomWindow.getMaximalHeight(self, ...) return cwGetMaximalHeight(self, ...) end
function CustomWindow.getMaximalSize(self, ...) return cwGetMaximalSize(self, ...) end
function CustomWindow.getSideBarLength(self) return self.SideBlockLength end
function CustomWindow.getSideBarPosition(self) return self.SideBlockLocation end

function CustomWindow.getFrame(self, ...) return cwGetFrame(self, ...) end
function CustomWindow.getHeader(self, ...) return cwGetHeader(self, ...) end
function CustomWindow.getDialog(self, ...) return cwGetDialog(self, ...) end

function CustomWindow.open(self) return cwOpen(self) end
function CustomWindow.close(self) return cwClose(self) end

function CustomWindow.setColorScheme(self, ...) return cwSetColorScheme(self, ...) end
function CustomWindow.getColorScheme(self, ...) return cwGetColorScheme(self, ...) end
function CustomWindow.addElement(self, ...) return cwAddSchemeElement(self, ...) end
function CustomWindow.addElements(self, ...) return cwAddSchemeElements(self, ...) end

function CustomWindow.addEvent(self, ...) return cwAddEvent(self, ...) end
function CustomWindow.removeEvent(self, ...) return cwRemoveEvent(self, ...) end

function CustomWindow.showDialog(self, ...) return cwShowDialog(self, ...) end
function CustomWindow.showBar(self, ...) return cwShowBar(self, ...) end

function CustomWindow.destroy(self, ...) return cwDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------ScrollPanes------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

ScrollPanels = {}
function guiCreateCustomScrollPane(x, y, w, h, relative, parent)
	
	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #ScrollPanels+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Creating

	ScrollPanels[id] = {}
	ScrollPanels[id].ColorScheme = DefaultColors

	if oldparent and oldparent.ColorScheme ~= nil then
		ScrollPanels[id].ColorScheme = oldparent.ColorScheme
	end

	ScrollPanels[id].Canvas = GuiStaticImage.create(x, y, w, h, pane, false, parent)
	ScrollPanels[id].Scroller = GuiStaticImage.create(0, 0, w, h, pane, false, ScrollPanels[id].Canvas)
	ScrollPanels[id].EnablingBlock = GuiStaticImage.create(0, 0, 1, 1, pane, true, ScrollPanels[id].Canvas)

	ScrollPanels[id].Elements = {}
	ScrollPanels[id].ScrollElements = {}

	ScrollPanels[id].MoveCursorPositions = {X = 0, Y = 0}
	ScrollPanels[id].IsScrolling = false
	ScrollPanels[id].IsHorizontal = false
	ScrollPanels[id].ScrollSpeed = 10

	ScrollPanels[id].InversedVertical = 1
	ScrollPanels[id].InversedHorizontal = 1
	ScrollPanels[id].ScrolledWithCursor = true
	ScrollPanels[id].ScrolledWithWheel = true

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	ScrollPanels[id].Canvas:setColor("0")
	ScrollPanels[id].Scroller:setColor("0")
	ScrollPanels[id].EnablingBlock:setColor("44000000")
	
	ScrollPanels[id].Scroller:setProperty("AbsoluteMaxSize", "w:10000000 h:10000000")	

	ScrollPanels[id].EnablingBlock:setEnabled(false)
	ScrollPanels[id].EnablingBlock:setVisible(false)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	local BFMState = BackForMouse:getVisible()
	ScrollPanels[id].Event = {}

	ScrollPanels[id].Event.MouseDown = {}
	ScrollPanels[id].Event.MouseDown.Name = "onClientGUIMouseDown"	
	ScrollPanels[id].Event.MouseDown.Function = function(button, x, y)

		local canScroll = false

		if ScrollPanels[id].ScrolledWithCursor then
			if source == ScrollPanels[id].Scroller then
				canScroll = true
			else
				for _, v in pairs(ScrollPanels[id].ScrollElements) do

					if source == v or source == v.Element then

						canScroll = true
						break
					end
				end
			end
		end

		if canScroll then
			
			ScrollPanels[id].IsScrolling = true

			local ax, ay = ScrollPanels[id].Scroller:getPosition(false)
			ScrollPanels[id].MoveCursorPositions = {X = x-ax, Y = y-ay}		

			BFMState = BackForMouse:getVisible()
			BackForMouse:setVisible(true)	
		end
	end


	ScrollPanels[id].Event.MouseUp = {}
	ScrollPanels[id].Event.MouseUp.Name = "onClientGUIMouseUp"	
	ScrollPanels[id].Event.MouseUp.Function = function()

		ScrollPanels[id].IsScrolling = false
		ScrollPanels[id].MoveCursorPositions = {X = 0, Y = 0}
	
		BackForMouse:setVisible(BFMState)	

	end

	ScrollPanels[id].Event.CursorMove = {}
	ScrollPanels[id].Event.CursorMove.Name = "onClientCursorMove"	
	ScrollPanels[id].Event.CursorMove.Function = function(_, _, x, y)

		if ScrollPanels[id].IsScrolling then
			
			local ax, ay = ScrollPanels[id].MoveCursorPositions.X, ScrollPanels[id].MoveCursorPositions.Y

			local w, h = ScrollPanels[id].Scroller:getSize(false)
			local aw, ah = ScrollPanels[id].Canvas:getSize(false)

			local posX, posY = x-ax, y-ay

			if posX > 0 then posX = 0 end
			if posY > 0 then posY = 0 end
			if posX < aw-w then posX = aw-w end
			if posY < ah-h then posY = ah-h end

			ScrollPanels[id].Scroller:setPosition(posX, posY, false)

			triggerEvent("onCustomScrollPaneScrolled", ScrollPanels[id].Scroller, ScrollPanels[id]:getVerticalScrollPosition(), ScrollPanels[id]:getHorizontalScrollPosition())
			triggerEvent("onClientGUIScroll", ScrollPanels[id].Scroller, ScrollPanels[id])

		end

	end

	ScrollPanels[id].Event.MouseWheel = {}
	ScrollPanels[id].Event.MouseWheel.Name = "onClientMouseWheel"	
	ScrollPanels[id].Event.MouseWheel.Function = function(upper)

		local canScroll = false

		if ScrollPanels[id].ScrolledWithWheel then
			if source == ScrollPanels[id].Scroller then
				canScroll = true
			else
				for _, v in pairs(ScrollPanels[id].ScrollElements) do
					if source == v or source == v.Element then
						canScroll = true
						break
					end
				end
			end
		end

		if canScroll then

			local x, y = ScrollPanels[id].Scroller:getPosition(false)

			local w, h = ScrollPanels[id].Scroller:getSize(false)
			local aw, ah = ScrollPanels[id].Canvas:getSize(false)

			if 
				(
					(getKeyState("lshift") == false and getKeyState("rshift") == false) 
					and not ScrollPanels[id].IsHorizontal

				) or (
					
					not (getKeyState("lshift") == false and getKeyState("rshift") == false) 
					and ScrollPanels[id].IsHorizontal
				)
			then

				y = y + ScrollPanels[id].InversedVertical*upper*ScrollPanels[id].ScrollSpeed
			else
				x = x + ScrollPanels[id].InversedHorizontal*upper*ScrollPanels[id].ScrollSpeed
			end

			if x < aw-w then x = aw-w end
			if y < ah-h then y = ah-h end

			if x < 0 then x = x-1 end
			if y < 0 then y = y-1 end

			if x > 0 then x = 0 end
			if y > 0 then y = 0 end

			ScrollPanels[id].Scroller:setPosition(x, y, false)

			triggerEvent("onCustomScrollPaneScrolled", ScrollPanels[id].Scroller, ScrollPanels[id]:getVerticalScrollPosition(), ScrollPanels[id]:getHorizontalScrollPosition())
			triggerEvent("onClientGUIScroll", ScrollPanels[id].Scroller, ScrollPanels[id])

		end
	end



	addEventHandler(ScrollPanels[id].Event.MouseDown.Name, root, ScrollPanels[id].Event.MouseDown.Function)
	addEventHandler(ScrollPanels[id].Event.MouseUp.Name, root, ScrollPanels[id].Event.MouseUp.Function)
	addEventHandler(ScrollPanels[id].Event.CursorMove.Name, root, ScrollPanels[id].Event.CursorMove.Function)
	addEventHandler(ScrollPanels[id].Event.MouseWheel.Name, root, ScrollPanels[id].Event.MouseWheel.Function)


	return ScrollPanels[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions

function cspRecalcSize(spane)

	local x, y = spane.Scroller:getPosition(false)
	local w, h = spane.Canvas:getSize(false)

	local maxW, maxH = 0, 0

	for _, v in pairs(spane.Elements) do

		local ax, ay = v:getPosition(false)
		local aw, ah = v:getSize(false)

		if v.getRealSize then
			aw, ah = v:getRealSize(false) 
		end

		maxW = math.max(ax+aw, maxW)
		maxH = math.max(ay+ah, maxH)

	end

	maxW = math.max(maxW, w)
	maxH = math.max(maxH, h)

	if x < w-maxW then x = w-maxW end
	if y < h-maxH then y = h-maxH end

	if x < 0 then x = x-1 end
	if y < 0 then y = y-1 end

	if x > 0 then x = 0 end
	if y > 0 then y = 0 end

	spane.Scroller:setPosition(x, y, false)
	spane.Scroller:setSize(maxW, maxH, false)

end

function cspSetPosition(spane, x, y, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = spane.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	spane.Canvas:setPosition(x, y, false)

end

function cspSetSize(spane, w, h, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = scroll.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	spane.Canvas:setSize(w, h, false)
	cspRecalcSize(spane)
end

function cspSetEnabled(spane, enabled)

	spane.EnablingBlock:setVisible(not (enabled or false))
	spane.EnablingBlock:bringToFront()

	spane.Canvas:setEnabled(enabled or false)
end

function cspSetVisible(spane, visible)
	spane.Canvas:setVisible(visible or false)
end

function cspSetColorScheme(spane, scheme)

	spane.ColorScheme = scheme

	for _, v in ipairs(spane.Elements) do

		if v.ColorScheme ~= nil then
			
			v:setColorScheme(scheme)
		end
	end

end

function cspSetScrollSpeed(spane, speed)
	if speed < 2 then speed = 2 end
	spane.ScrollSpeed = speed
end

function cspSetVerticalScrollPosition(spane, percentage)

	if percentage < 0 then percentage = 0 end
	if percentage > 100 then percentage = 100 end

	local x, y = spane.Scroller:getPosition(false)
	local w, h = spane.Scroller:getSize(false)
	local aw, ah = spane.Canvas:getSize(false)

	y = (ah-h-1)*percentage/100

	if x < 0 then x = x-1 end
	if y < 0 then y = y-1 end

	spane.Scroller:setPosition(x, y, false)
	cspRecalcSize(spane)

	triggerEvent("onCustomScrollPaneScrolled", spane.Scroller, spane:getVerticalScrollPosition(), spane:getHorizontalScrollPosition())
	triggerEvent("onClientGUIScroll", spane.Scroller, spane)

end

function cspSetHorizontalScrollPosition(spane, percentage)

	if percentage < 0 then percentage = 0 end
	if percentage > 100 then percentage = 100 end

	local x, y = spane.Scroller:getPosition(false)
	local w, h = spane.Scroller:getSize(false)
	local aw, ah = spane.Canvas:getSize(false)

	x = (aw-w)*percentage/100
	
	if x < 0 then x = x-1 end
	if y < 0 then y = y-1 end

	spane.Scroller:setPosition(x, y, false)
	cspRecalcSize(spane)

	triggerEvent("onCustomScrollPaneScrolled", spane.Scroller, spane:getVerticalScrollPosition(), spane:getHorizontalScrollPosition())
	triggerEvent("onClientGUIScroll", spane.Scroller, spane)

end

function cspSetVerticalInversed(spane, bool)
	if bool then
		spane.InversedVertical = -1
	else
		spane.InversedVertical = 1
	end
end

function cspSetHorizontalInversed(spane, bool)
	if bool then
		spane.InversedHorizontal = -1
	else
		spane.InversedHorizontal = 1
	end
end

function cspSetHorizontalScrolling(spane, bool)
	spane.IsHorizontal = bool or false
end

function cspSetScrollingWithCursor(spane, bool)
	spane.ScrolledWithCursor = bool or false
end

function cspSetScrollingWithWheel(spane, bool)
	spane.ScrolledWithWheel = bool or false
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function cspBringToFront(spane)
	spane.Canvas:bringToFront()
end

function cspMoveToBack(spane)
	spane.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function cspGetEnabled(spane)
	return spane.Canvas:getEnabled()
end

function cspGetVisible(spane)
	return spane.Canvas:getVisible()
end

function cspGetColorSheme(spane)
	return spane.ColorScheme
end

function cspGetPosition(spane, rel)

	local x, y = spane.Canvas:getPosition(rel or false)
	return x, y

end

function cspGetSize(spane, rel)

	return spane.Canvas:getSize(rel or false)
end

function cspGetScrollSpeed(spane)
	return spane.ScrollSpeed
end

function cspGetVerticalScrollPosition(spane)

	local x, y = spane.Scroller:getPosition(false)
	local w, h = spane.Scroller:getSize(false)
	local aw, ah = spane.Canvas:getSize(false)

	if x < 0 then x = x-1 end
	if y < 0 then y = y-1 end

	if ah-h == 0 then 
		return 0
	else
		return 100*y/(ah-h)
	end

end

function cspGetHorizontalScrollPosition(spane)

	local x, y = spane.Scroller:getPosition(false)
	local w, h = spane.Scroller:getSize(false)
	local aw, ah = spane.Canvas:getSize(false)

	if x < 0 then x = x-1 end
	if y < 0 then y = y-1 end

	if aw-w == 0 then 
		return 0
	else
		return 100*x/(aw-w)
	end

end

function cspGetFrame(spane)
	return spane.Scroller
end

function cspIsHorizontalScrolling(spane)
	return spane.IsHorizontal
end

function cspIsVerticalInversed(spane)
	return spane.InversedVertical == -1
end

function cspIsHorizontalInversed(spane)
	return spane.InversedHorizontal == -1
end

function cspGetScrollingWithCursor(spane, bool)
	return spane.ScrolledWithCursor
end

function cspGetScrollingWithWheel(spane, bool)
	return spane.ScrolledWithWheel
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event functions

function cspAddElement(spane, element, scrollable)

	if scrollable ~= false and scrollable ~= true then 
		scrollable = true 
	end

	local len = #spane.Elements+1
	spane.Elements[len] = element

	if scrollable then
		
		len = #spane.ScrollElements+1
		spane.ScrollElements[len] = element

	end
	
	cspRecalcSize(spane)
end

function cspRemoveElement(spane, element)

	for i, v in pairs(spane.Elements) do
		if v == element then
			table.remove(spane.Elements, i)
			break
		end
	end

	for i, v in pairs(spane.ScrollElements) do
		if v == element then
			table.remove(spane.ScrollElements, i)
			break
		end
	end

	cspRecalcSize(spane)
end

function cspAddEvent(spane, event, func)
	
	local f = function(...)
		if source == spane.Canvas or source == spane.Scroller then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end

function cspDestroy(spane)

	for _, v in pairs(spane.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	for i, v in pairs(spane.Elements) do
		if getType(v) then
			v:destroy()
		else
			destroyElement(v)
		end
	end

	destroyElement(spane.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP functions
CustomScrollPane = {}
CustomScrollPane.__index = CustomScrollPane
CustomScrollPane.ClassName = "CustomScrollPane"

function CustomScrollPane.create(...)
	local self = setmetatable(guiCreateCustomScrollPane(...), CustomScrollPane)

	compareAppend(self, ...)
	return self
end

function CustomScrollPane.setEnabled(self, ...) return cspSetEnabled(self, ...) end
function CustomScrollPane.setVisible(self, ...) return cspSetVisible(self, ...) end
function CustomScrollPane.setSize(self, ...) return cspSetSize(self, ...) end
function CustomScrollPane.setPosition(self, ...) return cspSetPosition(self, ...) end
function CustomScrollPane.setScrollSpeed(self, ...) return cspSetScrollSpeed(self, ...) end
function CustomScrollPane.setVerticalScrollPosition(self, ...) return cspSetVerticalScrollPosition(self, ...) end
function CustomScrollPane.setHorizontalScrollPosition(self, ...) return cspSetHorizontalScrollPosition(self, ...) end
function CustomScrollPane.setVerticalScrollInversed(self, ...) return cspSetVerticalInversed(self, ...) end
function CustomScrollPane.setHorizontalScrollInversed(self, ...) return cspSetHorizontalInversed(self, ...) end
function CustomScrollPane.setHorizontalScrolling(self, ...) return cspSetHorizontalScrolling(self, ...) end
function CustomScrollPane.setScrollingWithCursor(self, ...) return cspSetScrollingWithCursor(self, ...) end
function CustomScrollPane.setScrollingWithWheel(self, ...) return cspSetScrollingWithWheel(self, ...) end

function CustomScrollPane.bringToFront(self) return cspBringToFront(self) end
function CustomScrollPane.moveToBack(self) return cspMoveToBack(self) end

function CustomScrollPane.getEnabled(self, ...) return cspGetEnabled(self, ...) end
function CustomScrollPane.getVisible(self, ...) return cspGetVisible(self, ...) end
function CustomScrollPane.getSize(self, ...) return cspGetSize(self, ...) end
function CustomScrollPane.getRealSize(self, ...) return cspGetSize(self, ...) end
function CustomScrollPane.getPosition(self, ...) return cspGetPosition(self, ...) end
function CustomScrollPane.getScrollSpeed(self, ...) return cspGetScrollSpeed(self, ...) end
function CustomScrollPane.getVerticalScrollPosition(self, ...) return cspGetVerticalScrollPosition(self, ...) end
function CustomScrollPane.getHorizontalScrollPosition(self, ...) return cspGetHorizontalScrollPosition(self, ...) end
function CustomScrollPane.isHorizontalScrolling(self, ...) return cspIsHorizontalScrolling(self, ...) end
function CustomScrollPane.isVerticalScrollInversed(self, ...) return cspIsVerticalInversed(self, ...) end
function CustomScrollPane.isHorizontalScrollInversed(self, ...) return cspIsHorizontalInversed(self, ...) end
function CustomScrollPane.getScrollingWithCursor(self, ...) return cspGetScrollingWithCursor(self, ...) end
function CustomScrollPane.getScrollingWithWheel(self, ...) return cspGetScrollingWithWheel(self, ...) end

function CustomScrollPane.setColorScheme(self, ...) return cspSetColorScheme(self, ...) end
function CustomScrollPane.getColorScheme(self, ...) return cspGetColorScheme(self, ...) end

function CustomScrollPane.getFrame(self, ...) return cspGetFrame(self, ...) end
function CustomScrollPane.addElement(self, ...) return cspAddElement(self, ...) end
function CustomScrollPane.removeElement(self, ...) return cspRemoveElement(self, ...) end

function CustomScrollPane.addEvent(self, ...) return cspAddEvent(self, ...) end
function CustomScrollPane.removeEvent(self, ...) return cwRemoveEvent(self, ...) end

function CustomScrollPane.update(self, ...) return cspRecalcSize(self, ...) end
function CustomScrollPane.destroy(self, ...) return cspDestroy(self, ...) end


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Buttons----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Buttons = {}
function guiCreateCustomButton(x, y, w, h, text, relative, parent)
	
	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #Buttons+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main part of button
	Buttons[id] = {}

	Buttons[id].Canvas = GuiStaticImage.create(x-1, y-1, w+2, h+2, pane, false, parent)
	Buttons[id].ColorScheme = DefaultColors

	if oldparent and oldparent.ColorScheme ~= nil then
		Buttons[id].ColorScheme = oldparent.ColorScheme
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Button formal shadow
	Buttons[id].Vertical = GuiStaticImage.create(1, 0, w, h+2, pane, false, Buttons[id].Canvas)
	Buttons[id].Horizontal = GuiStaticImage.create(0, 1, w+2, h, pane, false, Buttons[id].Canvas)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Button main
	Buttons[id].Main = GuiStaticImage.create(1, 1, w, h, pane, false, Buttons[id].Canvas)
	Buttons[id].Image = GuiStaticImage.create(0, 0, 1, 1, pane, false, Buttons[id].Main)
	Buttons[id].ImageLocation = nil
	Buttons[id].Label = CustomLabel.create(0, 0, 1, 1, text or "", false, Buttons[id].Main)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	TopCol, BotCol, BackCol = "FFFFFF", "EEEEEE", "CCCCCC"
	if Buttons[id].ColorScheme.DarkTheme then TopCol, BotCol, BackCol = "555555", "444444", "333333" end

	TextColor = "444444"
	if Buttons[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
	fbtcol = "FF"..BackCol

	Buttons[id].Canvas:setColor("0")
	Buttons[id].Main:setProperty("ImageColours", btncol)
	Buttons[id].Vertical:setColor(fbtcol)
	Buttons[id].Horizontal:setColor(fbtcol)

	Buttons[id].Vertical:setEnabled(false)
	Buttons[id].Horizontal:setEnabled(false)
	Buttons[id].Image:setEnabled(false)
	Buttons[id].Label:setEnabled(false)

	Buttons[id].Image:setVisible(false)
	Buttons[id].Label:setVisible(text and text ~= "")

	Buttons[id].Label:setFont(Fonts.OpenSansRegular, 9)
	Buttons[id].Label:setColor(fromHEXToRGB(TextColor))

	if text and text ~= "" then
		Buttons[id].Label:setPosition(0, 0, false)
		Buttons[id].Label:setSize(w, h-3, false)
		Buttons[id].Label:setHorizontalAlign("center")
		Buttons[id].Label:setVerticalAlign("center")
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	Buttons[id].Event = {}

	--Enter
	Buttons[id].Event.MouseEnter = {}
	Buttons[id].Event.MouseEnter.Name = "onClientMouseEnter"
	Buttons[id].Event.MouseEnter.Function = function()
		if source == Buttons[id].Main then
			--source:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFDDDDDD br:FFDDDDDD")
			--Buttons[id].Label:setColor(fromHEXToRGB(Buttons[id].ColorScheme.Main))
			
			source:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", Buttons[id].ColorScheme.Main, Buttons[id].ColorScheme.Main, Buttons[id].ColorScheme.SubMain, Buttons[id].ColorScheme.SubMain))
			
			Buttons[id].Vertical:setColor(Buttons[id].ColorScheme.Main)
			Buttons[id].Horizontal:setColor(Buttons[id].ColorScheme.Main)
			Buttons[id].Label:setColor(fromHEXToRGB("FFFFFF"))
		end
	end


	--Leave
	Buttons[id].Event.MouseLeave = {}
	Buttons[id].Event.MouseLeave.Name = "onClientMouseLeave"
	Buttons[id].Event.MouseLeave.Function = function()

		if Buttons[id].Canvas:getEnabled() then
	
			TopCol, BotCol, BackCol = "FFFFFF", "EEEEEE", "CCCCCC"
			if Buttons[id].ColorScheme.DarkTheme then TopCol, BotCol, BackCol = "555555", "444444", "333333" end

			TextColor = "444444"
			if Buttons[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

			btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
			fbtcol = "FF"..BackCol

			Buttons[id].Label:setColor(fromHEXToRGB(TextColor))
			Buttons[id].Main:setProperty("ImageColours", btncol)
			Buttons[id].Vertical:setColor(fbtcol)
			Buttons[id].Horizontal:setColor(fbtcol)
	
		end

	end


	--Mouse Down
	Buttons[id].Event.MouseDown = {}
	Buttons[id].Event.MouseDown.Name = "onClientGUIMouseDown"
	Buttons[id].Event.MouseDown.Function = function()
		if source == Buttons[id].Main then

			source:setColor("FF"..Buttons[id].ColorScheme.SubMain)
			Buttons[id].Label:setColor(fromHEXToRGB("EEEEEE"))

			Buttons[id].Vertical:setColor("FF"..Buttons[id].ColorScheme.DarkMain)
			Buttons[id].Horizontal:setColor("FF"..Buttons[id].ColorScheme.DarkMain)
		
		end
	end


	--Mouse Up
	Buttons[id].Event.MouseUp = {}
	Buttons[id].Event.MouseUp.Name = "onClientGUIMouseUp"
	Buttons[id].Event.MouseUp.Function = function(_, ...)
		if source == Buttons[id].Main then
	
			triggerEvent("onClientMouseEnter", source, ...)

		end
	end


	addEventHandler(Buttons[id].Event.MouseEnter.Name, root, Buttons[id].Event.MouseEnter.Function)
	addEventHandler(Buttons[id].Event.MouseLeave.Name, root, Buttons[id].Event.MouseLeave.Function)
	addEventHandler(Buttons[id].Event.MouseDown.Name, root, Buttons[id].Event.MouseDown.Function)
	addEventHandler(Buttons[id].Event.MouseUp.Name, root, Buttons[id].Event.MouseUp.Function)

	return Buttons[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions
function cbSetImage(button, image)

	local w, h = button.Canvas:getSize(false)
	w, h = w-2, h-2

	if image == nil then

		button.Label:setPosition(0, 0, false)
		button.Label:setSize(w, h-3, false)
		button.Label:setHorizontalAlign("center")
		button.Image:setVisible(false)
		button.ImageLocation = nil

	else

		button.Image:loadImage(image)
		button.ImageLocation = image

		local img_w, img_h = guiStaticImageGetNativeSize(button.Image)
		button.Image:setSize(img_w, img_h, false)

		local x, y = math.floor(w/2-img_w/2), math.floor(h/2-img_h/2)
		
		if button.Label:getText() ~= "" then

			x = math.floor(h/2-img_w/2)

			button.Label:setPosition(x+img_w+2, 0, false)
			local ax = x+img_w
			button.Label:setSize(w-ax > 0 and w-ax or 10, h-3, false)
			button.Label:setHorizontalAlign("left")
		end

		button.Image:setPosition(x, y, false)
		button.Image:setVisible(true)

	end
end

function cbSetText(button, text)

	button.Label:setText(text or "")
	button.Label:setVisible(text and text ~= "")
	cbSetImage(button, button.ImageLocation)

end

function cbSetPosition(button, x, y, rel)
	
	if relative then

		local sw, sh = Width, Height
		local parent = button.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	button.Canvas:setPosition(x-1, y-1, false)
end

function cbSetSize(button, w, h, rel)

	if relative then

		local sw, sh = Width, Height
		local parent = button.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	button.Canvas:setSize(w+2, h+2, false)
	button.Vertical:setSize(w, h+2, false)
	button.Horizontal:setSize(w+2, h, false)
	button.Main:setSize(w, h, false)
	cbSetImage(button, button.Image:getVisible() and button.Image:getText() or nil)
end

function cbSetEnabled(button, bool)
	
	button.Canvas:setEnabled(bool)

	if not bool then

		button.Label:setColor(fromHEXToRGB("888888"))
		button.Main:setColor("AA"..button.ColorScheme.DarkMain)
		button.Vertical:setColor("AA"..button.ColorScheme.DarkMain)
		button.Horizontal:setColor("AA"..button.ColorScheme.DarkMain)

	else 

		TopCol, BotCol, BackCol = "FFFFFF", "EEEEEE", "CCCCCC"
		if button.ColorScheme.DarkTheme then TopCol, BotCol, BackCol = "555555", "444444", "333333" end

		TextColor = "444444"
		if button.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

		btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
		fbtcol = "FF"..BackCol

		button.Label:setColor(fromHEXToRGB(TextColor))
		button.Main:setProperty("ImageColours", btncol)
		button.Vertical:setColor(fbtcol)
		button.Horizontal:setColor(fbtcol)
	end

end

function cbSetVisible(button, bool)
	button.Canvas:setVisible(bool)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function cbBringToFront(button)
	button.Canvas:bringToFront()
end

function cbMoveToBack(button)
	button.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions
function cbGetText(button)
	return button.Label:getText()
end

function cbGetPosition(button, rel)

	local x, y = button.Canvas:getPosition(false)
	if rel then

		local sw, sh = Width, Height
		local parent = button.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end
		

		return (x+1)/sw, (y+1)/sh
	
	else

		return x+1, y+1
	end
end

function cbGetSize(button, rel)
	
	local w, h = button.Canvas:getSize(false)
	if rel then

		local sw, sh = Width, Height
		local parent = button.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		return (w-2)/sw, (h-2)/sh
	
	else

		return w-2, h-2
	end

end

function cbGetRealSize(button, rel)
	return button.Canvas:getSize(false)
end

function cbGetEnabled(button)
	return button.Canvas:getEnabled()
end

function cbGetVisible(button)
	return button.Canvas:getVisible()
end

function cbGetImage(button)
	return button.ImageLocation
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme editor

function cbSetColorScheme(button, scheme)

	button.ColorScheme = scheme

	enbld = cbGetEnabled(button)
	cbSetEnabled(button, enbld)

end

function cbGetColorScheme(button)
	return button.ColorScheme
end

function cbGetFrame(button)
	return button.Main
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function cbAddEvent(button, event, func)
	
	local f = function(...)
		if source == button.Main or source == button.Canvas then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end

function cbDestroy(button)

	for _, v in pairs(button.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	button.Label:destroy()
	destroyElement(button.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP functions
CustomButton = {}
CustomButton.__index = CustomButton
CustomButton.ClassName = "CustomButton"

function CustomButton.create(...)
	local self = setmetatable(guiCreateCustomButton(...), CustomButton)
	compareAppend(self, ...)

	self.Element = self.Main

	return self
end

function CustomButton.setEnabled(self, ...) return cbSetEnabled(self, ...) end
function CustomButton.setVisible(self, ...) return cbSetVisible(self, ...) end
function CustomButton.setSize(self, ...) return cbSetSize(self, ...) end
function CustomButton.setPosition(self, ...) return cbSetPosition(self, ...) end
function CustomButton.setText(self, ...) return cbSetText(self, ...) end
function CustomButton.setImage(self, ...) return cbSetImage(self, ...) end

function CustomButton.bringToFront(self) return cbBringToFront(self) end
function CustomButton.moveToBack(self) return cbMoveToBack(self) end

function CustomButton.getEnabled(self, ...) return cbGetEnabled(self, ...) end
function CustomButton.getVisible(self, ...) return cbGetVisible(self, ...) end
function CustomButton.getSize(self, ...) return cbGetSize(self, ...) end
function CustomButton.getRealSize(self, ...) return cbGetRealSize(self, ...) end
function CustomButton.getPosition(self, ...) return cbGetPosition(self, ...) end
function CustomButton.getText(self, ...) return cbGetText(self, ...) end
function CustomButton.getImage(self, ...) return cbGetImage(self, ...) end

function CustomButton.setColorScheme(self, ...) return cbSetColorScheme(self, ...) end
function CustomButton.getColorScheme(self, ...) return cbGetColorScheme(self, ...) end

function CustomButton.addEvent(self, ...) return cbAddEvent(self, ...) end
function CustomButton.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomButton.getFrame(self, ...) return cbGetFrame(self, ...) end

function CustomButton.destroy(self, ...) return cbDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------ProgressBars-----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

ProgressBars = {}
function guiCreateCustomProgressBar(x, y, w, h, relative, parent)
	
	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates

	local id = #ProgressBars+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main

	ProgressBars[id] = {}
	ProgressBars[id].Canvas = GuiStaticImage.create(x-1, y-1, w+2, h+2, pane, false, parent)
	ProgressBars[id].ColorScheme = DefaultColors

	if oldparent and oldparent.ColorScheme ~= nil then
		ProgressBars[id].ColorScheme = oldparent.ColorScheme
	end

	ProgressBars[id].Vertical = GuiStaticImage.create(1, 0, w, h+2, pane, false, ProgressBars[id].Canvas)
	ProgressBars[id].Horizontal = GuiStaticImage.create(0, 1, w+2, h, pane, false, ProgressBars[id].Canvas)

	ProgressBars[id].Main = GuiStaticImage.create(1, 1, w, h, pane, false, ProgressBars[id].Canvas)
	ProgressBars[id].Progress = GuiStaticImage.create(0, 0, 0, h, pane, false, ProgressBars[id].Main)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	BackCol, MainCol = "AAAAAA", "E7E7E7"
	if ProgressBars[id].ColorScheme.DarkTheme then BackCol, MainCol = "2F2F2F", "333333" end

	bckcol = "FF"..BackCol
	cntcol = "FF"..MainCol

	ProgressBars[id].Canvas:setColor("0")

	ProgressBars[id].Vertical:setColor(bckcol)
	ProgressBars[id].Horizontal:setColor(bckcol)

	ProgressBars[id].Main:setColor(cntcol)
	ProgressBars[id].Progress:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", ProgressBars[id].ColorScheme.LightMain, ProgressBars[id].ColorScheme.LightMain, ProgressBars[id].ColorScheme.Main, ProgressBars[id].ColorScheme.Main))

	ProgressBars[id].Vertical:setEnabled(false)
	ProgressBars[id].Horizontal:setEnabled(false)
	ProgressBars[id].Progress:setEnabled(false)

	ProgressBars[id].IsVertical = w<h

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending
	return ProgressBars[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set Functions

function cpbSetProgress(bar, percentage)
	
	if not tonumber(percentage) or percentage < 0 then percentage = 0
	elseif percentage > 100 then percentage = 100 end

	w, h = percentage/100, 1
	if bar.IsVertical then
		w, h = h, w
		bar.Progress:setPosition(0, 1-h, true)
	else
		bar.Progress:setPosition(0, 0, true)
	end

	bar.Progress:setSize(w, h, true)
end

function cpbSetPosition(bar, x, y, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = bar.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	bar.Canvas:setPosition(x, y, false)
end

function cpbSetSize(bar, w, h, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = bar.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = w*sh

	end

	local sw, sh = bar.Progress:getSize(true)
	
	bar.Canvas:setSize(w+2, h+2, false)
	bar.Vertical:setSize(w, h+2, false)
	bar.Horizontal:setSize(w+2, h, false)
	bar.Main:setSize(w, h, false)
	
	if bar.IsVertical ~= (w<h) then
		sw, sh = sh, sw
		bar.IsVertical = w<h
	end

	if bar.IsVertical then
		bar.Progress:setPosition(0, 1-sh, true)
	else
		bar.Progress:setPosition(0, 0, true)
	end
	bar.Progress:setSize(sw, sh, true)

end

function cpbSetVisible(bar, bool)
	return bar.Canvas:setVisible(bool)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function cpbBringToFront(bar)
	return bar.Canvas:bringToFront()
end

function cpbMoveToBack(bar)
	return bar.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get Functions

function cpbGetProgress(bar)
	local w = bar.Progress:getSize(true)
	return w*100
end

function cpbGetPosition(bar, rel)
	
	local x, y = bar.Canvas:getPosition(false)
	if rel then

		local sw, sh = Width, Height
		local parent = bar.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end
		

		return (x+1)/sw, (y+1)/sh
	
	else

		return x+1, y+1
	end
end

function cpbGetSize(bar, rel)
	
	local w, h = bar.Canvas:getSize(false)
	if rel then

		local sw, sh = Width, Height
		local parent = bar.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end
		

		return (w-2)/sw, (h-2)/sh
	
	else

		return w-2, h-2
	end
end

function cpbGetRealSize(bar, rel)
	return bar.Canvas:getSize(rel or false)
end

function cpbGetVisible(bar)
	return bar.Canvas:getVisible()
end

function cpbGetFrame(bar)
	return bar.Main
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme Functions

function cpbSetColorScheme(bar, scheme)

	bar.ColorScheme = scheme

	BackCol, MainCol = "AAAAAA", "E7E7E7"
	if bar.ColorScheme.DarkTheme then BackCol, MainCol = "2F2F2F", "333333" end

	bckcol = "FF"..BackCol
	cntcol = "FF"..MainCol

	bar.Vertical:setColor(bckcol)
	bar.Horizontal:setColor(bckcol)

	bar.Main:setColor(cntcol)
	bar.Progress:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", bar.ColorScheme.LightMain, bar.ColorScheme.LightMain, bar.ColorScheme.Main, bar.ColorScheme.Main))
end

function cpbGetColorScheme(bar)
	return bar.ColorScheme
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function cpbAddEvent(bar, event, func)

	local f = function(...)
		if source == bar.Main or source == bar.Canvas then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end

function cpbDestroy(bar)

	destroyElement(bar.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP Functions
CustomProgressBar = {}
CustomProgressBar.__index = CustomProgressBar
CustomProgressBar.ClassName = "CustomProgressBar"

function CustomProgressBar.create(...)
	local self = setmetatable(guiCreateCustomProgressBar(...), CustomProgressBar)
	compareAppend(self, ...)

	self.Element = self.Main

	return self
end

function CustomProgressBar.setProgress(self, ...) return cpbSetProgress(self, ...) end
function CustomProgressBar.setPosition(self, ...) return cpbSetPosition(self, ...) end
function CustomProgressBar.setSize(self, ...) return cpbSetSize(self, ...) end
function CustomProgressBar.setVisible(self, ...) return cpbSetVisible(self, ...) end

function CustomProgressBar.bringToFront(self) return cpbBringToFront(self) end
function CustomProgressBar.moveToBack(self) return cpbMoveToBack(self) end

function CustomProgressBar.getProgress(self, ...) return cpbGetProgress(self, ...) end
function CustomProgressBar.getPosition(self, ...) return cpbGetPosition(self, ...) end
function CustomProgressBar.getSize(self, ...) return cpbGetSize(self, ...) end
function CustomProgressBar.getRealSize(self, ...) return cpbGetRealSize(self, ...) end
function CustomProgressBar.getVisible(self, ...) return cpbGetVisible(self, ...) end

function CustomProgressBar.setColorScheme(self, ...) return cpbSetColorScheme(self, ...) end
function CustomProgressBar.getColorScheme(self, ...) return cpbGetColorScheme(self, ...) end

function CustomProgressBar.addEvent(self, ...) return cpbAddEvent(self, ...) end
function CustomProgressBar.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomProgressBar.getFrame(self, ...) return cpbGetFrame(self, ...) end

function CustomProgressBar.destroy(self, ...) return cpbDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------ScrollBars-------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
ScrollBars = {}

function guiCreateCustomScrollBar(x, y, w, h, rel, parent)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates

	local id = #ScrollBars+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end
	local high = w > h and w or h
	ScrollBars[id] = {}
	ScrollBars[id].ScrollLength = 0.2*high
	ScrollBars[id].ColorScheme = DefaultColors

	if parent and parent.ColorScheme ~= nil then
		ScrollBars[id].ColorScheme = parent.ColorScheme
	end

	local sw, sh = ScrollBars[id].ScrollLength, h
	local xw, xh = ScrollBars[id].ScrollLength-2, h
	local sx, sy = 1, 0

	if w < h then
		sw, sh = w, ScrollBars[id].ScrollLength
		xw, xh = w, ScrollBars[id].ScrollLength-2
		sx, sy = 0, 1
	end


	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main

	ScrollBars[id].Canvas = GuiStaticImage.create(x-1, y-1, w+2, h+2, pane, false, parent)
	ScrollBars[id].Vertical = GuiStaticImage.create(1, 0, w, h+2, pane, false, ScrollBars[id].Canvas)
	ScrollBars[id].Horizontal = GuiStaticImage.create(0, 1, w+2, h, pane, false, ScrollBars[id].Canvas)
	ScrollBars[id].Main = GuiStaticImage.create(1, 1, w, h, pane, false, ScrollBars[id].Canvas)

	ScrollBars[id].Edges = GuiStaticImage.create(0, 0, sw, sh, pane, false, ScrollBars[id].Main)
	ScrollBars[id].Entrail = GuiStaticImage.create(sx, sy, xw, xh, pane, false, ScrollBars[id].Edges)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	TopCol, BotCol, BackCol, EdgesCol, MainCol = "F6F6F6", "EAEAEA", "AAAAAA", "BBBBBB", "E7E7E7"
	if ScrollBars[id].ColorScheme.DarkTheme then TopCol, BotCol, BackCol, EdgesCol, MainCol = "555555", "444444", "333333", "3F3F3F", "3A3A3A" end

	bckcol = "FF"..BackCol
	maicol = "FF"..MainCol
	edgcol = "FF"..EdgesCol
	btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)

	ScrollBars[id].Canvas:setColor("0")

	ScrollBars[id].Vertical:setColor(bckcol)
	ScrollBars[id].Horizontal:setColor(bckcol)

	ScrollBars[id].Main:setColor(maicol)

	ScrollBars[id].Edges:setColor(edgcol)
	ScrollBars[id].Entrail:setProperty("ImageColours", btncol)

	ScrollBars[id].Vertical:setEnabled(false)
	ScrollBars[id].Horizontal:setEnabled(false)
	ScrollBars[id].Entrail:setEnabled(false)

	ScrollBars[id].IsVertical = w<h

	ScrollBars[id].LocalPosition = {X=0, Y=0, DX=0, DY=0} --X, Y - Start Positions, DX, DY - Cursor Differencial Position
	ScrollBars[id].PhysicalPosition = {X=0, Y=0}
	ScrollBars[id].ScrollEnabled = false
	ScrollBars[id].Scroll = 0
	ScrollBars[id].Entered = false
	ScrollBars[id].ScrollSpeed = 2

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	local BFMState = BackForMouse:getVisible()
	ScrollBars[id].Event = {}


	ScrollBars[id].Event.MouseEnter = {}
	ScrollBars[id].Event.MouseEnter.Name = "onClientMouseEnter"
	ScrollBars[id].Event.MouseEnter.Function = function()

		if source == ScrollBars[id].Edges then
			if not ScrollBars[id].ScrollEnabled then
				ScrollBars[id].Edges:setColor("FF"..ScrollBars[id].ColorScheme.LightMain)
				ScrollBars[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", ScrollBars[id].ColorScheme.LightMain, ScrollBars[id].ColorScheme.LightMain, ScrollBars[id].ColorScheme.Main, ScrollBars[id].ColorScheme.Main))
			end
			ScrollBars[id].Entered = true
		end
	end


	ScrollBars[id].Event.MouseLeave = {}
	ScrollBars[id].Event.MouseLeave.Name = "onClientMouseLeave"
	ScrollBars[id].Event.MouseLeave.Function = function()

		if ScrollBars[id].Canvas:getEnabled() then
			if not ScrollBars[id].ScrollEnabled then
				
				TopCol, BotCol, EdgesCol = "F6F6F6", "EAEAEA", "BBBBBB"
				if ScrollBars[id].ColorScheme.DarkTheme then TopCol, BotCol, EdgesCol = "555555", "444444", "3F3F3F" end

				edgcol = "FF"..EdgesCol
				btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
			
				ScrollBars[id].Edges:setColor(edgcol)
				ScrollBars[id].Entrail:setProperty("ImageColours", btncol)
			end

			ScrollBars[id].Entered = false
		end
	end

	
	ScrollBars[id].Event.MouseDown = {}
	ScrollBars[id].Event.MouseDown.Name = "onClientGUIMouseDown"
	ScrollBars[id].Event.MouseDown.Function = function(button, ax, ay)

		if button == "left" and source == ScrollBars[id].Edges then

			ScrollBars[id].LocalPosition.DX = ax 
			ScrollBars[id].LocalPosition.DY = ay

			ScrollBars[id].PhysicalPosition.X, ScrollBars[id].PhysicalPosition.Y = ScrollBars[id].Edges:getPosition(false)
			ScrollBars[id].LocalPosition.X, ScrollBars[id].LocalPosition.Y = ScrollBars[id].Edges:getPosition(false)

			ScrollBars[id].Edges:setColor("FF"..ScrollBars[id].ColorScheme.SubMain)
			ScrollBars[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", ScrollBars[id].ColorScheme.Main, ScrollBars[id].ColorScheme.Main, ScrollBars[id].ColorScheme.SubMain, ScrollBars[id].ColorScheme.SubMain))
			
			ScrollBars[id].ScrollEnabled = true

			BFMState = BackForMouse:getVisible()
			BackForMouse:setVisible(true)
		end
	end


	ScrollBars[id].Event.MouseUp = {}
	ScrollBars[id].Event.MouseUp.Name = "onClientGUIMouseUp"
	ScrollBars[id].Event.MouseUp.Function = function()

		ScrollBars[id].LocalPosition.X, ScrollBars[id].LocalPosition.Y = ScrollBars[id].PhysicalPosition.X, ScrollBars[id].PhysicalPosition.Y
		
		if ScrollBars[id].Canvas:getEnabled() then
			if ScrollBars[id].Entered then
				ScrollBars[id].Edges:setColor("FF"..ScrollBars[id].ColorScheme.LightMain)
				ScrollBars[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", ScrollBars[id].ColorScheme.LightMain, ScrollBars[id].ColorScheme.LightMain, ScrollBars[id].ColorScheme.Main, ScrollBars[id].ColorScheme.Main))
			else
			
				TopCol, BotCol, EdgesCol = "F6F6F6", "EAEAEA", "BBBBBB"
				if ScrollBars[id].ColorScheme.DarkTheme then TopCol, BotCol, EdgesCol = "555555", "444444", "3F3F3F" end

				edgcol = "FF"..EdgesCol
				btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
			
				ScrollBars[id].Edges:setColor(edgcol)
				ScrollBars[id].Entrail:setProperty("ImageColours", btncol)

			end
		end
		ScrollBars[id].ScrollEnabled = false
		BackForMouse:setVisible(BFMState)
	end


	ScrollBars[id].Event.CursorMove = {}
	ScrollBars[id].Event.CursorMove.Name = "onClientCursorMove"
	ScrollBars[id].Event.CursorMove.Function = function(_, _, x, y)

		if ScrollBars[id].ScrollEnabled then
				
			local difX = ScrollBars[id].LocalPosition.DX-x
			local difY = ScrollBars[id].LocalPosition.DY-y
			local sx, sy = ScrollBars[id].LocalPosition.X, ScrollBars[id].LocalPosition.Y
			local ax, ay = sx, sy
			local slen = ScrollBars[id].ScrollLength

			local swidth, sheight = ScrollBars[id].Main:getSize(false)
			if not ScrollBars[id].IsVertical then
				sx = sx-difX
				ax = sx

				if sx < 0 then sx = 0 end
				if sx > swidth-slen then sx = swidth-slen end

				ScrollBars[id].Scroll = 100*(sx/(swidth-slen))
			else
				sy = sy-difY
				ay = sy

				if sy < 0 then sy = 0 end
				if sy > sheight-slen then sy = sheight-slen end

				ScrollBars[id].Scroll = 100*(sy/(sheight-slen))
			end

			ScrollBars[id].LocalPosition.X = ax
			ScrollBars[id].LocalPosition.DX = x
			ScrollBars[id].PhysicalPosition.X = sx

			ScrollBars[id].LocalPosition.Y = ay
			ScrollBars[id].LocalPosition.DY = y
			ScrollBars[id].PhysicalPosition.Y = sy

			ScrollBars[id].Edges:setPosition(sx, sy, false)

			triggerEvent("onCustomScrollBarScrolled", ScrollBars[id].Canvas, ScrollBars[id].Scroll)
			triggerEvent("onClientGUIScroll", ScrollBars[id].Canvas, ScrollBars[id])

		end
	end

	ScrollBars[id].Event.MouseWheel = {}
	ScrollBars[id].Event.MouseWheel.Name = "onClientMouseWheel"
	ScrollBars[id].Event.MouseWheel.Function = function(upper)

		if source == ScrollBars[id].Edges or source == ScrollBars[id].Main then

			local x = 1
			if ScrollBars[id].IsVertical then
				x = -1
			end

			csbSetScrollPosition(ScrollBars[id], ScrollBars[id].Scroll + x*upper*ScrollBars[id].ScrollSpeed)
			triggerEvent("onCustomScrollBarScrolled", ScrollBars[id].Canvas, ScrollBars[id].Scroll)
			triggerEvent("onClientGUIScroll", ScrollBars[id].Canvas, ScrollBars[id])

		end
	end

	addEventHandler(ScrollBars[id].Event.MouseEnter.Name, root, ScrollBars[id].Event.MouseEnter.Function)
	addEventHandler(ScrollBars[id].Event.MouseLeave.Name, root, ScrollBars[id].Event.MouseLeave.Function)
	addEventHandler(ScrollBars[id].Event.MouseDown.Name, root, ScrollBars[id].Event.MouseDown.Function)
	addEventHandler(ScrollBars[id].Event.MouseUp.Name, root, ScrollBars[id].Event.MouseUp.Function)
	addEventHandler(ScrollBars[id].Event.CursorMove.Name, root, ScrollBars[id].Event.CursorMove.Function)
	addEventHandler(ScrollBars[id].Event.MouseWheel.Name, root, ScrollBars[id].Event.MouseWheel.Function)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending
	return ScrollBars[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions

function csbSetScrollPosition(scroll, pos)

	if pos < 0 then pos = 0 end
	if pos > 100 then pos = 100 end

	scroll.Scroll = pos

	local swidth, sheight = scroll.Main:getSize(false)
	local slen = scroll.ScrollLength

	if not scroll.IsVertical then
		scroll.Edges:setPosition(pos * (swidth-slen) / 100, 0, false)
	else
		scroll.Edges:setPosition(0, pos * (sheight-slen) / 100, false)
	end

	triggerEvent("onCustomScrollBarScrolled", scroll.Canvas, scroll.Scroll)
	triggerEvent("onClientGUIScroll", scroll.Canvas, scroll)

end

function csbSetScrollSpeed(scroll, speed)

	if speed < -100 then speed = -100 end
	if speed > 100 then speed = 100 end

	scroll.ScrollSpeed = speed

end

function csbSetScrollLength(scroll, len)
	local w, h = scroll.Main:getSize(false)
	if len < 5 then len = 5 end

	if not scroll.IsVertical then

		if len >= w then len = w end

		scroll.ScrollLength = len

		scroll.Edges:setPosition(scroll.Scroll * (w-len) / 100, 0, false)
		scroll.Edges:setSize(len, h, false)
		scroll.Entrail:setSize(len-2, h, false)
	else

		if len >= h then len = h end
		scroll.ScrollLength = len

		scroll.Edges:setPosition(0, scroll.Scroll * (h-len) / 100, false)
		scroll.Edges:setSize(w, len, false)
		scroll.Entrail:setSize(w, len-2, false)
	end
end

function csbSetPosition(scroll, x, y, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = scroll.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	scroll.Canvas:setPosition(x, y, false)
end

function csbSetSize(scroll, w, h, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = scroll.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	scroll.Canvas:setSize(w+2, h+2, false)
	scroll.Vertical:setSize(w, h+2, false)
	scroll.Horizontal:setSize(w+2, h, false)
	scroll.Main:setSize(w, h, false)
	local slen = scroll.ScrollLength

	if (w<h) ~= scroll.IsVertical then

		local sw, sh = slen, h
		local xw, xh = slen-2, h
		local sx, sy = 1, 0

		if w < h then
			sw, sh = w, slen
			xw, xh = w, slen-2
			sx, sy = 0, 1
		end

		scroll.Edges:setSize(sw, sh, false)
		scroll.Entrail:setSize(xw, xh, false)
		scroll.Entrail:setPosition(sx, sy, false)

	end

	scroll.IsVertical = w<h
	csbSetScrollLength(scroll, slen)

end

function csbSetVisible(scroll, bool)
	return scroll.Canvas:setVisible(scroll)
end

function csbSetEnabled(scroll, bool)
	scroll.Canvas:setEnabled(bool)
	
	TopCol, BotCol, BackCol, EdgesCol, MainCol = "F6F6F6", "EAEAEA", "AAAAAA", "BBBBBB", "E7E7E7"
	if scroll.ColorScheme.DarkTheme then TopCol, BotCol, BackCol, EdgesCol, MainCol = "555555", "444444", "333333", "3F3F3F", "3A3A3A" end
	
	bckcol = "FF"..BackCol
	maicol = "FF"..MainCol
	edgcol = "FF"..EdgesCol
	btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)

	scroll.Vertical:setColor(bckcol)
	scroll.Horizontal:setColor(bckcol)

	if bool then

		scroll.Main:setColor(maicol)
		scroll.Edges:setColor(edgcol)
		scroll.Entrail:setProperty("ImageColours", btncol)

	else

		TopCol, BotCol, EdgesCol, MainCol = "CCCCCC", "BBBBBB", "999999", "B7B7B7"
		if scroll.ColorScheme.DarkTheme then TopCol, BotCol, EdgesCol, MainCol = "3A3A3A", "333333", "222222", "2F2F2F" end

		maicol = "FF"..MainCol
		edgcol = "FF"..EdgesCol
		btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)

		scroll.Main:setColor(maicol)
		scroll.Edges:setColor(edgcol)
		scroll.Entrail:setProperty("ImageColours", btncol)

	end
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function csbBringToFront(scroll)
	return scroll.Canvas:bringToFront()
end

function csbMoveToBack(scroll)
	return scroll.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function csbGetPosition(scroll, rel)

	local x, y = scroll.Canvas:getPosition(false)
	if rel then

		local sw, sh = Width, Height
		local parent = scroll.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end
		

		return (x+1)/sw, (y+1)/sh
	
	else

		return x+1, y+1
	end
end

function csbGetSize(scroll, rel)
	
	local w, h = scroll.Canvas:getSize(false)
	if rel then

		local sw, sh = Width, Height
		local parent = scroll.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		return (w-2)/sw, (h-2)/sh
	
	else

		return w-2, h-2
	end

end

function csbGetRealSize(scroll, rel)
	
	return scroll.Canvas:getSize(rel)
end

function csbGetScrollPosition(scroll)
	return scroll.Scroll
end

function csbGetScrollLength(scroll)
	return scroll.ScrollLength
end

function csbGetEnabled(scroll)
	return scroll.Canvas:getEnabled()
end

function csbGetVisible(scroll)
	return scroll.Canvas:getVisible()
end

function csbGetScrollSpeed(scroll)
	return scroll.ScrollSpeed
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme Functions

function csbSetColorScheme(sbar, scheme)

	sbar.ColorScheme = scheme

	csbSetEnabled(sbar, csbGetEnabled(sbar))

end

function csbGetColorScheme(sbar)
	return sbar.ColorScheme
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function csbAddEvent(sbar, event, func)

	local f = function(...)
		if source == sbar.Main or source == sbar.Edges or source == sbar.Canvas then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end

function csbDestroy(sbar)

	for _, v in pairs(sbar.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	destroyElement(sbar.Canvas)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP Functions
CustomScrollBar = {}
CustomScrollBar.__index = CustomScrollBar
CustomScrollBar.ClassName = "CustomScrollBar"


function CustomScrollBar.create(...)
	local self = setmetatable(guiCreateCustomScrollBar(...), CustomScrollBar)
	compareAppend(self, ...)

	return self

end

function CustomScrollBar.setScrollPosition(self, ...) return csbSetScrollPosition(self, ...) end
function CustomScrollBar.setScrollLength(self, ...) return csbSetScrollLength(self, ...) end
function CustomScrollBar.setPosition(self, ...) return csbSetPosition(self, ...) end
function CustomScrollBar.setSize(self, ...) return csbSetSize(self, ...) end
function CustomScrollBar.setVisible(self, ...) return csbSetVisible(self, ...) end
function CustomScrollBar.setEnabled(self, ...) return csbSetEnabled(self, ...) end
function CustomScrollBar.setScrollSpeed(self, ...) return csbSetScrollSpeed(self, ...) end

function CustomScrollBar.bringToFront(self) return csbBringToFront(self) end
function CustomScrollBar.moveToBack(self) return csbMoveToBack(self) end

function CustomScrollBar.getScrollPosition(self, ...) return csbGetScrollPosition(self, ...) end
function CustomScrollBar.getScrollLength(self, ...) return csbGetScrollLength(self, ...) end
function CustomScrollBar.getPosition(self, ...) return csbGetPosition(self, ...) end
function CustomScrollBar.getSize(self, ...) return csbGetSize(self, ...) end
function CustomScrollBar.getRealSize(self, ...) return csbGetRealSize(self, ...) end
function CustomScrollBar.getVisible(self, ...) return csbGetVisible(self, ...) end
function CustomScrollBar.getEnabled(self, ...) return csbGetEnabled(self, ...) end
function CustomScrollBar.getScrollSpeed(self, ...) return csbGetScrollSpeed(self, ...) end

function CustomScrollBar.setColorScheme(self, ...) return csbSetColorScheme(self, ...) end
function CustomScrollBar.getColorScheme(self, ...) return csbGetColorScheme(self, ...) end

function CustomScrollBar.addEvent(self, ...) return csbAddEvent(self, ...) end
function CustomScrollBar.removeEvent(self, ...) return cwRemoveEvent(self, ...) end

function CustomScrollBar.destroy(self, ...) return csbDestroy(self, ...) end


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------EditMemoNumberBoxes----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
local EditBoxes = {}

function guiCreateCustomEdit(x, y, w, h, text, relative, parent, objtype)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates

	local id = #EditBoxes+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main

	EditBoxes[id] = {}
	EditBoxes[id].ColorScheme = DefaultColors
	EditBoxes[id].IsOnSideBlock = false
	EditBoxes[id].ColorSide = false

	EditBoxes[id].Canvas = GuiStaticImage.create(x, y, w, h, pane, false, parent)

	if oldparent and oldparent.ColorScheme ~= nil then
		EditBoxes[id].ColorScheme = oldparent.ColorScheme
	end

	if objtype == "memo" then
		EditBoxes[id].TextBox = GuiMemo.create(0, 0, w, h, text, false, EditBoxes[id].Canvas)
	else
		EditBoxes[id].TextBox = GuiEdit.create(0, 0, w, h, text, false, EditBoxes[id].Canvas)
	end

	EditBoxes[id].Sides = {}
	EditBoxes[id].Sides.Left = GuiStaticImage.create(0, 0, 3, h, pane, false, EditBoxes[id].TextBox)
	EditBoxes[id].Sides.Right = GuiStaticImage.create(w-3, 0, 3, h, pane, false, EditBoxes[id].TextBox)
	EditBoxes[id].Sides.Top = GuiStaticImage.create(0, 0, w, 5, pane, false, EditBoxes[id].TextBox)
	EditBoxes[id].Sides.Bottom = GuiStaticImage.create(0, h-3, w, 3, pane, false, EditBoxes[id].TextBox)

	EditBoxes[id].Edges = {}
	EditBoxes[id].Edges.Left = GuiStaticImage.create(2, 5, 1, h-8, pane, false, EditBoxes[id].Sides.Left)
	EditBoxes[id].Edges.Right = GuiStaticImage.create(0, 5, 1, h-8, pane, false, EditBoxes[id].Sides.Right)
	EditBoxes[id].Edges.Top = GuiStaticImage.create(3, 4, w-6, 1, pane, false, EditBoxes[id].Sides.Top)
	EditBoxes[id].Edges.Bottom = GuiStaticImage.create(3, 0, w-6, 1, pane, false, EditBoxes[id].Sides.Bottom)

	EditBoxes[id].Edge = GuiStaticImage.create(w-52, 5, 49, h-8, pane, false, EditBoxes[id].Canvas)

	EditBoxes[id].Up = GuiStaticImage.create(23, (h-8)/2 - 12.5, 23, 25, Images.Next, false, EditBoxes[id].Edge)
	EditBoxes[id].Down = GuiStaticImage.create(0, (h-8)/2 - 12.5, 23, 25, Images.Prev, false, EditBoxes[id].Edge)

	if objtype == "number" then
		EditBoxes[id].Edges.TopContinue = GuiStaticImage.create(w-52, 4, 51, 1, pane, false, EditBoxes[id].Canvas)
		EditBoxes[id].Edges.BottomContinue = GuiStaticImage.create(w-52, h-3, 51, 1, pane, false, EditBoxes[id].Canvas)
		EditBoxes[id].Edges.RightContinue = GuiStaticImage.create(w-1, 5, 1, h-8, pane, false, EditBoxes[id].Canvas)
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	WinColor, EdgeCol, TextCol = "EEEEEE", "CCCCCC", "444444"
	if EditBoxes[id].ColorScheme.DarkTheme then WinColor, EdgeCol, TextCol = "444444", "333333", "EEEEEE" end

	frmcol = "FF"..WinColor
	edgcol = "FF"..EdgeCol
	txtcol = "FF"..TextCol


	EditBoxes[id].Canvas:setColor(frmcol)
	EditBoxes[id].Edge:setColor("0")

	for _, v in pairs(EditBoxes[id].Sides) do
		v:setColor(frmcol)
		v:setEnabled(false)
	end

	for _, v in pairs(EditBoxes[id].Edges) do
		v:setColor(edgcol)
		v:setEnabled(false)
	end

	EditBoxes[id].TextBox:setFont(GuiFont.create(Fonts.OpenSansRegular, 8))
	EditBoxes[id].TextBox:setProperty("ActiveSelectionColour", "FF"..EditBoxes[id].ColorScheme.Main)
	EditBoxes[id].TextBox:setProperty("NormalTextColour", "FF444444")
	EditBoxes[id].TextBox:setProperty("SelectedTextColour", "FFEEEEEE")
	EditBoxes[id].TextBox:setProperty("ReadOnlyBGColour", "FFFFFFFF")
	EditBoxes[id].TextBox:setProperty("ForceVertScrollbar", "True")


	EditBoxes[id].Up:setColor(txtcol)
	EditBoxes[id].Down:setColor(txtcol)

	EditBoxes[id].Edge:setEnabled(objtype == "number")
	EditBoxes[id].Edge:setVisible(objtype == "number")
	EditBoxes[id].IsNumeric = (objtype == "number")

	if objtype == "number" then
		EditBoxes[id].Edges.Top:setSize(w-55, 1, false)
		EditBoxes[id].Edges.Bottom:setSize(w-52, 1, false)
		EditBoxes[id].TextBox:setSize(w-52, h, false)
		EditBoxes[id].Sides.Right:setPosition(w-55, 0, false)
	end

	EditBoxes[id].Minimal = 0
	EditBoxes[id].Maximal = 100
	EditBoxes[id].Current = 0
	EditBoxes[id].ScrollSpeed = 1
	EditBoxes[id].IsMouseDowned = false

	EditBoxes[id].Type = objtype or "edit"
	EditBoxes[id].Timer = nil

	EditBoxes[id].IsReadOnly = false
	EditBoxes[id].Enabled = true

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	EditBoxes[id].Event = {}


	local move_speed = 1
	local move_count = 0

	local BFMState = BackForMouse:getVisible()

	EditBoxes[id].Event.MouseEnter = {}
	EditBoxes[id].Event.MouseEnter.Name = "onClientMouseEnter"
	EditBoxes[id].Event.MouseEnter.Function = function()
		if source == EditBoxes[id].Up or source == EditBoxes[id].Down then

			source:setColor("FF"..EditBoxes[id].ColorScheme.Main)
			
			BFMState = BackForMouse:getVisible()
			BackForMouse:setVisible(false)

		end

	end


	EditBoxes[id].Event.MouseLeave = {}
	EditBoxes[id].Event.MouseLeave.Name = "onClientMouseLeave"
	EditBoxes[id].Event.MouseLeave.Function = function()
		if EditBoxes[id].Edge:getEnabled() then

			TextCol = "444444"
			if EditBoxes[id].ColorScheme.DarkTheme then TextCol = "EEEEEE" end

			txtcol = "FF"..TextCol
	
			EditBoxes[id].Up:setColor(txtcol)
			EditBoxes[id].Down:setColor(txtcol)

			BackForMouse:setVisible(BFMState)
		end
	end



	EditBoxes[id].Event.MouseUp = {}
	EditBoxes[id].Event.MouseUp.Name = "onClientGUIMouseUp"
	EditBoxes[id].Event.MouseUp.Function = function()
		EditBoxes[id].IsMouseDowned = false
	end


	local function click(positive)
		if positive then
			
			if EditBoxes[id].Current+EditBoxes[id].ScrollSpeed <= EditBoxes[id].Maximal then
				EditBoxes[id].Current = EditBoxes[id].Current+EditBoxes[id].ScrollSpeed*move_speed
			else
				EditBoxes[id].Current = EditBoxes[id].Maximal
			end

			EditBoxes[id].TextBox:setText(EditBoxes[id].Current.."")
		
		else

			if EditBoxes[id].Current-EditBoxes[id].ScrollSpeed >= EditBoxes[id].Minimal then
				EditBoxes[id].Current = EditBoxes[id].Current-EditBoxes[id].ScrollSpeed*move_speed
			else
				EditBoxes[id].Current = EditBoxes[id].Minimal
			end

			EditBoxes[id].TextBox:setText(EditBoxes[id].Current.."")
		end
	end


	EditBoxes[id].Event.Click = {}
	EditBoxes[id].Event.Click.Name = "onClientGUIClick"
	EditBoxes[id].Event.Click.Function = function()

		if source == EditBoxes[id].Up then

			if isTimer(EditBoxes[id].Timer) then killTimer(EditBoxes[id].Timer) end
			EditBoxes[id].IsMouseDowned = false
			click(true)

		elseif source == EditBoxes[id].Down then

			if isTimer(EditBoxes[id].Timer) then killTimer(EditBoxes[id].Timer) end
			EditBoxes[id].IsMouseDowned = false
			click(false)
		end
	end

	EditBoxes[id].Event.MouseDown = {}
	EditBoxes[id].Event.MouseDown.Name = "onClientGUIMouseDown"
	EditBoxes[id].Event.MouseDown.Function = function()
	
		move_count = 0
		move_speed = 1

		if source == EditBoxes[id].Up then
			EditBoxes[id].IsMouseDowned = true
		
			EditBoxes[id].Timer = setTimer(function()

				move_count = move_count+1

				if move_count/5 == math.floor(move_count/5) then
					move_speed = move_speed+2
				end				
				
				if EditBoxes[id].IsMouseDowned then
					click(true)
				else
					if isTimer(EditBoxes[id].Timer) then killTimer(EditBoxes[id].Timer) end
				end

			end, 80, 0)

		elseif source == EditBoxes[id].Down then
			
			move_count = 0
			move_speed = 1
			EditBoxes[id].IsMouseDowned = true

			EditBoxes[id].Timer = setTimer(function()
				
				move_count = move_count+1

				if move_count/5 == math.floor(move_count/5) then
					move_speed = move_speed+2
				end
				
				if EditBoxes[id].IsMouseDowned then
					click(false)
				else
					killTimer(EditBoxes[id].Timer)
				end

			end, 80, 0)

		end
	end

	EditBoxes[id].Event.Changed = {}
	EditBoxes[id].Event.Changed.Name = "onClientGUIChanged"
	EditBoxes[id].Event.Changed.Function = function()

		if EditBoxes[id].Type == "number" then
			local text = EditBoxes[id].TextBox:getText() or ""

			if text == "" then
				text = tostring(EditBoxes[id].Minimal)
			elseif not tonumber(text) then
				text = tostring(EditBoxes[id].Current)
			end

			if tonumber(text) > EditBoxes[id].Maximal then
				text = tostring(EditBoxes[id].Maximal)
			elseif tonumber(text) < EditBoxes[id].Minimal then
				text = tostring(EditBoxes[id].Minimal)
			end
			EditBoxes[id].TextBox:setText(text)
			EditBoxes[id].Current = tonumber(text)
		end
	end


	EditBoxes[id].Event.MouseWheel = {}
	EditBoxes[id].Event.MouseWheel.Name = "onClientMouseWheel"
	EditBoxes[id].Event.MouseWheel.Function = function(upper)

		if source == EditBoxes[id].TextBox or source == EditBoxes[id].Up or source == EditBoxes[id].Down or source == EditBoxes[id].Edge then

			move_count = 0
			move_speed = 1
			if EditBoxes[id].Edge:getEnabled() then
				click(upper > 0)
			end

		end
	end

	EditBoxes[id].Event.Focus = {}
	EditBoxes[id].Event.Focus.Name = "onClientGUIFocus"
	EditBoxes[id].Event.Focus.Function = function()
		if source == EditBoxes[id].TextBox then
			BFMState = BackForMouse:getVisible()
			BackForMouse:setVisible(false)
		end
	end

	EditBoxes[id].Event.Blur = {}
	EditBoxes[id].Event.Blur.Name = "onClientGUIBlur"
	EditBoxes[id].Event.Blur.Function = function()
		if source == EditBoxes[id].TextBox then
			BackForMouse:setVisible(BFMState)
		end
	end


	addEventHandler(EditBoxes[id].Event.MouseEnter.Name, root, EditBoxes[id].Event.MouseEnter.Function)
	addEventHandler(EditBoxes[id].Event.MouseLeave.Name, root, EditBoxes[id].Event.MouseLeave.Function)
	addEventHandler(EditBoxes[id].Event.MouseUp.Name, root, EditBoxes[id].Event.MouseUp.Function)
	addEventHandler(EditBoxes[id].Event.Click.Name, root, EditBoxes[id].Event.Click.Function)
	addEventHandler(EditBoxes[id].Event.MouseDown.Name, root, EditBoxes[id].Event.MouseDown.Function)
	addEventHandler(EditBoxes[id].Event.MouseWheel.Name, root, EditBoxes[id].Event.MouseWheel.Function)
	addEventHandler(EditBoxes[id].Event.Changed.Name, EditBoxes[id].TextBox, EditBoxes[id].Event.Changed.Function, false)
	addEventHandler(EditBoxes[id].Event.Focus.Name, root, EditBoxes[id].Event.Focus.Function)
	addEventHandler(EditBoxes[id].Event.Blur.Name, root, EditBoxes[id].Event.Blur.Function)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending
	return EditBoxes[id]

end

function guiCreateCustomMemo(x, y, w, h, text, relative, parent)
	return guiCreateCustomEdit(x, y, w, h, text, relative, parent, "memo")
end

function guiCreateCustomSpinner(x, y, w, h, relative, parent)
	return guiCreateCustomEdit(x, y, w, h, "0", relative, parent, "number")
end


----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions
function ctbSetSize(textbox, w, h, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = textbox.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = w*sh

	end

	textbox.Canvas:setSize(w, h, false)
	textbox.TextBox:setSize(w, h, false)

	textbox.Sides.Top:setSize(w, 5, false)
	textbox.Sides.Bottom:setSize(w, 3, false)
	textbox.Sides.Bottom:setPosition(0, h-3, false)

	textbox.Sides.Left:setSize(3, h, false)
	textbox.Sides.Right:setSize(3, h, false)
	textbox.Sides.Right:setPosition(w-3, 0, false)

	textbox.Edges.Top:setSize(w-6, 1, false)
	textbox.Edges.Bottom:setSize(w-6, 1, false)

	textbox.Edges.Left:setSize(1, h-8, false)
	textbox.Edges.Right:setSize(1, h-8, false)

	textbox.Edge:setPosition(w-52, 5, false)
	textbox.Edge:setSize(49, h-8, false)

	textbox.Up:setPosition(23, (h-8)/2 - 12.5, false)
	textbox.Down:setPosition(0, (h-8)/2 - 12.5, false)

	if textbox.Type == "number" then
		textbox.Edges.Top:setSize(w-55, 1, false)
		textbox.Edges.Bottom:setSize(w-55, 1, false)
		textbox.TextBox:setSize(w-52, h, false)
		textbox.Sides.Right:setPosition(w-55, 0, false)
		textbox.Edges.TopContinue:setPosition(w-52, 4, false)
		textbox.Edges.BottomContinue:setPosition(w-52, h-3, false)
		textbox.Edges.RightContinue:setPosition(w-1, 5, false)
		textbox.Edges.RightContinue:setSize(1, h-8, false)
	end

end

function ctbSetPosition(textbox, x, y, rel)
	textbox.Canvas:setPosition(x, y, rel or false)
end

function ctbSetVisible(textbox, boolean)
	return textbox.Canvas:setVisible(boolean)
end

function ctbSetReadOnly(textbox, boolean)

	if textbox.Enabled then

		if boolean then

			bgcolor = "FFEEEEEE"
			if textbox.ColorScheme.DarkTheme then bgcolor = "FF555555" end

			textcol = "FF666666"
			if textbox.ColorScheme.DarkTheme then textcol = "FFAAAAAA" end

			textbox.Up:setColor(textcol)
			textbox.Down:setColor(textcol)
			
			if textbox.Type == "number" then
				textbox.Edge:setEnabled(false)
			end

			textbox.TextBox:setProperty("NormalTextColour", "FF"..textbox.ColorScheme.Main)
			textbox.TextBox:setProperty("ReadOnlyBGColour", bgcolor)

			textbox.TextBox:setProperty("ReadOnly", "True")

		else

			TextCol = "444444"
			if textbox.ColorScheme.DarkTheme then TextCol = "EEEEEE" end

			txtcol = "FF"..TextCol

			textbox.TextBox:setProperty("NormalTextColour", "FF444444")
			textbox.TextBox:setProperty("ReadOnlyBGColour", "FFFFFFFF")

			textbox.Up:setColor(txtcol)
			textbox.Down:setColor(txtcol)
			
			if textbox.Type == "number" then
				textbox.Edge:setEnabled(true)
			end

			textbox.TextBox:setProperty("ReadOnly", "False")

		end

	end

	textbox.IsReadOnly = boolean

end

function ctbSetEnabled(textbox, boolean)
	
	if not boolean then

		bgcolor = "FFF7F7F7"
		if textbox.ColorScheme.DarkTheme then bgcolor = "FF444444" end

		textcol = "FF666666"
		if textbox.ColorScheme.DarkTheme then textcol = "FFAAAAAA" end

		textbox.Up:setColor(textcol)
		textbox.Down:setColor(textcol)

		if textbox.Type == "number" then
			textbox.Edge:setEnabled(false)
		end

		textbox.TextBox:setProperty("NormalTextColour", textcol)
		textbox.TextBox:setProperty("ReadOnlyBGColour", bgcolor)

		textbox.TextBox:setEnabled(false)

	else

		TextCol = "444444"
		if textbox.ColorScheme.DarkTheme then TextCol = "EEEEEE" end

		txtcol = "FF"..TextCol

		textbox.TextBox:setProperty("NormalTextColour", "FF444444")
		textbox.TextBox:setProperty("ReadOnlyBGColour", "FFFFFFFF")

		textbox.Up:setColor(txtcol)
		textbox.Down:setColor(txtcol)
		
		if textbox.Type == "number" then
			textbox.Edge:setEnabled(true)
		end
		
		textbox.TextBox:setEnabled(true)

	end

	textbox.Enabled = boolean

	if textbox.IsReadOnly and textbox.Enabled then
		ctbSetReadOnly(textbox, true)
	end
end

function ctbSetMaxLength(textbox, len)
	return textbox.TextBox:setProperty("MaxTextLength", len)
end

function ctbSetText(textbox, text)
	if textbox.Type == "number" then
		if not tonumber(text) or tonumber(text) < textbox.Minimal then
			text = tostring(textbox.Minimal)
		elseif tonumber(text) > textbox.Maximal then
			text = tostring(textbox.Maximal)
		end
		text = tostring(text)
	end
	return textbox.TextBox:setText(text)
end

function ctbSetCaretIndex(textbox, index)
	return textbox.TextBox:setCaretIndex(index)
end

function ctbSetMasked(textbox, boolean)
	return textbox.TextBox:setMasked(boolean)
end

function ctbSetMinimal(textbox, minimal)
	
	if textbox.Maximal < textbox.Minimal then
		maximal = minimal
		minimal = textbox.Maximal
		textbox.Minimal = maximal
	end

	textbox.Minimal = minimal

	if tonumber(textbox.TextBox:getText()) < textbox.Minimal then
		textbox.TextBox:setText(minimal)
	end
end

function ctbSetMaximal(textbox, maximal)

	if textbox.Maximal < textbox.Minimal then
		minimal = maximal
		maximal = textbox.Minimal
		textbox.Minimal = minimal
	end

	textbox.Maximal = maximal

	if tonumber(textbox.TextBox:getText()) > textbox.Maximal then
		textbox.TextBox:setText(maximal)
	end
end

function ctbSetScrollStep(textbox, stepsize)
	if not stepsize or stepsize <= 0 then
		stepsize = 1
	end
	textbox.ScrollSpeed = stepsize
end

function ctbSetFont(textbox, font, size)

	if not size or not tonumber(size) then size = 8 end

	textbox.TextBox:setFont(GuiFont.create(font, size))
end

function ctbPutOnSide(textbox, bool)

	textbox.IsOnSideBlock = bool

	scheme = textbox.ColorScheme

	WinColor = "EEEEEE"
	if scheme.DarkTheme then WinColor = "444444" end

	frmcol = "FF"..WinColor
	sbmcol = "FF"..scheme.SubMain

	for _, v in pairs(textbox.Sides) do
		
		v:setColor(textbox.IsOnSideBlock and sbmcol or frmcol)
		v:setEnabled(false)
	end
	
	textbox.Canvas:setColor(textbox.IsOnSideBlock and sbmcol or frmcol)

end

function ctbSetSidesColor(textbox, color)

	textbox.ColorSide = tostring(color)

	if textbox.ColorSide:len() ~= 6 or tonumber(textbox.ColorSide, 16) == nil then
		textbox.ColorSide = false
	end

	if textbox.ColorSide ~= false then
		for _, v in pairs(textbox.Sides) do
			
			v:setColor("FF"..textbox.ColorSide)
			v:setEnabled(false)
		end

		textbox.Canvas:setColor("FF"..textbox.ColorSide)

	else
		textbox:putOnSide(textbox:isOnSide())
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function ctbBringToFront(textbox)
	return textbox.Canvas:bringToFront()
end

function ctbMoveToBack(textbox)
	return textbox.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get Functions

function ctbGetSize(textbox, rel)
	return textbox.Canvas:getSize(rel or false)
end

function ctbGetPosition(textbox, rel)
	return textbox.Canvas:getPosition(rel or false)
end

function ctbGetVisible(textbox)
	return textbox.Canvas:getVisible()
end

function ctbGetEnabled(textbox)
	return textbox.Enabled
end

function ctbGetReadOnly(textbox)
	return textbox.IsReadOnly
end

function ctbGetMaxLength(textbox)
	return textbox.TextBox:getProperty("MaxTextLength")
end

function ctbGetText(textbox)
	return textbox.TextBox:getText()
end

function ctbGetCaretIndex(textbox)
	return textbox.TextBox:getCaretIndex()
end

function ctbGetMasked(textbox)
	return textbox.TextBox:getMasked()
end

function ctbGetMinimal(textbox)
	return textbox.Minimal
end

function ctbGetMaximal(textbox)
	return textbox.Maximal
end

function ctbGetScrollStep(textbox)
	return textbox.ScrollSpeed
end

function ctbIsOnSide(textbox)
	return textbox.IsOnSideBlock
end

function ctbGetSidesColor(textbox)
	return textbox.ColorSide
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme Functions

function ctbSetColorScheme(textbox, scheme)

	textbox.ColorScheme = scheme

	WinColor, EdgeCol, TextCol = "EEEEEE", "CCCCCC", "444444"
	if textbox.ColorScheme.DarkTheme then WinColor, EdgeCol, TextCol = "444444", "333333", "EEEEEE" end

	frmcol = "FF"..WinColor
	sbmcol = "FF"..textbox.ColorScheme.SubMain
	edgcol = "FF"..EdgeCol
	txtcol = "FF"..TextCol

	textbox.Canvas:setColor(frmcol)
	textbox.Up:setColor(txtcol)
	textbox.Down:setColor(txtcol)
	textbox.TextBox:setProperty("ActiveSelectionColour", "FF"..textbox.ColorScheme.Main)

	for _, v in pairs(textbox.Sides) do
		
		v:setColor(textbox.IsOnSideBlock and sbmcol or frmcol)
		v:setEnabled(false)

	end

	for _, v in pairs(textbox.Edges) do
		v:setColor(edgcol)
		v:setEnabled(false)
	end

	ctbSetReadOnly(textbox, ctbGetReadOnly(textbox))
	ctbSetEnabled(textbox, ctbGetEnabled(textbox))


	scheme = textbox.ColorScheme

	WinColor = "EEEEEE"
	if scheme.DarkTheme then WinColor = "444444" end

	frmcol = "FF"..WinColor
	sbmcol = "FF"..scheme.SubMain

	for _, v in pairs(textbox.Sides) do

		v:setColor(textbox.IsOnSideBlock and sbmcol or frmcol)
		v:setEnabled(false)
	end

end

function ctbGetColorScheme(textbox)
	return textbox.ColorScheme
end


----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function ctbAddEvent(textbox, event, func)

	local f = function(...)
		if source == textbox.TextBox or source == textbox.Up or source == textbox.Down or source == textbox.Edges or source == textbox.Canvas then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end

function ctbDestroy(textbox)

	removeEventHandler(textbox.Event.Changed.Name, textbox.TextBox, textbox.Event.Changed.Function)
	for _, v in pairs(textbox.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	destroyElement(textbox.Canvas)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP Functions
CustomEdit = {}
CustomEdit.__index = CustomEdit
CustomEdit.ClassName = "CustomEdit"


function CustomEdit.create(...)
	local self = setmetatable(guiCreateCustomEdit(...), CustomEdit)
	compareAppend(self, ...)

	self.Element = self.TextBox

	return self
end

function CustomEdit.setPosition(self, ...) return ctbSetPosition(self, ...) end
function CustomEdit.setSize(self, ...) return ctbSetSize(self, ...) end
function CustomEdit.setVisible(self, ...) return ctbSetVisible(self, ...) end
function CustomEdit.setEnabled(self, ...) return ctbSetEnabled(self, ...) end
function CustomEdit.setReadOnly(self, ...) return ctbSetReadOnly(self, ...) end
function CustomEdit.setMaxLength(self, ...) return ctbSetMaxLength(self, ...) end
function CustomEdit.setText(self, ...) return ctbSetText(self, ...) end
function CustomEdit.setCaretIndex(self, ...) return ctbSetCaretIndex(self, ...) end
function CustomEdit.setMasked(self, ...) return ctbSetMasked(self, ...) end
function CustomEdit.setSidesColor(self, ...) return ctbSetSidesColor(self, ...) end
function CustomEdit.setFont(self, ...) return ctbSetFont(self, ...) end

function CustomEdit.bringToFront(self) return ctbBringToFront(self) end
function CustomEdit.moveToBack(self) return ctbMoveToBack(self) end

function CustomEdit.getPosition(self, ...) return ctbGetPosition(self, ...) end
function CustomEdit.getSize(self, ...) return ctbGetSize(self, ...) end
function CustomEdit.getRealSize(self, ...) return ctbGetSize(self, ...) end
function CustomEdit.getVisible(self, ...) return ctbGetVisible(self, ...) end
function CustomEdit.getEnabled(self, ...) return ctbGetEnabled(self, ...) end
function CustomEdit.getReadOnly(self, ...) return ctbGetReadOnly(self, ...) end
function CustomEdit.getMaxLength(self, ...) return ctbGetMaxLength(self, ...) end
function CustomEdit.getText(self, ...) return ctbGetText(self, ...) end
function CustomEdit.getCaretIndex(self, ...) return ctbGetCaretIndex(self, ...) end
function CustomEdit.getMasked(self, ...) return ctbGetMasked(self, ...) end
function CustomEdit.getSidesColor(self, ...) return ctbGetSidesColor(self, ...) end

function CustomEdit.setColorScheme(self, ...) return ctbSetColorScheme(self, ...) end
function CustomEdit.getColorScheme(self, ...) return ctbGetColorScheme(self, ...) end

function CustomEdit.addEvent(self, ...) return ctbAddEvent(self, ...) end
function CustomEdit.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomEdit.putOnSide(self, ...) return ctbPutOnSide(self, ...) end
function CustomEdit.isOnSide(self, ...) return ctbIsOnSide(self, ...) end

function CustomEdit.destroy(self, ...) return ctbDestroy(self, ...) end


CustomMemo = {}
CustomMemo.__index = CustomMemo
CustomMemo.ClassName = "CustomMemo"

function CustomMemo.create(...)
	local self = setmetatable(guiCreateCustomMemo(...), CustomMemo)
	compareAppend(self, ...)

	return self
end

function CustomMemo.setPosition(self, ...) return ctbSetPosition(self, ...) end
function CustomMemo.setSize(self, ...) return ctbSetSize(self, ...) end
function CustomMemo.setVisible(self, ...) return ctbSetVisible(self, ...) end
function CustomMemo.setEnabled(self, ...) return ctbSetEnabled(self, ...) end
function CustomMemo.setReadOnly(self, ...) return ctbSetReadOnly(self, ...) end
function CustomMemo.setText(self, ...) return ctbSetText(self, ...) end
function CustomMemo.setCaretIndex(self, ...) return ctbSetCaretIndex(self, ...) end
function CustomMemo.setSidesColor(self, ...) return ctbSetSidesColor(self, ...) end
function CustomMemo.setFont(self, ...) return ctbSetFont(self, ...) end

function CustomMemo.bringToFront(self) return ctbBringToFront(self) end
function CustomMemo.moveToBack(self) return ctbMoveToBack(self) end

function CustomMemo.getPosition(self, ...) return ctbGetPosition(self, ...) end
function CustomMemo.getSize(self, ...) return ctbGetSize(self, ...) end
function CustomMemo.getRealSize(self, ...) return ctbGetSize(self, ...) end
function CustomMemo.getVisible(self, ...) return ctbGetVisible(self, ...) end
function CustomMemo.getEnabled(self, ...) return ctbGetEnabled(self, ...) end
function CustomMemo.getReadOnly(self, ...) return ctbGetReadOnly(self, ...) end
function CustomMemo.getText(self, ...) return ctbGetText(self, ...) end
function CustomMemo.getCaretIndex(self, ...) return ctbGetCaretIndex(self, ...) end
function CustomMemo.getSidesColor(self, ...) return ctbGetSidesColor(self, ...) end

function CustomMemo.setColorScheme(self, ...) return ctbSetColorScheme(self, ...) end
function CustomMemo.getColorScheme(self, ...) return ctbGetColorScheme(self, ...) end

function CustomMemo.addEvent(self, ...) return ctbAddEvent(self, ...) end
function CustomMemo.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomMemo.putOnSide(self, ...) return ctbPutOnSide(self, ...) end
function CustomMemo.isOnSide(self, ...) return ctbIsOnSide(self, ...) end

function CustomMemo.destroy(self, ...) return ctbDestroy(self, ...) end


CustomSpinner = {}
CustomSpinner.__index = CustomSpinner
CustomSpinner.ClassName = "CustomSpinner"

function CustomSpinner.create(...)
	local self = setmetatable(guiCreateCustomSpinner(...), CustomSpinner)
	compareAppend(self, ...)

	return self
end

function CustomSpinner.setPosition(self, ...) return ctbSetPosition(self, ...) end
function CustomSpinner.setSize(self, ...) return ctbSetSize(self, ...) end
function CustomSpinner.setVisible(self, ...) return ctbSetVisible(self, ...) end
function CustomSpinner.setEnabled(self, ...) return ctbSetEnabled(self, ...) end
function CustomSpinner.setReadOnly(self, ...) return ctbSetReadOnly(self, ...) end
function CustomSpinner.setText(self, ...) return ctbSetText(self, ...) end
function CustomSpinner.setCaretIndex(self, ...) return ctbSetCaretIndex(self, ...) end
function CustomSpinner.setSidesColor(self, ...) return ctbSetSidesColor(self, ...) end
function CustomSpinner.setFont(self, ...) return ctbSetFont(self, ...) end

function CustomSpinner.setMinimal(self, ...) return ctbSetMinimal(self, ...) end
function CustomSpinner.setMaximal(self, ...) return ctbSetMaximal(self, ...) end
function CustomSpinner.setStepSize(self, ...) return ctbSetScrollStep(self, ...) end

function CustomSpinner.bringToFront(self) return ctbBringToFront(self) end
function CustomSpinner.moveToBack(self) return ctbMoveToBack(self) end

function CustomSpinner.getPosition(self, ...) return ctbGetPosition(self, ...) end
function CustomSpinner.getSize(self, ...) return ctbGetSize(self, ...) end
function CustomSpinner.getRealSize(self, ...) return ctbGetSize(self, ...) end
function CustomSpinner.getVisible(self, ...) return ctbGetVisible(self, ...) end
function CustomSpinner.getEnabled(self, ...) return ctbGetEnabled(self, ...) end
function CustomSpinner.getReadOnly(self, ...) return ctbGetReadOnly(self, ...) end
function CustomSpinner.getText(self, ...) return ctbGetText(self, ...) end
function CustomSpinner.getCaretIndex(self, ...) return ctbGetCaretIndex(self, ...) end
function CustomSpinner.getSidesColor(self, ...) return ctbGetSidesColor(self, ...) end

function CustomSpinner.getMinimal(self, ...) return ctbGetMinimal(self, ...) end
function CustomSpinner.getMaximal(self, ...) return ctbGetMaximal(self, ...) end
function CustomSpinner.getStepSize(self, ...) return ctbGetScrollStep(self, ...) end

function CustomSpinner.setColorScheme(self, ...) return ctbSetColorScheme(self, ...) end
function CustomSpinner.getColorScheme(self, ...) return ctbGetColorScheme(self, ...) end

function CustomSpinner.addEvent(self, ...) return ctbAddEvent(self, ...) end
function CustomSpinner.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomSpinner.putOnSide(self, ...) return ctbPutOnSide(self, ...) end
function CustomSpinner.isOnSide(self, ...) return ctbIsOnSide(self, ...) end

function CustomSpinner.destroy(self, ...) return ctbDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------CheckBoxes-------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

local CheckBoxes = {}

function guiCreateCustomCheckBox(x, y, w, h, text, rel, parent)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates

	local id = #CheckBoxes+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main

	CheckBoxes[id] = {}
	CheckBoxes[id].ColorScheme = DefaultColors
	CheckBoxes[id].Canvas = GuiStaticImage.create(x, y, w, h, pane, false, parent)
	CheckBoxes[id].Label = CustomLabel.create(0, 0, w-44, h, text, false, CheckBoxes[id].Canvas)

	CheckBoxes[id].Main = GuiStaticImage.create(w-42, (h/2)-10, 40, 20, Images.Check, false, CheckBoxes[id].Canvas)

	CheckBoxes[id].Entrail = GuiStaticImage.create(0, 0, 20, 20, Images.Round, false, CheckBoxes[id].Main)

	if oldparent and oldparent.ColorScheme ~= nil then
		CheckBoxes[id].ColorScheme = oldparent.ColorScheme
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties
	CheckBoxes[id].Canvas:setColor("0")
	CheckBoxes[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CheckBoxes[id].ColorScheme.RedLight, CheckBoxes[id].ColorScheme.RedLight, CheckBoxes[id].ColorScheme.Red, CheckBoxes[id].ColorScheme.Red))

	BackColor = "FFFFFF"
	if CheckBoxes[id].ColorScheme.DarkTheme then BackColor = "666666" end

	TextColor = "555555"
	if CheckBoxes[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	CheckBoxes[id].Main:setColor("FF"..BackColor)

	CheckBoxes[id].Label:setFont(Fonts.OpenSansRegular, 9)
	CheckBoxes[id].Label:setColor(TextColor)
	CheckBoxes[id].Label:setVerticalAlign("center")

	CheckBoxes[id].State = false
	CheckBoxes[id].Moving = false
	CheckBoxes[id].LocalPosition = {X=0, DX=0}
	CheckBoxes[id].PhysicalPosition = {X=0}
	CheckBoxes[id].Animation = 0 -- 1 - open, 2 - close
	CheckBoxes[id].OnTableView = false

	if comparetypes(oldparent, CustomLabel) then
		if oldparent.Cell then
			CheckBoxes[id].OnTableView = true
		end
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	CheckBoxes[id].moveRight = function()
		CheckBoxes[id].State = true
		CheckBoxes[id].Animation = 1
		triggerEvent("onCustomCheckBoxChecked", CheckBoxes[id].Main, CheckBoxes[id].State)
	end
	CheckBoxes[id].moveLeft = function()
		CheckBoxes[id].State = false
		CheckBoxes[id].Animation = 2
		triggerEvent("onCustomCheckBoxChecked", CheckBoxes[id].Main, CheckBoxes[id].State)
	end

	CheckBoxes[id].Event = {}

	CheckBoxes[id].Event.MouseEnter = {}
	CheckBoxes[id].Event.MouseEnter.Name = "onClientMouseEnter"
	CheckBoxes[id].Event.MouseEnter.Function = function()
		if source == CheckBoxes[id].Entrail or source == CheckBoxes[id].Main or source == CheckBoxes[id].Label then
			CheckBoxes[id].Label:setColor(fromHEXToRGB(CheckBoxes[id].ColorScheme.Main))
		end
	end


	CheckBoxes[id].Event.MouseLeave = {}
	CheckBoxes[id].Event.MouseLeave.Name = "onClientMouseLeave"
	CheckBoxes[id].Event.MouseLeave.Function = function()

		if CheckBoxes[id].Canvas:getEnabled() and not CheckBoxes[id].OnTableView then

			TextColor = "555555"
			if CheckBoxes[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 
			
			CheckBoxes[id].Label:setColor(fromHEXToRGB(TextColor))
		end
	end


	CheckBoxes[id].Event.Click = {}
	CheckBoxes[id].Event.Click.Name = "onClientGUIClick"
	CheckBoxes[id].Event.Click.Function = function()

		if source == CheckBoxes[id].Entrail or source == CheckBoxes[id].Main or source == CheckBoxes[id].Label then
			local x = CheckBoxes[id].Entrail:getPosition(false)
			if x >= 15 then CheckBoxes[id].moveLeft()
			else CheckBoxes[id].moveRight() end
		end
	end


	CheckBoxes[id].Event.Render = {}
	CheckBoxes[id].Event.Render.Name = "onClientRender"
	CheckBoxes[id].Event.Render.Function = function()

		if CheckBoxes[id].Animation == 1 then
			local x = CheckBoxes[id].Entrail:getPosition(false)

			x = x+8
			if x > 20 then x = 20 end
			CheckBoxes[id].Entrail:setPosition(x, 0, false)

			CheckBoxes[id].LocalPosition.X = x
			CheckBoxes[id].LocalPosition.DX = x
			CheckBoxes[id].PhysicalPosition.X = x

			local sx = CheckBoxes[id].Entrail:getPosition(false)
			local swidth, sheight, slen = 40, 25, 20
			local max_dif = swidth-slen

			if CheckBoxes[id].Canvas:getEnabled() then
				local r, g, b = fromHEXToRGB(CheckBoxes[id].ColorScheme.RedLight)
				local ar, ag, ab = fromHEXToRGB(CheckBoxes[id].ColorScheme.GreenLight)

				local onePercR = sx*math.abs(r-ar)/max_dif
				if r > ar then r = r-onePercR else r = r+onePercR end

				local onePercG = sx*math.abs(g-ag)/max_dif
				if g > ag then g = g-onePercG else g = g+onePercG end

				local onePercB = sx*math.abs(b-ab)/max_dif
				if b > ab then b = b-onePercB else b = b+onePercB end

				local topCol = fromRGBToHEX(r, g, b)

				r, g, b = fromHEXToRGB(CheckBoxes[id].ColorScheme.Red)
				ar, ag, ab = fromHEXToRGB(CheckBoxes[id].ColorScheme.Green)

				onePercR = sx*math.abs(r-ar)/max_dif
				if r > ar then r = r-onePercR else r = r+onePercR end

				onePercG = sx*math.abs(g-ag)/max_dif
				if g > ag then g = g-onePercG else g = g+onePercG end

				onePercB = sx*math.abs(b-ab)/max_dif
				if b > ab then b = b-onePercB else b = b+onePercB end

				local botCol = fromRGBToHEX(r, g, b)

				CheckBoxes[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", topCol, topCol, botCol, botCol))
			end

			if x == 30 then
				CheckBoxes[id].Animation = 0
			end

		elseif CheckBoxes[id].Animation == 2 then
			
			local x = CheckBoxes[id].Entrail:getPosition(false)

			x = x-8
			if x < 0 then x = 0 end
			CheckBoxes[id].Entrail:setPosition(x, 0, false)

			CheckBoxes[id].LocalPosition.X = x
			CheckBoxes[id].LocalPosition.DX = x
			CheckBoxes[id].PhysicalPosition.X = x

			local sx = CheckBoxes[id].Entrail:getPosition(false)
			local swidth, sheight, slen = 40, 25, 20
			local max_dif = swidth-slen

			if CheckBoxes[id].Canvas:getEnabled() then
				local r, g, b = fromHEXToRGB(CheckBoxes[id].ColorScheme.RedLight)
				local ar, ag, ab = fromHEXToRGB(CheckBoxes[id].ColorScheme.GreenLight)

				local onePercR = sx*math.abs(r-ar)/max_dif
				if r > ar then r = r-onePercR else r = r+onePercR end

				local onePercG = sx*math.abs(g-ag)/max_dif
				if g > ag then g = g-onePercG else g = g+onePercG end

				local onePercB = sx*math.abs(b-ab)/max_dif
				if b > ab then b = b-onePercB else b = b+onePercB end

				local topCol = fromRGBToHEX(r, g, b)

				r, g, b = fromHEXToRGB(CheckBoxes[id].ColorScheme.Red)
				ar, ag, ab = fromHEXToRGB(CheckBoxes[id].ColorScheme.Green)

				onePercR = sx*math.abs(r-ar)/max_dif
				if r > ar then r = r-onePercR else r = r+onePercR end

				onePercG = sx*math.abs(g-ag)/max_dif
				if g > ag then g = g-onePercG else g = g+onePercG end

				onePercB = sx*math.abs(b-ab)/max_dif
				if b > ab then b = b-onePercB else b = b+onePercB end

				local botCol = fromRGBToHEX(r, g, b)

				CheckBoxes[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", topCol, topCol, botCol, botCol))
			end

			if x == 0 then
				CheckBoxes[id].Animation = 0
			end
		end

	end


	local BFMState = BackForMouse:getVisible()

	CheckBoxes[id].Event.MouseDown = {}
	CheckBoxes[id].Event.MouseDown.Name = "onClientGUIMouseDown"
	CheckBoxes[id].Event.MouseDown.Function = function(button, ax, ay)

		if button == "left" and source == CheckBoxes[id].Entrail then

			CheckBoxes[id].LocalPosition.DX = ax 

			CheckBoxes[id].PhysicalPosition.X = CheckBoxes[id].Entrail:getPosition(false)
			CheckBoxes[id].LocalPosition.X = CheckBoxes[id].Entrail:getPosition(false)
			
			CheckBoxes[id].Moving = true
			CheckBoxes[id].Animation = 0

			BFMState = BackForMouse:getVisible()
			BackForMouse:setVisible(true)
		end
	end


	CheckBoxes[id].Event.MouseUp = {}
	CheckBoxes[id].Event.MouseUp.Name = "onClientGUIMouseUp"
	CheckBoxes[id].Event.MouseUp.Function = function()
		
		if CheckBoxes[id].Moving then
			local x = CheckBoxes[id].Entrail:getPosition(false)
			if x <= 15 then CheckBoxes[id].moveLeft()
			else CheckBoxes[id].moveRight() end
		end

		CheckBoxes[id].LocalPosition.X = CheckBoxes[id].PhysicalPosition.X
		CheckBoxes[id].Moving = false

		BackForMouse:setVisible(BFMState)
	end


	CheckBoxes[id].Event.CursorMove = {}
	CheckBoxes[id].Event.CursorMove.Name = "onClientCursorMove"
	CheckBoxes[id].Event.CursorMove.Function = function(_, _, x, y)

		if CheckBoxes[id].Moving then
				
			local difX = CheckBoxes[id].LocalPosition.DX-x
			local sx = CheckBoxes[id].LocalPosition.X
			local ax = sx

			local swidth, sheight, slen = 40, 25, 20
			local max_dif = swidth-slen
			sx = sx-difX
			ax = sx

			if sx < 0 then sx = 0 end
			if sx > max_dif then sx = max_dif end


			if CheckBoxes[id].Canvas:getEnabled() then
				local r, g, b = fromHEXToRGB(CheckBoxes[id].ColorScheme.RedLight)
				local ar, ag, ab = fromHEXToRGB(CheckBoxes[id].ColorScheme.GreenLight)

				local onePercR = sx*math.abs(r-ar)/max_dif
				if r > ar then r = r-onePercR else r = r+onePercR end

				local onePercG = sx*math.abs(g-ag)/max_dif
				if g > ag then g = g-onePercG else g = g+onePercG end

				local onePercB = sx*math.abs(b-ab)/max_dif
				if b > ab then b = b-onePercB else b = b+onePercB end

				local topCol = fromRGBToHEX(r, g, b)

				r, g, b = fromHEXToRGB(CheckBoxes[id].ColorScheme.Red)
				ar, ag, ab = fromHEXToRGB(CheckBoxes[id].ColorScheme.Green)

				onePercR = sx*math.abs(r-ar)/max_dif
				if r > ar then r = r-onePercR else r = r+onePercR end

				onePercG = sx*math.abs(g-ag)/max_dif
				if g > ag then g = g-onePercG else g = g+onePercG end

				onePercB = sx*math.abs(b-ab)/max_dif
				if b > ab then b = b-onePercB else b = b+onePercB end

				local botCol = fromRGBToHEX(r, g, b)

				CheckBoxes[id].Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", topCol, topCol, botCol, botCol))
			end

			CheckBoxes[id].LocalPosition.X = ax
			CheckBoxes[id].LocalPosition.DX = x
			CheckBoxes[id].PhysicalPosition.X = sx

			CheckBoxes[id].Entrail:setPosition(sx, 0, false)

		end
	end

	addEventHandler(CheckBoxes[id].Event.MouseEnter.Name, root, CheckBoxes[id].Event.MouseEnter.Function)
	addEventHandler(CheckBoxes[id].Event.MouseLeave.Name, root, CheckBoxes[id].Event.MouseLeave.Function)
	addEventHandler(CheckBoxes[id].Event.Click.Name, root, CheckBoxes[id].Event.Click.Function)
	addEventHandler(CheckBoxes[id].Event.Render.Name, root, CheckBoxes[id].Event.Render.Function)
	addEventHandler(CheckBoxes[id].Event.MouseDown.Name, root, CheckBoxes[id].Event.MouseDown.Function)
	addEventHandler(CheckBoxes[id].Event.MouseUp.Name, root, CheckBoxes[id].Event.MouseUp.Function)
	addEventHandler(CheckBoxes[id].Event.CursorMove.Name, root, CheckBoxes[id].Event.CursorMove.Function)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending
	return CheckBoxes[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions

function ccbSetText(checkbox, text)
	checkbox.Label:setText(text)
end

function ccbSetPosition(checkbox, x, y, rel)
	checkbox.Canvas:setPosition(x, y, rel or false)
end

function ccbSetSize(checkbox, w, h, rel)
		
	if rel then

		local sw, sh = Width, Height
		local parent = checkbox.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	checkbox.Canvas:setSize(w, h, false)
	checkbox.Label:setSize(w-44, h, false)
	checkbox.Main:setPosition(w-42, (h/2)-10, false)

end

function ccbSetVisible(checkbox, bool)
	checkbox.Canvas:setVisible(bool or false)
end

function ccbSetEnabled(checkbox, bool)
	checkbox.Canvas:setEnabled(bool or false)

	if bool then
		local color = checkbox.State and checkbox.ColorScheme.GreenLight or checkbox.ColorScheme.RedLight
		local color2 = checkbox.State and checkbox.ColorScheme.Green or checkbox.ColorScheme.Red

		BackColor = "FFFFFF"
		if checkbox.ColorScheme.DarkTheme then BackColor = "666666" end
		
		TextColor = "555555"
		if checkbox.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

		checkbox.Entrail:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", color, color, color2, color2))
		checkbox.Main:setColor("FF"..BackColor)
		checkbox.Label:setColor(fromHEXToRGB(TextColor))

	else
		checkbox.Entrail:setProperty("ImageColours", "tl:FFBBBBBB tr:FFBBBBBB bl:FFAAAAAA br:FFAAAAAA")
		checkbox.Main:setColor("FFDDDDDD")
		checkbox.Label:setColor(fromHEXToRGB("999999"))		
	end
end

function ccbSetChecked(checkbox, bool)
	if not bool then checkbox.moveLeft()
	else checkbox.moveRight() end
end
----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function ccbBringToFront(checkbox)
	return checkbox.Canvas:bringToFront()
end

function ccbMoveToBack(checkbox)
	return checkbox.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function ccbGetText(checkbox)
	return checkbox.Label:getText()
end

function ccbGetPosition(checkbox, rel)
	return checkbox.Canvas:getPosition(rel or false)
end

function ccbGetSize(checkbox, rel)
	return checkbox.Canvas:getSize(rel or false)
end

function ccbGetVisible(checkbox)
	return checkbox.Canvas:getVisible()
end

function ccbGetEnabled(checkbox)
	return checkbox.Canvas:getEnabled()
end

function ccbGetChecked(checkbox)
	return checkbox.State
end

function ccbGetFrame(checkbox)
	return checkbox.Label
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme function

function ccbSetColorScheme(checkbox, scheme)

	checkbox.ColorScheme = scheme

	ccbSetEnabled(checkbox, ccbGetEnabled(checkbox))

end

function ccbGetColorScheme(checkbox)
	return checkbox.ColorScheme
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function ccbAddEvent(checkbox, event, func)

	local f = function(...)
		if source == checkbox.Entrail or source == checkbox.Main or source == checkbox.Label or source == checkbox.Canvas then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end


function ccbDestroy(checkbox)

	for _, v in pairs(checkbox.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	checkbox.Label:destroy()
	destroyElement(checkbox.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP functions

CustomCheckBox = {}
CustomCheckBox.__index = CustomCheckBox
CustomCheckBox.ClassName = "CustomCheckBox"

function CustomCheckBox.create(...)
	local self = setmetatable(guiCreateCustomCheckBox(...), CustomCheckBox)
	compareAppend(self, ...)

	self.Element = self.Label

	return self
end

function CustomCheckBox.setText(self, ...) return ccbSetText(self, ...) end
function CustomCheckBox.setPosition(self, ...) return ccbSetPosition(self, ...) end
function CustomCheckBox.setSize(self, ...) return ccbSetSize(self, ...) end
function CustomCheckBox.setVisible(self, ...) return ccbSetVisible(self, ...) end
function CustomCheckBox.setEnabled(self, ...) return ccbSetEnabled(self, ...) end
function CustomCheckBox.setChecked(self, ...) return ccbSetChecked(self, ...) end

function CustomCheckBox.bringToFront(self) return ccbBringToFront(self) end
function CustomCheckBox.moveToBack(self) return ccbMoveToBack(self) end

function CustomCheckBox.getText(self, ...) return ccbGetText(self, ...) end
function CustomCheckBox.getPosition(self, ...) return ccbGetPosition(self, ...) end
function CustomCheckBox.getSize(self, ...) return ccbGetSize(self, ...) end
function CustomCheckBox.getRealSize(self, ...) return ccbGetSize(self, ...) end
function CustomCheckBox.getVisible(self, ...) return ccbGetVisible(self, ...) end
function CustomCheckBox.getEnabled(self, ...) return ccbGetEnabled(self, ...) end
function CustomCheckBox.getChecked(self, ...) return ccbGetChecked(self, ...) end

function CustomCheckBox.setColorScheme(self, ...) return ccbSetColorScheme(self, ...) end
function CustomCheckBox.getColorScheme(self, ...) return ccbGetColorScheme(self, ...) end

function CustomCheckBox.addEvent(self, ...) return ccbAddEvent(self, ...) end
function CustomCheckBox.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomCheckBox.getFrame(self, ...) return ccbGetFrame(self, ...) end

function CustomCheckBox.destroy(self, ...) return ccbDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------ComboBoxes-------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

ComboBoxes = {}
function guiCreateCustomComboBox(x, y, w, h, text, relative, parent)
	
	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #ComboBoxes+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main

	ComboBoxes[id] = {}
	ComboBoxes[id].Canvas = GuiStaticImage.create(x-1, y-1, w+2, h+2, pane, false, parent)
	ComboBoxes[id].ColorScheme = DefaultColors

	if oldparent and oldparent.ColorScheme ~= nil then
		ComboBoxes[id].ColorScheme = oldparent.ColorScheme
	end

	ComboBoxes[id].Vertical = GuiStaticImage.create(1, 0, w, h+2, pane, false, ComboBoxes[id].Canvas)
	ComboBoxes[id].Horizontal = GuiStaticImage.create(0, 1, w+2, h, pane, false, ComboBoxes[id].Canvas)

	ComboBoxes[id].Main = GuiStaticImage.create(1, 1, w, h, pane, false, ComboBoxes[id].Canvas)
	ComboBoxes[id].Label = GuiLabel.create(0, 0, w-25, h-2, text, false, ComboBoxes[id].Main)
	ComboBoxes[id].Arrow = GuiStaticImage.create(w-25, (h/2)-12, 25, 25, Images.Down, false, ComboBoxes[id].Main)

	ComboBoxes[id].List = {}

	ComboBoxes[id].List.Canvas = GuiStaticImage.create(0, 0, w+2, h+2, pane, false)
	ComboBoxes[id].List.Vertical = GuiStaticImage.create(1, 0, w, h+2, pane, false, ComboBoxes[id].List.Canvas)
	ComboBoxes[id].List.Horizontal = GuiStaticImage.create(0, 1, w+2, h, pane, false, ComboBoxes[id].List.Canvas)

	ComboBoxes[id].List.Main = GuiStaticImage.create(1, 1, w, h, pane, false, ComboBoxes[id].List.Canvas)

	--ComboBoxes[id].Entrail = ScrollMenu.create(0, 0, w, h, false, ComboBoxes[id].List.Main)
	ComboBoxes[id].Entrail = CustomScrollPane.create(0, 0, w, h, false, ComboBoxes[id].List.Main)
	
	ComboBoxes[id].List.Items = {}

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	TopCol, BotCol, BackCol = "FFFFFF", "EEEEEE", "CCCCCC"
	if ComboBoxes[id].ColorScheme.DarkTheme then TopCol, BotCol, BackCol = "555555", "444444", "333333" end

	TextColor = "444444"
	if ComboBoxes[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	ButCol = "555555"
	if ComboBoxes[id].ColorScheme.DarkTheme then ButCol = "EEEEEE" end 

	LMainCol = "F7F7F7"
	if ComboBoxes[id].ColorScheme.DarkTheme then LMainCol = "505050" end 

	btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
	fbtcol = "FF"..BackCol
	arrcol = "FF"..ButCol
	lmncol = "FF"..LMainCol

	ComboBoxes[id].Canvas:setColor("0")
	ComboBoxes[id].List.Canvas:setColor("0")

	ComboBoxes[id].Main:setProperty("ImageColours", btncol)
	ComboBoxes[id].List.Main:setColor(lmncol)

	ComboBoxes[id].Vertical:setColor(fbtcol)
	ComboBoxes[id].Horizontal:setColor(fbtcol)
	ComboBoxes[id].List.Vertical:setColor("44000000")
	ComboBoxes[id].List.Horizontal:setColor("44000000")

	ComboBoxes[id].Label:setFont(GuiFont.create(Fonts.OpenSansRegular, 9))
	ComboBoxes[id].Label:setHorizontalAlign("center")
	ComboBoxes[id].Label:setVerticalAlign("center")
	ComboBoxes[id].Label:setColor(fromHEXToRGB(TextColor))

	ComboBoxes[id].Arrow:setColor(arrcol)

	ComboBoxes[id].Vertical:setEnabled(false)
	ComboBoxes[id].Horizontal:setEnabled(false)

	ComboBoxes[id].Label:setEnabled(false)
	ComboBoxes[id].Arrow:setEnabled(false)

	ComboBoxes[id].List.Canvas:setVisible(false)
	ComboBoxes[id].List.Vertical:setEnabled(false)
	ComboBoxes[id].List.Horizontal:setEnabled(false)

	ComboBoxes[id].List.Canvas:setProperty("AlwaysOnTop", "True")

	ComboBoxes[id].Height = h*3.5
	ComboBoxes[id].Elements = 0
	ComboBoxes[id].ButtonHeight = h
	ComboBoxes[id].Animation = 0 --1 -- open, 2 -- close
	ComboBoxes[id].DefaultText = text

	ComboBoxes[id].setComboSize = function(h)
		local w = ComboBoxes[id].Main:getSize(false)
		ComboBoxes[id].List.Canvas:setSize(w+2, h+2, false)
		ComboBoxes[id].List.Vertical:setSize(w, h+2, false)
		ComboBoxes[id].List.Horizontal:setSize(w+2, h, false)
		ComboBoxes[id].List.Main:setSize(w, h, false)
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events
	ComboBoxes[id].Opened = false

	ComboBoxes[id].Event = {}	


	ComboBoxes[id].Event.MouseEnter = {}
	ComboBoxes[id].Event.MouseEnter.Name = "onClientMouseEnter"
	ComboBoxes[id].Event.MouseEnter.Function = function()

		if source == ComboBoxes[id].Main then
			ComboBoxes[id].Label:setColor(fromHEXToRGB(ComboBoxes[id].ColorScheme.Main))
			ComboBoxes[id].Arrow:setColor("FF"..ComboBoxes[id].ColorScheme.Main)
		end

		TextColor = "444444"
		if ComboBoxes[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end

		for _, v in pairs(ComboBoxes[id].List.Items) do
			if source == v.Canvas then
				v.Label:setColor(fromHEXToRGB("FFFFFF"))
				v.Canvas:setColor("FF"..ComboBoxes[id].ColorScheme.Main)
			else
				v.Label:setColor(fromHEXToRGB(TextColor))
				v.Canvas:setColor("0")
			
			end
		end
	end

	
	ComboBoxes[id].Event.MouseLeave = {}
	ComboBoxes[id].Event.MouseLeave.Name = "onClientMouseLeave"
	ComboBoxes[id].Event.MouseLeave.Function = function()

		if ComboBoxes[id].Canvas:getEnabled() then

			ButCol = "555555"
			if ComboBoxes[id].ColorScheme.DarkTheme then ButCol = "EEEEEE" end 
			
			TextColor = "444444"
			if ComboBoxes[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end
			
			arrcol = "FF"..ButCol
		
			ComboBoxes[id].Label:setColor(fromHEXToRGB(TextColor))
			ComboBoxes[id].Arrow:setColor(arrcol)
		end
	end


	ComboBoxes[id].Event.Click = {}
	ComboBoxes[id].Event.Click.Name = "onClientGUIClick"
	ComboBoxes[id].Event.Click.Function = function()

		if ComboBoxes[id].Canvas:getEnabled() then
			for _, v in pairs(ComboBoxes[id].List.Items) do

				if source == v.Canvas then

					ComboBoxes[id].Label:setText(v.Text)

					for _, val in pairs(ComboBoxes[id].List.Items) do
						val.Selected = false
						val.Mark:setColor("0")
					end

					v.Selected = true
					v.Mark:setColor("FF"..ComboBoxes[id].ColorScheme.Main) 
					
					triggerEvent("onCustomComboBoxSelectItem", ComboBoxes[id].Canvas, v)

				end
			end
		end

	end


	ComboBoxes[id].OpenList = function()
			local x, y = guiGetOnScreenPosition(ComboBoxes[id].Canvas)
			ComboBoxes[id].List.Canvas:setPosition(x, y, false)
			ComboBoxes[id].List.Canvas:setVisible(true)
			ComboBoxes[id].setComboSize(1)
			ComboBoxes[id].Animation = 1	
			ComboBoxes[id].Opened = true
	end

	ComboBoxes[id].CloseList = function()
			local mheight = math.min(ComboBoxes[id].Elements*30 + 1, ComboBoxes[id].Height)
			ComboBoxes[id].Opened = false
			ComboBoxes[id].setComboSize(mheight)
			ComboBoxes[id].Animation = 2
	end


	ComboBoxes[id].Event.MouseUp = {}
	ComboBoxes[id].Event.MouseUp.Name = "onClientGUIMouseUp"
	ComboBoxes[id].Event.MouseUp.Function = function()

		if source == ComboBoxes[id].Main and not ComboBoxes[id].Opened then
			ComboBoxes[id].OpenList()
		else
			ComboBoxes[id].CloseList()
		end
	end


	ComboBoxes[id].Event.Render = {}
	ComboBoxes[id].Event.Render.Name = "onClientRender"
	ComboBoxes[id].Event.Render.Function = function()

		if ComboBoxes[id].Animation == 1 then

			local mheight = math.min(ComboBoxes[id].Elements*30 + 1, ComboBoxes[id].Height)
			local w, h = ComboBoxes[id].List.Main:getSize(false)
			h = h+(mheight/8)
			
			if h >= mheight then h = mheight end
			ComboBoxes[id].setComboSize(h)
			
			if h == mheight then
				ComboBoxes[id].Animation = 0
			end
		
		elseif ComboBoxes[id].Animation == 2 then

			local mheight = math.min(ComboBoxes[id].Elements*30 + 1, ComboBoxes[id].Height)
			local w, h = ComboBoxes[id].List.Main:getSize(false)
			h = h-(mheight/8)
		
			if h <= 1 then h = 1 end
			ComboBoxes[id].setComboSize(h)
		
			if h == 1 then
				ComboBoxes[id].Animation = 0
				ComboBoxes[id].List.Canvas:setVisible(false)
			end
		
		end

		if ComboBoxes[id].Opened then

			local x, y = guiGetOnScreenPosition(ComboBoxes[id].Canvas)
			ComboBoxes[id].List.Canvas:setPosition(x, y, false)

		end
	end



	addEventHandler(ComboBoxes[id].Event.MouseEnter.Name, root, ComboBoxes[id].Event.MouseEnter.Function)
	addEventHandler(ComboBoxes[id].Event.MouseLeave.Name, root, ComboBoxes[id].Event.MouseLeave.Function)
	addEventHandler(ComboBoxes[id].Event.Click.Name, root, ComboBoxes[id].Event.Click.Function)
	addEventHandler(ComboBoxes[id].Event.MouseUp.Name, root, ComboBoxes[id].Event.MouseUp.Function)
	addEventHandler(ComboBoxes[id].Event.Render.Name, root, ComboBoxes[id].Event.Render.Function)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending
	return ComboBoxes[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions

function clbSetMaxHeight(combo, h)
	
	combo.Height = h
	local w = combo.Main:getSize(false)

	combo.Entrail:setSize(w, combo.Height)
end

function clbAddItem(combo, text)

	local w = combo.Main:getSize(false)

	combo.Elements = combo.Elements+1
	combo.Entrail:setSize(w, combo.Height)

	local id = #combo.List.Items+1
	combo.List.Items[id] = {}

	combo.List.Items[id].Text = text
	combo.List.Items[id].Selected = false

	combo.List.Items[id].Canvas = GuiStaticImage.create(0, (id-1)*30, w, 30, pane, false, combo.Entrail)
	combo.List.Items[id].Label = GuiLabel.create(8, 0, w-8, 28, text, false, combo.List.Items[id].Canvas)
	combo.List.Items[id].Mark = GuiStaticImage.create(0, 0, 5, 30, pane, false, combo.List.Items[id].Canvas)

	combo.List.Items[id].Label:setEnabled(false)
	combo.List.Items[id].Mark:setEnabled(false)

	TextColor = "444444"
	if combo.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	combo.List.Items[id].Label:setFont(GuiFont.create(Fonts.OpenSansRegular, 9))
	combo.List.Items[id].Label:setVerticalAlign("center")
	combo.List.Items[id].Label:setColor(fromHEXToRGB(TextColor))

	combo.List.Items[id].Canvas:setColor("0")
	combo.List.Items[id].Mark:setColor("0")

	return combo.List.Items[id]
end

function clbRemoveItem(combo, item)

	local visited = false
	
	for i = #combo.List.Items, 1, -1 do
	
		local v = combo.List.Items[i]
		if item == v or item == v.Text then
	
			combo.Entrail:removeElement(v.Canvas)

			destroyElement(v.Label)
			destroyElement(v.Mark)
			destroyElement(v.Canvas)
			table.remove(combo.List.Items, i)
			visited = true
	
		end
	end

	for i, v in pairs(combo.List.Items) do
		
		v.Canvas:setPosition(0, 30*(i-1), false)

	end

	if visited then
		combo.Elements = combo.Elements-1
	end

	combo.Entrail:update()
end

function clbClear(combo)
	for i = #combo.List.Items, 1, -1 do
		clbRemoveItem(combo, combo.List.Items[i])
	end
end

--------------------------------------------------------------------------------------------------

function clbSetSelectedItem(combo, item)

	local visited = false
	for _, v in pairs(combo.List.Items) do

		if item == v or item == v.Text then

			local text = (item == v) and item.Text or item
			combo.Label:setText(text)
			v.Selected = true
			visited = true

		else
			v.Selected = false
		end
	
		if v.Selected then
			v.Mark:setColor("FF"..combo.ColorScheme.Main) 
		else
			v.Mark:setColor("0")
		end
	end
	if not visited then
		combo.Label:setText(combo.DefaultText)
	end
end

function clbSetPosition(combo, x, y, rel)
	return combo.Canvas:setPosition(x, y, rel)
end

function clbSetSize(combo, w, h, rel)
		
	if rel then

		local sw, sh = Width, Height
		local parent = combo.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	combo.Canvas:setSize(w+2, h+2, false)
	combo.Vertical:setSize(w, h+2, false)
	combo.Horizontal:setSize(w+2, h, false)
	combo.Main:setSize(w, h, false)
	combo.Label:setSize(w-25, h-2, false)
	combo.Arrow:setPosition(w-25, (h/2)-12, false)

	local sh = combo.Height

	combo.List.Canvas:setSize(w+2, sh+2, false)
	combo.List.Vertical:setSize(w, sh+2, false)
	combo.List.Horizontal:setSize(w+2, sh, false)
	combo.List.Main:setSize(w, sh, false)
	combo.Entrail:setSize(w, sh, false)

	for _, v in pairs(combo.List.Items) do
		
		v.Canvas:setSize(w, 30, false)
		v.Label:setSize(w-8, 28, false)

	end

	combo.Entrail:update()
end

function clbSetVisible(combo, bool)
	combo.CloseList()
	combo.Canvas:setVisible(bool or false)
end

function clbSetEnabled(combo, bool)
	combo.Canvas:setEnabled(bool or false)
	combo.Animation = 2

	combo.CloseList()

	TopCol, BotCol, BackCol = "FFFFFF", "EEEEEE", "CCCCCC"
	if combo.ColorScheme.DarkTheme then TopCol, BotCol, BackCol = "555555", "444444", "333333" end

	TextColor = "444444"
	if combo.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	ButCol = "555555"
	if combo.ColorScheme.DarkTheme then ButCol = "EEEEEE" end 

	btncol = string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", TopCol, TopCol, BotCol, BotCol)
	arrcol = "FF"..ButCol

	if bool then
		combo.Main:setProperty("ImageColours", btncol)
		combo.Label:setColor(fromHEXToRGB(TextColor))
		combo.Arrow:setColor(arrcol)
	else
		combo.Main:setProperty("ImageColours", "tl:FFCCCCCC tr:FFCCCCCC bl:FFBBBBBB br:FFBBBBBB")
		combo.Label:setColor(fromHEXToRGB("888888"))
		combo.Arrow:setColor("FF888888")
	end
end

function clbSetItemText(combo, item, text)
	
	for i = #combo.List.Items, 1, -1 do
		local v = combo.List.Items[i]
		if item == v or item == v.Text then
			v.Text = text
			v.Label:setText(text)
			break
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function clbBringToFront(combo)
	return combo.Canvas:bringToFront()
end

function clbMoveToBack(combo)
	return combo.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function clbGetMaxHeight(combo)
	return combo.Height
end

function clbGetSelectedItem(combo)
	local result = nil
	for _, v in pairs(combo.List.Items) do
		if v.Selected then
			result = v
			break
		end
	end
	return result
end

function clbGetPosition(combo, rel)
	return combo.Canvas:getPosition(rel or false)
end

function clbGetSize(combo, rel)
	if rel then
		return combo.Canvas:getSize(true)
	else
		return combo.Main:getSize(false)
	end
end

function clbGetRealSize(combo, rel)
	return combo.Canvas:getSize(rel or false)
end

function clbGetVisible(combo)
	return combo.Canvas:getVisible()
end

function clbGetEnabled(combo)
	return combo.Canvas:getEnabled()
end

function clbGetItemText(combo, item)
	
	for i = #combo.List.Items, 1, -1 do
		local v = combo.List.Items[i]
		if item == v or item == v.Text then
			return v.Text
		end
	end
end

function clbGetItemsCount(combo)
	return #combo.List.Items
end

function clbGetItems(combo)

	local items = {}
	
	for _, v in pairs(combo.List.Items) do
		items[#items+1] = v.Text
	end

	return items
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme Functions

function clbSetColorScheme(combo, scheme)

	local objtocol = nil
	for _, v in pairs(combo.List.Items) do
		if fromPropertyToHEX(v.Canvas) == "FF"..combo.ColorScheme.Main:upper() then
			objtocol = v.Canvas
		end
	end

	combo.ColorScheme = scheme

	clbSetEnabled(combo, clbGetEnabled(combo))

	BackCol = "CCCCCC"
	if combo.ColorScheme.DarkTheme then BackCol = "333333" end

	if objtocol then
		objtocol:setColor("FF"..combo.ColorScheme.Main)
	end

	LMainCol = "F7F7F7"
	if combo.ColorScheme.DarkTheme then LMainCol = "505050" end 

	fbtcol = "FF"..BackCol
	lmncol = "FF"..LMainCol

	combo.List.Main:setColor(lmncol)

	combo.Vertical:setColor(fbtcol)
	combo.Horizontal:setColor(fbtcol)

	for _, v in pairs(combo.List.Items) do
		if v.Selected then
			v.Mark:setColor("FF"..combo.ColorScheme.Main) 
		end
	end
end

function clbGetColorScheme(combo)
	return combo.ColorScheme
end

function clbGetFrame(combo)
	return combo.Main
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function clbAddEvent(combo, event, func)

	local f = function(...)

		local visited = false
		
		for _, v in ipairs(combo.List.Items) do
			if source == v.Canvas then
				visited = true
				break
			end
		end
		if source == combo.Main or source == combo.Canvas or source == combo.List.Main or visited then
			func(...)
		end
	end

	addEventHandler(event, root, f)

	return f
end


function clbDestroy(combo)

	for _, v in pairs(combo.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	combo:clear()

	combo.Entrail:destroy()

	destroyElement(combo.Canvas)
	destroyElement(combo.List.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP Functions

CustomComboBox = {}
CustomComboBox.__index = CustomComboBox
CustomComboBox.ClassName = "CustomComboBox"

function CustomComboBox.create(...)
	local self = setmetatable(guiCreateCustomComboBox(...), CustomComboBox)
	compareAppend(self, ...)

	self.Element = self.Main

	return self
end

function CustomComboBox.setPosition(self, ...) return clbSetPosition(self, ...) end
function CustomComboBox.setSize(self, ...) return clbSetSize(self, ...) end
function CustomComboBox.setVisible(self, ...) return clbSetVisible(self, ...) end
function CustomComboBox.setEnabled(self, ...) return clbSetEnabled(self, ...) end
function CustomComboBox.setSelectedItem(self, ...) return clbSetSelectedItem(self, ...) end
function CustomComboBox.setMaxHeight(self, ...) return clbSetMaxHeight(self, ...) end
function CustomComboBox.setItemText(self, ...) return clbSetItemText(self, ...) end

function CustomComboBox.bringToFront(self) return clbBringToFront(self) end
function CustomComboBox.moveToBack(self) return clbMoveToBack(self) end

function CustomComboBox.getPosition(self, ...) return clbGetPosition(self, ...) end
function CustomComboBox.getSize(self, ...) return clbGetSize(self, ...) end
function CustomComboBox.getRealSize(self, ...) return clbGetRealSize(self, ...) end
function CustomComboBox.getVisible(self, ...) return clbGetVisible(self, ...) end
function CustomComboBox.getEnabled(self, ...) return clbGetEnabled(self, ...) end
function CustomComboBox.getSelectedItem(self, ...) return clbGetSelectedItem(self, ...) end
function CustomComboBox.getMaxHeight(self, ...) return clbGetMaxHeight(self, ...) end
function CustomComboBox.getItemText(self, ...) return clbGetItemText(self, ...) end
function CustomComboBox.getItemsCount(self, ...) return clbGetItemsCount(self, ...) end
function CustomComboBox.getItems(self, ...) return clbGetItems(self, ...) end

function CustomComboBox.setColorScheme(self, ...) return clbSetColorScheme(self, ...) end
function CustomComboBox.getColorScheme(self, ...) return clbGetColorScheme(self, ...) end

function CustomComboBox.addEvent(self, ...) return clbAddEvent(self, ...) end
function CustomComboBox.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomComboBox.getFrame(self, ...) return clbGetFrame(self, ...) end

function CustomComboBox.addItem(self, ...) return clbAddItem(self, ...) end
function CustomComboBox.removeItem(self, ...) return clbRemoveItem(self, ...) end
function CustomComboBox.clear(self, ...) return clbClear(self, ...) end

function CustomComboBox.destroy(self, ...) return clbDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------TabPanels--------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

TabPanels = {}

function guiCreateCustomTabPanel(x, y, w, h, relative, parent)	

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #TabPanels+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)
		
	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	------------------------------------------------------------------------------------------------------------------------------------------
	--Main

	TabPanels[id] = {}
	TabPanels[id].ColorScheme = DefaultColors

	if oldparent and oldparent.ColorScheme ~= nil then
		TabPanels[id].ColorScheme = oldparent.ColorScheme
	end

	TabPanels[id].Canvas = GuiStaticImage.create(x-1, y-1, w+2, h+2, pane, false, parent)

	TabPanels[id].Vertical = GuiStaticImage.create(1, 0, w, h+2, pane, false, TabPanels[id].Canvas)
	TabPanels[id].Horizontal = GuiStaticImage.create(0, 1, w+2, h, pane, false, TabPanels[id].Canvas)

	TabPanels[id].Main = GuiStaticImage.create(1, 1, w, h, pane, false, TabPanels[id].Canvas)

	TabPanels[id].TitleBlock = GuiStaticImage.create(0, 0, w, 23, pane, false, TabPanels[id].Main)
	TabPanels[id].TitleDivider = GuiStaticImage.create(0, 22, w, 1, pane, false, TabPanels[id].TitleBlock)

	TabPanels[id].TabScroller = CustomScrollPane.create(0, 0, w, 22, false, TabPanels[id].TitleBlock)
	TabPanels[id].Tabs = {}

	------------------------------------------------------------------------------------------------------------------------------------------
	--Properties

	MainCol = "F6F6F6"
	if TabPanels[id].ColorScheme.DarkTheme then MainCol = "393939" end 

	SameCol = "BBBBBB"
	if TabPanels[id].ColorScheme.DarkTheme then SameCol = "222222" end 

	maincol = "FF"..MainCol
	samecol = "FF"..SameCol

	TabPanels[id].Canvas:setColor("0")

	TabPanels[id].Vertical:setColor("22000000")
	TabPanels[id].Horizontal:setColor("22000000")

	TabPanels[id].Main:setColor(maincol)
	TabPanels[id].TitleBlock:setColor("0")
	TabPanels[id].TitleDivider:setColor(samecol)

	TabPanels[id].CurrentTab = nil
	TabPanels[id].Animation = 0 -- 1 - swipe left, 2 - swipe right
	TabPanels[id].AnimObjects = {from=nil, to=nil}
	TabPanels[id].MinLen = 100

	TabPanels[id].Vertical:setEnabled(false)
	TabPanels[id].Horizontal:setEnabled(false)

	TabPanels[id].TabScroller:setHorizontalScrolling(true)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Events

	local function animate()
		local ax = -1
		if TabPanels[id].AnimObjects.from ~= nil then
			ax = TabPanels[id].AnimObjects.from.Canvas:getPosition(false)
		end

		local bx = TabPanels[id].AnimObjects.to.Canvas:getPosition(false)
		local w = TabPanels[id].Main:getSize(false)

		if ax < bx then
			TabPanels[id].AnimObjects.to.Entrail:setPosition(w, 23, false)
			TabPanels[id].Animation = 1
		else
			TabPanels[id].AnimObjects.to.Entrail:setPosition(-w, 23, false)
			TabPanels[id].Animation = 2
		end
	end

	TabPanels[id].Event = {}

	TabPanels[id].Event.Render = {}
	TabPanels[id].Event.Render.Name = "onClientRender"
	TabPanels[id].Event.Render.Function = function()

		if TabPanels[id].Animation == 1 then

			if TabPanels[id].AnimObjects.to == nil then
				TabPanels[id].Animation = 0
				return
			end

			local w = TabPanels[id].Main:getSize(false)
			local x = TabPanels[id].AnimObjects.to.Entrail:getPosition(false)
			x = x-(w/8)

			if x < 0 then x = 0 end
			TabPanels[id].AnimObjects.to.Entrail:setPosition(x, 23, false)
			if TabPanels[id].AnimObjects.from ~= nil then
				TabPanels[id].AnimObjects.from.Entrail:setPosition(x-w, 23, false)
			end

			if x == 0 then
				TabPanels[id].Animation = 0
				if TabPanels[id].AnimObjects.from ~= nil then
					TabPanels[id].AnimObjects.from.Entrail:setVisible(false)
				end
			end

		elseif TabPanels[id].Animation == 2 then

			if not TabPanels[id].AnimObjects.from then
				TabPanels[id].Animation = 0
				return
			end

			local w = TabPanels[id].Main:getSize(false)
			local x = TabPanels[id].AnimObjects.from.Entrail:getPosition(false)
			x = x+(w/8)

			if x > w then x = w end
			TabPanels[id].AnimObjects.to.Entrail:setPosition(x-w, 23, false)
			TabPanels[id].AnimObjects.from.Entrail:setPosition(x, 23, false)

			if x == w then
				TabPanels[id].Animation = 0
				TabPanels[id].AnimObjects.from.Entrail:setVisible(false)
			end
		end
	end

	TabPanels[id].Event.Click = {}
	TabPanels[id].Event.Click.Name = "onClientGUIClick"
	TabPanels[id].Event.Click.Function = function()

		for _, v in pairs(TabPanels[id].Tabs) do
			if source == v.Canvas and v ~= TabPanels[id].CurrentTab and v.Enabled then
				for _, val in pairs(TabPanels[id].Tabs) do
					val.Entrail:setVisible(false)
				end
				if TabPanels[id].CurrentTab ~= nil then
					
					TextCol = "444444"
					if TabPanels[id].ColorScheme.DarkTheme then TextCol = "EEEEEE" end
					
					TabPanels[id].CurrentTab.Entrail:setVisible(true)
					TabPanels[id].CurrentTab.Canvas:setColor("0")
					TabPanels[id].CurrentTab.Label:setColor(fromHEXToRGB(TextCol))

				end

				TabPanels[id].AnimObjects.from = TabPanels[id].CurrentTab
				TabPanels[id].AnimObjects.to = v
				animate()

				TabPanels[id].CurrentTab = v

				v.Entrail:setVisible(true) -- make animated
				v.Label:setColor(fromHEXToRGB("FFFFFF"))
				v.Canvas:setColor("FF"..TabPanels[id].ColorScheme.Main) 
				
				triggerEvent("onCustomTabPanelChangeTab", TabPanels[id].Main, v.Text)

			end
		end
	end

	TabPanels[id].Event.MouseEnter = {}
	TabPanels[id].Event.MouseEnter.Name = "onClientMouseEnter"
	TabPanels[id].Event.MouseEnter.Function = function()

		TextCol = "444444"
		if TabPanels[id].ColorScheme.DarkTheme then TextCol = "EEEEEE" end

		for _, v in pairs(TabPanels[id].Tabs) do
			if TabPanels[id].CurrentTab ~= v and v.Enabled then
				v.Label:setColor(fromHEXToRGB(TextCol))
				if source == v.Canvas then
					v.Label:setColor(fromHEXToRGB(TabPanels[id].ColorScheme.Main))
				end
			end
		end
	end

	addEventHandler(TabPanels[id].Event.Render.Name, root, TabPanels[id].Event.Render.Function)
	addEventHandler(TabPanels[id].Event.Click.Name, root, TabPanels[id].Event.Click.Function)
	addEventHandler(TabPanels[id].Event.MouseEnter.Name, root, TabPanels[id].Event.MouseEnter.Function)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Ending
	return TabPanels[id]
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions
function compareTabs(tabpan)
	
	local count = 0
	for _, v in pairs(tabpan.Tabs) do
		if v.Visible then
			count = count+1
		end
	end

	local w = tabpan.Main:getSize(false)
	local width = math.floor(w/count) > tabpan.MinLen and math.floor(w/count) or tabpan.MinLen

	--tabpan.TabScroller.Menu:setSize(w, 22, false)
	
	TextCol = "444444"
	if tabpan.ColorScheme.DarkTheme then TextCol = "EEEEEE" end

	DisCol = "DDDDDD"
	if tabpan.ColorScheme.DarkTheme then DisCol = "222222" end 

	SameCol = "BBBBBB"
	if tabpan.ColorScheme.DarkTheme then SameCol = "222222" end 

	discol = "FF"..DisCol
	samecol = "FF"..SameCol

	local id = 0
	for _, v in pairs(tabpan.Tabs) do
		if v.Visible then

			v.Canvas:setSize(width, 22, false)
			v.Canvas:setPosition(width*id, 0, false)
			v.Divider:setColor(samecol)

			if not v.Enabled then
				v.Canvas:setColor(discol)
				v.Label:setColor(fromHEXToRGB("888888"))
			else 
				if v == tabpan.CurrentTab then
					v.Canvas:setColor("FF"..tabpan.ColorScheme.Main) 
					v.Label:setColor(fromHEXToRGB("FFFFFF"))
				else
					v.Canvas:setColor("0")
					v.Label:setColor(fromHEXToRGB(TextCol))
				end
			end

			v.Label:setSize(width, 20, false)

			v.Divider:setVisible(id > 0)

			id = id+1

			if id == count and count%2 == 1 then
				v.Canvas:setSize(width+1, 22, false)
			end
		else
			v.Canvas:setVisible(false)
		end
	end

	tabpan.TabScroller:update()

end

function ctpAddTab(tabpan, text)

	local id = #tabpan.Tabs+1

	SameCol = "BBBBBB"
	if tabpan.ColorScheme.DarkTheme then SameCol = "222222" end 

	samecol = "FF"..SameCol

	tabpan.Tabs[id] = {}
	tabpan.Tabs[id].Visible = true
	tabpan.Tabs[id].Enabled = true
	tabpan.Tabs[id].Text = text

	local w, h = tabpan.Main:getSize(false)
	tabpan.Tabs[id].Canvas = GuiStaticImage.create(0, 0, 100, 22, pane, false, tabpan.TabScroller)
	tabpan.Tabs[id].Divider = GuiStaticImage.create(0, 0, 1, 22, pane, false, tabpan.Tabs[id].Canvas)
	tabpan.Tabs[id].Label = GuiLabel.create(0, 0, 100, 20, text, false, tabpan.Tabs[id].Canvas)
	tabpan.Tabs[id].Entrail = GuiStaticImage.create(0, 23, w, h-23, pane, false, tabpan.Main)
	--tabpan.TabScroller:addScrollElement(tabpan.Tabs[id].Canvas, "x")

	tabpan.Tabs[id].Canvas:setColor("0")
	tabpan.Tabs[id].Entrail:setColor("0")
	tabpan.Tabs[id].Divider:setColor(samecol)

	tabpan.Tabs[id].Label:setFont(GuiFont.create(Fonts.OpenSansRegular, 9))
	tabpan.Tabs[id].Label:setColor(fromHEXToRGB("444444"))
	tabpan.Tabs[id].Label:setVerticalAlign("center")
	tabpan.Tabs[id].Label:setHorizontalAlign("center")

	tabpan.Tabs[id].Divider:setVisible(false)
	tabpan.Tabs[id].Divider:setEnabled(false)
	tabpan.Tabs[id].Label:setEnabled(false)
	tabpan.Tabs[id].Entrail:setVisible(false)

	compareTabs(tabpan)
	return tabpan.Tabs[id].Entrail

end

function ctpRemoveTab(tabpan, tab)

	if tab == tabpan.CurrentTab then
		tabpan.CurrentTab = nil
		tabpan.AnimObjects = {from=nil, to=nil}
	end
		
	for i, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then

			tabpan.TabScroller:removeElement(v.Canvas)
			
			destroyElement(v.Entrail)
			destroyElement(v.Label)
			destroyElement(v.Divider)
			destroyElement(v.Canvas)

			table.remove(tabpan.Tabs, i)
		end
	end

	compareTabs(tabpan)
end

function ctpClearTabs(tabpan)

	for i = #tabpan.Tabs, 1, -1 do

		v = tabpan.Tabs[i]

		if v == tabpan.CurrentTab then
			tabpan.CurrentTab = nil
			tabpan.AnimObjects = {from=nil, to=nil}
		end

		tabpan.TabScroller:removeElement(v.Canvas)
		
		destroyElement(v.Entrail)
		destroyElement(v.Label)
		destroyElement(v.Divider)
		destroyElement(v.Canvas)

		table.remove(tabpan.Tabs, i)

	end

	compareTabs(tabpan)
end

function ctpSetTabEnabled(tabpan, tab, bool)

	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			v.Enabled = bool or false
		end
	end

	compareTabs(tabpan)
end

function ctpSetTabVisible(tabpan, tab, bool)

	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			v.Visible = bool or false
		end
	end

	compareTabs(tabpan)
end

function ctpSetTabText(tabpan, tab, text)

	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			v.Label:setText(text)
			v.Text = text
		end
	end

	compareTabs(tabpan)
end

function ctpSetEnabled(tabpan, bool)
	tabpan.Canvas:setEnabled(bool or false)

	if bool then
		tabpan.Main:bringToFront()
	else
		tabpan.Vertical:bringToFront()
		tabpan.Horizontal:bringToFront()
	end
end

function ctpSetVisible(tabpan, bool)
	return tabpan.Canvas:setVisible(bool or false)
end

function ctpSetPosition(tabpan, x, y, rel)
	tabpan.Canvas:setPosition(x, y, rel or false)
end

function ctpSetSize(tabpan, w, h, rel)
		
	if rel then

		local sw, sh = Width, Height
		local parent = combo.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	tabpan.Canvas:setSize(w+2, h+2, false)
	tabpan.Vertical:setSize(w, h+2, false)
	tabpan.Horizontal:setSize(w+2, h, false)

	tabpan.Main:setSize(w, h, false)
	tabpan.TitleBlock:setSize(w, 23, false)
	tabpan.TitleDivider:setSize(w, 1, false)

	tabpan.TabScroller:setSize(w, 22, false)

	for _, v in pairs(tabpan.Tabs) do
		v.Entrail:setSize(w, h-23, false)
	end

	compareTabs(tabpan)
end

function ctpSetTabsMinLength(tabpan, len)
	tabpan.MinLen = tonumber(len) or 100
	compareTabs(tabpan)
end

function ctpSetSelectedTab(tabpan, tab)
	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			triggerEvent("onClientGUIClick", v.Canvas)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function ctpBringToFront(tabpan)
	return tabpan.Canvas:bringToFront()
end

function ctpMoveToBack(tabpan)
	return tabpan.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function ctpGetTabEnabled(tabpan, tab)

	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			return v.Enabled
		end
	end

	return nil
end

function ctpGetTabVisible(tabpan, tab)

	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			return v.Visible
		end
	end

	return nil
end

function ctpGetTabText(tabpan, tab)

	for _, v in pairs(tabpan.Tabs) do
		if v.Entrail == tab then
			return v.Text
		end
	end

	return nil
end

function ctpGetEnabled(tabpan)
	return tabpan.Canvas:getEnabled()
end

function ctpGetVisible(tabpan)
	return tabpan.Canvas:getVisible()
end

function ctpGetPosition(tabpan, rel)
	return tabpan.Canvas:getPosition(rel or false)
end

function ctpGetSize(tabpan, rel)
	if rel then
		return tabpan.Canvas:getSize(true)
	else
		return tabpan.Main:getSize(false)
	end
end

function ctpGetRealSize(tabpan, rel)
	return tabpan.Canvas:getSize(rel or false)
end	

function ctpGetTabsMinLength(tabpan)
	return tabpan.MinLen
end

function ctpGetSelectedTab(tabpan)
	if tabpan.CurrentTab then
		return tabpan.CurrentTab.Entrail
	else
		return nil
	end
end

function ctpGetTabFromText(tabpan, text)
	for _, v in pairs(tabpan.Tabs) do
		if v.Text == text then
			return v.Entrail
		end
	end
end

function ctpGetTabHeader(tabpan, tab)
	for _, v in pairs(tabpan.Tabs) do
		if v.Text == tab or v.Entrail == tab then
			return v.Canvas
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme Functions

function ctpSetColorScheme(tabpan, scheme)

	tabpan.ColorScheme = scheme
	compareTabs(tabpan)

	MainCol = "F6F6F6"
	if tabpan.ColorScheme.DarkTheme then MainCol = "393939" end 

	SameCol = "BBBBBB"
	if tabpan.ColorScheme.DarkTheme then SameCol = "222222" end 

	maincol = "FF"..MainCol
	samecol = "FF"..SameCol

	tabpan.Main:setColor(maincol)
	tabpan.TitleDivider:setColor(samecol)

end

function ctpGetColorScheme(tabpan)
	return tabpan.ColorScheme
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function ctpAddEvent(tabpan, event, func)

	local f = function(...)
		if source == tabpan.Main then
			func(...)
		else

			for _, v in pairs(tabpan.Tabs) do
				if source == v.Canvas or source ==  v.Entrail then
					func(...)
				end
			end
		end
	end

	addEventHandler(event, root, f)

	return f
end

function ctpDestroy(tabpan)

	for _, v in pairs(tabpan.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	tabpan:clearTabs()
	tabpan.TabScroller:destroy()
	destroyElement(tabpan.Canvas)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP Functions

CustomTabPanel = {}
CustomTabPanel.__index = CustomTabPanel
CustomTabPanel.ClassName = "CustomTabPanel"

function CustomTabPanel.create(...)
	local self = setmetatable(guiCreateCustomTabPanel(...), CustomTabPanel)
	compareAppend(self, ...)

	return self
end

function CustomTabPanel.setPosition(self, ...) return ctpSetPosition(self, ...) end
function CustomTabPanel.setSize(self, ...) return ctpSetSize(self, ...) end
function CustomTabPanel.setVisible(self, ...) return ctpSetVisible(self, ...) end
function CustomTabPanel.setEnabled(self, ...) return ctpSetEnabled(self, ...) end
function CustomTabPanel.setTabEnabled(self, ...) return ctpSetTabEnabled(self, ...) end
function CustomTabPanel.setTabVisible(self, ...) return ctpSetTabVisible(self, ...) end
function CustomTabPanel.setTabText(self, ...) return ctpSetTabText(self, ...) end
function CustomTabPanel.setSelectedTab(self, ...) return ctpSetSelectedTab(self, ...) end
function CustomTabPanel.setTabsMinLength(self, ...) return ctpSetTabsMinLength(self, ...) end

function CustomTabPanel.bringToFront(self) return ctpBringToFront(self) end
function CustomTabPanel.moveToBack(self) return ctpMoveToBack(self) end

function CustomTabPanel.getPosition(self, ...) return ctpGetPosition(self, ...) end
function CustomTabPanel.getSize(self, ...) return ctpGetSize(self, ...) end
function CustomTabPanel.getRealSize(self, ...) return ctpGetRealSize(self, ...) end
function CustomTabPanel.getVisible(self, ...) return ctpGetVisible(self, ...) end
function CustomTabPanel.getEnabled(self, ...) return ctpGetEnabled(self, ...) end
function CustomTabPanel.getTabEnabled(self, ...) return ctpGetTabEnabled(self, ...) end
function CustomTabPanel.getTabVisible(self, ...) return ctpGetTabVisible(self, ...) end
function CustomTabPanel.getTabText(self, ...) return ctpGetTabText(self, ...) end
function CustomTabPanel.getTabFromText(self, ...) return ctpGetTabFromText(self, ...) end
function CustomTabPanel.getSelectedTab(self, ...) return ctpGetSelectedTab(self, ...) end
function CustomTabPanel.getTabsMinLength(self, ...) return ctpGetTabsMinLength(self, ...) end
function CustomTabPanel.getTabHeader(self, ...) return ctpGetTabHeader(self, ...) end

function CustomTabPanel.setColorScheme(self, ...) return ctpSetColorScheme(self, ...) end
function CustomTabPanel.getColorScheme(self, ...) return ctpGetColorScheme(self, ...) end

function CustomTabPanel.addEvent(self, ...) return ctpAddEvent(self, ...) end
function CustomTabPanel.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomTabPanel.getFrame(self, ...) return ctpGetSelectedTab(self, ...) end

function CustomTabPanel.addTab(self, ...) return ctpAddTab(self, ...) end
function CustomTabPanel.removeTab(self, ...) return ctpRemoveTab(self, ...) end
function CustomTabPanel.clearTabs(self, ...) return ctpClearTabs(self, ...) end

function CustomTabPanel.destroy(self, ...) return ctpDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-----------------------------Labels---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

Labels = {}
function guiCreateCustomLabel(x, y, w, h, text, relative, parent)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #Labels+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	Labels[id] = {}

	Labels[id].ColorScheme = DefaultColors
	Labels[id].IsHoverable = false
	Labels[id].IsSchematical = false
	Labels[id].VertAlign = "top"
	Labels[id].HorzAlign = "left"
	Labels[id].Font = Fonts.OpenSansRegular
	Labels[id].FontSize = 9
	Labels[id].Cell = false
	Labels[id].Attached = {}

	if oldparent and oldparent.ColorScheme ~= nil then
		Labels[id].ColorScheme = oldparent.ColorScheme
	end

	Labels[id].Label = GuiLabel.create(x, y, w, h, text, false, parent)

	TextColor = "444444"
	if Labels[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	Labels[id].Label:setFont(GuiFont.create(Labels[id].Font, Labels[id].FontSize))
	Labels[id].Label:setColor(fromHEXToRGB(TextColor))


	Labels[id].Event = {}

	Labels[id].Event.MouseEnter = {}
	Labels[id].Event.MouseEnter.Name = "onClientMouseEnter"
	Labels[id].Event.MouseEnter.Function = function()

		if source == Labels[id].Label and Labels[id].IsHoverable then
			
			Labels[id].Label:setColor(fromHEXToRGB(Labels[id].ColorScheme.Main))

		end
	end

	Labels[id].Event.MouseLeave = {}
	Labels[id].Event.MouseLeave.Name = "onClientMouseLeave"
	Labels[id].Event.MouseLeave.Function = function()

		if source == Labels[id].Label and Labels[id].IsHoverable then
			
			TextColor = "444444"
			if Labels[id].ColorScheme.DarkTheme then TextColor = "EEEEEE" end 
			Labels[id].Label:setColor(fromHEXToRGB(TextColor))

		end
	end

	addEventHandler(Labels[id].Event.MouseEnter.Name, root, Labels[id].Event.MouseEnter.Function)
	addEventHandler(Labels[id].Event.MouseLeave.Name, root, Labels[id].Event.MouseLeave.Function)

	return Labels[id]

end

----------------------------------------------------------------------------------------------------------------------------------------------
--Set functions

function clSetText(label, text)
	label.Label:setText(text)

	if label.Cell then
		for it_id, item in pairs(label.TView.Lines) do
			for i, v in pairs(label.TView.Columns) do
				if item.Elements[i] == label then
					label.TView.Items[it_id][i] = text
					break
				end
			end
		end
	end
end

function clSetPosition(label, x, y, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = label.Label.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	label.Label:setPosition(x, y, false)

end

function clSetSize(label, w, h, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = label.Label.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	label.Label:setSize(w, h, false)
end

function clSetEnabled(label, bool)
	label.Label:setEnabled(bool)
end

function clSetVisible(label, bool)
	label.Label:setVisible(bool)
end

function clSetColor(label, r, g, b)

	if r == tostring(r) and r:len() == 6 then
	
		r, g, b = fromHEXToRGB(r)

	elseif not (r and g and b and tonumber(r) and tonumber(g) and tonumber(b)) then
	
		if (r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255) then

			TextColor = "444444"
			if label.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 
		
			r, g, b = fromHEXToRGB(TextColor)
		end
	end

	label.IsHoverable = false
	label.IsSchematical = false

	label.Label:setColor(r, g, b)
end

function clSetSchematicalColor(label, bool)

	label.IsSchematical = bool

	if bool then
		label.IsHoverable = false

		label.Label:setColor(fromHEXToRGB(label.ColorScheme.Main))
	end
end

function clSetHoverable(label, bool)

	label.IsHoverable = bool

	if bool then
		label.IsSchematical = false

		TextColor = "444444"
		if label.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

		label.Label:setColor(fromHEXToRGB(TextColor))		
	end
end

function clSetVerticalAlign(label, align)
	label.VertAlign = align
	label.Label:setVerticalAlign(align)
end

function clSetHorizontalAlign(label, align)
	label.HorzAlign = align
	label.Label:setHorizontalAlign(align)
end

function clSetAlign(label, vertical, horizontal)

	if not vertical then vertical = "top" end
	if not horizontal then horizontal = "left" end

	clSetVerticalAlign(label, vertical)
	clSetHorizontalAlign(label, horizontal)
end

function clSetFont(label, font, size)

	if not size or not tonumber(size) then size = label.FontSize end
	label.Font = font
	label.FontSize = size

	label.Label:setFont(GuiFont.create(font, size))
end

function clSetFontSize(label, size)

	if not size or not tonumber(size) then size = 9 end
	label.FontSize = size
	
	label.Label:setFont(GuiFont.create(label.Font, size))
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function clBringToFront(label)
	label.Label:bringToFront()
end

function clMoveToBack(label)
	label.Label:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get functions

function clGetText(label)
	return label.Label:getText()
end

function clGetPosition(label, rel)

	local x, y = label.Label:getPosition(false)
	if rel then

		local sw, sh = Width, Height
		local parent = label.Label.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end
		

		return x/sw, y/sh
	
	else

		return x, y
	end
end

function clGetSize(label, rel)
	
	return label.Label:getSize(rel or false)
end

function clGetEnabled(label)
	return label.Label:getEnabled()
end

function clGetVisible(label)
	return label.Label:getVisible()
end

function clGetColor(label)
	return label.Label:getColor()
end

function clGetVerticalAlign(label)
	return label.VertAlign
end

function clGetHorizontalAlign(label)
	return label.HorzAlign
end

function clGetFont(label)
	return label.Font
end

function clGetFontSize(label)
	return label.FontSize
end

function clIsSchematicalColor(label)
	return label.IsSchematical
end

function clIsHoverable(label)
	return label.IsHoverable
end

function clGetFrame(label)
	return label.Label
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Theme editor

function clSetColorScheme(label, scheme)

	label.ColorScheme = scheme

	TextColor = "444444"
	if label.ColorScheme.DarkTheme then TextColor = "EEEEEE" end 

	issch = label.IsSchematical
	ishov = label.IsHoverable

	clSetColor(label, fromHEXToRGB(TextColor))

	label.IsSchematical = issch
	label.IsHoverable = ishov

	if label.IsSchematical then
		clSetSchematicalColor(label, true)
	end

	for _, item in pairs(label.Attached) do
		if item.ColorScheme then
			item:setColorScheme(scheme)
		end
	end
end

function clGetColorScheme(label)
	return label.ColorScheme
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event Functions

function clAddEvent(label, event, func)

	local f = function(...)
		if source == label.Label then
			func(...)
		end
	end
	
	addEventHandler(event, root, f)

	return f
end

function clAddElement(label, element)

	local len = #label.Attached+1
	label.Attached[len] = element

	if element.ColorScheme then
		element:setColorScheme(label.ColorScheme)
	end
end

function clRemoveElement(label, element)
	for i, v in pairs(label.Attached) do
		if v == element then
			table.remove(label.Attached, i)
			break
		end
	end
end

function clDestroy(label)

	for _, v in pairs(label.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	destroyElement(label.Label)
end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP functions
CustomLabel = {}
CustomLabel.__index = CustomLabel
CustomLabel.ClassName = "CustomLabel"

function CustomLabel.create(...)
	local self = setmetatable(guiCreateCustomLabel(...), CustomLabel)
	compareAppend(self, ...)

	self.Element = self.Label

	return self
end

function CustomLabel.setEnabled(self, ...) return clSetEnabled(self, ...) end
function CustomLabel.setVisible(self, ...) return clSetVisible(self, ...) end
function CustomLabel.setSize(self, ...) return clSetSize(self, ...) end
function CustomLabel.setPosition(self, ...) return clSetPosition(self, ...) end
function CustomLabel.setText(self, ...) return clSetText(self, ...) end
function CustomLabel.setColor(self, ...) return clSetColor(self, ...) end
function CustomLabel.setSchematicalColor(self, ...) return clSetSchematicalColor(self, ...) end
function CustomLabel.setHoverable(self, ...) return clSetHoverable(self, ...) end
function CustomLabel.setVerticalAlign(self, ...) return clSetVerticalAlign(self, ...) end
function CustomLabel.setHorizontalAlign(self, ...) return clSetHorizontalAlign(self, ...) end
function CustomLabel.setAlign(self, ...) return clSetAlign(self, ...) end
function CustomLabel.setFont(self, ...) return clSetFont(self, ...) end
function CustomLabel.setFontSize(self, ...) return clSetFontSize(self, ...) end

function CustomLabel.bringToFront(self) return clBringToFront(self) end
function CustomLabel.moveToBack(self) return clMoveToBack(self) end

function CustomLabel.getEnabled(self, ...) return clGetEnabled(self, ...) end
function CustomLabel.getVisible(self, ...) return clGetVisible(self, ...) end
function CustomLabel.getSize(self, ...) return clGetSize(self, ...) end
function CustomLabel.getRealSize(self, ...) return clGetSize(self, ...) end
function CustomLabel.getPosition(self, ...) return clGetPosition(self, ...) end
function CustomLabel.getText(self, ...) return clGetText(self, ...) end
function CustomLabel.getColor(self, ...) return clGetColor(self, ...) end
function CustomLabel.getVerticalAlign(self, ...) return clGetVerticalAlign(self, ...) end
function CustomLabel.getHorizontalAlign(self, ...) return clGetHorizontalAlign(self, ...) end
function CustomLabel.getFont(self, ...) return clSetFont(self, ...) end
function CustomLabel.getFontSize(self, ...) return clSetFontSize(self, ...) end
function CustomLabel.isSchematicalColor(self, ...) return clIsSchematicalColor(self, ...) end
function CustomLabel.isHoverable(self, ...) return clIsHoverable(self, ...) end

function CustomLabel.setColorScheme(self, ...) return clSetColorScheme(self, ...) end
function CustomLabel.getColorScheme(self, ...) return clGetColorScheme(self, ...) end

function CustomLabel.addEvent(self, ...) return clAddEvent(self, ...) end
function CustomLabel.removeEvent(self, ...) return cwRemoveEvent(self, ...) end
function CustomLabel.getFrame(self, ...) return clGetFrame(self, ...) end

function CustomLabel.addElement(self, ...) return clAddElement(self, ...) end
function CustomLabel.removeElement(self, ...) return clRemoveElement(self, ...) end

function CustomLabel.destroy(self, ...) return clDestroy(self, ...) end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Dialogs----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

CustomDialog = {}
CustomDialog.__index = CustomDialog
CustomDialog.ClassName = "CustomDialog"

Dialogs = {}

local LabelForGettingSizes = CustomLabel.create(0, 0, 0, 0, "", false)
function CustomDialog.create(rwidth, text, buttons, window)

	local id = #Dialogs+1

	Dialogs[id] = setmetatable({}, CustomDialog)

	local w, h
	local maxw = 0

	local objects = text:split("\n")

	for _, v in pairs(objects) do
		LabelForGettingSizes:setText(v)
		maxw = math.max(maxw, guiLabelGetTextExtent(LabelForGettingSizes.Label)+10)
	end
	maxw = maxw + 20

	local butmaxw = 0
	local butsizes = {}
	if type(buttons) == type(objects) then

		for _, v in pairs(buttons) do
		
			LabelForGettingSizes:setText(v)
			butmaxw = butmaxw + (guiLabelGetTextExtent(LabelForGettingSizes.Label) + 20) + 10
		
			butsizes[#butsizes + 1] = guiLabelGetTextExtent(LabelForGettingSizes.Label) + 20
		
		end
		
		butmaxw = butmaxw + 5
	
	elseif type(buttons) == type("string") or type(buttons) == type(123) then

		LabelForGettingSizes:setText(buttons)
		butmaxw = (guiLabelGetTextExtent(LabelForGettingSizes.Label) + 20) + 10
		buttons = {buttons}
		butsizes = {butmaxw-10}

	else
		buttons = {}

	end

	w = math.max(butmaxw, maxw) + 5
	w = math.max(rwidth, w)
	h = (guiLabelGetFontHeight(LabelForGettingSizes.Label) + 5)*(#objects+1) + 25 + 30


	local x, y = Width/2 - w/2, Height/2 - h/2
	if window then
		local nw, nh = window:getSize(false)
		x, y = nw/2 - w/2, nh/2 - h/2
	end

	local parent = nil
	if window then
		parent = window.Dialog
	end

	local dialog = CustomWindow.create(x, y, w, h, "", false, parent)
	dialog:setVisible(false)

	dialog.Parent = window

	if window then
		dialog:setMovable(false)
	else
		dialog:setCloseEnabled(true)
	end

	dialog.Label = CustomLabel.create(5, 20, w-10, h-38-30, text, false, dialog:getFrame())
	dialog.Label:setAlign("center", "center")

	dialog.Buttons = {}
	local nlen = 0
	for i, v in pairs(buttons) do

		nlen = nlen + butsizes[i]

		dialog.Buttons[i] = CustomButton.create(w-10*i-nlen, h-38, butsizes[i], 28, v, false, dialog:getFrame())
		dialog:addElement(dialog.Buttons[i])
		
		dialog.Buttons[i]:addEvent("onClientGUIClick", function()
			
			dialog:close()
			triggerEvent("onCustomDialogClick", dialog:getFrame(), v)

			if window then
				window:showDialog(false)
			end

		end)
	end

	dialog:addElement(dialog.Label)

	Dialogs[id].Dialog = dialog

	if window then
		window:addElement(dialog)
		window.DialogList[#window.DialogList+1] = Dialogs[id]
	end

	return Dialogs[id]
end

function CustomDialog.open(self) 
	if self.Dialog.Parent then
		self.Dialog.Parent:showDialog(true)
	end
	self.Dialog:open()
end

function CustomDialog.close(self) 
	if self.Dialog.Parent then
		self.Dialog.Parent:showDialog(false)
	end
	self.Dialog:close()
end

function CustomDialog.addEvent(self, ...)
	return self.Dialog:addEvent(...)
end

function CustomDialog.removeEvent(self, ...)
	return self.Dialog:removeEvent(...)
end

function CustomDialog.setColorScheme(self, ...)
	return self.Dialog:setColorScheme(...)
end

function CustomDialog.getColorScheme(self)
	return self.Dialog.Window.ColorScheme
end

function CustomDialog.destroy(self)

	for i, v in pairs(self.Dialog.Buttons) do
		v:destroy()
	end

	self.Dialog.Label:destroy()
	self.Dialog:destroy()
end


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Tooltips---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

CustomTooltip = {}
CustomTooltip.__index = CustomTooltip
CustomTooltip.ClassName = "CustomTooltip"

Tooltips = {}

function CustomTooltip.create(text, element, timetoshow)

	local id = #Tooltips+1

	Tooltips[id] = setmetatable({}, CustomTooltip)
	if not timetoshow or not tonumber(timetoshow) or timetoshow < 0 then
		timetoshow = 1
	end

	local objects = text:split("\n")
	local wdth = 0

	for _, v in pairs(objects) do
		LabelForGettingSizes:setText(v)
		wdth = math.max(wdth, guiLabelGetTextExtent(LabelForGettingSizes.Label))
	end

	local hght = (guiLabelGetFontHeight(LabelForGettingSizes.Label)+2)*(#objects)

	Tooltips[id].ShowTime = timetoshow

	wdth = wdth+4
	hght = hght+4

	Tooltips[id].Back = GuiStaticImage.create(0, 0, wdth+6, hght+6, pane, false)
	Tooltips[id].Shad1 = GuiStaticImage.create(0, 1, wdth+6, hght+4, pane, false, Tooltips[id].Back)
	Tooltips[id].Shad2 = GuiStaticImage.create(1, 0, wdth+4, hght+6, pane, false, Tooltips[id].Back)
	Tooltips[id].Main = GuiStaticImage.create(1, 1, wdth+4, hght+4, pane, false, Tooltips[id].Back)
	Tooltips[id].Label = CustomLabel.create(2, 2, wdth, hght, text, false, Tooltips[id].Main)


	Tooltips[id].Back:setColor("0")
	Tooltips[id].Shad1:setColor("44000000")
	Tooltips[id].Shad2:setColor("44000000")
	Tooltips[id].Back:setProperty("AlwaysOnTop", "True")
	Tooltips[id].Back:setEnabled(false)
	Tooltips[id].Back:setVisible(false)

	local isEntered = false
	local tooltiptimer
	local animation = 0 --1 to open, 2 to close

	local function show()

		Tooltips[id].Back:setAlpha(0)
		Tooltips[id].Back:setVisible(true)
		animation = 1

		local scheme = element:getColorScheme()
		local color = "FFEEEEEE"
		if scheme.DarkTheme then
			color = "FF444444"
		end
		
		Tooltips[id].Main:setColor(color)
		Tooltips[id].Label:setColorScheme(scheme)

	end

	local BFMState = BackForMouse:getVisible()

	Tooltips[id].Event = {}

	Tooltips[id].Event.MouseEnter = {}
	Tooltips[id].Event.MouseEnter.Name = "onClientMouseEnter"
	Tooltips[id].Event.MouseEnter.Function = function(ax, ay)

		isEntered = true
		Tooltips[id].Back:setPosition(ax+1, ay-hght-6, false)
		
		BFMState = BackForMouse:getVisible()
		BackForMouse:setVisible(true)
		
		if Tooltips[id].ShowTime < 5/100 then
			show()
		else 
			tooltiptimer = setTimer(show, Tooltips[id].ShowTime*1000, 1)
		end

	end


	Tooltips[id].Event.MouseLeave = {}
	Tooltips[id].Event.MouseLeave.Name = "onClientMouseLeave"
	Tooltips[id].Event.MouseLeave.Function = function()
		
		if isTimer(tooltiptimer) then killTimer(tooltiptimer) end

		BackForMouse:setVisible(BFMState)

		isEntered = false
		animation = 2
	end


	Tooltips[id].Event.CursorMove = {}
	Tooltips[id].Event.CursorMove.Name = "onClientCursorMove"
	Tooltips[id].Event.CursorMove.Function = function(_, _, ax, ay)

		if isEntered then
			Tooltips[id].Back:setPosition(ax+1, ay-hght-6, false)
		end

	end


	Tooltips[id].Event.Render = {}
	Tooltips[id].Event.Render.Name = "onClientRender"
	Tooltips[id].Event.Render.Function = function()

		if animation == 1 then

			if Tooltips[id].Back:getAlpha() >= 1 then
				Tooltips[id].Back:setAlpha(1)
				animation = 0
			end

			Tooltips[id].Back:setAlpha(Tooltips[id].Back:getAlpha() + 0.15)

		elseif animation == 2 then

			if Tooltips[id].Back:getAlpha() <= 0 then
				Tooltips[id].Back:setAlpha(0)
				animation = 0
			end

			Tooltips[id].Back:setAlpha(Tooltips[id].Back:getAlpha() - 0.15)

		end

	end


	Tooltips[id].Event.MouseEnter.Function = element:addEvent(Tooltips[id].Event.MouseEnter.Name, Tooltips[id].Event.MouseEnter.Function)

	addEventHandler(Tooltips[id].Event.MouseLeave.Name, root, Tooltips[id].Event.MouseLeave.Function)
	addEventHandler(Tooltips[id].Event.CursorMove.Name, root, Tooltips[id].Event.CursorMove.Function)
	addEventHandler(Tooltips[id].Event.Render.Name, root, Tooltips[id].Event.Render.Function)

	return Tooltips[id]
end

function CustomTooltip.setShowTime(self, time)
	self.ShowTime = time
end

function CustomTooltip.getShowTime(self)
	return self.ShowTime
end

function CustomTooltip.setText(self, text)
	
	local objects = text:split("\n")
	local wdth = 0

	for _, v in pairs(objects) do
		LabelForGettingSizes:setText(v)
		wdth = math.max(wdth, guiLabelGetTextExtent(LabelForGettingSizes.Label))
	end

	local hght = (guiLabelGetFontHeight(LabelForGettingSizes.Label)+2)*(#objects)

	wdth = wdth+4
	hght = hght+4

	self.Back:setSize(wdth+6, hght+6, false)
	self.Shad1:setSize(wdth+6, hght+4, false)
	self.Shad2:setSize(wdth+4, hght+6, false)
	self.Main:setSize(wdth+4, hght+4, false)
	self.Label:setSize(wdth, hght)
	self.Label:setText(text)
end

function CustomTooltip.getText(self)
	return self.Label:getText()
end

function CustomTooltip.destroy(self)

	for _, v in pairs(self.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	self.Label:destroy()
	destroyElement(self.Back)

end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Loadings---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

CustomLoading = {}
CustomLoading.__index = CustomLoading
CustomLoading.ClassName = "CustomLoading"

Loadings = {}
function CustomLoading.create(x, y, relative, parent)

	local id = #Loadings+1
	Loadings[id] = setmetatable({}, CustomLoading)

	if relative then

		w, h = Width, Height

		if parent then
			w, h = parent:getSize(false)
		end

		x, y = x*w, y*h
	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	Loadings[id].Back = GuiStaticImage.create(x, y, 30, 30, pane, false, parent)
	Loadings[id].ColorScheme = DefaultColors
	Loadings[id].Progress = 0
	Loadings[id].Animated = true
	Loadings[id].Element = Loadings[id].Back

	if oldparent and oldparent.ColorScheme ~= nil then
		Loadings[id].ColorScheme = oldparent.ColorScheme
	end

	Loadings[id].Circles = {}

	local color = "FFAAAAAA"
	if Loadings[id].ColorScheme.DarkTheme then
		color = "FFEEEEEE"
	end
	
	for i = 0, 330, 30 do	
		Loadings[id].Circles[#Loadings[id].Circles+1] = GuiStaticImage.create(15 + 10*math.cos(math.rad(i)) - 1, 15 + 10*math.sin(math.rad(i)) - 1, 3, 3, Images.Loading, false, Loadings[id].Back)
		Loadings[id].Circles[#Loadings[id].Circles]:setColor(color)
		Loadings[id].Circles[#Loadings[id].Circles]:setEnabled(false)
	end

	local angle = 0

	Loadings[id].Event = {}

	Loadings[id].Event.Render = {}
	Loadings[id].Event.Render.Name = "onClientRender"
	Loadings[id].Event.Render.Function = function()

		if Loadings[id].Back:getVisible() and Loadings[id].Animated then
			angle = angle+4
			if angle >= 360 then angle = 0 end

			for i, v in pairs(Loadings[id].Circles) do

				v:setPosition(15 + 10*math.cos(math.rad( (i-1)*30 - angle )) - 1, 15 + 10*math.sin(math.rad( (i-1)*30 - angle )) - 1, false)
			end
		end
	end

	addEventHandler(Loadings[id].Event.Render.Name, root, Loadings[id].Event.Render.Function)

	Loadings[id].Back:setColor("0")

	if comparetypes(oldparent, CustomWindow) or comparetypes(oldparent, CustomScrollPane) then
		oldparent:addElement(Loadings[id])
	end

	return Loadings[id]
end

function CustomLoading.setProgress(self, percentage)

	if percentage < 0 then 
		percentage = 0
	elseif percentage > 100 then 
		percentage = 100 
	end

	self.Progress = percentage

	for i = 0, 330, 30 do

		local color = "FFAAAAAA"
		if self.ColorScheme.DarkTheme then
			color = "FFEEEEEE"
		end
		
		if 360-(i+1) <= percentage*3.6 then
			color = "FF"..self.ColorScheme.Main
		end

		self.Circles[math.floor(i/30)+1]:setColor(color)
	end

end

function CustomLoading.setPosition(self, x, y, relative)
	self.Back:setPosition(x, y, relative)
end

function CustomLoading.setEnabled(self, bool)
	self.Back:setEnabled(bool)
end

function CustomLoading.setAnimated(self, bool)
	self.Animated = bool

	for i = 1, 12 do	
		self.Circles[i]:setPosition(15 + 10*math.cos(math.rad( (i-1)*30 )) - 1, 15 + 10*math.sin(math.rad( (i-1)*30 )) - 1, false)
	end
end

function CustomLoading.setVisible(self, bool)
	self.Back:setVisible(bool)
end

function CustomLoading.setColorScheme(self, scheme)
	self.ColorScheme = scheme
	self:setProgress(self:getProgress())
end


function CustomLoading.getProgress(self)
	return self.Progress
end

function CustomLoading.getPosition(self, relative)
	return self.Back:getPosition(relative or false)
end

function CustomLoading.getVisible(self)
	return self.Back:getVisible()
end

function CustomLoading.getEnabled(self)
	return self.Back:getEnabled()
end

function CustomLoading.getAnimated(self)
	return self.Animated
end

function CustomLoading.bringToFront(self) self.Back:bringToFront() end
function CustomLoading.moveToBack(self) self.Back:moveToBack()end

function CustomLoading.getColorScheme(self)
	return self.ColorScheme
end

function CustomLoading.destroy(self)

	for _, v in pairs(self.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	destroyElement(self.Back)

end

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-----------------------------TableView-------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

TableView = {}
function guiCreateCustomTableView(x, y, w, h, relative, parent)

	------------------------------------------------------------------------------------------------------------------------------------------
	--Counting IDs and coordinates
	local id = #TableView+1

	if relative then

		local sw, sh = Width, Height
		if parent then
			sw, sh = parent:getSize(false)
		else
			parent = nil
		end

		x = x*sw
		y = y*sh
		w = w*sw
		h = h*sh

	else

		x = math.floor(x)
		y = math.floor(y)
		w = math.floor(w)
		h = math.floor(h)

	end

	local oldparent = parent
	if compareDefaults(parent) then
		parent = parent:getFrame()
	end

	TableView[id] = {}

	TableView[id].ColorScheme = DefaultColors
	TableView[id].Items = {}
	TableView[id].Lines = {}
	TableView[id].Columns = {}
	TableView[id].Selected = 0
	TableView[id].Indent = 5
	TableView[id].Width = 0

	if oldparent and oldparent.ColorScheme ~= nil then
		TableView[id].ColorScheme = oldparent.ColorScheme
	end


	-------------------------------------------------------------------------------------
	--Creating

	TableView[id].Back = GuiStaticImage.create(x-1, y-1, w+2, h+2, pane, false, parent)
	TableView[id].ShadowVert = GuiStaticImage.create(1, 0, w, h+2, pane, false, TableView[id].Back)
	TableView[id].ShadowHorz = GuiStaticImage.create(0, 1, w+2, h, pane, false, TableView[id].Back)

	TableView[id].Canvas = GuiStaticImage.create(1, 1, w, h, pane, false, TableView[id].Back)

	TableView[id].TitleBlock = GuiStaticImage.create(0, 0, w, 23, pane, false, TableView[id].Canvas)
	TableView[id].Divider = GuiStaticImage.create(0, 22, w, 1, pane, false, TableView[id].TitleBlock)

	TableView[id].Containing = CustomScrollPane.create(0, 23, w, h-23, false, TableView[id].Canvas)
	TableView[id].TitleScrolls = CustomScrollPane.create(0, 0, w, 23, false, TableView[id].TitleBlock)

	TableView[id].ScrollObject = GuiStaticImage.create(0, 0, 1, 1, pane, false, TableView[id].Containing)

	TableView[id].Disabled = GuiStaticImage.create(0, 0, 1, 1, pane, true, TableView[id].Back)

	-------------------------------------------------------------------------------------
	--Properties

	MainCol = "DDDDDD"
	if TableView[id].ColorScheme.DarkTheme then MainCol = "393939" end 

	maincol = "FF"..MainCol
	objcol = "FF"..TableView[id].ColorScheme.DarkMain
	
	TableView[id].Back:setColor("0")
	TableView[id].Canvas:setColor(maincol)
	TableView[id].ShadowVert:setColor("44000000")
	TableView[id].ShadowHorz:setColor("44000000")
	TableView[id].Disabled:setColor("44000000")

	TableView[id].ScrollObject:setColor("0")

	TableView[id].TitleBlock:setColor(objcol)
	TableView[id].Divider:setColor("33000000")

	TableView[id].ShadowVert:setEnabled(false)
	TableView[id].ShadowHorz:setEnabled(false)
	TableView[id].Divider:setEnabled(false)

	TableView[id].Disabled:setVisible(false)

	TableView[id].TitleScrolls:setHorizontalScrolling(true)

	-------------------------------------------------------------------------------------
	--Events

	TableView[id].Event = {}

	TableView[id].Event.MouseEnter = {}
	TableView[id].Event.MouseEnter.Name = "onClientMouseEnter"
	TableView[id].Event.MouseEnter.Function = function()

		for k, item in pairs(TableView[id].Lines) do
			
			TextCol = "333333"
			if TableView[id].ColorScheme.DarkTheme or k == TableView[id].Selected or source == item.Canvas then TextCol = "FFFFFF" end

			NTextCol = "333333"
			if TableView[id].ColorScheme.DarkTheme then NTextCol = "FFFFFF" end

			if k == TableView[id].Selected then
				LineColor = TableView[id].ColorScheme.Main
			else
				LineColor = "EEEEEE"
				if TableView[id].ColorScheme.DarkTheme then LineColor = "444444" end 
			end

			if source == item.Canvas then

				LineColor = TableView[id].ColorScheme.LightMain
				linecol = "FF"..LineColor

				item.Canvas:setColor(linecol)

			end

			for i in pairs(TableView[id].Columns) do
				item.Elements[i]:setColor(TextCol)

				for _, v in pairs(item.Elements[i].Attached) do
					if multiplecompare(v, {CustomLabel, CustomCheckBox}) then
						v.Label:setColor(TextCol)

					elseif multiplecompare(v, {CustomEdit, CustomMemo, CustomSpinner}) then

						v:setSidesColor(LineColor)

					else
						if v.Label then
							v.Label:setColor(NTextCol)
						end
					end
				end
			end
		end

	end


	TableView[id].Event.MouseLeave = {}
	TableView[id].Event.MouseLeave.Name = "onClientMouseLeave"
	TableView[id].Event.MouseLeave.Function = function()

		for it_id, item in pairs(TableView[id].Lines) do

			LineColor = "EEEEEE"
			if TableView[id].ColorScheme.DarkTheme then LineColor = "444444" end 

			linecol = "FF"..LineColor

			if it_id == TableView[id].Selected then
				LineColor = TableView[id].ColorScheme.Main
				linecol = "FF"..LineColor
			end

			item.Canvas:setColor(linecol)

			TextCol = "333333"
			if TableView[id].ColorScheme.DarkTheme or it_id == TableView[id].Selected then TextCol = "FFFFFF" end

			NTextCol = "333333"
			if TableView[id].ColorScheme.DarkTheme then NTextCol = "FFFFFF" end

			for i in pairs(TableView[id].Columns) do
				item.Elements[i]:setColor(TextCol)
				
				for _, v in pairs(item.Elements[i].Attached) do

					if multiplecompare(v, {CustomLabel, CustomCheckBox}) then

						v.Label:setColor(TextCol)

					elseif multiplecompare(v, {CustomEdit, CustomMemo, CustomSpinner}) then

						v:setSidesColor(LineColor)

					else
						if v.Label then
							v.Label:setColor(NTextCol)
						end
					end
				end
			end
		end

	end


	TableView[id].Event.Click = {}
	TableView[id].Event.Click.Name = "onClientGUIClick"
	TableView[id].Event.Click.Function = function()

		local vid = 0
		local sid = TableView[id].Selected
		if sid > TableView[id]:getLinesCount() then sid = 0 end
		
		for t_id, item in pairs(TableView[id].Lines) do
			
			if source == item.Canvas then
				vid = t_id
			end
		end

		if vid > 0 then

			if sid > 0 then
				LineColor = "EEEEEE"
				if TableView[id].ColorScheme.DarkTheme then LineColor = "444444" end 

				DivColor = "CCCCCC"
				if TableView[id].ColorScheme.DarkTheme then DivColor = "333333" end 

				linecol = "FF"..LineColor
				TableView[id].Lines[sid].Canvas:setColor(linecol)

			end
			
			LineColor = TableView[id].ColorScheme.Main
			linecol = "FF"..LineColor

			TableView[id].Selected = vid
			TableView[id].Lines[vid].Canvas:setColor(linecol)

		end
	
		for k, item in pairs(TableView[id].Lines) do

			TextCol = "333333"
			if TableView[id].ColorScheme.DarkTheme or k == TableView[id].Selected then TextCol = "FFFFFF" end

			NTextCol = "333333"
			if TableView[id].ColorScheme.DarkTheme then NTextCol = "FFFFFF" end

			for i in pairs(TableView[id].Columns) do
				item.Elements[i]:setColor(TextCol)
				
				for _, v in pairs(item.Elements[i].Attached) do
					if multiplecompare(v, {CustomLabel, CustomCheckBox}) then
						
						v.Label:setColor(TextCol)

					elseif multiplecompare(v, {CustomEdit, CustomMemo, CustomSpinner}) then

						v:setSidesColor(LineColor)
						triggerEvent("onClientMouseLeave", item.Elements[i].Label)

					else
						if v.Label then
							v.Label:setColor(NTextCol)
						end
					end
				end
			end
		end

	end


	TableView[id].CScrolling = false
	TableView[id].TScrolling = false

	TableView[id].Event.ScrollPaneScrolled = {}
	TableView[id].Event.ScrollPaneScrolled.Name = "onCustomScrollPaneScrolled"
	TableView[id].Event.ScrollPaneScrolled.Function = function(vert, horz)
		
		TableView[id].CScrolling = true
		
		if not TableView[id].TScrolling then
			TableView[id].TitleScrolls:setHorizontalScrollPosition(horz)
		end
		
		TableView[id].CScrolling = false
	end



	TableView[id].Event.ScrollPaneScrolled2 = {}
	TableView[id].Event.ScrollPaneScrolled2.Name = "onCustomScrollPaneScrolled"
	TableView[id].Event.ScrollPaneScrolled2.Function = function(vert, horz)

		TableView[id].TScrolling = true
		
		local w = TableView[id].Containing.Canvas:getSize(false)
		local sw = TableView[id].Containing.Scroller:getSize(false)
		if not TableView[id].CScrolling then
			TableView[id].Containing:setHorizontalScrollPosition(horz)
		end

		TableView[id].TScrolling = false
	end


	addEventHandler(TableView[id].Event.MouseEnter.Name, root, TableView[id].Event.MouseEnter.Function)
	addEventHandler(TableView[id].Event.MouseLeave.Name, root, TableView[id].Event.MouseLeave.Function)
	addEventHandler(TableView[id].Event.Click.Name, root, TableView[id].Event.Click.Function)

	TableView[id].Event.ScrollPaneScrolled.Function = TableView[id].Containing:addEvent(TableView[id].Event.ScrollPaneScrolled.Name, TableView[id].Event.ScrollPaneScrolled.Function)
	TableView[id].Event.ScrollPaneScrolled2.Function = TableView[id].TitleScrolls:addEvent(TableView[id].Event.ScrollPaneScrolled2.Name, TableView[id].Event.ScrollPaneScrolled2.Function)

	return TableView[id]
end

---------------------------------------------------------------------------------------------------------------
--Update Functions

function ctvUpdate(tview)


	tview.Width = 0

	local x = 0
	for col, obj in pairs(tview.Columns) do

		local color = "33000000"
		if col == 1 then color = "0" end

		obj.Divider:setColor(color)
		
		obj.Title:setPosition(x, 0, false)
		obj.Title:setSize(obj.Width, 23, false)

		x = x + obj.Width

	end
	tview.Width = x

	local y = tview.Indent

	local w = tview.Canvas:getSize(false)

	w = math.max(w, tview.Width)

	for _, v in pairs(tview.Lines) do
		
		v.Canvas:setPosition(0, y, false)
		v.Canvas:setSize(w, v.Height, false)
		
		v.Divider:setPosition(0, v.Height-1, false)
		v.Divider:setSize(w, 1, false)

		y = y + v.Height + tview.Indent
	end

	tview.ScrollObject:setPosition(0, y-2, false)
	tview.Containing:update()
	tview.TitleScrolls:update()

	LineColor = "EEEEEE"
	if tview.ColorScheme.DarkTheme then LineColor = "444444" end 

	DivColor = "CCCCCC"
	if tview.ColorScheme.DarkTheme then DivColor = "333333" end 

	MainCol = "DDDDDD"
	if tview.ColorScheme.DarkTheme then MainCol = "393939" end 

	TextCol = "333333"
	if tview.ColorScheme.DarkTheme then TextCol = "FFFFFF" end

	maincol = "FF"..MainCol
	objcol = "FF"..tview.ColorScheme.SubMain

	tview.Canvas:setColor(maincol)
	tview.TitleBlock:setColor(objcol)

	for it_id, item in pairs(tview.Lines) do

		linecol = "FF"..LineColor

		if it_id == tview.Selected then
			linecol = "FF"..tview.ColorScheme.Main
		end

		item.Canvas:setColor(linecol)

		local x = 5	
		for i, v in pairs(tview.Columns) do

			item.Elements[i]:setPosition(x, 0, false)
			item.Elements[i]:setSize(v.Width-5, item.Height, false)
			item.Elements[i]:setText(tview.Items[it_id][i])
			item.Elements[i].ColorScheme = tview.ColorScheme

			for _, sv in pairs(item.Elements[i].Attached) do
				if sv.ColorScheme then
					sv:setColorScheme(tview.ColorScheme)
				end
			end

			local color = TextCol
			if it_id == tview.Selected then 
				color = "FFFFFF" 
			end

			item.Elements[i]:setColor(color)

			x = x + v.Width
		end
	end
	triggerEvent("onClientGUIClick", root)
end

function ctvBringToFront(tview)
	tview.Back:bringToFront()
end

function ctvMoveToBack(tview)
	tview.Back:moveToBack()
end

---------------------------------------------------------------------------------------------------------------
--Adding Elements Functions

function ctvAddLine(tview, height)

	local id = #tview.Lines+1

	------------------------------------------------------------------------------------
	--Calculation

	if not height or height < 22 then 
		height = 22
	end
	height = height+1 --for divider

	local YPos = tview.Indent
	for _, v in pairs(tview.Lines) do
		YPos = YPos + v.Height + tview.Indent
	end

	local width = tview.Canvas:getSize(false)


	------------------------------------------------------------------------------------
	--New tabs

	tview.Items[id] = {}
	tview.Lines[id] = {}

	-------------------------------------------------------------------------------------
	--Line Creation

	tview.Lines[id].Height = height
	tview.Lines[id].Elements = {}

	tview.Lines[id].Canvas = GuiStaticImage.create(0, YPos, width, height, pane, false, tview.Containing)
	tview.Lines[id].Divider = GuiStaticImage.create(0, height-1, width, 1, pane, false, tview.Lines[id].Canvas)

	tview.Lines[id].Divider:setEnabled(false)

	YPos = YPos + height + tview.Indent
	tview.ScrollObject:setPosition(0, YPos, false)
	
	tview.Containing:update()

	local x = 5
	for i, v in pairs(tview.Columns) do

		tview.Items[id][i] = ""

		tview.Lines[id].Elements[i] = CustomLabel.create(x, 0, v.Width-5, height, "", false, tview.Lines[id].Canvas)
		tview.Lines[id].Elements[i]:setVerticalAlign("center")
		tview.Lines[id].Elements[i]:setEnabled(false)
		tview.Lines[id].Elements[i].Cell = true
		tview.Lines[id].Elements[i].TView = tview
		tview.Lines[id].Elements[i].ColorScheme = tview.ColorScheme

		x = x + v.Width
	end

	-------------------------------------------------------------------------------------
	--Properties

	LineColor = "EEEEEE"
	if tview.ColorScheme.DarkTheme then LineColor = "444444" end 

	linecol = "FF"..LineColor

	tview.Lines[id].Canvas:setColor(linecol)
	tview.Lines[id].Divider:setColor("33000000")

	ctvUpdate(tview)
			
	return tview.Lines[id]
end

function ctvRemoveLine(tview, line)

	if not line and line ~= 0 then
		line = #tview.Lines
	end

	if line and tonumber(line) and (1 <= line and line <= #tview.Lines) then

		if line == tview:getSelectedLine() then
			tview:setSelectedLine()
		end

		tview.Containing:removeElement(tview.Lines[line].Canvas)

		for i, v in pairs(tview.Lines[line].Elements) do
			destroyElement(v.Label)
			table.remove(tview.Lines[line].Elements, i)
		end

		destroyElement(tview.Lines[line].Divider)
		destroyElement(tview.Lines[line].Canvas)

		table.remove(tview.Items, line)
		table.remove(tview.Lines, line)


		ctvUpdate(tview)

	else

		if line ~= 0 then
			local id = 0
			
			for t_id, tab in pairs(tview.Lines) do
				if tab == line then
					id = t_id
				end
			end
			
			ctvRemoveLine(tview, id)
		end

	end
end

function ctvClearLines(tview)
	for line = #tview.Lines, 1, -1 do
		ctvRemoveLine(tview, line)
	end
end


function ctvAddColumn(tview, title, width)

	local id = #tview.Columns+1

	---------------------------------------------------------------
	--Calculating	

	if not title then 
		title = ""
	else
		title = tostring(title)
	end

	if not width or width < 50 then 
		width = 50
	end
	width = width+1 --for divider

	local XPos = 0
	for _, v in pairs(tview.Columns) do
		XPos = XPos + v.Width
	end

	---------------------------------------------------------------
	--Creation

	tview.Columns[id] = {}
	tview.Columns[id].Width = width

	tview.Columns[id].Title = CustomLabel.create(XPos, 0, width, 23, title, false, tview.TitleScrolls)
	tview.Columns[id].Divider = GuiStaticImage.create(0, 0, 1, 22, pane, false, tview.Columns[id].Title.Label)

	for i, v in pairs(tview.Lines) do

		tview.Items[i][id] = ""

		v.Elements[id] = CustomLabel.create(XPos+5, 0, tview.Columns[id].Width-5, v.Height, "Sas", false, v.Canvas)
		v.Elements[id]:setVerticalAlign("center")
		v.Elements[id]:setEnabled(false)
		v.Elements[id].Elements[i].Cell = true
		v.Elements[id].Elements[i].TView = tview
		v.Elements[id].Elements[i].ColorScheme = tview.ColorScheme

	end

	---------------------------------------------------------------
	--Properties

	local color = "33000000"
	if id == 1 then color = "0" end

	tview.Columns[id].Divider:setColor(color)
	tview.Columns[id].Divider:setEnabled(false)

	tview.Columns[id].Title:setColor("FFFFFF")
	tview.Columns[id].Title:setAlign("center", "center")

	ctvUpdate(tview)

	return tview.Columns[id]
end

function ctvRemoveColumn(tview, column)

	if not column then
		column = #tview.Columns
	end

	if column and tonumber(column) and (1 <= column and column <= #tview.Columns) then


		for i, v in pairs(tview.Lines) do

			destroyElement(v.Elements[column].Label)

			table.remove(tview.Items[i], column)
			table.remove(tview.Lines[i].Elements, column)

		end

		tview.TitleScrolls:removeElement(tview.Columns[column].Title)

		destroyElement(tview.Columns[column].Divider)
		destroyElement(tview.Columns[column].Title.Label)

		table.remove(tview.Columns, column)
		
		ctvUpdate(tview)

	else

		if column ~= 0 then
			local id = 0
			
			for t_id, tab in pairs(tview.Columns) do
				if tab == column or tab.Title:getText() == column then
					id = t_id
				end
			end
			
			return ctvRemoveColumn(tview, id)
		end
	end

end

-------------------------------------
--Set Functions

function ctvSetPosition(tview, x, y, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = label.Label.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	tview.Back:setPosition(x-1, y-1, false)

end

function ctvSetSize(tview, w, h, rel)
	
	if rel then

		local sw, sh = Width, Height
		local parent = label.Label.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	local c = tview.TitleBlock:getVisible() and 1 or 0

	tview.Back:setSize(w+2, h+2, false)
	tview.ShadowVert:setSize(w, h+2, false)
	tview.ShadowHorz:setSize(w+2, h, false)

	tview.Canvas:setSize(w, h, false)
	tview.TitleBlock:setSize(w, 23, false)
	tview.Divider:setSize(w, 1, false)

	tview.Containing:setSize(w, h-c*23, false)
	tview.TitleScrolls:setSize(w, 23, false)

	ctvUpdate(tview)
end

function ctvSetEnabled(tview, bool)

	tview.Disabled:setVisible(not bool)
	tview.Back:setEnabled(bool)

	tview.Disabled:bringToFront()

end

function ctvSetVisible(tview, bool)
	tview.Back:setVisible(bool)
end


function ctvSetIndentation(tview, height)
	
	if not height or not tonumber(height) then height = 5 end
	if height < 0 then height = 0 end

	tview.Indent = height
	ctvUpdate(tview)
end

function ctvSetTitleBarVisible(tview, bool)

	local w, h = tview.Canvas:getSize(false)
	local c = bool and 1 or 0

	tview.TitleBlock:setVisible(bool)

	tview.Containing:setPosition(0, c*23, false)
	tview.Containing:setSize(w, h-c*23, false)

end

function ctvSetSelectedLine(tview, line)
	
	if not line then
		line = 0
	end

	if line and tonumber(line) and (0 <= line and line <= #tview.Lines) then

		tview.Selected = line

		ctvUpdate(tview)

	else

		local id = 0
		
		for t_id, tab in pairs(tview.Lines) do
			if tab == line then
				id = t_id
			end
		end
		
		ctvSetSelectedLine(tview, id)
	end
end

function ctvSetLineHeight(tview, line, height)
	
	if not height or height < 22 then 
		height = 22
	end
	height = height+1 --for divider


	if not line then
		line = 1
	end

	if line and tonumber(line) and (1 <= line and line <= #tview.Lines) then

		tview.Lines[line].Height = height

		ctvUpdate(tview)

	else

		local id = 1
		
		for t_id, tab in pairs(tview.Lines) do
			if tab == line then
				id = t_id
			end
		end
		
		ctvSetLineHeight(tview, id, height-1)
	end

end

function ctvSetColumnWidth(tview, column, width)
	
	if not width or width < 50 then 
		width = 50
	end
	width = width+1 --for divider


	if not column then
		column = 1
	end

	if column and tonumber(column) and (1 <= column and column <= #tview.Columns) then

		tview.Columns[column].Width = width

		ctvUpdate(tview)

	else

		local id = 1
		
		for t_col, tab in pairs(tview.Columns) do
			if tab == column or tab.Title:getText() == column then
				id = t_col
			end
		end
		
		ctvSetColumnWidth(tview, id, width-1)
	end
end

function ctvSetColumnTitle(tview, column, title)
	
	if not title then 
		title = ""
	else
		title = tostring(title)
	end

	if not column then
		column = 1
	end

	if column and tonumber(column) and (1 <= column and column <= #tview.Columns) then

		tview.Columns[column].Title:setText(title)

	else

		local id = 1
		
		for t_col, tab in pairs(tview.Columns) do
			if tab == column or tab.Title:getText() == column then
				id = t_col
			end
		end
		
		ctvSetColumnTitle(tview, id, title)
	end
end

function ctvSetColorScheme(tview, scheme)

	tview.ColorScheme = scheme
	ctvUpdate(tview)

end


function ctvSetCellText(tview, line, column, text)

	if not text then 
		text = ""
	else
		text = tostring(text)
	end


	if not column then
		column = 1
	end

	if not line then
		line = 1
	end

	if 
		(column and tonumber(column) and (1 <= column and column <= #tview.Columns)) and
		(line and tonumber(line) and (1 <= line and line <= #tview.Lines))
	then

		tview.Items[line][column] = text
		ctvUpdate(tview)

	else

		local cid = column

		if not (column and tonumber(column) and (1 <= column and column <= #tview.Columns)) then
	
			cid = 1
			for t_col, tab in pairs(tview.Columns) do
				if tab == column or tab.Title:getText() == column then
					cid = t_col
				end
			end
		end

		local rid = line
		
		if not (line and tonumber(line) and (1 <= line and line <= #tview.Lines)) then
			
			rid = 1
			for t_item, tab in pairs(tview.Lines) do
				if tab == line then
					rid = t_item
				end
			end
		end
		
		ctvSetCellText(tview, rid, cid, text)
	end
end


-------------------------------------
--Get Functions

function ctvGetEnabled(tview)
	return tview.Back:getEnabled()
end

function ctvGetVisible(tview)
	return tview.Back:getVisible()
end

function ctvGetPosition(tview, rel)
	if rel then
		return tview.Back:getPosition(true)
	else
		local x, y = tview.Back:getPosition(false)
		return x+1, y+1
	end
end

function ctvGetSize(tview, rel)
	if rel then
		return tview.Canvas:getSize(true)
	else
		return tview.Back:getSize(false)
	end
end

function ctvGetRealSize(tview, rel)
	return tview.Back:getSize(rel or false)
end	

function ctvGetColorScheme(tview)
	return tview.ColorScheme
end

function ctvGetSelectedLine(tview)
	return tview.Selected
end

function ctvGetIndentation(tview)
	return tview.Selected
end

function ctvGetTitleBarVisible(tview)
	return tview.TitleBlock:getVisible()
end

function ctvGetLineHeight(tview, line)
	
	if not line then
		line = 1
	end

	if line and tonumber(line) and (1 <= line and line <= #tview.Lines) then

		return tview.Lines[line].Height

	else

		local id = 1
		
		for t_id, tab in pairs(tview.Lines) do
			if tab == line then
				id = t_id
			end
		end
		
		return ctvGetLineHeight(tview, id)
	end

end


function ctvGetColumnWidth(tview, column)
	
	if not column then
		column = 1
	end

	if column and tonumber(column) and (1 <= column and column <= #tview.Columns) then

		return tview.Columns[column].Width

	else

		local id = 1
		
		for t_id, tab in pairs(tview.Columns) do
			if tab == column or tab.Title:getText() == column then
				id = t_id
			end
		end
		
		return ctvGetColumnWidth(tview, id)
	end

end


function ctvGetColumnTitle(tview, column)
	
	if not column then
		column = 1
	end

	if column and tonumber(column) and (1 <= column and column <= #tview.Columns) then

		return tview.Columns[column].Title:getText()

	else

		local id = 1
		
		for t_id, tab in pairs(tview.Columns) do
			if tab == column or tab.Title:getText() == column then
				id = t_id
			end
		end
		
		return ctvGetColumnWidth(tview, id)
	end

end

function ctvGetCellText(tview, line, column)

	if not column then
		column = 1
	end

	if not line then
		line = 1
	end

	if 
		(column and tonumber(column) and (1 <= column and column <= #tview.Columns)) and
		(line and tonumber(line) and (1 <= line and line <= #tview.Lines))
	then

		return tview.Items[line][column]

	else

		local cid = column

		if not (column and tonumber(column) and (1 <= column and column <= #tview.Columns)) then
	
			cid = 1
			for t_col, tab in pairs(tview.Columns) do
				if tab == column or tab.Title:getText() == column then
					cid = t_col
				end
			end
		end

		local rid = line
		
		if not (line and tonumber(line) and (1 <= line and line <= #tview.Lines)) then
			
			rid = 1
			for t_item, tab in pairs(tview.Lines) do
				if tab == line then
					rid = t_item
				end
			end
		end
		
		return ctvGetCellText(tview, rid, cid)
	end
end

function ctvGetCell(tview, line, column)

	if not column then
		column = 1
	end

	if not line then
		line = 1
	end

	if 
		(column and tonumber(column) and (1 <= column and column <= #tview.Columns)) and
		(line and tonumber(line) and (1 <= line and line <= #tview.Lines))
	then

		return tview.Lines[line].Elements[column]

	else

		local cid = column

		if not (column and tonumber(column) and (1 <= column and column <= #tview.Columns)) then
	
			cid = 1
			for t_col, tab in pairs(tview.Columns) do
				if tab == column or tab.Title:getText() == column then
					cid = t_col
				end
			end
		end

		local rid = line
		
		if not (line and tonumber(line) and (1 <= line and line <= #tview.Lines)) then
			
			rid = 1
			for t_item, tab in pairs(tview.Lines) do
				if tab == line then
					rid = t_item
				end
			end
		end

		return ctvGetCell(tview, rid, cid)
	end
end

function ctvGetLinesCount(tview)
	return #tview.Lines
end

function ctvGetColumnsCount(tview)
	return #tview.Columns
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Event

function ctvAddEvent(tview, event, func)

	local f1 = function(...)

		local visited = false

		for _, v in pairs(tview.Lines) do
			if source == v.Canvas then
				visited = true
				break
			end
		end

		for _, v in pairs(tview.Columns) do
			if source == v.Title.Label then
				visited = true
			end
		end

		if source == tview.Canvas or source == tview.Back or source == tview.TitleBlock or visited then
			func(...)
		end

	end

	addEventHandler(event, root, f1)

	local f2 = tview.Containing:addEvent(event, func)
	local f3 = tview.TitleScrolls:addEvent(event, func)

	return {f1, f2, f3}
end

function ctvRemoveEvent(tview, event, funcs)

	local f1, f2, f3 = unpack(funcs)

	removeEventHandler(event, root, f1)
	tview.Containing:removeEvent(event, f2)
	tview.TitleScrolls:removeEvent(event, f3)

end

function ctvDestroy(tview)

	for _, v in pairs(tview.Event) do
		removeEventHandler(v.Name, root, v.Function)
	end

	tview:clearLines()

	for _, v in pairs(tview.Columns) do
		v.Title:destroy()
	end

	destroyElement(tview.Back)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP functions
CustomTableView = {}
CustomTableView.__index = CustomTableView
CustomTableView.ClassName = "CustomTableView"

function CustomTableView.create(...)
	local self = setmetatable(guiCreateCustomTableView(...), CustomTableView)
	compareAppend(self, ...)

	return self
end

function CustomTableView.addLine(self, ...) return ctvAddLine(self, ...) end
function CustomTableView.removeLine(self, ...) return ctvRemoveLine(self, ...) end
function CustomTableView.clearLines(self, ...) return ctvClearLines(self, ...) end
function CustomTableView.addColumn(self, ...) return ctvAddColumn(self, ...) end
function CustomTableView.removeColumn(self, ...) return ctvRemoveColumn(self, ...) end

function CustomTableView.update(self, ...) return ctvUpdate(self, ...) end

function CustomTableView.setPosition(self, ...) return ctvSetPosition(self, ...) end
function CustomTableView.setSize(self, ...) return ctvSetSize(self, ...) end
function CustomTableView.setVisible(self, ...) return ctvSetVisible(self, ...) end
function CustomTableView.setEnabled(self, ...) return ctvSetEnabled(self, ...) end
function CustomTableView.setColorScheme(self, ...) return ctvSetColorScheme(self, ...) end
function CustomTableView.setSelectedLine(self, ...) return ctvSetSelectedLine(self, ...) end
function CustomTableView.setIndentation(self, ...) return ctvSetIndentation(self, ...) end
function CustomTableView.setTitleBarVisible(self, ...) return ctvSetTitleBarVisible(self, ...) end
function CustomTableView.setLineHeight(self, ...) return ctvSetLineHeight(self, ...) end
function CustomTableView.setColumnWidth(self, ...) return ctvSetColumnWidth(self, ...) end
function CustomTableView.setColumnTitle(self, ...) return ctvSetColumnTitle(self, ...) end
function CustomTableView.setCellText(self, ...) return ctvSetCellText(self, ...) end

function CustomTableView.bringToFront(self, ...) return ctvBringToFront(self, ...) end
function CustomTableView.moveToBack(self, ...) return ctvMoveToBack(self, ...) end

function CustomTableView.getPosition(self, ...) return ctvGetPosition(self, ...) end
function CustomTableView.getSize(self, ...) return ctvGetSize(self, ...) end
function CustomTableView.getRealSize(self, ...) return ctvGetRealSize(self, ...) end
function CustomTableView.getVisible(self, ...) return ctvGetVisible(self, ...) end
function CustomTableView.getEnabled(self, ...) return ctvGetEnabled(self, ...) end
function CustomTableView.getColorScheme(self, ...) return ctvGetColorScheme(self, ...) end
function CustomTableView.getSelectedLine(self, ...) return ctvGetSelectedLine(self, ...) end
function CustomTableView.getIndentation(self, ...) return ctvGetIndentation(self, ...) end
function CustomTableView.getTitleBarVisible(self, ...) return ctvGetTitleBarVisible(self, ...) end
function CustomTableView.getLineHeight(self, ...) return ctvGetLineHeight(self, ...) end
function CustomTableView.getColumnWidth(self, ...) return ctvGetColumnWidth(self, ...) end
function CustomTableView.getColumnTitle(self, ...) return ctvGetColumnTitle(self, ...) end
function CustomTableView.getCellText(self, ...) return ctvGetCellText(self, ...) end
function CustomTableView.getCell(self, ...) return ctvGetCell(self, ...) end
function CustomTableView.getLinesCount(self, ...) return ctvGetLinesCount(self, ...) end
function CustomTableView.getColumnsCount(self, ...) return ctvGetColumnsCount(self, ...) end

function CustomTableView.addEvent(self, ...) return ctvAddEvent(self, ...) end
function CustomTableView.removeEvent(self, ...) return ctvRemoveEvent(self, ...) end
function CustomTableView.destroy(self, ...) return ctvDestroy(self, ...) end


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Events-----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

addEvent("onCustomScrollBarScrolled", true)
addEvent("onCustomScrollPaneScrolled", true)
addEvent("onCustomDialogClick", true)
addEvent("onCustomWindowClose", true)
addEvent("onCustomCheckBoxChecked", true)
addEvent("onCustomComboBoxSelectItem", true)
addEvent("onCustomTabPanelChangeTab", true)