--> Module Script Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Algorithm = {};

--———————————— Module Functions ————————————--
function Algorithm.GetLerp(EaseStyle:string, EaseDirection:string, NowTime:number, Start:number, End:number, Duration:number, ExtraProperties)
	local Library = {
		--———————————— Linear ————————————--
		["Linear"] = End * (NowTime/Duration) + Start;
		--———————————— Quad ————————————--
		["Quad"] = {
			["In"] = function()
				NowTime = NowTime/Duration;
				return End * NowTime^2 + Start;
			end;
			["Out"] = function()
				NowTime = NowTime/Duration;
				return -End * NowTime * (NowTime - 2) + Start;
			end;
			["InOut"] = function()
				NowTime = NowTime/Duration;
				if ((NowTime/2) < 1) then
					return End/2 * NowTime^2 + Start;
				end;
				return -End/2 * ((NowTime - 1) * (NowTime - 2) - 1) + Start;
			end;
		};
		--———————————— Cubic ————————————--
		["Cubic"] = {
			["In"] = function()
				NowTime = NowTime/Duration;
				return End * NowTime^3 + Start;
			end;
			["Out"] = function()
				NowTime = NowTime/Duration - 1;
				return End * (NowTime^3 + 1) + Start;
			end;
			["InOut"] = function()
				NowTime = NowTime/Duration;
				if ((NowTime/2) < 1) then
					return End/2 * NowTime^3 + Start;
				end;
				NowTime -= 2;
				return End/2 * (NowTime^3 + 2) + Start;
			end;
		};
		--———————————— Quart ————————————--
		["Quart"] = {
			["In"] = function()
				NowTime = NowTime/Duration;
				return End * NowTime^4 + Start;
			end;
			["Out"] = function()
				NowTime = NowTime/Duration - 1;
				return -End * (NowTime^4 - 1) + Start;
			end;
			["InOut"] = function()
				NowTime = NowTime/Duration;
				if ((Duration/2) < 1) then
					return End/2 * NowTime^4 + Start;
				end;
				NowTime -= 2;
				return -End/2 * (NowTime^4 - 2) + Start;
			end;
		};
		--———————————— Quint ————————————--
		["Quint"] = {
			["In"] = function()
				NowTime = NowTime/Duration;
				return End * NowTime^5 + Start;
			end;
			["Out"] = function()
				NowTime = NowTime/Duration - 1;
				return End * (NowTime^5 + 1) + Start;
			end;
			["InOut"] = function()
				NowTime = NowTime/Duration;
				if ((NowTime/2) < 1) then
					return End/2 * NowTime^5 + Start;
				end;
				NowTime -= 2;
				return End/2 * (NowTime^5 + 2) + Start;
			end;
		};
		--———————————— Sine ————————————--
		["Sine"] = {
			["In"] = -End * math.cos(NowTime/Duration * (math.pi/2)) + End + Start;
			["Out"] = End * math.sin(NowTime/Duration * (math.pi/2)) + End;
			["InOut"] = -End/2 * (math.cos(math.pi * NowTime/Duration) - 1) + Start;
		};
		--———————————— Expo ————————————--
		["Expo"] = {
			["In"] = function()
				if (NowTime == 0) then
					return Start;
				else
					return End * math.pow(2, 10 * (NowTime/Duration - 1)) + Start;
				end;
			end;
			["Out"] = function()
				if (NowTime == Duration) then
					return Start + End;
				else
					return End * (-math.pow(2, -10 * NowTime/Duration) + 1) + Start;
				end;
			end;
			["InOut"] = function()
				if (NowTime == 0) then
					return Start;
				elseif (NowTime == Duration) then
					return Start + End;
				end;
				NowTime = NowTime/Duration;
				if ((NowTime/2) < 1) then
					return End/2 * math.pow(2, 10 * (NowTime - 1)) + Start;
				end;
				return End/2 * (-math.pow(2, -10 * NowTime - 1) + 2) + Start;
			end;
		};
		--———————————— Circ ————————————--
		["Circ"] = {
			["In"] = function()
				NowTime = NowTime/Duration;
				return -End * (math.sqrt(1 - NowTime^2) - 1) + Start;
			end;
			["Out"] = function()
				NowTime = NowTime/Duration - 1;
				return End * math.sqrt(1 - NowTime^2) + Start;
			end;
			["InOut"] = function()
				NowTime = NowTime/Duration;
				if ((NowTime/2) < 1) then
					return -End/2 * (math.sqrt(1 - NowTime^2) - 1) + Start;
				end;
			end;
		};
		--———————————— Elastic ————————————--
		["Elastic"] = {
			["In"] = function()
				local S;
				if (NowTime == 0) then
					return Start;
				end;
				NowTime = NowTime/Duration;
				if (NowTime == 1) then
					return Start + End;
				end;
				if (not ExtraProperties.P) then
					ExtraProperties.P = Duration * 0.3;
				end;
				if (not ExtraProperties.A) then
					S = ExtraProperties.P/4;
					ExtraProperties.A = End;
				else
					S = ExtraProperties.P/(2 * math.pi) * math.asin(End/ExtraProperties.A);
				end;
				NowTime -= 1;
				return -(ExtraProperties.A * math.pow(2, 10 * NowTime) * math.sin((NowTime * Duration - S) * (2 * math.pi) / ExtraProperties.P)) + Start;
			end;
			["Out"] = function()
				local S;
				if (NowTime == 0) then
					return Start;
				end;
				NowTime = NowTime/Duration;
				if (NowTime == 1) then
					return Start + End;
				end;
				if (not ExtraProperties.P) then
					ExtraProperties.P = Duration * 0.3;
				end;
				if (not ExtraProperties.A) then
					S = ExtraProperties.P/4;
					ExtraProperties.A = End;
				else
					S = ExtraProperties.P/(2 * math.pi) * math.asin(End/ExtraProperties.A);
				end;
				return (ExtraProperties.A * math.pow(2, -10 * NowTime) * math.sin((NowTime * Duration - S) * (2 * math.pi)/ExtraProperties.P) + End + Start);
			end;
			["InOut"] = function()
				local S;
				if (NowTime == 0) then
					return Start;
				end;
				NowTime = NowTime/Duration/2;
				if (NowTime == 2) then
					return Start + End;
				end;
				if (not ExtraProperties.P) then
					ExtraProperties.P = Duration * (0.3 * 1.5);
				end;
				if (not ExtraProperties.A) then
					S = ExtraProperties.P/4;
					ExtraProperties.A = End;
				else
					S = ExtraProperties.P/(2 * math.pi) * math.asin(End/ExtraProperties.A);
				end;
				if (NowTime < 1) then
					NowTime -= 1;
					return -0.5 * (ExtraProperties.A * math.pow(2, 10 * NowTime) * math.sin((NowTime * Duration - S) * (2 * math.pi)/ExtraProperties.P)) + Start;
				end;
				NowTime -= 1;
				return ExtraProperties.A * math.pow(2, -10 * NowTime) * math.sin((NowTime * Duration - S) * (2 * math.pi)/ExtraProperties.P) * 0.5 + End + Start;
			end;
		};
		--———————————— Back ————————————--
		["Back"] = {
			["In"] = function()
				if (not ExtraProperties.S) then
					ExtraProperties.S = 1.70158;
				end;
				NowTime = NowTime/Duration;
				return End * NowTime^2 * ((ExtraProperties.S + 1) * NowTime - ExtraProperties.S) + Start;
			end;
			["Out"] = function()
				if (not ExtraProperties.S) then
					ExtraProperties.S = 1.70158;
				end;
				NowTime = NowTime/Duration - 1;
				return End * (NowTime^2 * ((ExtraProperties.S + 1) * NowTime + ExtraProperties.S) + 1) + Start;
			end;
			["InOut"] = function()
				if (not ExtraProperties.S) then
					ExtraProperties.S = 1.70158;
				end;
				NowTime = NowTime/Duration/2;
				if (NowTime < 1) then
					ExtraProperties.S = ExtraProperties.S * 1.525;
					return End/2 * (NowTime^2 * ((ExtraProperties.S + 1) * NowTime - ExtraProperties.S)) + Start;
				end;
				NowTime -= 2;
				ExtraProperties.S = ExtraProperties.S * 1.525;
				return End/2 * (NowTime^2 * ((ExtraProperties.S + 1) * NowTime + ExtraProperties.S) + 2) + Start;
			end;
		};
		--———————————— Bounce ————————————--
		["Bounce"] = {
			["In"] = function()
				local function Lerp()
					NowTime = Duration - NowTime;
					Start = 0;
					NowTime = NowTime/Duration;
					if (NowTime < (1/2.75)) then
						return End * (7.5625 * NowTime^2) + Start;
					elseif (NowTime < (2/2.75)) then
						NowTime -= 1.5/2.75;
						return End * (7.5625 * NowTime^2 + 0.75) + Start;
					elseif (NowTime < (2.5/2.75)) then
						NowTime -= 2.25/2.75;
						return End * (7.5625 * NowTime^2 + 0.9375) + Start;
					else
						NowTime -= 2.625/2.75;
						return End * (7.5625 * NowTime^2 + 0.984375) + Start;
					end;
				end;
				return End - Lerp() + Start;
			end;
			["Out"] = function()
				NowTime = NowTime/Duration;
				if (NowTime < (1/2.75)) then
					return End * (7.5625 * NowTime^2) + Start;
				elseif (NowTime < (2/2.75)) then
					NowTime -= 1.5/2.75;
					return End * (7.5625 * NowTime^2 + 0.75) + Start;
				elseif (NowTime < (2.5/2.75)) then
					NowTime -= 2.25/2.75;
					return End * (7.5625 * NowTime^2 + 0.9375) + Start;
				else
					NowTime -= 2.625/2.75;
					return End * (7.5625 * NowTime^2 + 0.984375) + Start;
				end;
			end;
			["InOut"] = function()
				if (NowTime < Duration/2) then
					local function Lerp()
						NowTime = NowTime * 2;
						Start = 0;
						NowTime = NowTime/Duration;
						if (NowTime < (1/2.75)) then
							return End * (7.5625 * NowTime^2) + Start;
						elseif (NowTime < (2/2.75)) then
							NowTime -= 1.5/2.75;
							return End * (7.5625 * NowTime^2 + 0.75) + Start;
						elseif (NowTime < (2.5/2.75)) then
							NowTime -= 2.25/2.75;
							return End * (7.5625 * NowTime^2 + 0.9375) + Start;
						else
							NowTime -= 2.625/2.75;
							return End * (7.5625 * NowTime^2 + 0.984375) + Start;
						end;
					end;
					return Lerp() * 0.5 + Start;
				else
					local function Lerp()
						NowTime = NowTime * 2 - Duration;
						Start = 0;
						NowTime = NowTime/Duration;
						if (NowTime < (1/2.75)) then
							return End * (7.5625 * NowTime^2) + Start;
						elseif (NowTime < (2/2.75)) then
							NowTime -= 1.5/2.75;
							return End * (7.5625 * NowTime^2 + 0.75) + Start;
						elseif (NowTime < (2.5/2.75)) then
							NowTime -= 2.25/2.75;
							return End * (7.5625 * NowTime^2 + 0.9375) + Start;
						else
							NowTime -= 2.625/2.75;
							return End * (7.5625 * NowTime^2 + 0.984375) + Start;
						end;
					end;
					return Lerp() * 0.5 + End * 0.5 + Start;
				end;
			end;
		};
	};
	if (EaseStyle == "Linear") then
		return Library[EaseStyle];
	elseif (typeof(Library[EaseStyle][EaseDirection]) == "function") then
		return Library[EaseStyle][EaseDirection]();
	else
		return Library[EaseStyle][EaseDirection];
	end;
end;

--———————————— Module Run ————————————--
return Algorithm;
