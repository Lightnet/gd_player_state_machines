extends Node3D

@export var right_weapon:Node3D
@export var prev_right_weapon:Node3D
@export var weapons:Array[Node3D]

@export var weapon_index:int = 0

func _ready() -> void:
	right_weapon.set_process_mode(PROCESS_MODE_INHERIT)
	prev_right_weapon = right_weapon
	
	set_weapon_index(0)
	#right_weapon.set_process_mode(PROCESS_MODE_DISABLED)
	pass

# can't be use here input
#func _unhandled_input(event: InputEvent) -> void:
	#print("_unhandled_input")

# global input
func _input(event: InputEvent) -> void:
	
	if event.is_action_released("prev_weapon"):
		weapon_index = weapon_index - 1
		if weapon_index < 0:
			weapon_index = len(weapons) - 1
		set_weapon_index(weapon_index)
		#pass
		
	if event.is_action_released("next_weapon"):
		weapon_index = weapon_index + 1
		if weapon_index > len(weapons) - 1:
			weapon_index = 0
		set_weapon_index(weapon_index)
		#pass
	
	print("weapon_index:", weapon_index)
	if event.is_action_pressed("primary_fire"):
		#print("primary_fire")
		if right_weapon:
			if right_weapon.has_method("primary_fire"):
				right_weapon.primary_fire()
	#pass

#func _process(delta: float) -> void:
	#pass

func set_weapon_index(_index:int):
	prev_right_weapon.set_process_mode(PROCESS_MODE_DISABLED)
	prev_right_weapon.visible = false
	
	right_weapon = weapons[_index]
	right_weapon.visible = true
	print("index: ", _index ," right_weapon: ", right_weapon)
	
	right_weapon.set_process_mode(PROCESS_MODE_INHERIT)
	prev_right_weapon = right_weapon
	
	pass
