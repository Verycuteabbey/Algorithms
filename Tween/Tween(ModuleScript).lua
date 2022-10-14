--> Module Compiled By Fallen_VCA#6890

--———————————— Local Variable - Services ————————————--
local RunService = game:GetService("RunService");

--———————————— Local Variable - Others ————————————--
local Algorithm = require();
local Connection = require();
local Thread = require();
local Tween = {};

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
		local Finished = false;
		local NowTime = 0;
		local LoopedTime = 0;
		local Precision = task.wait();
		local PrecisionTime = math.ceil((1/Precision) * Duration);
		local function OnHeartbeat()
			if (LoopedTime > PrecisionTime) then
				Finished = true;
				return;
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
		local NewConnection = RunService.Heartbeat:Connect(OnHeartbeat);
		local Result = Connection:Find({
			[1] = Instance;
			[2] = Property;
		});
		if (Result) then
			Result:Update(NewConnection);
		else
			Result = Connection:Add(NewConnection, {
				[1] = Instance;
				[2] = Property;
			});
		end;
		while (true) do
			if (Finished) then
				break;
			end;
			task.wait();
		end;
		NewConnection:Disconnect();
		Connection:Clear(Result);
	end;
	--———————————— Thread ————————————--
	local Result = Thread:Find({
		[1] = Instance;
		[2] = Property;
	});
	if (Result) then
		Result:Update(Main);
	else
		Thread:Create(Main, {
			[1] = Instance;
			[2] = Property;
		});
	end;
end;

--———————————— Module Run ————————————--
return Tween;
