--> Script Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Algorithm = require();
local Tween = {};

--———————————— Coroutine ————————————--
local CollectedThreads = {};
local RunningThreads = {};
local Threads = {};

function Threads.Create(Function, Instance:Instance, Property:string)
	local self = {};
	self.CurrentThread = coroutine.create(Function);
	self.SuspendedTime = 0;
	self.TweenInstance = Instance;
	self.TweenProperty = Property;
	--———————————— Local Functions ————————————--
	local function ResetTime()
		if (self.SuspendedTime < 5) then
			self.SuspendedTime = 0;
		end;
	end
	--———————————— Object Functions ————————————--
	function self.Collect()
		for Number, RunningThread in pairs(RunningThreads) do
			if ((RunningThread == self) and (self.SuspendedTime >= 5)) then
				table.insert(CollectedThreads, self);
				table.remove(RunningThreads, Number);
			end;
		end;
	end;
	function self.StartThread()
		local IsSucessed, ReturnInfo = coroutine.resume(self.CurrentThread);
		if (not IsSucessed) then
			warn(string.format("Thread at resume got some problems:\n	- %s", ReturnInfo));
		end;
	end;
	function self.UpdateStatus(NewFunction)
		coroutine.close(self.CurrentThread);
		self.CurrentThread = coroutine.create(NewFunction);
		self.StartThread();
		ResetTime();
	end;
	--———————————— Enable ————————————--
	table.insert(RunningThreads, self);
	return self;
end;

function Threads.Find(Instance:Instance, Property:string)
	local CurrentThread;
	for _, RunningThread in pairs(RunningThreads) do
		if ((RunningThread.TweenInstance == Instance) and (RunningThread.TweenProperty == Property)) then
			CurrentThread = RunningThread;
		end;
	end;
	return CurrentThread;
end;

task.spawn(function()
	local LoopedTime = 0;
	while (task.wait(1)) do
		for _, RunningThread in pairs(RunningThreads) do
			RunningThread.SuspendedTime += 1;
			RunningThread.Collect();
		end;
		LoopedTime += 1;
		if (LoopedTime >= 30) then
			LoopedTime = 0;
			for Number, _ in pairs(CollectedThreads) do
				table.remove(CollectedThreads, Number);
			end;
		end;
	end;
end);

--———————————— Local Functions ————————————--
local function Transform(Origin)
	if (typeof(Origin) == "CFrame") then
		return "CFrame", Origin.X, Origin.Y, Origin.Z;
	elseif (typeof(Origin) == "UDim") then
		return "UDim", Origin.Scale, Origin.Offset;
	elseif (typeof(Origin) == "UDim2") then
		return "UDim2", Origin.X.Scale, Origin.X.Offset, Origin.Y.Scale, Origin.Y.Offset;
	elseif (typeof(Origin) == "Vector2") then
		return "Vector2", Origin.X, Origin.Y;
	elseif (typeof(Origin) == "Vector3") then
		return "Vector3", Origin.X, Origin.Y, Origin.Z;
	else
		return "Number", Origin;
	end;
end;

--———————————— Module Functions ————————————--
function Tween.Create(Instance:Instance, Property:string, EaseStyle:string, EaseDirection:string, End, Duration:number, ExtraProperties)
	local function Main()
		local PropertyType, PropertyNumber0, PropertyNumber1, PropertyNumber2, PropertyNumber3 = Transform(Instance[Property]);
		local TransformType, TransformNumber0, TransformNumber1, TransformNumber2, TransformNumber3 = Transform(End);
		--———————————— Main ————————————--
		local NowTime = 0;
		local LoopedTime = 0;
		local Precision = 0.0166;
		local PrecisionTime = math.ceil((1/Precision) * Duration);
		local Transforms = {
			["CFrame"] = function(X:number, Y:number, Z:number)
				return CFrame.new(X, Y, Z);
			end;
			["Number"] = function(Number:number)
				return Number;
			end;
			["UDim"] = function(Scale:number, Offset:number)
				return UDim.new(Scale, Offset);
			end;
			["UDim2"] = function(X_Scale:number, X_Offset:number, Y_Scale:number, Y_Offset:number)
				return UDim2.new(X_Scale, X_Offset, Y_Scale, Y_Offset);
			end;
			["Vector2"] = function(X:number, Y:number)
				return Vector2.new(X, Y);
			end;
			["Vector3"] = function(X:number, Y:number, Z:number)
				return Vector3.new(X, Y, Z);
			end;
		};
		while (true) do
			if (LoopedTime > PrecisionTime) then
				break;
			end;
			--———————————— Lerp ————————————--
			local Lerp0;
			local Lerp1;
			local Lerp2;
			local Lerp3;
			if (TransformType == "CFrame") then
				Lerp0 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration, ExtraProperties);
				Lerp1 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber1, TransformNumber1 - PropertyNumber1, Duration, ExtraProperties);
				Lerp2 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber2, TransformNumber2 - PropertyNumber2, Duration, ExtraProperties);
			elseif (TransformType == "UDim") then
				Lerp0 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration, ExtraProperties);
				Lerp1 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber1, TransformNumber1 - PropertyNumber1, Duration, ExtraProperties);
			elseif (TransformType == "UDim2") then
				Lerp0 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration, ExtraProperties);
				Lerp1 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber1, TransformNumber1 - PropertyNumber1, Duration, ExtraProperties);
				Lerp2 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber2, TransformNumber2 - PropertyNumber2, Duration, ExtraProperties);
				Lerp3 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber3, TransformNumber3 - PropertyNumber3, Duration, ExtraProperties);
			elseif (TransformType == "Vector2") then
				Lerp0 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration, ExtraProperties);
				Lerp1 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber1, TransformNumber1 - PropertyNumber1, Duration, ExtraProperties);
			elseif (TransformType == "Vector3") then
				Lerp0 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration, ExtraProperties);
				Lerp1 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber1, TransformNumber1 - PropertyNumber1, Duration, ExtraProperties);
				Lerp2 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber2, TransformNumber2 - PropertyNumber2, Duration, ExtraProperties);
			else
				Lerp0 = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration, ExtraProperties);
			end;
			--———————————— Enable ————————————--
			Instance[Property] = Transforms[TransformType](Lerp0, Lerp1, Lerp2, Lerp3);
			LoopedTime += 1;
			NowTime += Precision;
			task.wait(Duration/PrecisionTime);
		end;
	end;
	--———————————— Thread ————————————--
	local Result = Threads.Find(Instance, Property);
	if (Result) then
		Result.UpdateStatus(Main);
	else
		local NewThread = Threads.Create(Main, Instance, Property);
		NewThread.StartThread();
	end;
end;

--———————————— Module Run ————————————--
return Tween;
