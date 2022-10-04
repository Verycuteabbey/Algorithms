--> Script Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Algorithm = require();
local Tween = {};

--———————————— Coroutine ————————————--
local Threads = {};
Threads.Collected = {};
Threads.Idle = {};
Threads.Running = {};

function Threads.Create(Function, Instance:Instance, Property:string)
	local Thread = {};
	local self = {};
	--———————————— Metatable ————————————--
	self.__call = function(self, Argument:string, ...)
		if (Argument == "Clear") then
			table.clear(self);
			table.clear(Thread);
		elseif (Argument == "Run") then
			table.insert(Threads.Running, Thread);
			for Number, Object in pairs(Threads.Idle) do
				if (Object == Thread) then
					table.remove(Threads.Idle, Number);
				end;
			end;
			local IsSucessed, ReturnInfo = coroutine.resume(Thread.CurrentThread);
			if (not IsSucessed) then
				local String = "Coroutine has got a problem form Thread %s\n	- &s\n";
				warn(String:format(tostring(Thread.CurrentThread), ReturnInfo));
			end;
		elseif (Argument == "Update") then
			coroutine.close(Thread.CurrentThread);
			Thread.CurrentThread = coroutine.create(...);
			local IsSucessed, ReturnInfo = coroutine.resume(Thread.CurrentThread);
			if (not IsSucessed) then
				local String = "Coroutine has got a problem form Thread %s\n	- &s\n";
				warn(String:format(tostring(Thread.CurrentThread), ReturnInfo));
			end;
			Thread.SuspendedTime = 0;
		end;
	end;
	--———————————— Objects ————————————--
	Thread.CurrentThread = coroutine.create(Function);
	Thread.SuspendedTime = 0;
	Thread.TweenInstance = Instance;
	Thread.TweenProperty = Property;
	--———————————— Enable ————————————--
	setmetatable(Thread, self);
	table.insert(Threads.Idle, Thread);
	return Thread;
end;

function Threads.Find(Instance:Instance, Property:string)
	local CurrentThread;
	for _, Object in pairs(Threads.Running) do
		if ((Object.TweenInstance == Instance) and (Object.TweenProperty == Property)) then
			CurrentThread = Object;
		end;
	end;
	return CurrentThread;
end;

task.spawn(function()
	local LoopedTime = 0;
	while (task.wait(1)) do
		--———————————— Suspended Time ————————————--
		for Number, Object in pairs(Threads.Running) do
			Object.SuspendedTime += 1;
			if (Object.SuspendedTime >= 5) then
				table.insert(Threads.Collected, Object);
				table.remove(Threads.Running, Number);
			end;
		end;
		LoopedTime += 1;
		--———————————— Recycle ————————————--
		if (LoopedTime >= 60) then
			LoopedTime = 0;
			for _, Object in pairs(Threads.Collected) do
				Object("Clear");
			end;
			table.clear(Threads.Collected);
		end;
	end;
end);

--———————————— Local Functions ————————————--
local function Analysis(Type:string, Argument)
	if (Type == "EaseType") then
		if (not Argument.Style) then
			Argument.Style = "Linear";
		end;
		if (not Argument.Direction) then
			Argument.Direction = "Out";
		end;
		if (not Argument.ExtraProperties) then
			Argument.ExtraProperties = {};
		end;
		return Argument.Style, Argument.Direction, Argument.ExtraProperties;
	elseif (Type == "Target") then
		if (typeof(Argument) == "CFrame") then
			return "CFrame", {
				[1] = Argument.X;
				[2] = Argument.Y;
				[3] = Argument.Z;
			};
		elseif (typeof(Argument) == "Color3") then
			return "Color3", {
				[1] = Argument.R;
				[2] = Argument.G;
				[3] = Argument.B;
			};
		elseif (typeof(Argument) == "UDim") then
			return "UDim", {
				[1] = Argument.Scale;
				[2] = Argument.Offset;
			};
		elseif (typeof(Argument) == "UDim2") then
			return "UDim2", {
				[1] = Argument.X.Scale;
				[2] = Argument.X.Offset;
				[3] = Argument.Y.Scale;
				[4] = Argument.Y.Offset;
			};
		elseif (typeof(Argument) == "Vector2") then
			return "Vector2", {
				[1] = Argument.X;
				[2] = Argument.Y;
			};
		elseif (typeof(Argument) == "Vector3") then
			return "Vector3", {
				[1] = Argument.X;
				[2] = Argument.Y;
				[3] = Argument.Z;
			};
		else
			return nil, Argument;
		end;
	end;
