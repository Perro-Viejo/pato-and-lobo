tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not C.player.last_room == 'Luna':
		yield(E.run([
			A.play('sfx_spaceship_transition', Vector2.ZERO),
			E.current_room.goto_planet(script_name)
		]), 'completed')
		E.goto_room('Luna')
	else:
		var message := ''
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			message = 'RoomSpace-Luna-01'
		elif Globals.has_done(Globals.GameState.GOT_HOME):
			message = 'RoomSpace-Luna-02'
		else:
			message = 'RoomSpace-Luna-03'
		E.run([
			G.display(message)
		])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
