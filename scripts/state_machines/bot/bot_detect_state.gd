extends BotState


func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	
func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	
	if bot.target:
		finished.emit(FOLLOW)
	
	#pass

func physics_update(_delta: float) -> void:
	pass
