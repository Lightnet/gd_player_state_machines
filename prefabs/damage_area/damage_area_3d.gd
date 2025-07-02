extends Area3D

@export var hit_info:HitInfoData
#@export var damage_type:DamageData

# damage tick
@export var timer:Timer
var bodies:Array
var is_damage_on:bool = false
var tick_timer:float = 30.0
var tick_counter:float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	tick_counter += delta
	#print("tick_counter: ", tick_counter)
	if tick_counter >= 1:
		tick_counter = 0
		#print("tick")
		if len(bodies) > 0:
			for body in bodies:
				if body.has_method("_on_hit_received"):
					body._on_hit_received(hit_info)
				#if body.has_method("on_damage"):
					#body.on_damage(damage_type)
					#pass
				#print("test damage body")
				#pass
	#pass

func _on_body_entered(body: Node3D) -> void:
	#print("enter")
	if body:
		bodies.append(body)
	#pass

func _on_body_exited(body: Node3D) -> void:
	#print("exit")
	if body:
		bodies.remove_at(bodies.find(body))
	#pass

func _on_timer_timeout() -> void:
	pass
