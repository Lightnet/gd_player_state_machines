extends BotState

var target_point:Vector3
@export var move_speed: float = 4.0
@export var rotation_speed: float = 5.0  # For smooth rotation
@export var point_threshold: float = 1.5  # Distance to consider a point reached
@export var out_range: float = 5.0  # Distance out range to stop follow

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	
func exit() -> void:
	
	pass

func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if bot.target:
		target_point = bot.target.global_position
		var bot_position: Vector3 = bot.global_position
		
		var distance_to_point: float = bot_position.distance_to(target_point)
		# Calculate direction to the target point (movement direction)
		var direction: Vector3 = (target_point - bot_position).normalized()
		
		if distance_to_point <= point_threshold:
			#print("bot.hand_right: " , bot.hand_right)
			#if bot.hand_right:
				#if bot.hand_right.has_method("set_attack_enabled"):
					##print("attack " )
					#bot.hand_right.set_attack_enabled(true)
			if bot.behaviour_mode == "argo":
				finished.emit(ATTACK)
			pass
		elif distance_to_point >= out_range:
			#finished.emit(IDLE)
			finished.emit(DETECT)
			pass
		else:
			finished.emit(FOLLOW)
	pass
