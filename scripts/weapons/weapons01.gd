extends Node3D

@export var right_weapon:Node3D

func _ready() -> void:
	pass

# can't be use here input
#func _unhandled_input(event: InputEvent) -> void:
	#print("_unhandled_input")

# global input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_fire"):
		#print("primary_fire")
		if right_weapon:
			if right_weapon.has_method("primary_fire"):
				right_weapon.primary_fire()
	#pass

#func _process(delta: float) -> void:
	#pass
