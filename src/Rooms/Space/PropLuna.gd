tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not C.player.last_room == 'Luna':
		yield(E.run([
			A.play('sfx_spaceship_transition', Vector2.ZERO),
			C.walk_to_clicked()
		]), 'completed')
		E.goto_room('Luna')
	else:
		var message := ''
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			message = 'Pato and Lobo wouldn\'t return to Luna without the house-seed'
		elif Globals.has_done(Globals.GameState.GOT_HOME):
			message = 'Pato and Lobo wouldn\'t return to Luna without the water'
		else:
			message = 'Pato and Lobo wouldn\'t return to Luna without the house-seed or the water'
		E.run([
			G.display(message)
		])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
