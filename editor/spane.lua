function CustomScrollPane.draw(tab) return CustomScrollPane.create(tab.X, tab.Y, tab.W, tab.H, tab.Rel, tab.Parent) end

ScrollPaneTool = Tool.create("Scroll Pane", CustomScrollPane, "CustomScrollPane")

ScrollPaneTool:addProperty("Inversed Vertical Scrolling", "check", false, "setVerticalScrollInversed", "isVerticalScrollInversed")
ScrollPaneTool:addProperty("Inversed Horizontal Scrolling", "check", false, "setHorizontalScrollInversed", "isHorizontalScrollInversed")
ScrollPaneTool:addProperty("Horizontal Scrolling with mouse", "check", false, "setHorizontalScrolling", "isHorizontalScrolling")
ScrollPaneTool:addProperty("Scroll Speed", "spin", {10, 2, 20}, "setScrollSpeed", "getScrollSpeed")