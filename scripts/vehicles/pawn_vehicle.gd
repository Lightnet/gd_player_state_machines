extends VehicleBody3D
## base vhicle for enter, exist and others funcs
class_name PawnVehicle
## store player
var player
@export var is_controller:bool = false
@export var camera:Camera3D
@export var exit_timer:Timer
@export var exit_point:Node3D
# input overlap when checking
var is_exit:bool = false

func _ready() -> void:
	if exit_timer:
		exit_timer.timeout.connect(_on_exit_time_timeout)

func disable_controller()->void:
	is_controller = false
	
func enable_controller()->void:
	is_controller = true
	if camera:
		camera.make_current()

func player_interact(current_player=null) -> void:
	print("car current_player: ",current_player)
	
	if not current_player:
		return
	
	print("is_controller: ",current_player.get("is_controller"))
	
	#if current_player.get("is_controller"):
	#if does_variable_exist(current_player, "is_controller"):
	if current_player.has_method("disable_controller"):
		vehicle_enter(current_player)
		#print("Found is_controller")
		#current_player.disable_controller()
		#current_player.set_process(false)
		#current_player.visible = false
		#current_player.set_process_input(false)
		#player=current_player
		#player.enter_vehicle_hide()
		
		#enable_controller()
		#exit_time.start()
		#is_exit = false
		#pass
	else:
		print("NO is_controller")
	#pass

func vehicle_exit():
	is_controller = false
	player.exit_vehicle_show()
	player.global_position = exit_point.global_position
	player=null
	#pass
	
func vehicle_enter(current_player):
	player=current_player
	player.enter_vehicle_hide()
	enable_controller()
	exit_timer.start()
	is_exit = false
	#pass
	
func _on_exit_time_timeout() -> void:
	print("exit ready...")
	is_exit = true
	#pass
