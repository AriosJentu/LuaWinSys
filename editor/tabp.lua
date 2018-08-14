function CustomTabPanel.draw(tab) return CustomTabPanel.create(tab.X, tab.Y, tab.W, tab.H, tab.Rel, tab.Parent) end

TabPanelTool = Tool.create("Tabbed Panel", CustomTabPanel, "CustomTabPanel")

TabPanelTool:addProperty("Minimal Tabs Length", "spin", {100, 50, Width/2, 1}, "setTabsMinLength", "getTabsMinLength")
TabPanelTool:addProperty("Tabs", "button", {"Add Tab", "Remove Tab"}, "addTab", "removeTab")
TabPanelTool:addProperty("Tab Variable", "edit", "")
TabPanelTool:addProperty("Tab Text", "edit", "Tab", "setTabText", "getTabText")
TabPanelTool:addProperty("Enabled Tab", "check", true, "setTabEnabled", "getTabEnabled")
TabPanelTool:addProperty("Visible Tab", "check", true, "setTabVisible", "getTabVisible")