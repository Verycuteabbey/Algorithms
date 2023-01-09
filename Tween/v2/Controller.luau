--> module compiled by VoID#6890(mengmengyujie@hotmail.com) & smallpenguin666(2942169233@qq.com)

--> object for: Tween - Controller

--———————————— reference ————————————--
local cancel = task.cancel;
local newCFrame = CFrame.new;
local newColor3 = Color3.fromRGB;
local newUDim = UDim.new;
local newUDim2 = UDim2.new;
local newVector2 = Vector2.new;
local newVector3 = Vector3.new;
local spawn = task.spawn;

--———————————— service ————————————--
local runService = game:GetService("RunService");

--———————————— variant ————————————--
local controller = {};
local library = require();
local typeTable = {
    ["CFrame"] = newCFrame;
    ["Color3"] = newColor3;
    ["UDim"] = newUDim;
    ["UDim2"] = newUDim2;
    ["Vector2"] = newVector2;
    ["Vector3"] = newVector3;
};

--———————————— function ————————————--
function controller:customTween(targetInstance, targetProperty: string, easeType, from, target, duration: number)
    local object = {};

    --> property
    object.instance = targetInstance;
    object.property = targetProperty;
    object.suspendedTime = 0;

    --> analysis
    local easeStyle, easeDirection, extraProperties = unpack(easeType);
    local propertyType = typeof(targetInstance[targetProperty]);
    local lastProperty = library:transformTarget(from, propertyType);
    local targetResult = library:transformTarget(target, propertyType);

    --> main
    local function tween()
        --> variant
        local nowTime = 0;
        local lerpResult = {};
        local options = {easeStyle, easeDirection, extraProperties};
        local transform = typeTable[propertyType];

        --> lerp
        local onHeartbeat;
        if (propertyType == "number") then
            onHeartbeat = function(deltaTime: number)
                if (nowTime >= duration) then
                    object.connection:Disconnect();
                    nowTime = duration;
                end;
                for number, index in ipairs(targetResult) do
                    lerpResult[number] = library:lerpResult(options, lastProperty[number], index - lastProperty[number], duration, nowTime);
                end;
                targetInstance[targetProperty] = unpack(lerpResult);
                nowTime += deltaTime;
                object.suspendedTime = 0;
            end;
        else
            onHeartbeat = function(deltaTime: number)
                if (nowTime >= duration) then
                    object.connection:Disconnect();
                    nowTime = duration;
                end;
                for number, index in ipairs(targetResult) do
                    lerpResult[number] = library:lerpResult(options, lastProperty[number], index - lastProperty[number], duration, nowTime);
                end;
                targetInstance[targetProperty] = transform(unpack(lerpResult));
                nowTime += deltaTime;
                object.suspendedTime = 0;
            end;
        end;

        --> connection
        object.connection = runService.Heartbeat:Connect(onHeartbeat);
    end;

    --> function
    function object:clear()
        self:stop();
        table.clear(self);
    end;
    function object:replay()
        self:stop();
        self.suspendedTime = 0;
        if (self.newFunction) then
            self.thread = spawn(self.newFunction);
        else
            self.thread = spawn(tween);
        end;
    end;
    function object:stop()
        self.connection:Disconnect();
        cancel(self.thread);
    end;
    function object:update(targetFunction)
        self.newFunction = targetFunction;
    end;

    --> find
    local findResult = library:findTween(targetInstance, targetProperty);
    if (findResult) then
        findResult:update(tween);
        findResult:replay();
        return findResult;

    --> resume
    else
        local resumeResult = library:resumeTween(targetInstance, targetProperty, tween);
        if (resumeResult) then
            return resumeResult;

        --> new
        else
            object.thread = spawn(tween);
            table.insert(library.active, object);
            return object;
        end;
    end;
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
        local nowTime = 0;
        local lerpResult = {};
        local options = {easeStyle, easeDirection, {}};
        local transform = typeTable[propertyType];

        --> lerp
        local onHeartbeat;
        if (propertyType == "number") then
            onHeartbeat = function(deltaTime: number)
                if (nowTime >= duration) then
                    object.connection:Disconnect();
                    nowTime = duration;
                end;
                for number, index in ipairs(targetResult) do
                    lerpResult[number] = library:lerpResult(options, lastProperty[number], index - lastProperty[number], duration, nowTime);
                end;
                targetInstance[targetProperty] = unpack(lerpResult);
                nowTime += deltaTime;
                object.suspendedTime = 0;
            end;
        else
            onHeartbeat = function(deltaTime: number)
                if (nowTime >= duration) then
                    object.connection:Disconnect();
                    nowTime = duration;
                end;
                for number, index in ipairs(targetResult) do
                    lerpResult[number] = library:lerpResult(options, lastProperty[number], index - lastProperty[number], duration, nowTime);
                end;
                targetInstance[targetProperty] = transform(unpack(lerpResult));
                nowTime += deltaTime;
                object.suspendedTime = 0;
            end;
        end;

        --> connection
        object.connection = runService.Heartbeat:Connect(onHeartbeat);
    end;

    --> function
    function object:clear()
        self:stop();
        table.clear(self);
    end;
    function object:replay()
        self:stop();
        self.suspendedTime = 0;
        if (self.newFunction) then
            self.thread = spawn(self.newFunction);
        else
            self.thread = spawn(tween);
        end;
    end;
    function object:stop()
        self.connection:Disconnect();
        cancel(self.thread);
    end;
    function object:update(targetFunction)
        self.newFunction = targetFunction;
    end;

    --> find
    local findResult = library:findTween(targetInstance, targetProperty);
    if (findResult) then
        findResult:update(tween);
        findResult:replay();
        return findResult;

    --> resume
    else
        local resumeResult = library:resumeTween(targetInstance, targetProperty, tween);
        if (resumeResult) then
            return resumeResult;

        --> new
        else
            object.thread = spawn(tween);
            table.insert(library.active, object);
            return object;
        end;
    end;
end;

--———————————— run ————————————--
return controller;
