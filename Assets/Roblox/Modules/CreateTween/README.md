## CreateTween
[CreateTween]: #user-content-createtween

CreateTween allows you to create animations
with tweens in a simplified way
it was designed for animating uses

## CreateTween:CreateNewTween()
[CreateTween:CreateNewTween()]: #user-content-createtweencreatenewtween
```lua
function CreateTween:CreateNewTween(TypeOfInstance, {Data}, EasingStyle: String, EasingDirection: String, time: int,  PlayOnCreation: bool)
```
CreateNewTween basically creates a tween with
the following arguments: *TypeOfInstance* refers
to what you are using, *Data* is the table for
the properties that are being tweened, *EasingStyle*
refers to the style of the tween you want to use,
*EasingDirection* refers to the way the tween will act,
*time* is the Interpolation time the tween will go through,
*PlayOnCreation* is whether you want the tween to be played or not
