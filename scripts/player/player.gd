class_name Player extends CharacterBody3D


@export var WALK_SPEED := 10.0
@export var SPRINT_SPEED = 8.0

@export var JUMP_VELOCITY := 4.0
@export var GRAVITY := 9.8
@export var GRAVITY_FALL := 0.9
@export var AIR_CONTROL_SPEED := 5.0
@export var IS_CONTROLLER: = true #handle when the menu N/A
@export var CROUCH_HEIGHT_SCALE = 0.5
@export var CROUCH_RADIUS_SCALE = 0.5

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# camera handle for all state.
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(80), deg_to_rad(90))
			
	if event.is_action_pressed("escape"):
		get_tree().quit()
