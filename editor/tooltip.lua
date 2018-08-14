function CustomTooltip.draw(tab) return CustomTooltip.create(tab.Text, tab.Parent, 1) end

ToolTipTool = Tool.create("Tooltip", CustomTooltip, "CustomTooltip")
ToolTipTool.Drawable = false

for key, _ in pairs(ToolTipTool.Properties) do
	if key ~= "Color Scheme" then
		ToolTipTool:removeProperty(key)
	end
end

ToolTipTool:addProperty("Showing Time", "spin", {1, 0, 10, 0.1}, "setShowTime", "getShowTime")
