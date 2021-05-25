tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GOT_HOME):
		yield(
			E.run([
				C.walk_to_clicked(),
				'Pato: What do you think of this one?',
				'Lobo: Awwwww, is our dream-home.',
				'Pato: So this one will be.'
			]), 'completed'
		)
		E.goto_room('Spaceship')
		Globals.did(Globals.GameState.GOT_HOME)

func on_look() -> void:
	E.run([
		'Pato: Planted 8 months ago, front garden, two bedrooms, bathroom with tub...'
	])


func on_item_used(_item: Item) -> void:
	pass
