# 开源 | Algorithms [测试版]

(English)[https://github.com/Verycuteabbey/Algorithms/blob/main/README.md]

## 警告
**该算法还处于测试阶段，不能保证在使用过程中没有任何问题**
### What is this?
This is a Tween Logic Algorithm for Roblox, 你可以 require() 这个并且取代 TweenService (**不能是全部**)

算法并没有完善, 并且难用于 TweenService (**难在源码重编译**)
### 使用
`Tween.Create()` 需要 6 个参数:
Instance | Property | EaseType | EaseDirection | End | Duration

Instance —————— 可以是任何 instances, 类型指定是 Instance

Property —————— 要求是 "Instance" 的任何一个属性

EaseType —————— 你可以应用这里的其中一个: "Linear", "Quad", "Cubic", "Quart", "Quint", "Sine", "Expo", "Circ"

EaseDirection —————— 你可以应用这里的其中一个: "In", "Out", "InOut"

End —————— 可以为 "CFrame", "number", "UDim", "UDim2", "Vector2", "Vector3", 决定于 Property

Duration —————— Tween 运行时间

示例: Part 的坐标 (0, 0, 0) 到 (1, 1, 1)
```lua
Tween.Create(game.Workspace.Part, "Position", "Quad", "Out", Vector3.new(1, 1, 1), 1);
```
# End
感谢你使用该算法, 我们正在尝试让算法的体验变得更好!

如果找到 Bug, 可以截图并发送到我的联系方式:

1.QQ
 - 487313236

2.邮箱
 - mengmengyujie@hotmail.com

 - 487313236@qq.com (Not recommended)
