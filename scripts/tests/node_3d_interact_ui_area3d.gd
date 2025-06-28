extends Node3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

@onready var camera: Camera3D = $Camera3D
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var sub_viewport: SubViewport = $SubViewport
@onready var node_area: Area3D = $Sprite3D/Area3D

func _ready():
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)

func _unhandled_input(event):
	# Check if the event is a non-mouse/non-touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via Physics Picking.
			return
	print("_unhandled_input")
	sub_viewport.push_input(event)

func _mouse_entered_area():
	print("enter")
	is_mouse_inside = true

func _mouse_exited_area():
	print("exit")
	is_mouse_inside = false

#area3d for interact sprite from subviewport size
func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	# Convert the 3D event_position to SubViewport 2D coordinates
	var local_point = sprite_3d.to_local(event_position)
	var sprite_size = sprite_3d.pixel_size * sprite_3d.texture.get_size()  # Size in 3D world units
	var subviewport_size = sub_viewport.size  # SubViewport resolution (e.g., 320x180)
	
	# Normalize the local point to UV coordinates (0 to 1)
	var uv = Vector2(
		(local_point.x / sprite_size.x + 0.5),
		(-local_point.y / sprite_size.y + 0.5)  # Y is inverted
	)
	
	# Convert UV to SubViewport pixel coordinates
	var mouse_pos_2d = Vector2(
		uv.x * subviewport_size.x,
		uv.y * subviewport_size.y
	)
	
	# Modify the event's position if it's a mouse event
	if event is InputEventMouse:
		event.position = mouse_pos_2d
		event.global_position = mouse_pos_2d
	print("mouse_pos_2d: ", mouse_pos_2d)
	# Send the modified input event to the SubViewport
	sub_viewport.push_input(event)

func _on_button_pressed() -> void:
	print("area3d button test")
	#pass
