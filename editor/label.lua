function CustomLabel.draw(tab) return CustomLabel.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end

LabelTool = Tool.create("Label", CustomLabel, "CustomLabel")

LabelTool:addProperty("Text", "edit", "Label", "setText", "getText")
LabelTool:addProperty("Color", "edit", "EEEEEE", "setColor", "getColor")
LabelTool:addProperty("Vertical Align", "combo", {Value={["Top"]="top", ["Center"]="center", ["Bottom"]="bottom"}}, "setVerticalAlign", "getVerticalAlign")
LabelTool:addProperty("Horizontal Align", "combo", {Value={["Left"]="left", ["Center"]="center", ["Right"]="right"}}, "setHorizontalAlign", "getHorizontalAlign")
LabelTool:addProperty("Schematical Color", "check", false, "setSchematicalColor", "isSchematicalColor")
LabelTool:addProperty("Hoverable", "check", false, "setHoverable", "isHoverable")
LabelTool:addProperty("Font", "combo", {Value=Fonts}, "setFont", "getFont")
LabelTool:addProperty("Font Size", "spin", {9, 8, 100, 1}, "setFontSize", "getFontSize")