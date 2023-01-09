[简体中文](https://github.com/Verycuteabbey/Algorithms/blob/main/Tween/v2/README_CN.md)
### What is this?
This is a Tween Logic Algorithm v2 for Roblox, you can require() Controller to instead TweenService!
### Use
There are two modes let you choose, `easyTween()` and `customTween()`

`easyTween()` is `customTween()`'s simplified version, not need too much arguments

`easyTween()` need 6 arguments
  - `targetInstance` | Target instance
  - `targetProperty` | Target instance's property
  - `easeStyle` | It's can be `Linear`, `Quad`, `Cubic`, `Quart`, `Quint`, `Sine`, `Expo`, `Circ`, `Elastic`, `Back`, `Bounce`
  - `easeDirection` | It's can be `In`, `Out`, `InOut`, `OutIn`
  - `target` | Target property value
  - `duration` | How many time spend at tween
	
`customTween()` need 7 arguments
  - `targetInstance` | Target instance
  - `targetProperty` | Target instance's property
  - `easeType` | A table
    - `easeStyle` | It's can be `Linear`, `Quad`, `Cubic`, `Quart`, `Quint`, `Sine`, `Expo`, `Circ`, `Elastic`, `Back`, `Bounce`
    - `easeDirection` | It's can be `In`, `Out`, `InOut`, `OutIn`
    - `extraProperties` | A table for `Elastic` and `Back` style, see [Extra Properties](https://github.com/Verycuteabbey/Algorithms/tree/main/v1/Tween#extra-properties)
  - `from` | Start property value
  - `target` | Target property value
  - `duration` | How many time spend at tween

examples:
```lua
easyTween(workspace.Part, "Position", "Linear", "InOut", Vector3.new(1, 1, 1), 1);
```
```lua
customTween(workspace.Part, "Position", {"Linear", "InOut", {A = 1, P = 2, S = 3}}, Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), 1);
```
