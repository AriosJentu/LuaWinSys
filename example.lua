--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---------------------------Testing-Widgets--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

CurrentTheme = Themes.Light.Blue

themes = {
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

----------------------------------------------------------------------------------------------------------------------------------------------
--Windows
demo_window = CustomWindow.create(100, 100, 750, 580, "Widgets List", false)
demo_window:setVisible(false)
demo_window:setCloseEnabled(true)
demo_window:showBar("left", 165)
--bindKey("b", "up", function() demo_window:open() end)


demo_window_l = CustomWindow.create(1000, 100, 300, 200, "Disabled Window", false)
demo_window_l:setVisible(false)
--bindKey("n", "up", function() demo_window_l:open() end)

demo_window_m = CustomWindow.create(1000, 350, 300, 300, "Not Movable Window", false)
demo_window_m:setVisible(false)
demo_window_m:setCloseEnabled(true)
demo_window_m:setMovable(false)
demo_window_m:showBar("top", 65)
--bindKey("m", "up", function() demo_window_m:open() end)

demo_window_n = CustomWindow.create(5, 80, 90, 50, "Parented", false, demo_window_l)
demo_window_n:setCloseEnabled(true)
demo_window_n:showBar("right", 30)
demo_window_l:setEnabled(false)

addCommandHandler("demowidgets", function()
	if demo_window_l:getVisible() then
		demo_window:close()
		demo_window_l:close()
		demo_window_m:close()
		showCursor(false)
	else
		demo_window:open()
		demo_window_l:open()
		demo_window_m:open()
		showCursor(true)
	end
end)

demo_window:addEvent("onCustomWindowClose", function()
	if not demo_window_m:getVisible() then
		showCursor(false)
	end
end)

demo_window_m:addEvent("onCustomWindowClose", function()
	if not demo_window:getVisible() then
		showCursor(false)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------
--Buttons
test_button = CustomButton.create(10, 30, 100, 40, "Texted", false, demo_window)
test_imgs = CustomButton.create(10, 80, 100, 40, "Removed Text", false, demo_window)
test_imgtxt = CustomButton.create(10, 130, 100, 40, "Imaged", false, demo_window)

test_imgs:setText("")
test_imgs:setImage(Images.Point)
test_imgs.Image:setProperty("ImageColours", "tl:FF62D262 tr:FF62D262 bl:FF62D262 br:FF62D262")

test_imgtxt:setImage(Images.Cross)
test_imgtxt.Image:setProperty("ImageColours", "tl:FF62D262 tr:FF62D262 bl:FF62D262 br:FF62D262")

test_but_locked = CustomButton.create(10, 180, 100, 40, "Disabled", false, demo_window)
test_but_locked:setEnabled(false)

test_but_locked2 = CustomButton.create(100, 60, 100, 40, "Disabled", false, demo_window_l)
test_but_locked2:setEnabled(false)

test_but_clicked2 = CustomButton.create(100, 110, 100, 40, "Clicked", false, demo_window_l)

test_but_locked3 = CustomButton.create(40, 80, 100, 30, "Disabled", false, demo_window_m)
test_but_locked3:setEnabled(false)

test_but_clicked3 = CustomButton.create(160, 80, 100, 30, "Clicked", false, demo_window_m)

CustomTooltip.create("Custom Tooltip", test_button, 0)

----------------------------------------------------------------------------------------------------------------------------------------------
--Progress bars
test_pbar = CustomProgressBar.create(10, 230, 100, 20, false, demo_window)
test_pbar:setProgress(0)

test_pbar2 = CustomProgressBar.create(10, 265, 100, 10, false, demo_window)
test_pbar2:setProgress(50)

test_pbar3 = CustomProgressBar.create(10, 290, 100, 20, false, demo_window)
test_pbar3:setProgress(100)

test_pbar4 = CustomProgressBar.create(20, 320, 20, 200, false, demo_window)
test_pbar4:setProgress(0)

test_pbar5 = CustomProgressBar.create(55, 320, 10, 200, false, demo_window)
test_pbar5:setProgress(50)

test_pbar6 = CustomProgressBar.create(80, 320, 20, 200, false, demo_window)
test_pbar6:setProgress(100)

----------------------------------------------------------------------------------------------------------------------------------------------
--Scroll bars
test_scver = CustomScrollBar.create(120, 30, 10, 490, false, demo_window)
test_scver_l = CustomScrollBar.create(140, 30, 15, 490, false, demo_window)
test_schor = CustomScrollBar.create(10, 530, 145, 10, false, demo_window)
test_schor_l = CustomScrollBar.create(10, 550, 145, 20, false, demo_window)

test_scver:setScrollPosition(50)
test_scver:setScrollLength(90)

test_scver_l:setScrollPosition(40)
test_scver_l:setScrollLength(30)
test_scver_l:setEnabled(false)

test_schor:setScrollPosition(50)
test_schor:setScrollLength(50)
test_schor:setScrollSpeed(10)

test_schor_l:setScrollPosition(100)
test_schor_l:setScrollLength(40)
test_schor_l:setEnabled(false)

test_scver:addEvent("onCustomScrollBarScrolled", function()
	test_pbar5:setProgress(test_scver:getScrollPosition())
end)

test_schor:addEvent("onCustomScrollBarScrolled", function()
	test_pbar2:setProgress(test_schor:getScrollPosition())
end)


----------------------------------------------------------------------------------------------------------------------------------------------
--Edit/Memo/Number boxes
test_edit = CustomEdit.create(170, 30, 250, 30, "EditBox", false, demo_window)
test_edit_l = CustomEdit.create(170, 70, 250, 30, "EditBox Disabled", false, demo_window)
test_edit_m = CustomEdit.create(170, 110, 250, 30, "EditBox Masked", false, demo_window)
test_edit_r = CustomEdit.create(170, 150, 250, 30, "EditBox ReadOnly", false, demo_window)

test_edit_nm = CustomEdit.create(10, 30, 280, 30, "EditBox on Side Panel", false, demo_window_m)
test_edit_nm:putOnSide(true)

test_memo = CustomMemo.create(170, 190, 250, 200, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", false, demo_window)
test_memo_l = CustomMemo.create(170, 400, 250, 80, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", false, demo_window)
test_memo_r = CustomMemo.create(170, 490, 250, 83, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", false, demo_window)

test_spinner = CustomSpinner.create(430, 30, 150, 30, false, demo_window)
test_spinner_l = CustomSpinner.create(430, 70, 150, 30, false, demo_window)
test_spinner_r = CustomSpinner.create(630, 30, 30, 30, false, demo_window)

test_spinner_r:setSize(110, 70, false)

test_edit_l:setEnabled(false)
test_memo_l:setEnabled(false)
test_spinner_l:setEnabled(false)

test_edit_m:setMasked(true)

test_edit_r:setReadOnly(true)
test_memo_r:setReadOnly(true)
test_spinner_r:setReadOnly(true)
test_spinner_r:setText(49)


----------------------------------------------------------------------------------------------------------------------------------------------
--Check boxes

test_checkbox = CustomCheckBox.create(430, 120, 150, 30, "Deactivated", false, demo_window)
test_checkbox_e = CustomCheckBox.create(430, 160, 150, 30, "Activated", false, demo_window)
test_checkbox_d = CustomCheckBox.create(590, 120, 150, 30, "Disabled", false, demo_window)
test_checkbox_d_e = CustomCheckBox.create(590, 160, 150, 30, "Disabled Activated", false, demo_window)

test_checkbox_e:setChecked(true)
test_checkbox_d:setEnabled(false)

test_checkbox_d_e:setChecked(true)
test_checkbox_d_e:setEnabled(false)

CustomTooltip.create("Multiline Tooltip\nTesting on another object\nWith different text sizes\nLast Line", test_checkbox, 1)

----------------------------------------------------------------------------------------------------------------------------------------------
--Combo boxes
test_combo = CustomComboBox.create(430, 200, 150, 30, "Select Theme...", false, demo_window)
test_combo_d = CustomComboBox.create(430, 240, 150, 30, "Disabled", false, demo_window)
test_combo_s = CustomComboBox.create(590, 200, 50, 20, "Sized", false, demo_window)

for i = 1, 20 do
	test_combo_d:addItem("Test"..i)
	test_combo_s:addItem("Test"..i)
end

for i in pairs(themes) do
	test_combo:addItem(i)
end

test_combo:setMaxHeight(450)

test_combo_d:setEnabled(false)
test_combo_s:setMaxHeight(200)
test_combo_s:setSize(150, 70, false)

test_combo_s:removeItem("Test5")

----------------------------------------------------------------------------------------------------------------------------------------------
--Tab panels
test_tab = CustomTabPanel.create(430, 280, 40, 40, false, demo_window)
test_tab_d = CustomTabPanel.create(430, 430, 310, 110, false, demo_window)

tabs = {}
dtabs = {}
for i = 1, 5 do
	tabs[i] = test_tab:addTab("Tab "..i)
	dtabs[i] = test_tab_d:addTab("Tab "..i)
end

test_tab:removeTab(tabs[2])

test_tab:setSize(310, 140, false)
test_tab:setSelectedTab("Tab 5")
test_tab:setTabEnabled("Tab 3", false)
test_tab:setTabVisible("Tab 4", false)
test_tab:setTabsMinLength(100)
test_tab_d:setTabsMinLength(150)
test_tab_d:setSelectedTab("Tab 3")

test_tab_d:setEnabled(false)

local image1 = GuiStaticImage.create(40, 10, 30, 20, pane, false, tabs[1])
local image2 = GuiStaticImage.create(72, 32, 40, 30, pane, false, tabs[1])
local image3 = GuiStaticImage.create(114, 64, 50, 40, pane, false, tabs[1])
local image10 = GuiStaticImage.create(166, 104, 60, 50, pane, false, tabs[1])

local image4 = GuiStaticImage.create(40, 10, 30, 20, pane, false, tabs[3])
local image5 = GuiStaticImage.create(72, 32, 40, 30, pane, false, tabs[3])
local image6 = GuiStaticImage.create(114, 64, 50, 40, pane, false, tabs[3])
local image11 = GuiStaticImage.create(166, 104, 60, 50, pane, false, tabs[3])

local image7 = GuiStaticImage.create(40, 10, 30, 20, pane, false, tabs[5])
local image8 = GuiStaticImage.create(72, 32, 40, 30, pane, false, tabs[5])
local image9 = GuiStaticImage.create(114, 64, 50, 40, pane, false, tabs[5])
local image12 = GuiStaticImage.create(166, 104, 60, 50, pane, false, tabs[5])

local imagel1 = GuiStaticImage.create(26, 8, 119, 5, pane, false, demo_window)
local imagel2 = GuiStaticImage.create(25, 9, 121, 3, pane, false, demo_window)

image1:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.Main, DefaultColors.Main, DefaultColors.Main, DefaultColors.Main)) 
image2:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.Main, DefaultColors.Main, DefaultColors.Main, DefaultColors.Main)) 
image3:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.Main, DefaultColors.Main, DefaultColors.Main, DefaultColors.Main)) 

