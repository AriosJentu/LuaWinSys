function CustomWindow.draw(tab) return CustomWindow.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end

local Positions = {
	["None"] = "none",
	["Top"] = "top",
	["Bottom"] = "bottom",
	["Left"] = "left",
	["Right"] = "right",
}

WindowTool = Tool.create("Window", CustomWindow, "CustomWindow")

WindowTool:addProperty("Title", "edit", "Title", "setText", "getText")
WindowTool:addProperty("Movable", "check", true, "setMovable", "getMovable")
WindowTool:addProperty("Enabled Close Button", "check", false, "setCloseEnabled", "getCloseEnabled")
WindowTool:addProperty("Side Bar Position", "combo", {Value=Positions}, "setSideBarPosition", "getSideBarPosition")
WindowTool:addProperty("Side Bar Size", "spin", {0, 0, Width, 1}, "setSideBarLength", "getSideBarLength")