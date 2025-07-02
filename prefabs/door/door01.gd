extends StaticBody3D

@export var is_open:bool = false
@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(on_finish_animation)
	pass

func _process(_delta: float) -> void:
	pass

func player_interact(current_player=null) -> void:
	print("door current_player: ",current_player)
	if is_open:
		is_open = false
		animation_player.play("close")
	else:
		is_open = true
		animation_player.play("open")
	print("is_open:", is_open)

func on_finish_animation(animation_name:String):
	print("name:", animation_name)
	if animation_name == "open":
		animation_player.play("open_idle")
	if animation_name == "close":
		animation_player.play("close_idle")
	pass