image4:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain)) 
image5:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain)) 
image6:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain)) 

image7:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain)) 
image8:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain)) 
image9:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain)) 

image10:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.Main, DefaultColors.Main, DefaultColors.Main, DefaultColors.Main)) 
image11:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain, DefaultColors.DarkMain)) 
image12:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain, DefaultColors.LightMain)) 

----------------------------------------------------------------------------------------------------------------------------------------------
--Labels

test_label = CustomLabel.create(435, 545, 95, 25, "Theme Col Label", false, demo_window)
test_label_hov = CustomLabel.create(535, 545, 95, 25, "Hoverable Label", false, demo_window)
test_label_sch = CustomLabel.create(635, 545, 95, 25, "Schematic Label", false, demo_window)

test_label_hov:setHoverable(true)
test_label_sch:setSchematicalColor(true)

test_label:setAlign("center")
test_label_hov:setAlign("center", "center")
test_label_sch:setAlign("center", "right")

local ntest_timer
test_label_hov:addEvent("onClientGUIClick", function()

	test_label:setText("Hello World")
	test_label_hov:setText("Clicked")

	if isTimer(ntest_timer) then killTimer(ntest_timer) end
	setTimer(function()
		test_label:setText("Theme Col Label")
		test_label_hov:setText("Hoverable Label")
	end, 1000, 1)

end)

