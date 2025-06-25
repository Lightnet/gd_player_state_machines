extends Node3D
# https://forum.godotengine.org/t/keyword-translation-doesnt-work-in-godot-4-because-its-seen-as-a-variable-what-should-i-use-instead/5610
var camlock = false

@export var camera:Camera3D
@export var spring_arm:SpringArm3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spring_arm.add_excluded_object(get_parent())

func _input(event):
	
	if Input.is_action_just_pressed("escape"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion && camlock == false:
			rotation_degrees.x = clamp(rotation_degrees.x-event.relative.y*0.1, -70, 70)
			rotation_degrees.y -= event.relative.x*0.1

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("tab"):
		if camlock == false:
			camlock = true
		else:
			camlock = true
	if camlock == true:
		rotation.x = lerp_angle(rotation.x,0.0,0.1)
		rotation.y = lerp_angle(rotation.y,0.0,0.1)
	
	if Input.is_action_pressed("RMB"):
		spring_arm.position.x = lerp(spring_arm.position.x,1.0,0.1)
		spring_arm.spring_length = lerp(spring_arm.spring_length,3,0.1)
	else:
		spring_arm.position.x = lerp(spring_arm.position.x,0.0,0.1)
		spring_arm.spring_length = lerp(spring_arm.spring_length,5.0,0.1)
