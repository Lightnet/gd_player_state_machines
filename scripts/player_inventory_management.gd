extends Node

const PICKUP = preload("res://item/pickUp/pick_up.tscn")

@export var player: CharacterBody3D
@export var inventory_interface: Control
@export var hot_bar_inventory: PanelContainer
#@export var inventory_interface: Control = $"../UI/InventoryInterface"
#@export var hot_bar_inventory: PanelContainer = $"../UI/HotBarInventory"

func _ready() -> void:
	PlayerManager.player = player
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_equip_inventory_data(player.equip_inventory_data)
	inventory_interface.force_close.connect(toggle_inventory_interface)
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)
	#pass

func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		PlayerManager.enable_menu()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		PlayerManager.disable_menu()
	
	if external_inventory_owner and inventory_interface.visible:
		print("external_inventory_owner")
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()
		
#func _process(delta: float) -> void:
	#pass

func _on_inventory_interface_drop_slot_data(slot_data: SlotData) -> void:
	var pick_up = PICKUP.instantiate()
	pick_up.slot_data = slot_data
	#pick_up.position = Vector3.UP
	pick_up.position = player.get_drop_position()
	get_tree().current_scene.add_child(pick_up)
	#pass