end;

--———————————— Module Functions ————————————--
function Tween.Create(Instance:Instance, Property:string, EaseType, Target, Duration:number)
	local function Main()
		local Style, Direction, ExtraProperties = Analysis("EaseType", EaseType);
		local _, PropertyTransforms = Analysis("Target", Instance[Property]);
		local TargetType, TargetTransforms = Analysis("Target", Target);
		--———————————— Main ————————————--
		local NowTime = 0;
		local LoopedTime = 0;
		local Precision = task.wait();
		local PrecisionTime = math.ceil((1/Precision) * Duration);
		while (true) do
			if (LoopedTime > PrecisionTime) then
				break;
			end;
			--———————————— Lerp ————————————--
			local Lerps = {};
			if (typeof(TargetTransforms) == "table") then
				if (#TargetTransforms == 2) then
					Lerps[1] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[1], TargetTransforms[1] - PropertyTransforms[1], Duration);
					Lerps[2] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[2], TargetTransforms[2] - PropertyTransforms[2], Duration);
				elseif (#TargetTransforms == 3) then
					Lerps[1] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[1], TargetTransforms[1] - PropertyTransforms[1], Duration);
					Lerps[2] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[2], TargetTransforms[2] - PropertyTransforms[2], Duration);
					Lerps[3] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[3], TargetTransforms[3] - PropertyTransforms[3], Duration);
				elseif (#TargetTransforms == 4) then
					Lerps[1] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[1], TargetTransforms[1] - PropertyTransforms[1], Duration);
					Lerps[2] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[2], TargetTransforms[2] - PropertyTransforms[2], Duration);
					Lerps[3] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[3], TargetTransforms[3] - PropertyTransforms[3], Duration);
					Lerps[4] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms[4], TargetTransforms[4] - PropertyTransforms[4], Duration);
				end;
			else
				Lerps[1] = Algorithm.GetLerp(Style, Direction, ExtraProperties, NowTime, PropertyTransforms, TargetTransforms - PropertyTransforms, Duration);
			end;
			--———————————— Enable ————————————--
			if (TargetType == "CFrame") then
				Instance[Property] = CFrame.new(Lerps[1], Lerps[2], Lerps[3]);
			elseif (TargetType == "Color3") then
				Instance[Property] = Color3.new(Lerps[1], Lerps[2], Lerps[3]);
			elseif (TargetType == "UDim") then
				Instance[Property] = UDim.new(Lerps[1], Lerps[2]);
			elseif (TargetType == "UDim2") then
				Instance[Property] = UDim2.new(Lerps[1], Lerps[2], Lerps[3], Lerps[4]);
			elseif (TargetType == "Vector2") then
				Instance[Property] = Vector2.new(Lerps[1], Lerps[2]);
			elseif (TargetType == "Vector3") then
				Instance[Property] = Vector3.new(Lerps[1], Lerps[2], Lerps[3]);
			else
				Instance[Property] = Lerps[1];
			end;
			LoopedTime += 1;
			NowTime += Precision;
			task.wait(Duration/PrecisionTime);
		end;
	end;
	--———————————— Thread ————————————--
	local Result = Threads.Find(Instance, Property);
	if (Result) then
		Result("Update", Main);
	else
		local Thread = Threads.Create(Main, Instance, Property);
		Thread("Run");
	end;
end;

--———————————— Module Run ————————————--
return Tween;
