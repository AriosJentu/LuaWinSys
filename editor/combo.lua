function CustomComboBox.draw(tab) return CustomComboBox.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end

ComboBoxTool = Tool.create("Combo Box", CustomComboBox, "CustomComboBox")

ComboBoxTool:addProperty("Selected Item", "combo", {Value={["None"]=""}}, "setSelectedItem", "getSelectedItem")
ComboBoxTool:addProperty("Maximal Height", "spin", {30, 30, Height-50}, "setMaxHeight", "getMaxHeight")
ComboBoxTool:addProperty("Items", "button", {"Add Item", "Remove Item"}, "addItem", "removeItem")
ComboBoxTool:addProperty("Item Text", "edit", "", "setItemText", "getItemText")