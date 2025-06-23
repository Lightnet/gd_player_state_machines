extends Control

@export var label_mph: Label
@export var vehicle_body_3d: VehicleController
@onready var speedometer_needle: ColorRect = $SpeedometerNeedle

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_update_speedometer()
	#pass

func _update_speedometer() -> void:
	# Calculate speed in MPH
	var speed_ms: float = vehicle_body_3d.linear_velocity.length()  # Speed in meters per second
	var speed_mph: float = speed_ms * 2.23694      # Convert to MPH
	# Round to nearest integer for clean display
	#speed_label.text = str(round(speed_mph)) + " MPH"
	#label_mph.text = str(round(speed_mph))
	#speed_label.text = "%03d MPH" % round(speed_mph)
	label_mph.text = "%03d" % round(speed_mph)
	
	var max_mph: float = 120.0
	var angle: float = (speed_mph / max_mph) #* deg_to_rad(180.0)
	speedometer_needle.rotation = angle + deg_to_rad(180)
	
