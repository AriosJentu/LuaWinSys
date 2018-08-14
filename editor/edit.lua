function CustomEdit.draw(tab) return CustomEdit.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end

EditBoxTool = Tool.create("Edit Box", CustomEdit, "CustomEdit")

EditBoxTool:addProperty("Text", "edit", "Edit Box", "setText", "getText")
EditBoxTool:addProperty("Read Only", "check", false, "setReadOnly", "getReadOnly")
EditBoxTool:addProperty("Maximal Length", "spin", {144, 1, 10000, 1}, "setMaxLength", "getMaxLength")
EditBoxTool:addProperty("Masked", "check", false, "setMasked", "getMasked")
EditBoxTool:addProperty("Is On Side Bar", "check", false, "putOnSide", "isOnSide")