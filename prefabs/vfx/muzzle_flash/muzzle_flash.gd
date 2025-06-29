extends Node3D

@export var particles:Array[GPUParticles3D]
@onready var pause_timer: Timer = $Timer

# Duration to pause between emissions
@export var pause_duration: float = 0.1

func _ready() -> void:
	# Initialize particles: ensure none are emitting
	for particle in particles:
		particle.emitting = false
	 # Set timer properties
	pause_timer.wait_time = pause_duration
	pause_timer.one_shot = true
	# Connect timer timeout signal
	pause_timer.timeout.connect(_on_pause_timer_timeout)
	pass

func _process(delta: float) -> void:
	pass
	
func trigger_fire():
	# Start emitting all particles
	for particle in particles:
		particle.emitting = true
		particle.restart() # Reset for one-shot emission
	# Start the timer to pause before allowing another emission
	pause_timer.start()

func _on_pause_timer_timeout():
	#print("gpu p finish")
	for particle in particles:
		#print("particle: ", particle)
		particle.emitting = false
		#particle.restart() # Reset for one-shot emission
	# Timer finished; particles can be triggered again
	pass

func _on_timer_timeout() -> void:
	for particle in particles:
		particle.emitting = false
		particle.restart() # Reset for one-shot emission
	#pass