----------------------------------------------------------------------------------------------------------------------------------------------
--Loading

test_loading = CustomLoading.create(590, 50, false, demo_window)

----------------------------------------------------------------------------------------------------------------------------------------------
--Grid Lists

test_grid = CustomTableView.create(5, 125, 290, 170, false, demo_window_m)

cleared_column = test_grid:addColumn()
short_column = test_grid:addColumn("Short")
long_column = test_grid:addColumn("Long Column", 120)
removed_column = test_grid:addColumn("It Will Be Removed", 150)
removed_named_column = test_grid:addColumn("It Will Be Removed Too", 150)
another_column = test_grid:addColumn("Another", 90)
scrolled_column = test_grid:addColumn("Scroll it to look at me", 130)

test_grid:removeColumn(removed_column)
test_grid:removeColumn("It Will Be Removed Too")

for i = 1, 10 do
	if i == 5 then
		test_line = test_grid:addLine()
	else
		test_grid:addLine(26 - math.abs(5-i))
	end
end

for i = 1, test_grid:getLinesCount() do
	for j = 1, test_grid:getColumnsCount() do
		test_grid:setCellText(i, j, i.." "..j)
	end
end

test_grid:setCellText(test_line, cleared_column, "Cell")
test_grid:setCellText(1, 1, "First")
test_grid:setCellText(test_grid:getLinesCount(), scrolled_column, "Last")


