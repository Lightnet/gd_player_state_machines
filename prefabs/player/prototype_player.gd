extends CharacterBody3D
# testing normal without state machine
@onready var camera: Camera3D = $Neck/Camera3D
@onready var t_wall_run: Timer = $wall_run

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var wall_normal
var is_wall_runable:bool = false
var direction:Vector3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _unhandled_input(event: InputEvent) -> void:
	# camera handle for all state.
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(80), deg_to_rad(90))
			
	if event.is_action_pressed("escape"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		is_wall_runable=false
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_wall_runable=true
		t_wall_run.start()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	wall_run()

	move_and_slide()

func wall_run():
	if is_wall_runable:
		if Input.is_action_pressed("jump"):
			if Input.is_action_pressed("forward"):
				if is_on_wall():
					wall_normal = get_slide_collision(0)
					await get_tree().create_timer(0.2).timeout
					velocity.y = 0
					direction = -wall_normal.get_normal() * SPEED
	#pass


func _on_wall_run_timeout() -> void:
	is_wall_runable=false
	#pass
