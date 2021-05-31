tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func _ready() -> void:
	_looking_dir = 'l'
	idle(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		D.show_dialog('ChatWithMarrano')
	else:
		E.run(["Marrano: Go away! I'm searching the intruder."])


func on_look() -> void:
	.on_look()
