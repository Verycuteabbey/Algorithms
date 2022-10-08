[English](https://github.com/Verycuteabbey/Algorithms/blob/main/Tween/README.md)
## 警告
**该算法还处于测试阶段，不能保证在使用过程中没有任何问题**
### 这是什么？
这是一个适用于 Roblox 的 Tween 逻辑算法, 你可以 require() Tween 来取代 TweenService (**不能完全取代，在效率方面 Roblox API 要好一些**)
### 使用
`Tween.Create()` 需要 5 个参数:

`Instance:Instance` | `Property:string` | `EaseType:table` | `Target:CFrame|Color3|number|UDim|UDim2|Vector2|Vector3` | `Duration:number`

`Instance` —————— 可以是任何 instances, 类型指定是 Instance

`Property` —————— 要求是 `Instance` 的任何一个属性

`EaseType` —————— 这是一个表, 必须要包含这 3 个参数: `Style`, `Direction`, `ExtraProperties`
  - `Style` 可以是 `Linear`, `Quad`, `Cubic`, `Quart`, `Quint`, `Sine`, `Expo`, `Circ`, `Elastic`, `Back`, `Bounce`
  - `Direction` 可以是 `In`, `Out`, `InOut`
  - `ExtraProperties` 可以是空表，详细看 [Extra Properties](https://github.com/Verycuteabbey/Algorithms/blob/main/Tween/README_CN.md#extra-properties-%E4%B8%8D%E6%8E%A8%E8%8D%90)

`Target` —————— 可以为 `CFrame`, `Color3`, `number`, `UDim`, `UDim2`, `Vector2`, `Vector3`, 决定于 Property

`Duration` —————— Tween 运行时间

示例: Part 的坐标用 Quart Out 效果在 1 秒内从 (0, 0, 0) 到 (1, 1, 1)
```lua
Tween.Create(game.Workspace.Part, "Position", {Style = "Quart", Direction = "Out", ExtraProperties = {}}, Vector3.new(1, 1, 1), 1);
```
### Extra Properties
包含 3 个参数, 分别为 `A`, `P`, `S`, 所有都为数字

`A` 与 `P` 为 `Elastic` 效果的参数，`S` 为 `Back` 效果的参数

`A` 必须大于或等于 `Target` 参数，越高的值效果距离将会更远

`P` 越低, `Elastic` 效果将会更加快

`S` 越高, `Back` 效果距离将会更远
