--> module compiled by VoID#6890(mengmengyujie@hotmail.com) & smallpenguin666(2942169233@qq.com)

--> object for: Tween - Library

--———————————— reference ————————————--
local abs = math.abs;
local asin = math.asin;
local cos = math.cos;
local pi = math.pi;
local pow = math.pow;
local remove = table.remove;
local sin = math.sin;
local spawn = task.spawn;
local sqrt = math.sqrt;
local wait = task.wait;

--———————————— variant ————————————--
local active = {};
local library = {};
local suspended = {};
library.active = active;
library.suspended = suspended;

--———————————— function ————————————--
local function tweenCollector()
	local LoopedTime = 0;
	while (wait(1)) do
		--> tab
		for number, index in pairs(active) do
			index.suspendedTime += 1;
			if (index.suspendedTime > 5) then
				active[#active + 1] = index;
				remove(active, number);
			end;
		end;
		LoopedTime += 1;

		--> clear
		if (LoopedTime > 60) then
			for number, index in pairs(suspended) do
				index:clear();
				remove(suspended, number);
			end;
			LoopedTime = 0;
		end;
	end;
end;

function library:findTween(targetInstance, targetProperty: string)
	for _, index in pairs(active) do
		if ((index.instance == targetInstance) and (index.property == targetProperty)) then
			return index;
		end;
	end;
	return;
end;

function library:lerpResult(easeType, start: number, target: number, duration: number, process: number)
	--> analysis
	local easeStyle, easeDirection, extraProperties = unpack(easeType);
	local A, P, S = unpack(extraProperties);

	--> variant
	local currentProcess = process/duration;

	--> function
	local function bounceResult(start: number, process: number)
		local currentProcess = process/duration;
		if (currentProcess < (1/2.75)) then
			return target * (7.5625 * currentProcess * currentProcess) + start;
		elseif (currentProcess < (2/2.75)) then
			currentProcess -= 1.5/2.75;
			return target * (7.5625 * currentProcess * currentProcess + 0.75) + start;
		elseif (currentProcess < (2.5/2.75)) then
			currentProcess -= 2.25/2.75;
			return target * (7.5625 * currentProcess * currentProcess + 0.9375) + start;
		else
			currentProcess -= 2.625/2.75;
			return target * (7.5625 * currentProcess * currentProcess + 0.984375) + start;
		end;
	end;

	--> main
	if (easeStyle == "Linear") then
		return target * currentProcess + start;

	--> "In" direction
	elseif (easeDirection == "In") then
		--> "Quad" style
		if (easeStyle == "Quad") then
			return target * currentProcess * currentProcess + start;

		--> "Cubic" style
		elseif (easeStyle == "Cubic") then
			return target * currentProcess * currentProcess * currentProcess + start;

		--> "Quart" style
		elseif (easeStyle == "Quart") then
			return target * currentProcess * currentProcess * currentProcess * currentProcess + start;

		--> "Quint" style
		elseif (easeStyle == "Quint") then
			return target * currentProcess * currentProcess * currentProcess * currentProcess * currentProcess + start;

		--> "Sine" style
		elseif (easeStyle == "Sine") then
			return -target * cos(currentProcess * (pi/2)) + target + start;

		--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == 0) then
				return start;
			end;
			return target * pow(2, 10 * (currentProcess - 1)) + start;

		--> "Circ" style
		elseif (easeStyle == "Circ") then
			return -target * (sqrt(1 - currentProcess * currentProcess) - 1) + start;

		--> "Elastic" style
		elseif (easeStyle == "Elastic") then
			local S;
			if (process == 0) then
				return start;
			end;
			if (currentProcess == 1) then
				return start + target;
			end;
			if (not P) then
				P = duration * 0.3;
			end;
			if ((not A) or (A < abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * pi) * asin(target/A);
			end;
			currentProcess -= 1;
			return -(A * pow(2, 10 * currentProcess) * sin((currentProcess * duration - S) * (2 * pi)/P)) + start;

		--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			return target * currentProcess * currentProcess * ((S + 1) * currentProcess - S) + start;

		--> "Bounce" style
		elseif (easeStyle == "Bounce") then
			return target - bounceResult(0, duration - process) + start;
		end;

	--> "Out" direction
	elseif (easeDirection == "Out") then
		--> "Quad" style
		if (easeStyle == "Quad") then
			return -target * currentProcess * (currentProcess - 2) + start;

		--> "Cubic" style
		elseif (easeStyle == "Cubic") then
			currentProcess -= 1;
			return target * (currentProcess * currentProcess * currentProcess + 1) + start;

		--> "Quart" style
		elseif (easeStyle == "Quart") then
			currentProcess -= 1;
			return -target * (currentProcess * currentProcess * currentProcess * currentProcess - 1) + start;

		--> "Quint" style
		elseif (easeStyle == "Quint") then
			currentProcess -= 1;
			return target * (currentProcess * currentProcess * currentProcess * currentProcess * currentProcess + 1) + start;

		--> "Sine" style
		elseif (easeStyle == "Sine") then
			return target * sin(currentProcess * (pi/2)) + target;

		--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == duration) then
				return start + target;
			end;
			return target * (-pow(2, -10 * currentProcess) + 1) + start;

		--> "Circ" style
		elseif (easeStyle == "Circ") then
			currentProcess -= 1;
			return target * sqrt(1 - currentProcess * currentProcess) + start;

		--> "Elastic" style
		elseif (easeStyle == "Elastic") then
			local S;
			if (process == 0) then
				return start;
			end;
			if (currentProcess == 1) then
				return start + target;
			end;
			if (not P) then
				P = duration * 0.3;
			end;
			if ((not A) or (A < abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * pi) * asin(target/A);
			end;
			return A * pow(2, -10 * currentProcess) * sin((currentProcess * duration - S) * (2 * pi)/P) + target + start;

		--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			currentProcess -= 1;
			return target * (currentProcess * currentProcess * ((S + 1) * currentProcess + S) + 1) + start;

		--> "Bounce" style
		elseif (easeStyle == "Bounce") then
			return bounceResult(start, process);
		end;

	--> "InOut" direction
	elseif (easeDirection == "InOut") then
		--> "Quad" style
		if (easeStyle == "Quad") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess * currentProcess + start;
			end;
			return -target/2 * ((currentProcess - 1) * (currentProcess - 2) - 1) + start;

		--> "Cubic" style
		elseif (easeStyle == "Cubic") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess * currentProcess * currentProcess + start;
			end;
			currentProcess -= 2;
			return target/2 * (currentProcess * currentProcess * currentProcess + 2) + start;

		--> "Quart" style
		elseif (easeStyle == "Quart") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess * currentProcess * currentProcess * currentProcess + start;
			end;
			currentProcess -= 2;
			return -target/2 * (currentProcess * currentProcess * currentProcess * currentProcess - 2) + start;

		--> "Quint" style
		elseif (easeStyle == "Quint") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess * currentProcess * currentProcess * currentProcess * currentProcess + start;
			end;
			currentProcess -= 2;
			return target/2 * (currentProcess * currentProcess * currentProcess * currentProcess * currentProcess + 2) + start;

		--> "Sine" style
		elseif (easeStyle == "Sine") then
			return -target/2 * (cos(pi * currentProcess) - 1) + start;

		--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == 0) then
				return start;
			elseif (process == duration) then
				return start + target;
			end;
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * pow(2, 10 * (currentProcess - 1)) + start;
			end;
			return target/2 * (-pow(2, -10 * (currentProcess - 1)) + 2) + start;

		--> "Circ" style
		elseif (easeStyle == "Circ") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return -target/2 * (sqrt(1 - currentProcess * currentProcess) - 1) + start;
			end;
			currentProcess -= 2;
			return target/2 * (sqrt(1 - currentProcess * currentProcess) + 1) + start;

		--> "Elastic" style
		elseif (easeStyle == "Elastic") then
			local S;
			if (process == 0) then
				return start;
			end;
			currentProcess /= 2;
			if (currentProcess == 2) then
				return start + target;
			end;
			if (not P) then
				P = duration * (0.3 * 1.5);
			end;
			if ((not A) or (A < abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * pi) * asin(target/A);
			end;
			currentProcess -= 1;
			if (currentProcess < 1) then
				return -0.5 * (A * pow(2, 10 * currentProcess) * sin((currentProcess * duration - S) * (2 * pi)/P)) + start;
			end;
			return A * pow(2, -10 * currentProcess) * sin((currentProcess * duration - S) * (2 * pi)/P) * 0.5 + target + start;

		--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			currentProcess /= 2;
			S *= 1.525;
			if (currentProcess < 1) then
				return target/2 * (currentProcess * currentProcess * ((S + 1) * currentProcess - S)) + start;
			end;
			currentProcess -= 2;
			return target/2 * (currentProcess * currentProcess * (((S + 1) * currentProcess + S) + 2)) + start;

		--> "Bounce" style
		elseif (easeStyle == "Bounce") then
			if (process < duration/2) then
				local result = target * 2 - bounceResult(0, duration - process);
				return result * 0.5 + start;
			end;
			return bounceResult(0, process * 2 - duration) * 0.5 + target * 0.5 + start;
		end;

	--> "OutIn" direction
	elseif (easeDirection == "OutIn") then
		target /= 2;
		if (currentProcess <= 0.5) then
			--> "Quad" style
			if (easeStyle == "Quad") then
				return -target * currentProcess * (currentProcess - 2) + start;

			--> "Cubic" style
			elseif (easeStyle == "Cubic") then
				currentProcess -= 1;
				return target * (currentProcess * currentProcess * currentProcess + 1) + start;

			--> "Quart" style
			elseif (easeStyle == "Quart") then
				currentProcess -= 1;
				return -target * (currentProcess * currentProcess * currentProcess * currentProcess - 1) + start;

			--> "Quint" style
			elseif (easeStyle == "Quint") then
				currentProcess -= 1;
				return target * (currentProcess * currentProcess * currentProcess * currentProcess * currentProcess + 1) + start;

			--> "Sine" style
			elseif (easeStyle == "Sine") then
				return target * sin(currentProcess * (pi/2)) + target;

			--> "Expo" style
			elseif (easeStyle == "Expo") then
				if (process == duration) then
					return start + target;
				end;
				return target * (-pow(2, -10 * currentProcess) + 1) + start;

			--> "Circ" style
			elseif (easeStyle == "Circ") then
				currentProcess -= 1;
				return target * sqrt(1 - currentProcess * currentProcess) + start;

			--> "Elastic" style
			elseif (easeStyle == "Elastic") then
				local S;
				if (process == 0) then
					return start;
				end;
				if (currentProcess == 1) then
					return start + target;
				end;
				if (not P) then
					P = duration * 0.3;
				end;
				if ((not A) or (A < abs(target))) then
					A = target;
					S = P/4;
				else
					S = P/(2 * pi) * asin(target/A);
				end;
				return A * pow(2, -10 * currentProcess) * sin((currentProcess * duration - S) * (2 * pi)/P) + target + start;

				--> "Back" style
			elseif (easeStyle == "Back") then
				if (not S) then
					S = 1.70158;
				end;
				currentProcess -= 1;
				return target * (currentProcess * currentProcess * ((S + 1) * currentProcess + S) + 1) + start;

				--> "Bounce" style
			elseif (easeStyle == "Bounce") then
				return bounceResult(start, process);
			end;
		end;
		--> "Quad" style
		if (easeStyle == "Quad") then
			return target + target * currentProcess * currentProcess + start;

		--> "Cubic" style
		elseif (easeStyle == "Cubic") then
			return target + target * currentProcess * currentProcess * currentProcess + start;

		--> "Quart" style
		elseif (easeStyle == "Quart") then
			return target + target * currentProcess * currentProcess * currentProcess * currentProcess + start;

		--> "Quint" style
		elseif (easeStyle == "Quint") then
			return target + target * currentProcess * currentProcess * currentProcess * currentProcess * currentProcess + start;

		--> "Sine" style
		elseif (easeStyle == "Sine") then
			return target + -target * cos(currentProcess * (pi/2)) + target + start;

		--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == 0) then
				return target + start;
			end;
			return target + target * pow(2, 10 * (currentProcess - 1)) + start;

		--> "Circ" style
		elseif (easeStyle == "Circ") then
			return target + -target * (sqrt(1 - currentProcess * currentProcess) - 1) + start;

		--> "Elastic" style
		elseif (easeStyle == "Elastic") then
			local S;
			if (process == 0) then
				return target + start;
			end;
			if (currentProcess == 1) then
				return target + start + target;
			end;
			if (not P) then
				P = duration * 0.3;
			end;
			if ((not A) or (A < abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * pi) * asin(target/A);
			end;
			currentProcess -= 1;
			return target + -(A * pow(2, 10 * currentProcess) * sin((currentProcess * duration - S) * (2 * pi)/P)) + start;

		--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			return target + target * currentProcess * currentProcess * ((S + 1) * currentProcess - S) + start;

		--> "Bounce" style
		elseif (easeStyle == "Bounce") then
			return target + target - bounceResult(0, duration - process) + start;
		end;
	end;
end;

function library:resumeTween(targetInstance, targetProperty: string, targetFunction)
	for number, index in pairs(suspended) do
		if ((index.instance == targetInstance) and (index.property == targetProperty)) then
			index:update(targetFunction);
			index:replay();
			active[#active + 1] = index;
			remove(suspended, number);
			local findResult = library:findTween(targetInstance, targetProperty);
			return findResult;
		end;
	end;
	return;
end;

function library:transformTarget(target, transformType: string)
	if (transformType == "CFrame") then
        return {
			[1] = target.X;
			[2] = target.Y;
			[3] = target.Z;
		};
    elseif (transformType == "Color3") then
        return {
			[1] = target.R;
			[2] = target.G;
			[3] = target.B;
		};
    elseif (transformType == "number") then
        return {
			[1] = target;
		};
    elseif (transformType == "UDim") then
        return {
			[1] = target.Scale;
			[2] = target.Offset;
		};
    elseif (transformType == "UDim2") then
        return {
			[1] = target.X.Scale;
			[2] = target.X.Offset;
			[3] = target.Y.Scale;
			[4] = target.Y.Offset;
		};
    elseif (transformType == "Vector2") then
        return {
			[1] = target.X;
			[2] = target.Y;
		};
    elseif (transformType == "Vector3") then
        return {
			[1] = target.X;
			[2] = target.Y;
			[3] = target.Z;
		};
    end;
end;

--———————————— run ————————————--
spawn(tweenCollector);
return library;
