extends Node


func _ready() -> void:
	Console.add_command("addbots", console_addbots, ["number_bots"])
	Console.console_opened.connect(on_conole_opened)
	Console.console_closed.connect(on_console_closed)
	#pass

func on_conole_opened():
	print("open")
	pass
	
func on_console_closed():
	print("close")
	pass

func console_addbots(param:String ):
	Console.print_line("bots: %s" % param)
	print("bots:",param.to_int())
	#pass
