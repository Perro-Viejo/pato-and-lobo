tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.DOME_SPOTTED):
		yield(
			E.run([
				C.walk_to_clicked(),
				C.face_clicked(),
				'Pato: Lobo my love, open the garbage gates here',
				'Lobo: Are we going to make a mess?',
				'Pato: Just a bit...'
			]), 'completed'
		)
		E.goto_room('Spaceship')
		Globals.did(Globals.GameState.DOME_SPOTTED)
	else:
		E.run([
			'Pato: Now is the time. I\'ll stole the Fast-growing-water.'
		])

func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
