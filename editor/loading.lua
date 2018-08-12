function CustomLoading.draw(tab) return CustomLoading.create(tab.X, tab.Y, tab.Rel, tab.Parent) end

LoadingTool = Tool.create("Loading Bar", CustomLoading, "CustomLoading")

LoadingTool:addProperty("Progress", "spin", {0, 0, 100}, "setProgress", "getProgress")
LoadingTool:addProperty("Animated", "check", true, "setAnimated", "getAnimated")
LoadingTool:removeProperty("Width")
LoadingTool:removeProperty("Height")
