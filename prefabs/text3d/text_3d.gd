extends Node3D

# there is strange bug not render as use default texture purple and black checker box
# for mesh but for sprite3d it worked.

#@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var sub_viewport: SubViewport = $SubViewport
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var rich_text_label: RichTextLabel = $SubViewport/RichTextLabel

@export_multiline var text:String = "None":
	set(value):
		text = value
		#update_text()
		#rich_text_label.text = text

#@onready var rich_text_label: RichTextLabel = $SubViewport/Control/RichTextLabel

func _ready() -> void:
	#rich_text_label.text = text
	#update_text()
	rich_text_label.text = text
	pass

#func update_text():
	#var material:StandardMaterial3D = mesh.get_active_material(0)
	#material.albedo_texture = sub_viewport.get_texture()
	#pass
