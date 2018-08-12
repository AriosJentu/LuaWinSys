function CustomTooltip.draw(tab) return CustomTooltip.create(tab.Text, tab.Parent, tab.Time) end

ToolTipTool = Tool.create("Tooltip", CustomTooltip, "CustomTooltip")

for key, _ in pairs(ToolTipTool.Properties) do
	if key ~= "Color Scheme" then
		ToolTipTool:removeProperty(key)
	end
end