extends Node3D

@export var PROJECTILE:PackedScene
@export var fire_point: Node3D
@export var muzzle:Node3D

#func _ready() -> void:
	#pass

#func _process(delta: float) -> void:
	#pass

func primary_fire():
	print("primary_fire project")
	if PROJECTILE:
		if muzzle:
			if muzzle.has_method("trigger_fire"):
				muzzle.trigger_fire()
		var projectile = PROJECTILE.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.global_position =fire_point.global_position
		projectile.global_rotation =fire_point.global_rotation
	#pass
	
