extends Area3D

@export var speed = 10
var distance_traveled: float = 0.0  # Tracks distance for despawning

var bStarted:bool = false
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:

	var motion: Vector3 = -transform.basis.z * speed * delta
	position += motion
	distance_traveled += motion.length()
	pass

func _on_timer_timeout() -> void:
	print("delete")
	queue_free()
	pass

func _on_body_entered(body: Node3D) -> void:
	#if body.is_in_group("enemies"):
		## Apply damage (assumes enemy has a take_damage method)
		#if body.has_method("take_damage"):
			#body.take_damage(damage)
	# Destroy bullet on collision
	print("area DELETE")
	queue_free()
	pass
