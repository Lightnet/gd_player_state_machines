extends Control

@onready var UIPlayerState: Label = $VBoxContainer/HBoxContainer/PlayerState
@onready var player: Player = $"../../Player"

#func _ready() -> void:
	#pass

#func _process(delta: float) -> void:
	#UIPlayerState.text = player.get_node("StateMachine").state.name
	#pass
