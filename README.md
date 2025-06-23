# gd_player_state_machine

# License: MIT

# status:
- vaulting test.
- obstacle test.

# Information:
	
  This is sample project for state machines to test basic movement and interact for player controls. There are different way to handle state machines depend on the game play and controls. It is base on GDQuest creator tutorial but out date some degree for missing or remove api for Godot 4.4.1 changes. Which had to adapt to change.

  The reason for state machines is check for condition for input from user controls and state. One is example is prone pose while jump which should not be doing. The prone position can only move slowly but can't jump. It need to be out the pose stance. By Crouch or stand to jump. Another is ladder state to prevent gravity fall.

  Another point is later use AI logic state.

  Testing vehicle interact.

# Features:
- state machine
	- [x] idle
	- [x] walk
	- [ ] sprint
	- [x] jump
	- [x] edge climb with area 3d (wip)
	- [x] fall
	- [ ] crouch
	- [ ] slide
	- [ ] prone
	- [ ] ghost
	- [ ] fly
	- [ ] ladder
	- [ ] climb over
	- [ ] ladder
	- [ ] death

- UI debug
	- [x] player state
	- [x] draw line
	- [x] draw point
- [ ] Vehicle
- [ ] Ladder
- [ ] Edge Climb
- [ ] Inventory
- [ ] 

# Notes:
	There are three access position, global, transform for forward direction.
	
	This part is for testing to reflect how player state and other things to make code works.
	
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

# Credits:
- https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
- https://docs.godotengine.org/en/3.2/tutorials/misc/state_design_pattern.html
- https://gdscript.com/solutions/godot-state-machine/
- https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
- https://www.youtube.com/watch?v=zcLxBk-Els8 How to make a BASIC FPS CLIMB / VAULT system in Godot 4.2!
- https://www.youtube.com/watch?v=vapZQ0EuXAs GODOT 4 DYNAMIC MANTLE AND VAULT TUTORIAL
- https://www.youtube.com/@Brokencircuitboard
- https://www.youtube.com/watch?v=JnrhURF1jgM How To Draw Lines and Points in 3D - Godot 4 Tutorial
- https://www.reddit.com/r/godot/comments/14pean4/godot_4xgdextensions_forward_left_up_of_a_node/
- https://docs.godotengine.org/en/stable/tutorials/3d/using_transforms.html
- https://www.youtube.com/watch?v=fMC9JWg4BMk Click and Drag 3D Rotation in Godot

# Content Credits:
- https://kenney.nl/assets/prototype-textures
- 

# Addons Credits:
- console
	- Developer Console
	- Author: jitspoe
- 
	
