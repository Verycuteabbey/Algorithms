# Open Source | Algorithms [Beta]

[简体中文](https://github.com/Verycuteabbey/Algorithms/blob/main/README_CN.md)

## Warning
**This algorithm still in beta, there is no guarantee that there will be no problems during use**
### What is this?
This is a Tween Logic Algorithm for Roblox, you can require() this for instead TweenService (**NOT ALL**)

Algorithm is not finished yet, and also use harder of TweenService (**Hard at source code recompile**)
### Use
`Tween.Create()` is require 7 arguments:
Instance | Property | EaseType | EaseDirection | End | Duration | ExtraProperties

Instance —————— Is can be any instances, type check is Instance

Property —————— Is require to be "Instance" any property

EaseType —————— You can enable one of this: "Linear", "Quad", "Cubic", "Quart", "Quint", "Sine", "Expo", "Circ", "Elastic", "Back", "Bounce"

EaseDirection —————— You can enable one of this: "In", "Out", "InOut"

End —————— Is can be "CFrame", "number", "UDim", "UDim2", "Vector2", "Vector3", depend on your tween property

Duration —————— Tween running time

ExtraProperties —————— Only for ease style "Elastic" and "Back", see [Extra Properties](https://github.com/Verycuteabbey/Algorithms/blob/main/README.md#extra-properties-not-recommented)

Example: Part's position (0, 0, 0) to (1, 1, 1)
```lua
Tween.Create(game.Workspace.Part, "Position", "Quad", "Out", Vector3.new(1, 1, 1), 1, {});
```
### Extra Properties (**NOT RECOMMENTED**)
**If given a empty table will enable default argument's setting**

Includes 3 arguments, they are "A", "P", "S", all are number

"A" and "P" is for style "Elastic", "S" is for style "Back"

Higher "A" and "P", elastic tween effect will more quickly (looks like?)

Higher "S", back tween effect will more stronger
# End
Thank you for using algorithms, we are trying to let this algorithm's experience get more better!

If you are find bugs, welcome you take a screenshot report to my email:

mengmengyujie@hotmail.com

487313236@qq.com (Not recommended)
