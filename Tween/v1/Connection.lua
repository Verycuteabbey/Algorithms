--> Module Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Connection = {};
Connection.Objects = {};

--———————————— Module Functions ————————————--
function Connection:Add(Connection:RBXScriptConnection, Properties)
	local Object = {};
	--———————————— Properties ————————————--
	local Instance, Property = table.unpack(Properties);
	Object.Connection = Connection;
	Object.Instance = Instance;
	Object.Property = Property;
	--———————————— Module Functions ————————————--
	function Object:Destroy()
		table.clear(self);
	end;
	function Object:Update(Connection:RBXScriptConnection)
		self.Connection:Disconnect();
		self.Connection = Connection;
	end;
	--———————————— Enable ————————————--
	table.insert(self.Objects, Object);
	return Object;
end;

function Connection:Clear(Object)
	for Number, Index in pairs(self.Objects) do
		if (Index == Object) then
			Index:Destroy();
			table.remove(self.Objects, Number);
		end;
	end;
end;

function Connection:Find(Properties)
	local Found = false;
	local Instance, Property = table.unpack(Properties);
	for _, Index in pairs(self.Objects) do
		if ((Index.Instance == Instance) and (Index.Property == Property)) then
			Found = true;
			return Index;
		end;
	end;
	if (not Found) then
		return;
	end;
end;

--———————————— Module Run ————————————--
return Connection;
