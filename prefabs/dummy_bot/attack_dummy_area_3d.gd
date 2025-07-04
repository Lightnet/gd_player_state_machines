extends Area3D

@export var timer: Timer

var bodies:Array = []
var is_attacking:bool = false
@export var hit_info:HitInfoData
@export var attack_enabled: bool = true  # Toggle to enable/disable attacks
var player
#func _ready() -> void:
	#print("timer.is_stopped():", timer)
	#pass

func _process(delta: float) -> void:
	
	#print("player: ", player)
	#print("bodies: ", bodies)
	#print("is_attacking: ", is_attacking)
	#print("attack_enabled: ", attack_enabled, " timer.is_stopped(): ", timer.is_stopped())
	#print("bodies len(): ",len(bodies))
	#print("bodies.size(): ",bodies.size())
	# Only manage timer if attacks are enabled and enemies are present
	# bodies.size()
	if attack_enabled == true and len(bodies) > 0 and timer.is_stopped() == true:
		print("Starting attack timer")
		timer.start()
	elif (bodies.size() == 0 or attack_enabled == false) and not timer.is_stopped():
		print("Stopping attack timer")
		timer.stop()

func _on_body_entered(body: Node3D) -> void:
	#print("_on_body_entered:", body)
	player = body
	#if body:
	bodies.append(player)
	#pass

func _on_body_exited(body: Node3D) -> void:
	#print("_on_body_exited:", body)
	if body:
		var index = bodies.find(body)
		if index != -1:
			bodies.remove_at(index)
	#pass

func _on_timer_timeout() -> void:
	if attack_enabled and bodies.size() > 0 and not is_attacking:
		perform_attack()
		
func perform_attack() -> void:
	is_attacking = true
	# Attack all valid bodies in the area
	for body in bodies:
		if is_instance_valid(body) and body.has_method("_on_hit_received"):
			print("Attacking body: ", body.name)
			body._on_hit_received(hit_info)
	is_attacking = false

# Public function to toggle attack state
func set_attack_enabled(enabled: bool) -> void:
	attack_enabled = enabled
	if not attack_enabled:
		timer.stop()  # Stop timer if attack is disabled
		#entities.clear()  # Optional: Clear bodies to reset state
		#print("Attack system ", "enabled" if enabled else "disabled")
