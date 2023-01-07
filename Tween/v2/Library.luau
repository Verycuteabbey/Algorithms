--> module compiled by VoID#6890(mengmengyujie@hotmail.com)

--> object for: Tween - Library

--———————————— variant ————————————--
local library = {};

--———————————— function ————————————--
function library:lerpResult(easeType, start: number, target: number, duration: number, process: number)
	--> analysis
	local easeStyle, easeDirection, extraProperties = table.unpack(easeType);
	local A, P, S = table.unpack(extraProperties);

	--> variant
	local currentProcess = process/duration;

	--> function
	local function bounceResult(start: number, process: number)
		local currentProcess = process/duration;
		if (currentProcess < (1/2.75)) then
			return target * (7.5625 * currentProcess^2) + start;
		elseif (currentProcess < (2/2.75)) then
			currentProcess -= 1.5/2.75;
			return target * (7.5625 * currentProcess^2 + 0.75) + start;
		elseif (currentProcess < (2.5/2.75)) then
			currentProcess -= 2.25/2.75;
			return target * (7.5625 * currentProcess^2 + 0.9375) + start;
		else
			currentProcess -= 2.625/2.75;
			return target * (7.5625 * currentProcess^2 + 0.984375) + start;
		end;
	end;

	--> main
	if (easeStyle == "Linear") then
		return target * currentProcess + start;

		--> "In" direction
	elseif (easeDirection == "In") then
		--> "Quad" style
		if (easeStyle == "Quad") then
			return target * currentProcess^2 + start;

			--> "Cubic" style
		elseif (easeStyle == "Cubic") then
			return target * currentProcess^3 + start;

			--> "Quart" style
		elseif (easeStyle == "Quart") then
			return target * currentProcess^4 + start;

			--> "Quint" style
		elseif (easeStyle == "Quint") then
			return target * currentProcess^5 + start;

			--> "Sine" style
		elseif (easeStyle == "Sine") then
			return -target * math.cos(currentProcess * (math.pi/2)) + target + start;

			--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == 0) then
				return start;
			end;
			return target * math.pow(2, 10 * (currentProcess - 1)) + start;

			--> "Circ" style
		elseif (easeStyle == "Circ") then
			return -target * (math.sqrt(1 - currentProcess^2) - 1) + start;

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
			if ((not A) or (A < math.abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * math.pi) * math.asin(target/A);
			end;
			currentProcess -= 1;
			return -(A * math.pow(2, 10 * currentProcess) * math.sin((currentProcess * duration - S) * (2 * math.pi)/P)) + start;

			--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			return target * currentProcess^2 * ((S + 1) * currentProcess - S) + start;

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
			return target * (currentProcess^3 + 1) + start;

			--> "Quart" style
		elseif (easeStyle == "Quart") then
			currentProcess -= 1;
			return -target * (currentProcess^4 - 1) + start;

			--> "Quint" style
		elseif (easeStyle == "Quint") then
			currentProcess -= 1;
			return target * (currentProcess^5 + 1) + start;

			--> "Sine" style
		elseif (easeStyle == "Sine") then
			return target * math.sin(currentProcess * (math.pi/2)) + target;

			--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == duration) then
				return start + target;
			end;
			return target * (-math.pow(2, -10 * currentProcess) + 1) + start;

			--> "Circ" style
		elseif (easeStyle == "Circ") then
			currentProcess -= 1;
			return target * math.sqrt(1 - currentProcess^2) + start;

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
			if ((not A) or (A < math.abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * math.pi) * math.asin(target/A);
			end;
			return A * math.pow(2, -10 * currentProcess) * math.sin((currentProcess * duration - S) * (2 * math.pi)/P) + target + start;

			--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			currentProcess -= 1;
			return target * (currentProcess^2 * ((S + 1) * currentProcess + S) + 1) + start;

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
				return target/2 * currentProcess^2 + start;
			end;
			return -target/2 * ((currentProcess - 1) * (currentProcess - 2) - 1) + start;

			--> "Cubic" style
		elseif (easeStyle == "Cubic") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess^3 + start;
			end;
			currentProcess -= 2;
			return target/2 * (currentProcess^3 + 2) + start;

			--> "Quart" style
		elseif (easeStyle == "Quart") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess^4 + start;
			end;
			currentProcess -= 2;
			return -target/2 * (currentProcess^4 - 2) + start;

			--> "Quint" style
		elseif (easeStyle == "Quint") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * currentProcess^5 + start;
			end;
			currentProcess -= 2;
			return target/2 * (currentProcess^5 + 2) + start;

			--> "Sine" style
		elseif (easeStyle == "Sine") then
			return -target/2 * (math.cos(math.pi * currentProcess) - 1) + start;

			--> "Expo" style
		elseif (easeStyle == "Expo") then
			if (process == 0) then
				return start;
			elseif (process == duration) then
				return start + target;
			end;
			currentProcess /= 2;
			if (currentProcess < 1) then
				return target/2 * math.pow(2, 10 * (currentProcess - 1)) + start;
			end;
			return target/2 * (-math.pow(2, -10 * (currentProcess - 1)) + 2) + start;

			--> "Circ" style
		elseif (easeStyle == "Circ") then
			currentProcess /= 2;
			if (currentProcess < 1) then
				return -target/2 * (math.sqrt(1 - currentProcess^2) - 1) + start;
			end;
			currentProcess -= 2;
			return target/2 * (math.sqrt(1 - currentProcess^2) + 1) + start;

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
			if ((not A) or (A < math.abs(target))) then
				A = target;
				S = P/4;
			else
				S = P/(2 * math.pi) * math.asin(target/A);
			end;
			currentProcess -= 1;
			if (currentProcess < 1) then
				return -0.5 * (A * math.pow(2, 10 * currentProcess) * math.sin((currentProcess * duration - S) * (2 * math.pi)/P)) + start;
			end;
			return A * math.pow(2, -10 * currentProcess) * math.sin((currentProcess * duration - S) * (2 * math.pi)/P) * 0.5 + target + start;

			--> "Back" style
		elseif (easeStyle == "Back") then
			if (not S) then
				S = 1.70158;
			end;
			currentProcess /= 2;
			S *= 1.525;
			if (currentProcess < 1) then
				return target/2 * (currentProcess^2 * ((S + 1) * currentProcess - S)) + start;
			end;
			currentProcess -= 2;
			return target/2 * (currentProcess^2 * (((S + 1) * currentProcess + S) + 2)) + start;

			--> "Bounce" style
		elseif (easeStyle == "Bounce") then
			if (process < duration/2) then
				local result = target * 2 - bounceResult(0, duration - process);
				return result * 0.5 + start;
			end;
			return bounceResult(0, process * 2 - duration) * 0.5 + target * 0.5 + start;
		end;
	end;
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
return library;
