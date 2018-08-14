Object = {}
Object.__index = Object

function Object.create(tool, x, y, w, h, text, rel, parent)

	local id = #Object + 1

	Object[id] = setmetatable({}, Object)

	Object[id].Arguments = {
		X=x,
		Y=y,
		W=w,
		H=h,
		Text=text,
		Rel=rel,
		Parent=parent
	}

	Object[id].Properties = {}
	Object[id].PropList = {}
	Object[id].Variable = tool.Tool

	----------------------------------------------------------------------------------------------------------------

	for name, v in pairs(tool.Properties) do

		Object[id].Properties[name] = v
		local types = v.Type
		
		if v.Type == "edit" then
		
			Object[id].PropList[name] = WidgetProperties[name].Edit

		elseif v.Type == "check" then

			Object[id].PropList[name] = WidgetProperties[name].Check

		elseif v.Type == "combo" then

			Object[id].PropList[name] = WidgetProperties[name].Combo

		elseif v.Type == "spin" then

			Object[id].PropList[name] = WidgetProperties[name].Spin

		elseif v.Type == "button" then

			Object[id].PropList[name] = {Add=WidgetProperties[name].Add, Remove=WidgetProperties[name].Remove}

		end
	end

	Object[id].Tool = tool
	Object[id].Element = tool.Class.draw(Object[id].Arguments)

	if Object[id].Element.getFrame then
		Object[id].DrawableElement = Object[id].Element:getFrame()
	else
		Object[id].DrawableElement = nil
	end

	----------------------------------------------------------------------------------------------------------------

	local Downed = false
	Object[id].Element:addEvent("onClientGUIMouseDown", function()
		Downed = true

		CurrentObject = Object[id]

		Object[id].Tool:showProperties()
		CurrentObject:updateProperties()
	end)

	addEventHandler("onClientGUIMouseUp", root, function()
		Downed = false
	end)

	Object[id].Element:addEvent("onClientGUIClick", function()
		CurrentObject = Object[id]

		Object[id].Tool:showProperties()
		CurrentObject:updateProperties()
	end)

	----------------------------------------------------------------------------------------------------------------

	local function updatef()
		print("Updating")
		if CurrentObject == Object[id] then
			CurrentObject:updateProperties()

			CurrentObject:updateFromPositions("Position X")
			CurrentObject:updateFromPositions("Position Y")

			CurrentObject:updateFromSizes("Width")
			CurrentObject:updateFromSizes("Height")
		end
	end

	Object[id].Element:addEvent("onClientGUIChanged", updatef)
	Object[id].Element:addEvent("onClientMouseMove", function() if Downed then updatef() end end)


	return Object[id]

end

function Object.update(self, prop, value)

	if prop == "Position X" or prop == "Position Y" then
		return self:updatePositions(prop, value)
	elseif prop == "Width" or prop == "Height" then
		return self:updateSizes(prop, value)
	end

	----------------------------------------------------------------------------------------------------------------

	local isfuncable = false 
	if self.Properties[prop].Set then
		isfuncable = true
	end

	local types = self.Properties[prop].Type

	local setf = self.Properties[prop].Set
	local getf = self.Properties[prop].Get

	----------------------------------------------------------------------------------------------------------------

	if types == "edit" or types == "spin" then

		self.Properties[prop].Value = value
		
		if isfuncable then
			setf(self.Element, value)
			self.PropList[prop]:setText(getf(self.Element))
		else
			self.PropList[prop]:setText(value)
		end

	elseif types == "check" then

		self.Properties[prop].Value = value

		if isfuncable then
			setf(self.Element, value)
			self.PropList[prop]:setChecked(getf(self.Element))
		else
			self.PropList[prop]:setChecked(value)
		end

	elseif types == "combo" then

		for key, val in pairs(self.Properties[prop].Value.Value) do
			if val == value then
				self.Properties[prop].Selected = key
				setf(self.Element, self.Properties[prop].Value.Value[key])
				self.PropList[prop]:setSelectedItem(key)
				break
			end
		end
	end

end

function Object.updatePositions(self, prop, value)

	self.PropList[prop]:setText(value)

	local x, y = self.Element:getPosition(false)
	
	----------------------------------------------------------------------------------------------------------------

	if prop == "Position X" then
		x = tonumber(self.PropList[prop]:getText())
		self.Properties[prop] = {x, 0, Width, 1}
	else
		y = tonumber(self.PropList[prop]:getText())
		self.Properties[prop] = {y, 0, Height, 1}
	end

	self.Element:setPosition(x, y, false)
end

function Object.updateSizes(self, prop, value)

	if self.PropList[prop] then
		self.PropList[prop]:setText(value)

		local w, h = self.Element:getSize(false)
	
		------------------------------------------------------------------------------------------------------------

		if prop == "Width" then
			w = tonumber(self.PropList[prop]:getText())
			self.Properties[prop] = {w, 0, Width, 1}
		else
			h = tonumber(self.PropList[prop]:getText())
			self.Properties[prop] = {h, 0, Height, 1}
		end

		self.Element:setSize(w, h, false)
	end
end

function Object.updateFromPositions(self, prop)


	local x, y = self.Element:getPosition(false)
	local value = y
	local s = Height

	if prop == "Position X" then
		value = x
		s = Width
	end

	self.Properties[prop] = {value, 0, s, 1}
	self.PropList[prop]:setText(value)
end

function Object.updateFromSizes(self, prop)

	local w, h = self.Element:getSize(false)
	local value = h
	local s = Height

	if prop == "Width" then
		value = w
		s = Width
	end

	self.Properties[prop] = {value, 0, s, 1}
	self.PropList[prop]:setText(value)
end

function Object.updateProperties(self)
	
	for key, val in pairs(self.Properties) do

		local isfuncable = false 
		if val.Get then
			isfuncable = true
		end
	
		if isfuncable then
			self:update(key, val.Get(self.Element))
		end
	end

	self:update("Variable Name", self.Variable)
end