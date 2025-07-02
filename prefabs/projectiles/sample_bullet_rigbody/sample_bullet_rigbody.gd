extends RigidBody3D

@export var hit_info:HitInfoData
@export var speed = 100
@onready var ray: RayCast3D = $RayCast3D

var bStarted:bool = false

func _ready() -> void:
	if not hit_info:
		hit_info = HitInfoData.new()
	pass

func _physics_process(delta: float) -> void:
	#var motion = transform.basis.z * speed * delta
	#ray.target_position = motion.normalized() * (speed * delta)
	#ray.force_raycast_update()
	#if ray.is_colliding():
		#var collider = ray.get_collider()
		## Handle collision (e.g., damage, destroy bullet)
		#queue_free()
	#else:
		#position += motion
	#position += transform.basis * Vector3(0,0,-speed) * delta
	if bStarted == false:
		bStarted = true
		apply_force(transform.basis.z * -speed)
	pass

func _on_timer_timeout() -> void:
	print("delete")
	queue_free()
	pass

#for player or character3d
func _on_body_entered(body: Node) -> void:
	if body:
		if body.has_method("_on_hit_received"):
			body._on_hit_received(hit_info)
			queue_free()
			#pass
	pass
