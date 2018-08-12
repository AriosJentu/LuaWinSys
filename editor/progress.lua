function CustomProgressBar.draw(tab) return CustomProgressBar.create(tab.X, tab.Y, tab.W, tab.H, tab.Rel, tab.Parent) end

ProgressBarTool = Tool.create("Progress Bar", CustomProgressBar, "CustomProgressBar")

ProgressBarTool:addProperty("Progress", "spin", {0, 0, 100}, "setProgress", "getProgress")
ProgressBarTool:removeProperty("Enabled")