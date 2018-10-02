local clipboard = ""
sclip = setClipboard
function setClipboard(text)
	clipboard = text
	return sclip(text)
end
function getClipboard() return clipboard end

local HPerc = 2.4
local CHARTAB = {
	" ", 
	"\n", 
	"%.", 
	",", 
	"%^", 
	"'", 
	'"', 
	"#", 
	"/", 
	"\\", 
	"%(", 
	")", 
	"%[", 
	"]", 
	"%{", 
	"}", 
	"<", 
	">", 
	"=", 
	"+", 
	"-",
	--"*",
	"@",
	":",
	";",
	"?",
	"~",
	"`",
	"|"
}

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
	local h = edit.FontHeight
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
	local h = edit.FontHeight

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
	if compareIsAttachable(parent) then
		parent = parent:getFrame()
	end

	if not multilined then
		multilined = false
		text = table.concat(text:split("\n"))
	end

	--------------------------------------------------------------

	NewEditBoxes[id] = {}
	NewEditBoxes[id].ColorScheme = DefaultColors
	NewEditBoxes[id].Active = false
	NewEditBoxes[id].IsSelecting = false
	NewEditBoxes[id].ReadOnly = false
	NewEditBoxes[id].Colored = false
	NewEditBoxes[id].Text = text

	NewEditBoxes[id].CaretIndex = 0
	NewEditBoxes[id].SelectingCaretIndex = 0
	
	NewEditBoxes[id].MultiLined = multilined
	NewEditBoxes[id].Masked = false

	--------------------------------------------------------------

	NewEditBoxes[id].Canvas = GuiStaticImage.create(x, y, w, h, pane, false, parent)
	NewEditBoxes[id].Background = GuiStaticImage.create(1, 1, w-2, h-2, pane, false, NewEditBoxes[id].Canvas)
	NewEditBoxes[id].Scroller = CustomScrollPane.create(1, 1, w-2, h-2, false, NewEditBoxes[id].Canvas)
	NewEditBoxes[id].HelpLabel = CustomLabel.create(0, 0, 0, 0, "", false, NewEditBoxes[id].Canvas)

	NewEditBoxes[id].Caret = GuiStaticImage.create(0, 0, 2, h, pane, false, NewEditBoxes[id].Scroller)
	NewEditBoxes[id].SelectionCaret = GuiStaticImage.create(0, 0, 2, h, pane, false, NewEditBoxes[id].Scroller)

	NewEditBoxes[id].SelectorTop = GuiStaticImage.create(0, 0, 1, h, pane, false, NewEditBoxes[id].Scroller)
	NewEditBoxes[id].SelectorMid = GuiStaticImage.create(0, 0, w, h, pane, false, NewEditBoxes[id].Scroller)
	NewEditBoxes[id].SelectorBot = GuiStaticImage.create(0, 0, 1, h, pane, false, NewEditBoxes[id].Scroller)

	NewEditBoxes[id].BorderTop 		= GuiStaticImage.create(1, 0, w-2, 1, pane, false, NewEditBoxes[id].Canvas)
	NewEditBoxes[id].BorderBottom 	= GuiStaticImage.create(1, h-1, w-2, 1, pane, false, NewEditBoxes[id].Canvas)
	NewEditBoxes[id].BorderLeft		= GuiStaticImage.create(0, 1, 1, h-2, pane, false, NewEditBoxes[id].Canvas)
	NewEditBoxes[id].BorderRight	= GuiStaticImage.create(w-1, 1, 1, h-2, pane, false, NewEditBoxes[id].Canvas)

	NewEditBoxes[id].Label = CustomLabel.create(2, 2,  w-4, h-4, text, false, NewEditBoxes[id].Scroller)

	--------------------------------------------------------------

	NewEditBoxes[id].FontHeight = guiLabelGetFontHeight(NewEditBoxes[id].Label.Label)

	--------------------------------------------------------------

	local nw = guiLabelGetTextExtent(NewEditBoxes[id].Label.Label)
	local nh = NewEditBoxes[id].FontHeight
	local sh = h

	if NewEditBoxes[id].MultiLined then
		sh = (nh+HPerc)*#text:split("\n")
	else
		--print("HERE", (h-nh)/2 - 2, h, nh)
		NewEditBoxes[id].Label:setPosition(2, (h-nh)/2 - 2, false)		
		NewEditBoxes[id].HelpLabel:setPosition(2, (h-nh)/2 - 2, false)		
	end

	NewEditBoxes[id].Background:setEnabled(false)

	NewEditBoxes[id].Label:setSize(nw, sh)	
	NewEditBoxes[id].Caret:setSize(2, nh, false)	
	NewEditBoxes[id].Caret:setPosition(0, (h-nh)/2, false)
	NewEditBoxes[id].SelectionCaret:setSize(2, nh, false)	
	NewEditBoxes[id].SelectionCaret:setPosition(0, (h-nh)/2, false)

	NewEditBoxes[id].Scroller:update()

	NewEditBoxes[id].Scroller:setScrollingWithCursor(false)
	NewEditBoxes[id].Scroller:setHorizontalScrolling(not NewEditBoxes[id].MultiLined)

	local col, bcol, rcol = "EEEEEE", "666666", "444444"
	if not NewEditBoxes[id].ColorScheme.DarkTheme then col, bcol, rcol = rcol, rcol, col end

	NewEditBoxes[id].Canvas:setColor("0")
	NewEditBoxes[id].Background:setColor("FF"..rcol)
	NewEditBoxes[id].Label:setColor(col)
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

	NewEditBoxes[id].BorderTop:setColor("FF"..bcol)
	NewEditBoxes[id].BorderBottom:setColor("FF"..bcol)
	NewEditBoxes[id].BorderLeft:setColor("FF"..bcol)
	NewEditBoxes[id].BorderRight:setColor("FF"..bcol)

	--------------------------------------------------------------

	NewEditBoxes[id].Events = {}

	local doubleClicked = false
	NewEditBoxes[id].Events.ClickScroller = {}
	NewEditBoxes[id].Events.ClickScroller.Name = "onClientGUIClick"
	NewEditBoxes[id].Events.ClickScroller.Function = function(_, _, x, y)

		if not doubleClicked then
			NewEditBoxes[id].Active = true

			local ax, ay = guiGetOnScreenPosition(NewEditBoxes[id].Label.Label)
			local _, _, caret = getCharCoordsFromAbsoluteCoords(NewEditBoxes[id], x-ax, y-ay)

			cxpSetCaretIndex(NewEditBoxes[id], caret)
			NewEditBoxes[id].SelectionCaret:setVisible(false)
		end
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

	NewEditBoxes[id].Events.ClickDown = {}
	NewEditBoxes[id].Events.ClickDown.Name = "onClientGUIMouseDown"
	NewEditBoxes[id].Events.ClickDown.Function = function()
		NewEditBoxes[id].Active = false
		NewEditBoxes[id].Caret:setVisible(false)
	end

	NewEditBoxes[id].Events.Click = {}
	NewEditBoxes[id].Events.Click.Name = "onClientGUIClick"
	NewEditBoxes[id].Events.Click.Function = function()
		if not doubleClicked then
			NewEditBoxes[id].Active = false
			NewEditBoxes[id].Caret:setVisible(false)
		end
	end

	NewEditBoxes[id].Events.DoubleClickScroller = {}
	NewEditBoxes[id].Events.DoubleClickScroller.Name = "onClientGUIDoubleClick"
	NewEditBoxes[id].Events.DoubleClickScroller.Function = function(_, _, x, y)

		NewEditBoxes[id].Active = true

		local ax, ay = guiGetOnScreenPosition(NewEditBoxes[id].Label.Label)
		local _, _, caret = getCharCoordsFromAbsoluteCoords(NewEditBoxes[id], x-ax, y-ay)

		local str = NewEditBoxes[id].Label:getText()
		local lpcaret = utf8.minrfind(utf8.sub(str, 0, caret), CHARTAB)
		local rpcaret = utf8.minfind(utf8.sub(str, caret+1, #str), CHARTAB)

		cxpSetCaretIndex(NewEditBoxes[id], caret-lpcaret+1)
		cxpSetCaretIndex(NewEditBoxes[id], caret+rpcaret-1, true)

		doubleClicked = true
		setTimer(function() doubleClicked = false end, 300, 1)

	end

	NewEditBoxes[id].Events.Char = {}
	NewEditBoxes[id].Events.Char.Name = "onClientCharacter"
	NewEditBoxes[id].Events.Char.Function = function(button)

		if NewEditBoxes[id].Active and isCWCursorShowing() and not NewEditBoxes[id].ReadOnly then

			local sbutton = button
			if NewEditBoxes[id].Masked then 
				sbutton = ""
				for i = 1, #button do
					sbutton = sbutton.."*"
				end
			end
			
			local str = NewEditBoxes[id].Label:getText()
			local nstr = NewEditBoxes[id].Text
			local start = NewEditBoxes[id].CaretIndex
		
			if NewEditBoxes[id].SelectingCaretIndex == NewEditBoxes[id].CaretIndex then

				str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex)..sbutton..utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str) 
				nstr = utf8.sub(nstr, 0, NewEditBoxes[id].CaretIndex)..button..utf8.sub(nstr, NewEditBoxes[id].CaretIndex+1, #nstr)

			else

				start = math.min(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
				local ends = start + math.abs(NewEditBoxes[id].SelectingCaretIndex - NewEditBoxes[id].CaretIndex) + 1

				str = utf8.sub(str, 0, start)..sbutton..utf8.sub(str, ends, #str)
				nstr = utf8.sub(nstr, 0, start)..button..utf8.sub(nstr, ends, #nstr)
			end

			NewEditBoxes[id].Label:setText(str)
			NewEditBoxes[id].Text = nstr
			cxpSetCaretIndex(NewEditBoxes[id], start+sbutton:len())
		end
	end

	local holdTimer
	NewEditBoxes[id].Events.Key = {}
	NewEditBoxes[id].Events.Key.Name = "onClientKey"
	NewEditBoxes[id].Events.Key.Function = function(button, por, x)

		if NewEditBoxes[id].Active and por and isCWCursorShowing() then

			local shift = getKeyState("lshift") or getKeyState("rshift")
			local ctrl = getKeyState("lctrl") or getKeyState("rctrl")

			if button == "backspace" and not NewEditBoxes[id].ReadOnly then

				local str = NewEditBoxes[id].Label:getText()
				local nstr = NewEditBoxes[id].Text
				local start = NewEditBoxes[id].CaretIndex-1

				if NewEditBoxes[id].SelectingCaretIndex == NewEditBoxes[id].CaretIndex then
					local pcaret = 1
					
					if ctrl then

						pcaret = utf8.minrfind(utf8.sub(str, 0, NewEditBoxes[id].CaretIndex-1), CHARTAB)
						
						if pcaret == nil then 
							pcaret = NewEditBoxes[id].CaretIndex
						end

						start = NewEditBoxes[id].CaretIndex-pcaret 

					end 

					str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex-pcaret)..utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str)
					nstr = utf8.sub(nstr, 0, NewEditBoxes[id].CaretIndex-pcaret)..utf8.sub(nstr, NewEditBoxes[id].CaretIndex+1, #nstr)
				else
					
					start = math.min(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
					local ends = start + math.abs(NewEditBoxes[id].SelectingCaretIndex - NewEditBoxes[id].CaretIndex) + 1

					str = utf8.sub(str, 0, start)..utf8.sub(str, ends, #str)
					nstr = utf8.sub(nstr, 0, start)..utf8.sub(nstr, ends, #nstr)
				end

				NewEditBoxes[id].Label:setText(str)
				NewEditBoxes[id].Text = nstr
				cxpSetCaretIndex(NewEditBoxes[id], start)
			end

			if button == "delete" and not NewEditBoxes[id].ReadOnly then

				local str = NewEditBoxes[id].Label:getText()
				local nstr = NewEditBoxes[id].Text
				local start = NewEditBoxes[id].CaretIndex

				if NewEditBoxes[id].SelectingCaretIndex == NewEditBoxes[id].CaretIndex then
					local pcaret = 1

					if ctrl then

						pcaret = utf8.minfind(utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str), CHARTAB)
						
						if pcaret == nil then 
							pcaret = 0
						end

					end 

					str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex)..utf8.sub(str, NewEditBoxes[id].CaretIndex+1+pcaret, #str)
					nstr = utf8.sub(nstr, 0, NewEditBoxes[id].CaretIndex)..utf8.sub(nstr, NewEditBoxes[id].CaretIndex+1+pcaret, #nstr)
				else
					start = math.min(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
					local ends = start + math.abs(NewEditBoxes[id].SelectingCaretIndex - NewEditBoxes[id].CaretIndex) + 1

					str = utf8.sub(str, 0, start)..utf8.sub(str, ends, #str)
					nstr = utf8.sub(nstr, 0, start)..utf8.sub(nstr, ends, #nstr)
				end
				
				NewEditBoxes[id].Label:setText(str)
				NewEditBoxes[id].Text = nstr
				cxpSetCaretIndex(NewEditBoxes[id], start)
			end

			if button == "enter" and not NewEditBoxes[id].ReadOnly then
				if NewEditBoxes[id].MultiLined then
					NewEditBoxes[id].Events.Char.Function("\n")
				end
			end

			if button == "arrow_l" then
				
				local pcaret = 1
					
				if ctrl then
					local str = NewEditBoxes[id].Label:getText()
					pcaret = utf8.minrfind(utf8.sub(str, 0, NewEditBoxes[id].SelectingCaretIndex-1), CHARTAB)
					
					if pcaret == nil then 
						pcaret = NewEditBoxes[id].SelectingCaretIndex
					end
				end 

				cxpSetCaretIndex(NewEditBoxes[id], NewEditBoxes[id].SelectingCaretIndex-pcaret, shift)
			end

			if button == "arrow_r" then

				local pcaret = 1
					
				if ctrl then
					local str = NewEditBoxes[id].Label:getText()
					pcaret = utf8.minfind(utf8.sub(str, NewEditBoxes[id].SelectingCaretIndex+1, #str), CHARTAB)
					
					if pcaret == nil then
						pcaret = NewEditBoxes[id].SelectingCaretIndex
					end
				end 

				cxpSetCaretIndex(NewEditBoxes[id], NewEditBoxes[id].SelectingCaretIndex+pcaret, shift)
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

			if button == "a" and ctrl then
				local str = NewEditBoxes[id].Label:getText()

				cxpSetCaretIndex(NewEditBoxes[id], 0)
				cxpSetCaretIndex(NewEditBoxes[id], #str, true)
			end

			if button == "x" and ctrl and not NewEditBoxes[id].ReadOnly then
		
				local str = NewEditBoxes[id].Label:getText()
				local nstr = NewEditBoxes[id].Text

				if NewEditBoxes[id].SelectingCaretIndex ~= NewEditBoxes[id].CaretIndex then
					
					local min, max = math.minmax(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
					str = utf8.sub(str, 0, min)..utf8.sub(str, max+1, #str)
					nstr = utf8.sub(nstr, 0, min)..utf8.sub(nstr, max+1, #nstr)

					NewEditBoxes[id].Label:setText(str)
					NewEditBoxes[id].Text = nstr
					cxpSetCaretIndex(NewEditBoxes[id], min)

				elseif NewEditBoxes[id].MultiLined then
				
					local left = math.max(utf8.rfind(utf8.sub(str, 0, NewEditBoxes[id].CaretIndex), "\n") or NewEditBoxes[id].CaretIndex, 0)
					local right = math.min(utf8.find(utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str), "\n") or #str, #str)

					str = utf8.sub(str, 0, NewEditBoxes[id].CaretIndex-left)..utf8.sub(str, NewEditBoxes[id].CaretIndex+right, #str)
					nstr = utf8.sub(nstr, 0, NewEditBoxes[id].CaretIndex-left)..utf8.sub(nstr, NewEditBoxes[id].CaretIndex+right, #nstr)

					if left == NewEditBoxes[id].CaretIndex then
						
						str = utf8.sub(str, 2, #str)
						nstr = utf8.sub(nstr, 2, #nstr)

						left = NewEditBoxes[id].CaretIndex+1
					end
					
					NewEditBoxes[id].Label:setText(str)
					NewEditBoxes[id].Text = nstr
					cxpSetCaretIndex(NewEditBoxes[id], NewEditBoxes[id].CaretIndex-left+1)

				end

			end

			if button == "c" and ctrl then

				local str = NewEditBoxes[id].Text
				if NewEditBoxes[id].SelectingCaretIndex ~= NewEditBoxes[id].CaretIndex then

					local min, max = math.minmax(NewEditBoxes[id].SelectingCaretIndex, NewEditBoxes[id].CaretIndex)
					local save = utf8.sub(str, min+1, max)
					setClipboard(save)

				elseif NewEditBoxes[id].MultiLined then
				
					local left = math.max(utf8.rfind(utf8.sub(str, 0, NewEditBoxes[id].CaretIndex), "\n") or NewEditBoxes[id].CaretIndex+2, 2)-2
					local right = math.min(utf8.find(utf8.sub(str, NewEditBoxes[id].CaretIndex+1, #str), "\n") or #str+1, #str+1)-1
					
					local save = utf8.sub(str, NewEditBoxes[id].CaretIndex-left, NewEditBoxes[id].CaretIndex+right)
					setClipboard(save)

				end
			end			

			if button == "v" and ctrl and not NewEditBoxes[id].ReadOnly then
				NewEditBoxes[id].Events.Char.Function(getClipboard())
			end	



			local u = function()
				if getKeyState(button) then
					setTimer(function() triggerEvent(NewEditBoxes[id].Events.Key.Name, root, button, getKeyState(button), 12) end, 50, 1)
				end
			end

			if x == 12 then u()
			else setTimer(u, 100, 1) end
		end
	end
	
	addEventHandler(NewEditBoxes[id].Events.ClickDown.Name, root, NewEditBoxes[id].Events.ClickDown.Function)
	addEventHandler(NewEditBoxes[id].Events.Click.Name, root, NewEditBoxes[id].Events.Click.Function)
	NewEditBoxes[id].Events.DoubleClickScroller.Function = NewEditBoxes[id].Scroller:addEvent(NewEditBoxes[id].Events.DoubleClickScroller.Name, NewEditBoxes[id].Events.DoubleClickScroller.Function)
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

----------------------------------------------------------------------------------------------------------------------------------------------
--Set Functions

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

function cxpSetPosition(edit, x, y, rel)

	if rel then

		local sw, sh = Width, Height
		local parent = edit.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		x = x*sw
		y = y*sh

	end

	edit.Canvas:setPosition(x, y, false)
end

function cxpSetSize(edit, w, h, rel)

	if rel then

		local sw, sh = Width, Height
		local parent = edit.Canvas.parent or nil

		if parent then
			sw, sh = parent:getSize(false)
		end

		w = w*sw
		h = h*sh

	end

	edit.Background:setSize(w-2, h-2, false)

	edit.BorderTop:setSize(w-2, 1, false)
	edit.BorderLeft:setSize(1, h-2, false)

	edit.BorderBottom:setSize(w-2, 1, false)
	edit.BorderBottom:setPosition(1, h-1, false)

	edit.BorderRight:setSize(1, h-2, false)
	edit.BorderRight:setPosition(w-1, 1, false)

	edit.Canvas:setSize(w, h, false)
	edit.Scroller:setSize(w-2, h-2, false)

end

function cxpSetVisible(edit, bool) edit.Canvas:setVisible(bool or false) end

function cxpSetReadOnly(edit, bool)

	edit.ReadOnly = bool or false

	if bool then
		edit.Label:setColor(edit.ColorScheme.DarkMain)
	else
		
		local col = "EEEEEE"
		if not edit.ColorScheme.DarkTheme then col = "444444" end
		if edit.Colored then col = edit.Colored end

		if not edit.Canvas:getEnabled() then 

			col = "AAAAAA"
			if not edit.ColorScheme.DarkTheme then col = "777777" end

		end

		edit.Label:setColor(col)
	
	end

	local col, rcol = "666666", "444444"
	if not edit.ColorScheme.DarkTheme then col, rcol = "444444", "EEEEEE" end

	edit.BorderTop:setColor("FF"..col)
	edit.BorderBottom:setColor("FF"..col)
	edit.BorderLeft:setColor("FF"..col)
	edit.BorderRight:setColor("FF"..col)
	edit.Background:setColor("FF"..rcol)

end

function cxpSetColor(edit, color)
	
	if not color or not tonumber(color, 16) or color:len() ~= 6 then
		color = false
	end

	edit.Colored = color

	cxpSetReadOnly(edit, edit.ReadOnly)
end

function cxpSetEnabled(edit, bool) 
	edit.Canvas:setEnabled(bool or false) 
	cxpSetReadOnly(edit, edit.ReadOnly)
end

function cxpSetColorScheme(edit, scheme)
	edit.ColorScheme = scheme
	
	edit.Caret:setColor("FF"..edit.ColorScheme.Main)
	edit.SelectionCaret:setColor("FF"..edit.ColorScheme.Main)

	local col = edit.ColorScheme.Main
	if not edit.ColorScheme.DarkTheme then col = edit.ColorScheme.LightMain end 

	edit.SelectorTop:setColor("FF"..col)
	edit.SelectorMid:setColor("FF"..col)
	edit.SelectorBot:setColor("FF"..col)

	cxpSetReadOnly(edit, edit.ReadOnly)
end

function cxpSetText(edit, text)

	local s = ""
	if edit.Masked then
		for i = 1, #text do
			s = s.."*"
		end
	else
		s = text
	end

	edit.Label:setText(s)
	edit.Text = text
	cxpRecalc(edit)
end

function cxpSetMasked(edit, bool)
	if not edit.MultiLined then
		edit.Masked = bool or false

		local s = ""
		if edit.Masked then
			for i = 1, #edit.Label:getText() do
				s = s.."*"
			end
		else 
			s = edit.Text
		end

		edit.Label:setText(s)
	end
end

function cxpSetBordersEnabled(edit, bool)
	
	if not bool then bool = false
	else bool = true end

	edit.BorderTop:setVisible(bool)
	edit.BorderBottom:setVisible(bool)
	edit.BorderLeft:setVisible(bool)
	edit.BorderRight:setVisible(bool)

end

function cxpSetBackgroundEnabled(edit, bool)
	
	if not bool then bool = false
	else bool = true end

	edit.Background:setVisible(bool)

end

----------------------------------------------------------------------------------------------------------------------------------------------
--Layering functions

function cxpBringToFront(edit)
	edit.Canvas:bringToFront()
end

function cxpMoveToBack(edit)
	edit.Canvas:moveToBack()
end

----------------------------------------------------------------------------------------------------------------------------------------------
--Get Functions

function cxpGetPosition(edit, bool) return edit.Canvas:getPosition(bool or false) end
function cxpGetSize(edit, bool) return edit.Canvas:getSize(bool or false) end
function cxpGetVisible(edit) return edit.Canvas:getVisible() end
function cxpGetEnabled(edit) return edit.Canvas:getEnabled() end
function cxpGetColor(edit) return edit.Colored end
function cxpGetCaretIndex(edit) return edit.SelectingCaretIndex end
function cxpGetSelectionStart(edit) return math.min(edit.SelectingCaretIndex, edit.CaretIndex) end
function cxpGetSelectionEnd(edit) return math.max(edit.SelectingCaretIndex, edit.CaretIndex) end
function cxpGetSelectionLength(edit) return math.abs(edit.SelectingCaretIndex-edit.CaretIndex) end
function cxpGetText(edit) return edit.Text end
function cxpIsMasked(edit) return edit.Masked end
function cxpIsReadOnly(edit) return edit.ReadOnly end
function cxpIsBackgroundEnabled(edit) return edit.Background:getVisible() end
function cxpIsBordersEnabled(edit) return edit.BorderTop:getVisible() end
function cxpGetColorScheme(edit) return edit.ColorScheme end

----------------------------------------------------------------------------------------------------------------------------------------------
--OOP Functions

CustomTextBox = {}
CustomTextBox.__index = CustomTextBox
CustomTextBox.ClassName = "CustomTextBox"

function CustomTextBox.create(...)

	local self = setmetatable(guiCreateCustomEditPanel(...), CustomTextBox)
	compareAppend(self, ...)
	return self
end

function CustomTextBox.setEnabled(self, ...) return cxpSetEnabled(self, ...) end
function CustomTextBox.setVisible(self, ...) return cxpSetVisible(self, ...) end
function CustomTextBox.setSize(self, ...) return cxpSetSize(self, ...) end
function CustomTextBox.setPosition(self, ...) return cxpSetPosition(self, ...) end
function CustomTextBox.setText(self, ...) return cxpSetText(self, ...) end
function CustomTextBox.setColor(self, ...) return cxpSetColor(self, ...) end
function CustomTextBox.setColorScheme(self, ...) return cxpSetColorScheme(self, ...) end
function CustomTextBox.setCaretIndex(self, ...) return cxpSetCaretIndex(self, ...) end
function CustomTextBox.setReadOnly(self, ...) return cxpSetReadOnly(self, ...) end
function CustomTextBox.setMasked(self, ...) return cxpSetMasked(self, ...) end
function CustomTextBox.setBordersEnabled(self, ...) return cxpSetBordersEnabled(self, ...) end
function CustomTextBox.setBackgroundEnabled(self, ...) return cxpSetBackgroundEnabled(self, ...) end

function CustomTextBox.bringToFront(self) return cxpBringToFront(self) end
function CustomTextBox.moveToBack(self) return cxpMoveToBack(self) end

function CustomTextBox.getEnabled(self, ...) return cxpGetEnabled(self, ...) end
function CustomTextBox.getVisible(self, ...) return cxpGetVisible(self, ...) end
function CustomTextBox.getSize(self, ...) return cxpGetSize(self, ...) end
function CustomTextBox.getPosition(self, ...) return cxpGetPosition(self, ...) end
function CustomTextBox.getText(self, ...) return cxpGetText(self, ...) end
function CustomTextBox.getColor(self, ...) return cxpGetColor(self, ...) end
function CustomTextBox.getColorScheme(self, ...) return cxpGetColorScheme(self, ...) end
function CustomTextBox.getCaretIndex(self, ...) return cxpGetCaretIndex(self, ...) end
function CustomTextBox.getCaretSelectionStart(self, ...) return cxpGetCaretSelectionStart(self, ...) end
function CustomTextBox.getCaretSelectionEnd(self, ...) return cxpGetCaretSelectionEnd(self, ...) end
function CustomTextBox.getCaretSelectionLength(self, ...) return cxpGetCaretSelectionLength(self, ...) end
function CustomTextBox.isReadOnly(self, ...) return cxpIsReadOnly(self, ...) end
function CustomTextBox.isMasked(self, ...) return cxpIsMasked(self, ...) end
function CustomTextBox.isBordersEnabled(self, ...) return cxpIsBordersEnabled(self, ...) end
function CustomTextBox.isBackgroundEnabled(self, ...) return cxpIsBackgroundEnabled(self, ...) end

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
local nedit = guiCreateCustomEditPanel(100, 250, 250, 30, "Lorem\n ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", _, _, false)

cxpSetColorScheme(nmemo, Themes.Dark.Purple)
cxpSetText(nmemo, "HELLO")
cxpSetBackgroundEnabled(nedit, false)
cxpSetBordersEnabled(nmemo, false)

bindKey("f2", "down", function()
	cxpSetMasked(nedit, not nedit.Masked)
end)