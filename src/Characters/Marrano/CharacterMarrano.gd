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
		E.run(["Marrano: Character-Marrano-OnInteract-Marrano-01"])


func on_look() -> void:
	.on_look()
