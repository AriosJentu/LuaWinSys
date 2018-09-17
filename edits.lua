local HPerc = 2.4

function isCWCursorShowing()
	return isCursorShowing() or isConsoleActive()
end

function getCharCoordsFromAbsoluteCoords(edit, x, y)
	
	local AW, AH = edit.Label:getSize()
	local AX, AY = edit.Label:getPosition()

	if y < AY then 
		x = AX
		y = AY
	end

	if y >= AH+AY then
		x = AX+AW-1
		y = AY+AH-1
	end

	--Calculating font height and text
	local h = guiLabelGetFontHeight(edit.Label.Label)
	local text = edit.Label:getText()

	--Getting lines count
	local lines = text:split("\n")

	--Get line by clicked Y coordinate, using font height
	local line = math.min(math.floor(y/(h+HPerc))+1, #lines)

	--Set this text from line to help label
	edit.HelpLabel:setText(lines[line])

	--Calculate width of label
	local w = guiLabelGetTextExtent(edit.HelpLabel.Label)
	
	--Getting position of character using width of help label
	local pos = #lines[line]	
	while math.max(x+3, 0) < w do
		pos = pos-1
		text = edit.HelpLabel:getText()						--Get help label text
		edit.HelpLabel:setText(utf8.sub(text, 1, pos))		--Sub from help label text one last char 
		w = guiLabelGetTextExtent(edit.HelpLabel.Label)		--Recalculate width
	end
	--Get maximal position of char
	pos = math.min(pos, #lines[line])	

	--Set text to calculate absolute coords of char
	edit.HelpLabel:setText(utf8.sub(lines[line], 1, pos))
	
	--Calculate absolute coords
	local ny = (line-1)*(h+HPerc)
	local nx = guiLabelGetTextExtent(edit.HelpLabel.Label)

	--Calculate char 
	local caretindex = pos
	for i = 1, line-1 do
		caretindex = caretindex + #lines[i] + 1
	end

	--returns CharY, CharX, CaretIndex, AbsCharX, AbsCharY
	return line, pos, caretindex, nx, ny
end

function getCharCoordsFromCaretIndex(edit, caret)

	local text = edit.Label:getText()
	local lines = text:split("\n")
	local h = guiLabelGetFontHeight(edit.Label.Label)

	local lcaret = caret
	local line = 1
	for i, v in pairs(lines) do
		if lcaret > #v then
			lcaret = lcaret - (#v + 1)
		else 
			line = i
			break 
		end
	end

	--[[if utf8.sub(lines[line], lcaret, lcaret) == "" and lcaret ~= 0 then 
		lcaret = 0
		line = line+1
	end]]

	edit.HelpLabel:setText(utf8.sub(lines[line], 1, lcaret))
	
	local ny = (line-1)*(h+HPerc)
	local nx = guiLabelGetTextExtent(edit.HelpLabel.Label)

	return nx, ny
end

local NewEditBoxes = {}
function guiCreateCustomEditPanel(x, y, w, h, text, rel, parent, multilined)

	local id = #NewEditBoxes+1

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

	if not multilined then
		multilined = false
	end

	--------------------------------------------------------------

	NewEditBoxes[id] = {}
	NewEditBoxes[id].ColorScheme = DefaultColors
	NewEditBoxes[id].Active = false
	NewEditBoxes[id].IsSelecting = false

	NewEditBoxes[id].CaretIndex = 0
	NewEditBoxes[id].SelectingCaretIndex = 0
	
	NewEditBoxes[id].MultiLined = multilined

	--------------------------------------------------------------

	NewEditBoxes[id].Canvas = GuiStaticImage.create(x, y, w, h, pane, false, parent)
	NewEditBoxes[id].Scroller = CustomScrollPane.create(0, 0, w, h, false, NewEditBoxes[id].Canvas)
	NewEditBoxes[id].HelpLabel = CustomLabel.create(0, 0, 0, 0, "", false, NewEditBoxes[id].Canvas)

	NewEditBoxes[id].Caret = GuiStaticImage.create(0, 0, 2, h, pane, false, NewEditBoxes[id].Scroller)
	NewEditBoxes[id].SelectionCaret = GuiStaticImage.create(0, 0, 2, h, pane, false, NewEditBoxes[id].Scroller)

	NewEditBoxes[id].SelectorTop = GuiStaticImage.create(0, 0, 1, h, pane, false, NewEditBoxes[id].Scroller)
	NewEditBoxes[id].SelectorMid = GuiStaticImage.create(0, 0, w, h, pane, false, NewEditBoxes[id].Scroller)
	NewEditBoxes[id].SelectorBot = GuiStaticImage.create(0, 0, 1, h, pane, false, NewEditBoxes[id].Scroller)

	NewEditBoxes[id].Label = CustomLabel.create(2, 2,  w-4, h-4, text, false, NewEditBoxes[id].Scroller)

	--------------------------------------------------------------

	local nw = guiLabelGetTextExtent(NewEditBoxes[id].Label.Label)
	local nh = guiLabelGetFontHeight(NewEditBoxes[id].Label.Label)
	local sh = h

	if NewEditBoxes[id].MultiLined then
		sh = (nh+HPerc)*#text:split("\n")
	else
		print("HERE", (h-nh)/2 - 2, h, nh)
		NewEditBoxes[id].Label:setPosition(2, (h-nh)/2 - 2, false)		
		NewEditBoxes[id].HelpLabel:setPosition(2, (h-nh)/2 - 2, false)		
	end

	NewEditBoxes[id].Label:setSize(nw, sh)	
	NewEditBoxes[id].Caret:setSize(2, nh, false)	
	NewEditBoxes[id].Caret:setPosition(0, (h-nh)/2, false)
	NewEditBoxes[id].SelectionCaret:setSize(2, nh, false)	
	NewEditBoxes[id].SelectionCaret:setPosition(0, (h-nh)/2, false)

	NewEditBoxes[id].Scroller:update()

	NewEditBoxes[id].Scroller:setScrollingWithCursor(false)
	NewEditBoxes[id].Scroller:setHorizontalScrolling(not NewEditBoxes[id].MultiLined)

	NewEditBoxes[id].Canvas:setColor("FF444444")
	NewEditBoxes[id].Label:setColor("EEEEEE")
	NewEditBoxes[id].Label:setEnabled(false)

	NewEditBoxes[id].Caret:setVisible(false)
	NewEditBoxes[id].Caret:setEnabled(false)
	NewEditBoxes[id].Caret:setColor("FF"..NewEditBoxes[id].ColorScheme.Main)

	NewEditBoxes[id].SelectionCaret:setVisible(false)
	NewEditBoxes[id].SelectionCaret:setEnabled(false)
	NewEditBoxes[id].SelectionCaret:setColor("FF"..NewEditBoxes[id].ColorScheme.Main)

	NewEditBoxes[id].SelectorTop:setVisible(false)
	NewEditBoxes[id].SelectorMid:setVisible(false)
	NewEditBoxes[id].SelectorBot:setVisible(false)

	NewEditBoxes[id].SelectorTop:setEnabled(false)
	NewEditBoxes[id].SelectorMid:setEnabled(false)
	NewEditBoxes[id].SelectorBot:setEnabled(false)

	NewEditBoxes[id].SelectorTop:setColor("FF"..NewEditBoxes[id].ColorScheme.Main)
	NewEditBoxes[id].SelectorMid:setColor("FF"..NewEditBoxes[id].ColorScheme.Main)
	NewEditBoxes[id].SelectorBot:setColor("FF"..NewEditBoxes[id].ColorScheme.Main)

	--------------------------------------------------------------

	NewEditBoxes[id].Events = {}

	NewEditBoxes[id].Events.ClickScroller = {}
	NewEditBoxes[id].Events.ClickScroller.Name = "onClientGUIClick"
	NewEditBoxes[id].Events.ClickScroller.Function = function(_, _, x, y)

		NewEditBoxes[id].Active = true

		local ax, ay = guiGetOnScreenPosition(NewEditBoxes[id].Label.Label)
		local _, _, caret = getCharCoordsFromAbsoluteCoords(NewEditBoxes[id], x-ax, y-ay)

		cxpSetCaretIndex(NewEditBoxes[id], caret)
		NewEditBoxes[id].SelectionCaret:setVisible(false)
	end

	NewEditBoxes[id].Events.MouseDown = {}
	NewEditBoxes[id].Events.MouseDown.Name = "onClientGUIMouseDown"
	NewEditBoxes[id].Events.MouseDown.Function = function(button, x, y)

		NewEditBoxes[id].IsSelecting = true
		NewEditBoxes[id].Events.ClickScroller.Function(_, _, x, y)

	end

	NewEditBoxes[id].Events.MouseUp = {}
	NewEditBoxes[id].Events.MouseUp.Name = "onClientGUIMouseUp"
	NewEditBoxes[id].Events.MouseUp.Function = function()
		NewEditBoxes[id].IsSelecting = false
	end

	NewEditBoxes[id].Events.CursorMove = {}
	NewEditBoxes[id].Events.CursorMove.Name = "onClientCursorMove"
	NewEditBoxes[id].Events.CursorMove.Function = function(_, _, x, y)

		if NewEditBoxes[id].IsSelecting and isCWCursorShowing() then
			
			local ax, ay = guiGetOnScreenPosition(NewEditBoxes[id].Label.Label)
			local _, _, caret = getCharCoordsFromAbsoluteCoords(NewEditBoxes[id], x-ax, y-ay)

			cxpSetCaretIndex(NewEditBoxes[id], caret, true)
			NewEditBoxes[id].SelectionCaret:setVisible(true)

		end
	end

	NewEditBoxes[id].Events.Click = {}
	NewEditBoxes[id].Events.Click.Name = "onClientGUIClick"
	NewEditBoxes[id].Events.Click.Function = function()
		NewEditBoxes[id].Active = false
		NewEditBoxes[id].Caret:setVisible(false)
	end

	NewEditBoxes[id].Events.Char = {}
	NewEditBoxes[id].Events.Char.Name = "onClientCharacter"
	NewEditBoxes[id].Events.Char.Function = function(button)

		if NewEditBoxes[id].Active and isCWCursorShowing() then
			
			local str = NewEditBoxes[id].Label:getText()
			local start = NewEditBoxes[id].CaretIndex
		
			if NewEditBoxes[id].SelectingCaretIndex == NewEditBoxes[id].CaretIndex then
				str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex)..button..utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str) 
			else
				start = math.min(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
				local ends = start + math.abs(NewEditBoxes[id].SelectingCaretIndex - NewEditBoxes[id].CaretIndex) + 1
				str = utf8.sub(str, 0, start)..button..utf8.sub(str, ends, #str)
			end

			NewEditBoxes[id].Label:setText(str)
			cxpSetCaretIndex(NewEditBoxes[id], start+1)
		end
	end

	NewEditBoxes[id].Events.Key = {}
	NewEditBoxes[id].Events.Key.Name = "onClientKey"
	NewEditBoxes[id].Events.Key.Function = function(button, por)

		if NewEditBoxes[id].Active and por and isCWCursorShowing() then

			local shift = getKeyState("lshift") or getKeyState("rshift")

			if button == "backspace" then

				local str = NewEditBoxes[id].Label:getText()
				local start = NewEditBoxes[id].CaretIndex-1

				if NewEditBoxes[id].SelectingCaretIndex == NewEditBoxes[id].CaretIndex then
					str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex-1)..utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str)
				else
					start = math.min(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
					local ends = start + math.abs(NewEditBoxes[id].SelectingCaretIndex - NewEditBoxes[id].CaretIndex) + 1
					str = utf8.sub(str, 0, start)..utf8.sub(str, ends, #str)
				end

				NewEditBoxes[id].Label:setText(str)
				cxpSetCaretIndex(NewEditBoxes[id], start)
			end

			if button == "delete" then

				local str = NewEditBoxes[id].Label:getText()
				local start = NewEditBoxes[id].CaretIndex

				if NewEditBoxes[id].SelectingCaretIndex == NewEditBoxes[id].CaretIndex then
					str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex)..utf8.sub(str, NewEditBoxes[id].CaretIndex+2, #str)
				else
					start = math.min(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
					local ends = start + math.abs(NewEditBoxes[id].SelectingCaretIndex - NewEditBoxes[id].CaretIndex) + 1
					str = utf8.sub(str, 0, start)..utf8.sub(str, ends, #str)
				end
				
				NewEditBoxes[id].Label:setText(str)
				cxpSetCaretIndex(NewEditBoxes[id], start)
			end

			if button == "enter" then
				if NewEditBoxes[id].MultiLined then
					NewEditBoxes[id].Events.Char.Function("\n")
				end
			end

			if button == "arrow_l" then
				cxpSetCaretIndex(NewEditBoxes[id], NewEditBoxes[id].SelectingCaretIndex-1, shift)
			end

			if button == "arrow_r" then
				cxpSetCaretIndex(NewEditBoxes[id], NewEditBoxes[id].SelectingCaretIndex+1, shift)
			end

			if button == "arrow_u" then

				local x, y = NewEditBoxes[id].SelectionCaret:getPosition(false)
				local _, _, caret = getCharCoordsFromAbsoluteCoords(NewEditBoxes[id], x-2, y-5)

				cxpSetCaretIndex(NewEditBoxes[id], caret, shift)
			end

			if button == "arrow_d" then

				local x, y = NewEditBoxes[id].SelectionCaret:getPosition(false)
				local _, h = NewEditBoxes[id].Caret:getSize(false)
				local _, _, caret = getCharCoordsFromAbsoluteCoords(NewEditBoxes[id], x-2, y+h+5)

				cxpSetCaretIndex(NewEditBoxes[id], caret, shift)
			end

		end
	end
	
	addEventHandler(NewEditBoxes[id].Events.Click.Name, root, NewEditBoxes[id].Events.Click.Function)
	NewEditBoxes[id].Events.ClickScroller.Function = NewEditBoxes[id].Scroller:addEvent(NewEditBoxes[id].Events.ClickScroller.Name, NewEditBoxes[id].Events.ClickScroller.Function)
	addEventHandler(NewEditBoxes[id].Events.Char.Name, root, NewEditBoxes[id].Events.Char.Function)
	addEventHandler(NewEditBoxes[id].Events.Key.Name, root, NewEditBoxes[id].Events.Key.Function)

	NewEditBoxes[id].Events.MouseDown.Function = NewEditBoxes[id].Scroller:addEvent(NewEditBoxes[id].Events.MouseDown.Name, NewEditBoxes[id].Events.MouseDown.Function)
	addEventHandler(NewEditBoxes[id].Events.MouseUp.Name, root, NewEditBoxes[id].Events.MouseUp.Function)
	addEventHandler(NewEditBoxes[id].Events.CursorMove.Name, root, NewEditBoxes[id].Events.CursorMove.Function)

	--------------------------------------------------------------

	return NewEditBoxes[id]
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function cxpSetCaretIndex(edit, caret, selection)

	edit.SelectorTop:setVisible(false)
	edit.SelectorMid:setVisible(false)
	edit.SelectorBot:setVisible(false)

	local text = edit.Label:getText()
	local indx = math.min(#text, math.max(caret, 0))

	if not selection then
		edit.CaretIndex = indx
	end
	edit.SelectingCaretIndex = indx

	local nx, ny = edit.Label:getPosition()
	local sx, sy = getCharCoordsFromCaretIndex(edit, indx)

	edit.SelectionCaret:setPosition(nx+sx, ny+sy+2, false)

	if not selection then
		edit.Caret:setPosition(nx+sx, ny+sy+2, false)
		edit.Caret:setVisible(edit.Active)
	end
	
	--Selection
	local _, CH = edit.Caret:getSize(false)
	local C2X, C2Y = edit.SelectionCaret:getPosition(false)
	if selection then

		local C1X, C1Y = edit.Caret:getPosition(false)
		local NW = edit.Label:getSize(false)
		CH = CH+4

		if C1Y == C2Y then

			edit.SelectorTop:setPosition(math.min(C1X, C2X), C1Y-2, false)
			edit.SelectorTop:setSize(math.abs(C1X-C2X)+2, CH, false)
			edit.SelectorTop:setVisible(true)

		else

			local miny, maxy = math.min(C1Y, C2Y), math.max(C1Y, C2Y)
			local minx, maxx = C1X, C2X
			if miny == C2Y then minx, maxx = C2X, C1X end

			local SH = maxy-(miny+CH-2)
			if SH < CH-3 then SH = 0 end 

			edit.SelectorTop:setPosition(minx, miny-2, false)
			edit.SelectorTop:setSize(NW-minx, CH, false)

			edit.SelectorBot:setPosition(0, maxy-2, false)
			edit.SelectorBot:setSize(maxx+2, CH, false)

			edit.SelectorMid:setPosition(0, miny+CH-2, false)
			edit.SelectorMid:setSize(NW, SH, false)

			edit.SelectorTop:setVisible(true)
			edit.SelectorBot:setVisible(true)
			edit.SelectorMid:setVisible(true)
		end

	end
	
	cxpRecalc(edit)

	local ax, ay = guiGetOnScreenPosition(edit.SelectionCaret)
	local cx, cy = guiGetOnScreenPosition(edit.Label.Label)
	local dx, dy = edit.Scroller.Scroller:getPosition(false)
	local dw, dh = edit.Scroller.Scroller:getSize(false)
	local xw, xh = edit.Canvas:getSize(false)

	local CaretX, CaretY = ax-cx+dx, ay-cy+dy
	if CaretY < 0 or CaretY+CH > xh then

		local pixs = CaretY+CH-xh+10		
		if CaretY < 0 then pixs = CaretY-6 end 
		edit.Scroller:addVerticalPixelScrollPosition(pixs)

	end

	print(CaretX, xw)
	if CaretX < 0 or CaretX+4 > xw then

		local pixs = CaretX-xw+8		
		if CaretX < 0 then pixs = CaretX-3 end 
		edit.Scroller:addHorizontalPixelScrollPosition(pixs)

	end

end

function cxpRecalc(edit)

	local text = edit.Label:getText()

	local nw = guiLabelGetTextExtent(edit.Label.Label)
	local nh = guiLabelGetFontHeight(edit.Label.Label)
	local sh = nh
	if edit.MultiLined then
		sh = (nh+HPerc)*#text:split("\n")
	end

	edit.Label:setSize(nw, sh)	
	edit.Scroller:update()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local str = [[Lorem ipsum dolor sit amet, 
consectetur adipiscing elit, 
sed do eiusmod tempor incididunt 
ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis 
nostrud exercitation ullamco 
laboris nisi ut aliquip ex ea 
commodo consequat. Duis aute irure 
dolor in reprehenderit in voluptate 
velit esse cillum dolore eu fugiat 
nulla pariatur. Excepteur sint 
occaecat cupidatat non proident, 
sunt in culpa qui officia deserunt 
mollit anim id est laborum.
Lorem ipsum dolor sit amet, 
consectetur adipiscing elit, 
sed do eiusmod tempor incididunt 
ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis 
nostrud exercitation ullamco 
laboris nisi ut aliquip ex ea 
commodo consequat. Duis aute irure 
dolor in reprehenderit in voluptate 
velit esse cillum dolore eu fugiat 
nulla pariatur. Excepteur sint 
occaecat cupidatat non proident, 
sunt in culpa qui officia deserunt 
mollit anim id est laborum.]]

local nmemo = guiCreateCustomEditPanel(100, 300, 250, 200, str, _, _, true)
local nedit = guiCreateCustomEditPanel(100, 250, 250, 30, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", _, _, false)
