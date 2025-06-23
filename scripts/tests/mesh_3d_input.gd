extends MeshInstance3D

func _ready() -> void:
	print("Vector3.FORWARD:", Vector3.FORWARD)
	print("Vector3.BACK:", Vector3.BACK)
	print("Vector3.DOWN:", Vector3.DOWN)
	print("Vector3.UP:", Vector3.UP)
	print("Vector3.LEFT:", Vector3.LEFT)
	print("Vector3.RIGHT:", Vector3.RIGHT)
	#pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("forward"):
		var forward = transform.basis.z * -1
		translate(forward)
	if event.is_action_pressed("backward"):
		var backward = transform.basis.z * 1
		translate(backward)
	if event.is_action_pressed("right"):
		var right = transform.basis.x * 1
		translate(right)
	if event.is_action_pressed("left"):
		var left = transform.basis.x * -1
		translate(left)
	if event.is_action_pressed("up"):
		var up = transform.basis.y * 1
		translate(up)
	if event.is_action_pressed("down"):
		var down = transform.basis.y * -1
		translate(down)
	#pass

func _process(delta: float) -> void:
	pass
