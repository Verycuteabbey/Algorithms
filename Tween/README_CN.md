[English](https://github.com/Verycuteabbey/Algorithms/Tween/blob/main/README.md)

## 警告
**该算法还处于测试阶段，不能保证在使用过程中没有任何问题**
### 这是什么？
这是一个适用于 Roblox 的 Tween 逻辑算法, 你可以 require() 这个并且取代 TweenService (**不能是全部**)

算法并没有完善, 并且难用于 TweenService (**难在源码重编译**)
### 使用
`Tween.Create()` 需要 7 个参数:
Instance | Property | EaseType | EaseDirection | End | Duration | ExtraProperties

Instance —————— 可以是任何 instances, 类型指定是 Instance

Property —————— 要求是 "Instance" 的任何一个属性

EaseType —————— 你可以应用这里的其中一个: "Linear", "Quad", "Cubic", "Quart", "Quint", "Sine", "Expo", "Circ", "Elastic", "Back", "Bounce"

EaseDirection —————— 你可以应用这里的其中一个: "In", "Out", "InOut"

End —————— 可以为 "CFrame", "number", "UDim", "UDim2", "Vector2", "Vector3", 决定于 Property

Duration —————— Tween 运行时间

ExtraProperties —————— 只适用于 "Elastic" 与 "Back"，详细看 [Extra Properties](https://github.com/Verycuteabbey/Algorithms/Tween/blob/main/README_CN.md#extra-properties-不推荐)

示例: Part 的坐标 (0, 0, 0) 到 (1, 1, 1)
```lua
Tween.Create(game.Workspace.Part, "Position", "Quad", "Out", Vector3.new(1, 1, 1), 1, {});
```
### Extra Properties (不推荐)
**若提交空表将会应用默认参数值**

包含 3 个参数, 分别为 "A", "P", "S", 所有都为数字

"A" 与 "P" 为 "Elastic" 效果的参数，"S" 为 "Back" 效果的参数

"A" 必须大于或等于 "End" 参数，越高的值效果距离将会更远

"P" 越低, "Elastic" 效果将会更加快

"S" 越高, "Back" 效果距离将会更远