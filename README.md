# Open Source | Algorithms [Beta]
## Warning
**This algorithm still in beta, there is no guarantee that there will be no problems during use**
### What is this?
This is a Tween Logic Algorithm for Roblox, you can require() this for instead TweenService (**NOT ALL**)

Algorithm is not finished yet, and also use harder of TweenService (**Hard at source code recompile**)
### Use
`Tween.Create()` is require 6 arguments:
Instance | Property | EaseType | EaseDirection | End | Duration

Instance —————— Is can be any instances, type check is Instance

Property —————— Is require to be "Instance" any property when you need to tween it

EaseType —————— You can enable one of this: "Linear", "Quad", "Cubic", "Quart", "Quint", "Sine", "Expo", "Circ"

EaseDirection —————— You can enable one of this: "In", "Out", "InOut"

End —————— Is can be "CFrame", "number", "UDim", "UDim2", "Vector2", "Vector3", depend on your property need to tween it

Duration —————— Tween running time

Example: Part's position (0, 0, 0) to (1, 1, 1)
```lua
Tween.Create(game.Workspace.Part, "Position", "Quad", "Out", Vector3.new(1, 1, 1), 1);
```
# End
Thank you for using algorithms, we are trying to let this algorithm's experience get more better!

If you are find bugs, welcome you take a screenshot report to my email:

mengmengyujie@hotmail.com

487313236@qq.com (Not recommended)
