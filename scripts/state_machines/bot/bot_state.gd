class_name BotState extends State

const IDLE = "Idle" # node name
const RUNNING = "Running"
const WALKING = "Walking" 
const JUMPING = "Jumping"
const FOLLOW = "Follow"
const ATTACK = "Attack"

var bot: DummyBot

func _ready() -> void:
	await owner.ready
	bot = owner as DummyBot
	#print("bot: ",bot)
	assert(bot != null, "The BotState state type must be used only in the DummyBot scene. It needs the owner to be a DummyBot node.")
	#pass
