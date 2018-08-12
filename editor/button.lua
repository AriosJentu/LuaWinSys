function CustomButton.draw(tab) return CustomButton.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end
function CustomButton.getImage(self) return self.ImageLocation end

ButtonTool = Tool.create("Button", CustomButton, "CustomButton")

ButtonTool:addProperty("Text", "edit", "Button", "setText", "getText")
ButtonTool:addProperty("Image", "edit", "", "setImage", "getImage")