---------------------------------------

demo_dialog = CustomDialog.create(100, "Dialog, what attached\nto Demo Window Frame\nMultiline Automatic", {"OK", "Cancel", "Buttons", "Three", "Another"}, demo_window)
demo_dialog_l = CustomDialog.create(200, "Local Dialog")

--[[demo_window:setColorScheme(Themes.Dark.Red)
demo_window_l:setColorScheme(BlueColorsDark)
demo_window_m:setColorScheme(BlueColorsDark)]]

indx = 1

test_checkbox:addEvent("onCustomCheckBoxChecked", function(checked)

	if checked then
		test_checkbox:setText("Activated")
	else
		test_checkbox:setText("Deactivated")
	end

end)

test_checkbox_e:addEvent("onCustomCheckBoxChecked", function(checked)

	if checked then
		test_checkbox_e:setText("Activated")
		test_loading:setAnimated(true)
	else
		test_checkbox_e:setText("Deactivated")
		test_loading:setAnimated(false)
	end

end)

demo_dialog:addEvent("onCustomDialogClick", function(button)
	if button == "OK" then
		test_imgtxt:setText("Accepted")
	elseif button == "Cancel" then
		test_imgtxt:setText("Cancelled")
	end
end)

local test_timer
test_button:addEvent("onClientMouseEnter", function()
	test_button:setText("Hover")
end)

test_button:addEvent("onClientMouseLeave", function()
	if isTimer(test_timer) then killTimer(test_timer) end
	test_button:setText("Texted")
end)

test_imgtxt:addEvent("onClientGUIClick", function()
	demo_dialog:open()
end)

test_imgs:addEvent("onClientGUIClick", function()
	demo_dialog_l:open()
end)

test_button:addEvent("onClientGUIClick", function()

	if demo_window_l:getVisible() then
		demo_window_l:close()
	else
		demo_window_l:open()
	end
	
	test_button:setText("Clicked")

	test_timer = setTimer(function()
		test_button:setText("Hover")
	end, 1000, 1)

end)

test_imgtxt:addEvent("onClientMouseEnter", function()
	test_imgtxt:setImage(Images.Down)
end)

test_imgtxt:addEvent("onClientMouseLeave", function()
	test_imgtxt:setImage(Images.Cross)
end)

test_combo:addEvent("onCustomComboBoxSelectItem", function()

	if test_combo:getSelectedItem() ~= nil then
		CurrentTheme = themes[test_combo:getSelectedItem().Text]
	end

	demo_window:setColorScheme(CurrentTheme)
	demo_window_l:setColorScheme(CurrentTheme)
	demo_window_m:setColorScheme(CurrentTheme)

	image1:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main)) 
	image2:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main)) 
	image3:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main)) 

	image4:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain)) 
	image5:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain)) 
	image6:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain)) 

	image7:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain)) 
	image8:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain)) 
	image9:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain)) 

	image10:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main, CurrentTheme.Main)) 
	image11:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain, CurrentTheme.DarkMain)) 
	image12:setProperty("ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain, CurrentTheme.LightMain))

	test_edit:setText("Selected theme: "..test_combo:getSelectedItem().Text)
end)

test_spinner:addEvent("onClientGUIChanged", function()

	test_loading:setProgress(tonumber(test_spinner:getText()))

end)

test_but_clicked3:addEvent("onClientGUIClick", function()
	local selected_line = test_grid:getSelectedLine()

	if selected_line == 0 then
		test_edit_nm:setText("Nothing selected")
	else
		test_edit_nm:setText(test_grid:getCellText(selected_line, 1))
	end

end)