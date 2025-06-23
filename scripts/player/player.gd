class_name Player extends CharacterBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D

@export var WALK_SPEED := 5.0
@export var SPRINT_SPEED = 8.0

@export var JUMP_VELOCITY := 4.0
@export var GRAVITY := 9.8
@export var GRAVITY_FALL := 0.9
@export var AIR_CONTROL_SPEED := 5.0
@export var IS_CONTROLLER: = true #handle when the menu N/A
@export var CROUCH_HEIGHT_SCALE = 0.5
@export var CROUCH_RADIUS_SCALE = 0.5
@export var is_climbing:bool = false

@onready var draw_3d: Node = $draw3d

var obstacles:Array


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Console.add_command("hello", console_hello)
	
	Console.add_command("fly", console_fly)
	Console.add_command("ghost", console_ghost)
	Console.add_command("walk", console_walk)
	Console.add_command("god", console_god)
	#Console.add_command("summon", console_summon)
	#Console.add_command("addbots", console_addbots)
	#print("FORWARD: ", Vector3.FORWARD)
	
func _exit_tree() -> void:
	Console.remove_command("hello")
	
func _input(event: InputEvent) -> void:
	# camera handle for all state.
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(80), deg_to_rad(90))
			
	if event.is_action_pressed("escape"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	vaulting(delta)
	#pass

# calculting the place_to_land position and initiating the vault animation.
func vaulting(delta):
	if Input.is_action_just_pressed("jump"):
		# need to fixed error since detect move when not looking at the area
		#var from  = camera.transform.origin
		var from  = camera.global_position
		var to = camera.to_global(Vector3(0,0,-1))
		draw_3d.line(from, to)
		#print("from:", from, " to:", to)
		var start_hit = raycast(from, to)
		#print("start_hit: ", start_hit)
		if start_hit and obstacles.is_empty():
			
			draw_3d.point(start_hit.position, 0.1, Color.RED)
			
			#RayCast to detect the prefect place to land(Not that speical, I just excaggerate :D)
			#from = start_hit.position + self.to_global(Vector3.FORWARD) * collision_shape.shape.radius + (Vector3.UP * collision_shape.shape.height)
			#var forward = -(camera.transform.basis.z.normalized())#nope
			
			# local
			var forward = (transform.basis.z.normalized()) * -1 #correct forward from player root
			#print("forward:", forward)
			
			# start from top to point to ground
			# current ray cast poition + (player forward direction * player shape radius) + (Up * player shape height)
			from = start_hit.position + (forward * collision_shape.shape.radius) + (Vector3.UP * collision_shape.shape.height)
			
			#to = Vector3.DOWN * (collision_shape.shape.height)
			to = start_hit.position + (Vector3.DOWN * (collision_shape.shape.height))
			#ref debug draw
			draw_3d.line(from, to, Color.RED)
			var place_to_land = raycast(from, to)
			#var place_to_land = raycast(\
				#start_hit.position + self.to_global(Vector3.FORWARD) * collision_shape.shape.radius + (Vector3.UP * collision_shape.shape.height), \
				#Vector3.DOWN * (collision_shape.shape.height))
			if place_to_land:
				vault_animation(place_to_land)
	#pass

# create raycast from vis code
func raycast(from:Vector3, to:Vector3):
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to, 2)
	query.collide_with_areas = true
	return space.intersect_ray(query)
	#pass

# obstacles for top
func _on_obstacle_detector_top_body_entered(body: Node3D) -> void:
	if body != self:
		obstacles.append(body)
	#pass
	
# obstacles for top
func _on_obstacle_detector_top_body_exited(body: Node3D) -> void:
	if body != self:
		obstacles.remove_at(obstacles.find(body))
	#pass
	
# animation for vulting / climbing
func vault_animation(place_to_land):
	# player is climbing
	is_climbing = true
	
	# first tween animation will make the player move up
	var vertical_climb = Vector3(global_transform.origin.x, place_to_land.position.y, global_transform.origin.z)
	#print("vertical_climb: ", vertical_climb)
	# player set ground with different in player capsule( center orign ) height by half.
	vertical_climb.y = vertical_climb.y + (collision_shape.shape.height / 2)
	var vertical_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	vertical_tween.tween_property(self, "global_transform:origin", vertical_climb, 0.4)
	
	# we wait for the animation to finish
	await vertical_tween.finished
	
	# second tween animation will make the player move forard where the place is facing
	var forward = global_transform.origin + (-self.basis.z * 1.2)
	var forward_tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	forward_tween.tween_property(self, "global_transform:origin", forward, 0.3)
	
	# we wait for the animation to finish
	await forward_tween.finished
	
	# player isn't climb anymore
	is_climbing = false
	#pass
#

## dev access
func console_hello():
	Console.print_line("Hello There")
	print("Hello")

func console_fly():
	pass

func console_ghost():
	pass
	
func console_walk():
	pass
	
func console_god():
	pass

#func console_summon():
	#pass
	
#func console_addbots():
	#pass
