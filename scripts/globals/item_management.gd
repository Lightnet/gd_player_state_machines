extends Node
# https://godotforums.org/d/29126-iterating-through-all-nodes-of-a-class/2
# https://www.reddit.com/r/godot/comments/13uao7l/current_way_in_godot_4_to_find_to_find_player/

const PICKUP = preload("res://item/pickUp/pick_up.tscn")
var folder_path = "res://item/items"

func _ready() -> void:
	Console.add_command("summon", console_summon, ["item_name","item_stock"])
	pass

func console_summon(param:String, param2:String ):
	Console.print_line("summon %s" % param)
	#Console.print_line("Count %s" % param2.to_int())
	var stock = param2.to_int()
	if stock==0:
		stock =1
	Console.print_line("Count %s" % str(stock))
	#print("bots:",param.to_int())
	
	var players = get_tree().get_nodes_in_group("Player")
	var player
	#var player = get_tree().get_first_node_in_group("Player")
	#print(players)
	# need to check current active players
	if len(players) == 1:
		print("found player", players[0])
		player = players[0]
	else:
		Console.print_line("No Player...")
		return
	#pass
	
	var item_name = param
	if does_item_name_exist(folder_path, item_name):
		print("Item with name '%s' exists!" % item_name)
		var pick_up = PICKUP.instantiate()
		var slot_data = SlotData.new()
		var item_data = get_item_data_by_name(folder_path, item_name)
		slot_data.item_data = item_data 
		slot_data.quantity = stock
		#slot_data
		pick_up.slot_data = slot_data
		
		pick_up.position = player.get_drop_position()
		get_tree().current_scene.add_child(pick_up)
		
		#var pick_up = PICKUP.instantiate()
	else:
		print("Item with name '%s' not found." % item_name)

func does_item_name_exist(folder_path: String, item_name: String) -> bool:
	var dir = DirAccess.open(folder_path)
	if dir:
		# Normalize input item_name: lowercase and replace spaces with underscores
		var normalized_item_name = item_name.to_lower().replace(" ", "_")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var full_path = folder_path + "/" + file_name
				var resource = load(full_path) as ItemData
				if resource:
					# Normalize resource name for comparison
					var normalized_resource_name = resource.name.to_lower().replace(" ", "_")
					if normalized_resource_name == normalized_item_name:
						return true
			file_name = dir.get_next()
		dir.list_dir_end()
	return false
	
func get_item_data_by_name(folder_path: String, item_name: String) -> ItemData:
	var dir = DirAccess.open(folder_path)
	if dir:
		# Normalize input item_name: lowercase and replace spaces with underscores
		var normalized_item_name = item_name.to_lower().replace(" ", "_")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var full_path = folder_path + "/" + file_name
				var resource = load(full_path) as ItemData
				if resource:
					# Normalize resource name for comparison
					var normalized_resource_name = resource.name.to_lower().replace(" ", "_")
					if normalized_resource_name == normalized_item_name:
						return resource
			file_name = dir.get_next()
		dir.list_dir_end()
	return null

# Method 1: Iterating through children
#func find_node_by_name(root_node, target_name):
	#for child in root_node.get_children():
		#if child.name == target_name:
			#return child
		#else:
			#var found_node = find_node_by_name(child, target_name)
			#if found_node:
				#return found_node
	#return null

# Method 2: Using Node Paths
#func find_node_by_path(path):
	#return get_node_or_null(path)
	#

# Method 3: Using Groups
#func find_node_in_group(group_name):
	#var nodes = get_tree().get_nodes_in_group(group_name)
	#if nodes.size() > 0:
		#return nodes[0] # Returns the first node in the group
	#return null
	
# Example usage
#func _ready():
	#var root = get_tree().root
	#var found_node_by_name = find_node_by_name(root, "MyTargetNode")
	#if found_node_by_name:
		#print("Found node by name: ", found_node_by_name.name)
	#
	#var found_node_by_path = find_node_by_path("Path/To/MyTargetNode")
	#if found_node_by_path:
		#print("Found node by path: ", found_node_by_path.name)
	#
	#var found_node_in_group = find_node_in_group("MyTargetGroup")
	#if found_node_in_group:
		#print("Found node in group: ", found_node_in_group.name)
