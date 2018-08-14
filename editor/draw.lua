local Drawing = false
local CursorPositions = {X=0, Y=0}
local DiffPositions = {X=0, Y=0}

ListOfObjects = {}

addEventHandler("onClientGUIMouseDown", root, function(_, x, y)

	if CurrentTool.Drawable then

		local visited = false
		local parent = source

		for _, v in pairs(ListOfObjects) do
			if source == v.DrawableElement then
				local sx, sy = guiGetOnScreenPosition(source)
				DiffPositions = {X=sx, Y=sy}
				visited = true
				parent = v.Element
			end
		end

		if visited or source == EditorFrame then

			CursorPositions = {X=x, Y=y}

			x = CursorPositions.X - DiffPositions.X
			y = CursorPositions.Y - DiffPositions.Y

			local currentid = #ListOfObjects+1
			ListOfObjects[currentid] = Object.create(CurrentTool, x, y, 0, 0, CurrentTool.Tool, false, parent)
			CurrentObject = ListOfObjects[currentid]

			CurrentObject:updatePositions("Position X", x)
			CurrentObject:updatePositions("Position Y", y)
			CurrentObject:updateSizes("Width", 0)
			CurrentObject:updateSizes("Height", 0)

			Drawing = true
		end

	end
end)

addEventHandler("onClientGUIMouseUp", root, function()
	Drawing = false
	CursorPositions = {X=0, Y=0}	
	DiffPositions = {X=0, Y=0}
end)

addEventHandler("onClientCursorMove", root, function(_, _, x, y)

	if Drawing and CurrentObject then
		
		local width = math.abs(x - CursorPositions.X)
		local height = math.abs(y - CursorPositions.Y)

		local ax = math.min(x-DiffPositions.X, CursorPositions.X-DiffPositions.X)
		local ay = math.min(y-DiffPositions.Y, CursorPositions.Y-DiffPositions.Y)

		CurrentObject:updatePositions("Position X", ax)
		CurrentObject:updatePositions("Position Y", ay)
		CurrentObject:updateSizes("Width", width)
		CurrentObject:updateSizes("Height", height)
	end


end)