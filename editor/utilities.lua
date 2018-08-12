--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--SETS

local nset = {}
nset.__index = nset

function set(vals)
	
	local self = setmetatable({}, nset)
	self:append(vals)

	return self
end

function nset.append(self, value)
	local visited = false

	if type(value) == "table" then

		for _, v in pairs(value) do
			self:append(v)
		end

	else

		for _, v in pairs(self) do
			if v == value then
				visited = true
			end
		end

		if not visited then
			self[#self+1] = value
		end
	end
end

function nset.remove(self, value)
	for i, v in pairs(self) do
		if v == value then
			return table.remove(self, i)
		end
	end
end

function nset.tostring(self)
	local s = "{" 
	for i, v in pairs(self) do
		if type(v) == "string" then s = s..'"'..v..'"'
		else s = s..tostring(v) end
		if i ~= #self then s = s..", " end
	end
	s = s.."}"
	return s
end

local ntype = type
function type(...)
	
	local args = {...}
	if getmetatable(args[1]) == nset then
		return "set"
	else
		return ntype(...)
	end
end

local nprint = print
function print(...)

	local args = {...}
	for i, v in pairs(args) do
		if type(v) == "set" then
			args[i] = v:tostring()
		end
	end

	nprint(unpack(args))
end