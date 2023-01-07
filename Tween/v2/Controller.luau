--> module compiled by VoID#6890(mengmengyujie@hotmail.com)

--> object for: Tween - Controller

--———————————— service ————————————--
local runService = game:GetService("RunService");

--———————————— variant ————————————--
local controller = {};
controller.tweens = {};
local library = require();

--———————————— function ————————————--
local function tweenCollector()
    while (task.wait(1)) do
        for number, index in pairs(controller.tweens) do
            index.suspendedTime += 1;
            if (index.suspendedTime > 5) then
                index:clear();
                table.remove(controller.tweens, number);
            end;
        end;
    end;
end;

function controller:customTween(targetInstance, targetProperty: string, easeType, from, target, duration: number)
    local object = {};

    --> property
    object.instance = targetInstance;
    object.property = targetProperty;
    object.suspendedTime = 0;

    --> analysis
    local easeStyle, easeDirection, extraProperties = table.unpack(easeType);
    local propertyType = typeof(targetInstance[targetProperty]);
    local lastProperty = library:transformTarget(from, propertyType);
    local targetResult = library:transformTarget(target, propertyType);

    --> main
    local function tween()
        local finished = false;
        local nowTime = 0;
        local lerpResult = {};

        --> lerp
        local function onHeartbeat()
            if (nowTime > duration) then
                finished = true;
                return;
            end;
            for number, index in pairs(targetResult) do
                lerpResult[number] = library:lerpResult({easeStyle, easeDirection, extraProperties}, lastProperty[number], index - lastProperty[number], duration, nowTime);
            end;
            if (propertyType == "CFrame") then
                targetInstance[targetProperty] = CFrame.new(lerpResult[1], lerpResult[2], lerpResult[3]);
            elseif (propertyType == "Color3") then
                targetInstance[targetProperty] = Color3.fromRGB(lerpResult[1], lerpResult[2], lerpResult[3]);
            elseif (propertyType == "number") then
                targetInstance[targetProperty] = lerpResult[1];
            elseif (propertyType == "UDim") then
                targetInstance[targetProperty] = UDim.new(lerpResult[1], lerpResult[2]);
            elseif (propertyType == "UDim2") then
                targetInstance[targetProperty] = UDim2.new(lerpResult[1], lerpResult[2], lerpResult[3], lerpResult[4]);
            elseif (propertyType == "Vector2") then
                targetInstance[targetProperty] = Vector2.new(lerpResult[1], lerpResult[2]);
            elseif (propertyType == "Vector3") then
                targetInstance[targetProperty] = Vector3.new(lerpResult[1], lerpResult[2], lerpResult[3]);
            end;
            table.clear(lerpResult);
			nowTime += task.wait();
            object.suspendedTime = 0;
        end;

        --> connection
        for _, index in pairs(self.tweens) do
            if ((index.instance == targetInstance) and (index.property == targetProperty)) then
                index:stop();
            end;
        end;
        local Connection = runService.Heartbeat:Connect(onHeartbeat);
        object.connection = Connection;
        while (true) do
            if (finished) then
                break;
            end;
            task.wait();
        end;
        Connection:Disconnect();
    end;

    --> function
    function object:clear()
        self:stop();
        table.clear(self);
    end;
    function object:replay()
        self:stop();
        self.suspendedTime = 0;
        self.thread = task.spawn(tween);
    end;
    function object:stop()
        self.connection:Disconnect();
        task.cancel(self.thread);
    end;

    --> end
    object.thread = task.spawn(tween);
    table.insert(self.tweens, object);
    return object;
end;

function controller:easyTween(targetInstance, targetProperty: string, easeStyle: string, easeDirection: string, target, duration: number)
    local object = {};

    --> property
    object.instance = targetInstance;
    object.property = targetProperty;
    object.suspendedTime = 0;

    --> analysis
    local propertyType = typeof(targetInstance[targetProperty]);
    local lastProperty = library:transformTarget(targetInstance[targetProperty], propertyType);
    local targetResult = library:transformTarget(target, propertyType);

    --> main
    local function tween()
        local finished = false;
        local nowTime = 0;
        local lerpResult = {};

        --> lerp
        local function onHeartbeat()
            if (nowTime > duration) then
                finished = true;
                return;
            end;
            for number, index in pairs(targetResult) do
                lerpResult[number] = library:lerpResult({easeStyle, easeDirection, {}}, lastProperty[number], index - lastProperty[number], duration, nowTime);
            end;
            if (propertyType == "CFrame") then
                targetInstance[targetProperty] = CFrame.new(lerpResult[1], lerpResult[2], lerpResult[3]);
            elseif (propertyType == "Color3") then
                targetInstance[targetProperty] = Color3.fromRGB(lerpResult[1], lerpResult[2], lerpResult[3]);
            elseif (propertyType == "number") then
                targetInstance[targetProperty] = lerpResult[1];
            elseif (propertyType == "UDim") then
                targetInstance[targetProperty] = UDim.new(lerpResult[1], lerpResult[2]);
            elseif (propertyType == "UDim2") then
                targetInstance[targetProperty] = UDim2.new(lerpResult[1], lerpResult[2], lerpResult[3], lerpResult[4]);
            elseif (propertyType == "Vector2") then
                targetInstance[targetProperty] = Vector2.new(lerpResult[1], lerpResult[2]);
            elseif (propertyType == "Vector3") then
                targetInstance[targetProperty] = Vector3.new(lerpResult[1], lerpResult[2], lerpResult[3]);
            end;
            table.clear(lerpResult);
			nowTime += task.wait();
            object.suspendedTime = 0;
        end;

        --> connection
        for _, index in pairs(self.tweens) do
            if ((index.instance == targetInstance) and (index.property == targetProperty)) then
                index:stop();
            end;
        end;
        local Connection = runService.Heartbeat:Connect(onHeartbeat);
        object.connection = Connection;
        while (true) do
            if (finished) then
                break;
            end;
            task.wait();
        end;
        Connection:Disconnect();
    end;

    --> function
    function object:clear()
        self:stop();
        table.clear(self);
    end;
    function object:replay()
        self:stop();
        object.suspendedTime = 0;
        self.thread = task.spawn(tween);
    end;
    function object:stop()
        self.connection:Disconnect();
        task.cancel(self.thread);
    end;

    --> end
    object.thread = task.spawn(tween);
    table.insert(self.tweens, object);
    return object;
end;

--———————————— run ————————————--
task.defer(tweenCollector);
return controller;
