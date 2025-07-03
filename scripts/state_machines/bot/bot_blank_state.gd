extends BotState


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
	pass
