extends StaticBody3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area:",area )
	pass 


func _on_area_3d_area_exited(area: Area3D) -> void:
	pass 

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("enter body:",body )
	if body.is_in_group("Player"):
		body.enter_ladder()
		#pass
	#pass
	
func _on_area_3d_body_exited(body: Node3D) -> void:
	print("exit body:",body )
	if body.is_in_group("Player"):
		body.enter_idle()
	#pass 
