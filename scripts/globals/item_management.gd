extends Node
# https://godotforums.org/d/29126-iterating-through-all-nodes-of-a-class/2
# https://www.reddit.com/r/godot/comments/13uao7l/current_way_in_godot_4_to_find_to_find_player/
func _ready() -> void:
	Console.add_command("summon", console_summon, ["item_name"])
	pass

func console_summon(param:String ):
	Console.print_line("summon %s" % param)
	#print("bots:",param.to_int())
	
	var players = get_tree().get_nodes_in_group("Player")
	#var player = get_tree().get_first_node_in_group("Player")
	#print(players)
	# need to check current active players
	if len(players) == 1:
		print("found player", players[0])
	
	
	#pass

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
