for _, name in pairs(SortedProperties) do

	WidgetProperties[name] = {}
	local types = PropertiesTypes[name].type

	local width = 190
	if types == "button" or types == "spin" then
		width = 140
	elseif types == "edit" or types == "combo" then
		width = 120
	end

	local height = 30
	if types == "button" then height = 60 end

	WidgetProperties[name].Type = types

	WidgetProperties[name].Canvas = GuiStaticImage.create(0, 0, 250, height-2, pane, false, PropertiesScroll)
	WidgetProperties[name].Divider = GuiStaticImage.create(0, height-3, 250, 1, pane, false, WidgetProperties[name].Canvas)
	WidgetProperties[name].Label = CustomLabel.create(0, 0, width-2, height-2, name, false, WidgetProperties[name].Canvas)

	if types == "check" then
		
		WidgetProperties[name].Check = CustomCheckBox.create(width, 0, 250-width, height, "", false, WidgetProperties[name].Canvas)

	elseif types == "edit" then
		
		WidgetProperties[name].Edit = CustomEdit.create(width, 0, 250-width, height-3, "", false, WidgetProperties[name].Canvas)

	elseif types == "spin" then

		WidgetProperties[name].Spin = CustomSpinner.create(width, 0, 250-width, height-3, false, WidgetProperties[name].Canvas)
		
		WidgetProperties[name].Spin:setMinimal(PropertiesTypes[name].vals[2])
		WidgetProperties[name].Spin:setMaximal(PropertiesTypes[name].vals[3])

	elseif types == "combo" then

		WidgetProperties[name].Combo = CustomComboBox.create(width+2, 1, 245-width, height-6, "Select", false, WidgetProperties[name].Canvas)

		local s = 0
		for v in pairs(PropertiesTypes[name].vals) do
			WidgetProperties[name].Combo:addItem(v)
			s = s+1
		end

		WidgetProperties[name].Combo:setMaxHeight(30*s)

	elseif types == "button" then

		WidgetProperties[name].Add = CustomButton.create(width+2, 2, 245-width, 24, PropertiesTypes[name].vals[1], false, WidgetProperties[name].Canvas)
		WidgetProperties[name].Remove = CustomButton.create(width+2, 30, 245-width, 24, PropertiesTypes[name].vals[2], false, WidgetProperties[name].Canvas)

	end

	WidgetProperties[name].Canvas:setColor("FFEEEEEE")
	WidgetProperties[name].Divider:setColor("33000000")

	WidgetProperties[name].Label:setAlign("center", "right")

	WidgetProperties[name].Divider:setEnabled(false)
	WidgetProperties[name].Label:setEnabled(false)

	WidgetProperties[name].Canvas:setVisible(false)

end