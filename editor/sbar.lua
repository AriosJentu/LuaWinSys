function CustomScrollBar.draw(tab) return CustomScrollBar.create(tab.X, tab.Y, tab.W, tab.H, tab.Rel, tab.Parent) end

ScrollBarTool = Tool.create("Scroll Bar", CustomScrollBar, "CustomScrollBar")

ScrollBarTool:addProperty("Scroller Length", "spin", {5, 5, 100}, "setScrollLength", "getScrollLength")
ScrollBarTool:addProperty("Scroller Speed", "spin", {2, 2, 30}, "setScrollSpeed", "getScrollSpeed")
ScrollBarTool:addProperty("Progress", "spin", {0, 0, 100}, "setScrollPosition", "getScrollPosition")
