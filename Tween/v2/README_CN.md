[English](https://github.com/Verycuteabbey/Algorithms/blob/main/Tween/v2/README.md)
### 这是什么？
这是一个适用于 Roblox 的 Tween 逻辑算法 v2，你可以 require() 来代替掉 TweenService！
### 使用
提供了两种模式, `easyTween()` 和 `customTween()`

`easyTween()` 是 `customTween()` 的精简版本，不需要太多的参数就能使用

`easyTween()` 需要 6 个参数
  - `targetInstance` | 目标
  - `targetProperty` | 目标的属性
  - `easeStyle` | 可以是 `Linear`, `Quad`, `Cubic`, `Quart`, `Quint`, `Sine`, `Expo`, `Circ`, `Elastic`, `Back`, `Bounce`
  - `easeDirection` | 可以是 `In`, `Out`, `InOut`
  - `target` | 属性的目标值
  - `duration` | 需要多少时间完成
	
`customTween()` 需要 7 个参数
  - `targetInstance` | 目标
  - `targetProperty` | 目标的属性
  - `easeType` | 一个集合
    - `easeStyle` | 可以是 `Linear`, `Quad`, `Cubic`, `Quart`, `Quint`, `Sine`, `Expo`, `Circ`, `Elastic`, `Back`, `Bounce`
    - `easeDirection` | 可以是 `In`, `Out`, `InOut`
    - `extraProperties` | 一个集合给 `Elastic` 和 `Back` 效果使用, 详细看 [Extra Properties](https://github.com/Verycuteabbey/Algorithms/blob/main/Tween/v1/README_CN.md#extra-properties)
  - `from` | 从属性的哪里开始
  - `target` | 属性的目标值
  - `duration` | 需要多少时间完成

示例:
```lua
easyTween(workspace.Part, "Position", "Linear", "InOut", Vector3.new(1, 1, 1), 1);
```
```lua
customTween(workspace.Part, "Position", {"Linear", "InOut", {A = 1, P = 2, S = 3}}, Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), 1);
```
