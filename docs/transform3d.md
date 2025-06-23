
# Notes:
  There different method to handle move position, global, transform for forward direction. Working to create diferent state on how player states.

  To handle transform, tween, raycast and others.

## 	local forward
```gdscript
	var forward = (transform.basis.z.normalized()) * -1
```
## global forward
```gdscript
	var forward = (global_transform.basis.z.normalized()) * -1
```

## look at
```gdscript
	look_at(target_position, Vector3.UP) # Target position and up direction
```

## Vector3:
```
Vector3.FORWARD:(0.0, 0.0, -1.0)
Vector3.BACK:(0.0, 0.0, 1.0)
Vector3.DOWN:(0.0, -1.0, 0.0)
Vector3.UP:(0.0, 1.0, 0.0)
Vector3.LEFT:(-1.0, 0.0, 0.0)
Vector3.RIGHT:(1.0, 0.0, 0.0)
```

## forward:
```
@export var speed = 5.0
func _process(delta):
	var forward = -transform.basis.z
	global_position += forward * speed * delta
```

```
@export var speed = 5.0
func _process(delta):
	var forward = -transform.basis.z
	translate(forward * speed * delta)
```
## rotate:

```
rotate_x(angle)
rotate_y(angle)
rotate_z(angle)
rotation (Vector3)
looking_at(target, up_direction)
interpolate_with(to, weight)
```