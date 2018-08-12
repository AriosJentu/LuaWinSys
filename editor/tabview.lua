function CustomTableView.draw(tab) return CustomTableView.create(tab.X, tab.Y, tab.W, tab.H, tab.Rel, tab.Parent) end

TabViewTool = Tool.create("Table View", CustomTableView, "CustomTableView")

TabViewTool:addProperty("Visible Title Bar", "check", false, "setTitleBarVisible", "getTitleBarVisible")
TabViewTool:addProperty("Lines", "button", {"Add Line", "Remove Line"}, "addLine", "removeLine")
TabViewTool:addProperty("Line Height", "spin", {22, 22, 100}, "setLineHeight", "getLineHeight")
TabViewTool:addProperty("Lines Indentation", "spin", {5, 0, 20}, "setIndentation", "getIndentation")
TabViewTool:addProperty("Columns", "button", {"Add Column", "Remove Column"}, "addColumn", "removeColumn")
TabViewTool:addProperty("Column Title", "edit", "Column", "setColumnTitle", "getColumnTitle")
TabViewTool:addProperty("Column Width", "spin", {50, 50, Width}, "setColumnWidth", "getColumnWidth")
TabViewTool:addProperty("Cell Text", "edit", "", "setCellText", "getCellText")