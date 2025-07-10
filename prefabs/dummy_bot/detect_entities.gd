extends Area3D

@export var character:Node3D
@export var entity:Node3D

#func _ready() -> void:
	#pass

#func _process(delta: float) -> void:
	#pass

func _on_body_entered(body: Node3D) -> void:
	if character:
		character.target = body
	pass

func _on_body_exited(body: Node3D) -> void:
	if character:
		character.target = null
	pass
