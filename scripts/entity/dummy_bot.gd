extends CharacterBody3D
class_name DummyBot

@export var target:Node3D
var target_position:Vector3
var is_target_position:bool = false 

@export var state_machine:StateMachine

signal health_changed(new_health: int, old_health: int)  # Emitted when health changes
signal died()  # Emitted when health reaches zero

var stats:StatsData

@export var path:Node3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var is_controller:bool = false;

func _ready() -> void:
	if not stats:
		stats = StatsData.new()

func _physics_process(delta: float) -> void:
	if not is_controller:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_hit_received(hit_info:HitInfoData):
	
	if stats:
		var old_health: float = stats.health
		if hit_info.type == "Heal":
			stats.health += hit_info.amount_point
			if stats.health > stats.health_max:
				stats.health = stats.health_max
			return
		stats.health -= hit_info.amount_point
		print("stats.health: ", stats.health)
		if stats.health < 0:
			stats.health = 0
			#emit_signal("died")
		var current_health_points: float = stats.health
		#emit_signal("health_changed", current_health_points, old_health)
	pass



#
