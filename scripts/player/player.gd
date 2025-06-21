class_name Player extends CharacterBody3D


@export var speed := 10.0
@export var gravity := -9.81
@export var jump_impulse := 10.0
@export var air_control_speed := 5.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("escape"):
		get_tree().quit()
