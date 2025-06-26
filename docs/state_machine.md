## Player State Nodes:

player.tscn
```
Player (CharacterBody3D) (player.gd)
-CollisionShape3D
-MeshInstance3D
-Neck
	-Camera3D
-StateMachine
	-Idle
	-Running
	-Walking
	-Jumping
	-Falling
	-Ghost
	-Flying
	-Crouching
-draw3d
```

state_machine.gd
```
class_name StateMachine extends Node

@export var initial_state: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()

func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")
	
func _input(event: InputEvent) -> void:
	state.handle_input(event)

func _unhandled_input(event: InputEvent) -> void:
	#print("statemachine _unhandled_input", state.name)
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
	#print("state: ", state.name)
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
```

state.gd
```
# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
## Virtual base class for all states.
## Extend this class and override its methods to implement a state.
class_name State extends Node

## Emitted when the state finishes and wants to transition to another state.
signal finished(next_state_path: String, data: Dictionary)

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass

```

player.gd
```
class_name Player extends CharacterBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D

@export var WALK_SPEED := 5.0
@export var SPRINT_SPEED = 8.0

@export var JUMP_VELOCITY := 4.0
@export var GRAVITY := 9.8
@export var GRAVITY_FALL := 0.9
@export var AIR_CONTROL_SPEED := 5.0
@export var IS_CONTROLLER: = true # handle when the menu N/A
@export var CROUCH_HEIGHT_SCALE = 0.5
@export var CROUCH_RADIUS_SCALE = 0.5
@export var CROUCH_SPEED = 2.5 
@export var is_climbing:bool = false

# Stored original properties
var original_shape_height: float
var original_shape_radius: float
var original_mesh_position: Vector3
var original_neck_position: Vector3
var original_position_y: float

@onready var draw_3d: Node = $draw3d
@export var statemachine:Node

var obstacles:Array

func _ready() -> void:
	#...
	pass
```

# refs:
- https://www.youtube.com/watch?v=EX0oIS_BD70  Advanced State Machine - Learn Godot 4 3D - no talking
- https://www.youtube.com/watch?v=cMtEagxz4h0 Programming Wallrunning in my Game with Godot
- https://www.youtube.com/watch?v=K9JizfQ-oFU
- 
- 
- 
- 
- 
