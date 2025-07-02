extends Control

@export var player:CharacterBody3D
@export var label_health:Label
@export var label_health_max:Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if player and label_health and label_health_max:
		label_health.text = str(player.stats.health)
		label_health_max.text = str(player.stats.health_max)
	pass
