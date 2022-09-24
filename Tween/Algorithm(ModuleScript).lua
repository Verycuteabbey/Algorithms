--> Module Script Compiled By Fallen_VCA#6890

--———————————— Local Variable - Others ————————————--
local Algorithm = {};

--———————————— Module Functions ————————————--
function Algorithm.GetLerp(EaseStyle:string, EaseDirection:string, NowTime:number, Start:number, End:number, Duration:number)
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
