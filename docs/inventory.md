


# player < CharacterBody3D
```
class_name Player extends CharacterBody3D
#...
@export var inventory_data:InventoryData # access for inventory
@export var equip_inventory_data:InventoryDataEquip # access for inventory
#...
func _input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
		
	if Input.is_action_just_pressed("interact"):
		interact()		
#...
# interact raycast object for chest inventory
func interact() -> void:
	if interact_ray.is_colliding():
		print("interact with ", interact_ray.get_collider())
		if interact_ray.get_collider().has_method("player_interact"):
			interact_ray.get_collider().player_interact()

# drop item forward position
func get_drop_position() -> Vector3:
	var direction  = -camera.global_transform.basis.z
	return camera.global_position + direction
	#pass
```
Note this is subject to change as trying to make it module to disable controller when there quest menu or other menus and events.

# chest inventory:
There is tag group:
```
external_inventory
```
To open the chest inventory ui

