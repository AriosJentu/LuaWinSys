function CustomCheckBox.draw(tab) return CustomCheckBox.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end

CheckBoxTool = Tool.create("Check Box", CustomCheckBox, "CustomCheckBox")

CheckBoxTool:addProperty("Text", "edit", "Check Box", "setText", "getText")
CheckBoxTool:addProperty("Checked", "check", false, "setChecked", "getChecked")