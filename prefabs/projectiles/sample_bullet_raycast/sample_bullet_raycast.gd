extends Node3D

@export var speed = 50
@onready var ray: RayCast3D = $RayCast3D

var bStarted:bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var motion = -transform.basis.z * speed * delta
	ray.target_position = motion.normalized() * (speed * delta)
	ray.force_raycast_update()
	if ray.is_colliding():
		var collider = ray.get_collider()
		# Handle collision (e.g., damage, destroy bullet)
		print("DELETE")
		queue_free()
		return
	else:
		position += motion
	pass

func _on_timer_timeout() -> void:
	print("delete")
	queue_free()
	pass
