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

	return Object[id]

end

function Object.update(self, prop, value)

	if prop == "Position X" or prop == "Position Y" then
		return self:updatePositions(prop, value)
	elseif prop == "Width" or prop == "Height" then
		return self:updateSizes(prop, value)
	end


	local isfuncable = (self.Properties[prop].Set ~= nil) and true or false
	local types = self.Properties[prop].Type

	local setf = self.Properties[prop].Set
	local getf = self.Properties[prop].Get

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

		self.Properties[prop].Selected = value
		setf(self.Element, self.Properties[prop].Value.Value[value])
		self.PropList[prop]:setSelectedItem(value)

	end

end

function Object.updatePositions(self, prop, value)

	self.PropList[prop]:setText(value)

	local x, y = self.Element:getPosition(false)

	if prop == "Position X" then
		x = tonumber(self.PropList[prop]:getText())
		self.Properties[prop] = x
	else
		y = tonumber(self.PropList[prop]:getText())
		self.Properties[prop] = y
	end

	self.Element:setPosition(x, y, false)
end

function Object.updateSizes(self, prop, value)

	if self.PropList[prop] then
		self.PropList[prop]:setText(value)

		local w, h = self.Element:getSize(false)

		if prop == "Width" then
			w = tonumber(self.PropList[prop]:getText())
			self.Properties[prop] = w
		else
			h = tonumber(self.PropList[prop]:getText())
			self.Properties[prop] = h
		end

		self.Element:setSize(w, h, false)
	end
end
