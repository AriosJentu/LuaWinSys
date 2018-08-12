function CustomSpinner.draw(tab) return CustomSpinner.create(tab.X, tab.Y, tab.W, tab.H, tab.Rel, tab.Parent) end

SpinnerBoxTool = Tool.create("Spinner", CustomSpinner, "CustomSpinner")

SpinnerBoxTool:addProperty("Value", "spin", {0, -100000, 100000}, "setText", "getText")
SpinnerBoxTool:addProperty("Read Only", "check", false, "setReadOnly", "getReadOnly")
SpinnerBoxTool:addProperty("Minimal Value", "spin", {0, -10000, 10000}, "setMinimal", "getMinimal")
SpinnerBoxTool:addProperty("Maximal Value", "spin", {100, -10000, 10000}, "setMaximal", "getMaximal")
SpinnerBoxTool:addProperty("Step", "spin", {1, 0.01, 1000}, "setStepSize", "getStepSize")