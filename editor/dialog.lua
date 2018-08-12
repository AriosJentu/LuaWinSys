function CustomDialog.draw(tab) return CustomDialog.create(tab.W, tab.Text, {"Accept", "Cancel"}, tab.Parent) end

DialogTool = Tool.create("Dialog", CustomDialog, "CustomDialog")

for key, _ in pairs(DialogTool.Properties) do
	if key ~= "Color Scheme" then
		DialogTool:removeProperty(key)
	end
end