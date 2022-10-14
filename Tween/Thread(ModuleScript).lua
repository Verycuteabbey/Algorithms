--> Module Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Thread = {};
Thread.Objects = {};

--———————————— Local Functions ————————————--
local function Collector()
	local LoopedTime = 0;
	while (task.wait(1)) do
		for _, Index in pairs(Thread.Objects) do
			if (not Index.Suspended) then
				Index.IdleTime += 1;
				if (Index.IdleTime >= 5) then
					Index.Suspended = true;
				end;
			end;
		end;
		LoopedTime += 1;
		if (LoopedTime >= 60) then
			LoopedTime = 0;
			for Number, Index in pairs(Thread.Objects) do
				if (Index.Suspended) then
					Index:Destroy();
					table.remove(Thread.Objects, Number);
				end;
			end;
		end;
	end;
end;

--———————————— Module Functions ————————————--
function Thread:Create(Function, Properties)
	local Object = {};
	--———————————— Properties ————————————--
	local Instance, Property = table.unpack(Properties);
	Object.IdleTime = 0;
	Object.Instance = Instance;
	Object.Property = Property;
	Object.Suspended = false;
	Object.Thread = task.spawn(Function);
	--———————————— Object Functions ————————————--
	function Object:Destroy()
		table.clear(self);
	end;
	function Object:Update(Function)
		task.cancel(self.Thread);
		self.IdleTime = 0;
		self.Thread = task.spawn(Function);
	end;
	--———————————— Enable ————————————--
	table.insert(self.Objects, Object);
	return Object;
end;

function Thread:Find(Properties)
	local Found = false;
	local Instance, Property = table.unpack(Properties);
	for _, Index in pairs(self.Objects) do
		if ((Index.Instance == Instance) and (Index.Property == Property)) then
			if (Index.Suspended) then
				Found = true;
				Index.Suspended = false;
			else
				Found = true;
			end;
			return Index;
		end;
	end;
	if (not Found) then
		return;
	end;
end;

--———————————— Module Run ————————————--
task.spawn(Collector);
return Thread;
