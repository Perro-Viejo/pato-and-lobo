tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.DOME_SPOTTED):
		if E.current_room.state.container_weakness_revealed:
			yield(
				E.run([
					C.walk_to_clicked(),
					C.player.face_up(),
					"Pato: There must be something we can do to break this shield.",
					"Lobo: What if I crash the spaceship into it?",
					"Pato: That will be risky, my love.",
					"Pato: But maybe there's something we can use from it.",
				]), 'completed'
			)
			E.goto_room('Spaceship')
			Globals.did(Globals.GameState.DOME_SPOTTED)
		else:
			E.run([
				C.walk_to_clicked(),
				C.player.face_up(),
				"Pato: Look at those beautiful flowers.",
				"Pato: They make a great contrast to their owner."
			])
	else:
		E.run([
			"Pato: Now is the time. I'll stole the Fast-growing-water."
		])

func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
