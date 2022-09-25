--> Script Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Algorithm = require();
local Tween = {};

--———————————— Coroutine ————————————--
local CollectedThreads = {};
local RunningThreads = {};
local Thread = {};

function Thread.Create(Function, TweenInstance:Instance, TweenProperty:string)
	local self = {};
	self.CurrentThread = coroutine.create(Function);
	self.SuspendedTime = 0;
	self.TweenInstance = TweenInstance;
	self.TweenProperty = TweenProperty;
	--———————————— Object Functions ————————————--
	function self.Start()
		coroutine.resume(self.CurrentThread);
	end;
	function self.UpdateThread(NewFunction)
		coroutine.close(self.CurrentThread);
		self.CurrentThread = coroutine.create(NewFunction);
		self.SuspendedTime = 0;
		coroutine.resume(self.CurrentThread);
	end;
	table.insert(RunningThreads, self);
	return self;
end;

function Thread.Find(TweenInstance:Instance, TweenProperty:string)
	local CurrentThread;
	for _, RunningThread in pairs(RunningThreads) do
		if ((RunningThread.TweenInstance == TweenInstance) and (RunningThread.TweenProperty == TweenProperty)) then
			CurrentThread = RunningThread;
		end;
	end;
	return CurrentThread;
end;

task.spawn(function()
	local LoopedTime = 0;
	while (task.wait(1)) do
		for Number, RunningThread in pairs(RunningThreads) do
			if (coroutine.status(RunningThread.CurrentThread) == "died") then
				table.insert(CollectedThreads, RunningThread);
				table.remove(RunningThreads, Number);
			elseif (RunningThread.SuspendedTime > 10) then
				table.insert(CollectedThreads, RunningThread);
				table.remove(RunningThreads, Number);
			else
				RunningThread.SuspendedTime += 1;
			end;
		end;
		LoopedTime += 1;
		if (LoopedTime > 60) then
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
function Tween.Create(Instance:Instance, Property:string, EaseStyle:string, EaseDirection:string, End, Duration:number)
	local function Main()
		local PropertyType, PropertyNumber0, PropertyNumber1, PropertyNumber2, PropertyNumber3 = Transform(Instance[Property]);
		local TransformType, TransformNumber0, TransformNumber1, TransformNumber2, TransformNumber3 = Transform(End);
		--———————————— Main ————————————--
		local NowTime = 0;
		local LoopedTime = 0;
		local Precicion = 0.0125;
		local PrecicionTime = (1/Precicion) * Duration;
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
			if (LoopedTime > PrecicionTime) then
				break;
			end;
			--———————————— Lerp ————————————--
			local Lerp0;
			local Lerp1;
			local Lerp2;
			local Lerp3;
			local Lerps = {
				[1] = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber0, TransformNumber0 - PropertyNumber0, Duration);
				[2] = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber1, TransformNumber1 - PropertyNumber1, Duration);
				[3] = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber2, TransformNumber2 - PropertyNumber2, Duration);
				[4] = Algorithm.GetLerp(EaseStyle, EaseDirection, NowTime, PropertyNumber3, TransformNumber3 - PropertyNumber3, Duration);
			}
			if (TransformType == "CFrame") then
				Lerp0 = Lerps[1];
				Lerp1 = Lerps[2];
				Lerp2 = Lerps[3];
			elseif (TransformType == "UDim") then
				Lerp0 = Lerps[1];
				Lerp1 = Lerps[2];
			elseif (TransformType == "UDim2") then
				Lerp0 = Lerps[1];
				Lerp1 = Lerps[2];
				Lerp2 = Lerps[3];
				Lerp3 = Lerps[4];
			elseif (TransformType == "Vector2") then
				Lerp0 = Lerps[1];
				Lerp1 = Lerps[2];
			elseif (TransformType == "Vector3") then
				Lerp0 = Lerps[1];
				Lerp1 = Lerps[2];
				Lerp2 = Lerps[3];
			else
				Lerp0 = Lerps[1];
			end;
			--———————————— Enable ————————————--
			Instance[Property] = Transforms[TransformType](Lerp0, Lerp1, Lerp2, Lerp3);
			LoopedTime += 1;
			NowTime += Precicion;
			task.wait(Duration/PrecicionTime);
		end;
	end;
	--———————————— Thread ————————————--
	local Result = Thread.Find(Instance, Property);
	if (Result) then
		Result.UpdateThread(Main);
	else
		local NewThread = Thread.Create(Main, Instance, Property);
		NewThread.Start();
	end;
end;

--———————————— Module Run ————————————--
return Tween;
