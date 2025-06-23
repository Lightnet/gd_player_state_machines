extends RigidBody3D
# https://www.youtube.com/watch?v=fMC9JWg4BMk
var rotating = false

var prev_mouse_position:Vector2
var next_mouse_position:Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("rotate"):
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
		print("rotate true")
	if Input.is_action_just_released("rotate"):
		rotating = false
		print("rotate false")
	
	if rotating:
		next_mouse_position = get_viewport().get_mouse_position()
		rotate_y((next_mouse_position.x - prev_mouse_position.x) * .1 * delta)
		rotate_z(-(next_mouse_position.y - prev_mouse_position.y) * .1 * delta)
		prev_mouse_position = next_mouse_position
		
	pass
