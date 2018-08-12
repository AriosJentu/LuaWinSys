function CustomMemo.draw(tab) return CustomMemo.create(tab.X, tab.Y, tab.W, tab.H, tab.Text, tab.Rel, tab.Parent) end

MemoBoxTool = Tool.create("Memo Box", CustomMemo, "CustomMemo")

MemoBoxTool:addProperty("Text", "edit", "Memo Box", "setText", "getText")
MemoBoxTool:addProperty("Read Only", "check", false, "setReadOnly", "getReadOnly")
MemoBoxTool:addProperty("Is On Side Bar", "check", false, "putOnSide", "isOnSide")