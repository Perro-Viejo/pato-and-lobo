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
					"Pato: RoomMarrano-Container-Pato-01",
					"Lobo: RoomMarrano-Container-Lobo-01",
					"Pato: RoomMarrano-Container-Pato-02",
					"Pato: RoomMarrano-Container-Pato-03",
				]), 'completed'
			)
			E.goto_room('Spaceship')
			Globals.did(Globals.GameState.DOME_SPOTTED)
		else:
			E.run([
				C.walk_to_clicked(),
				C.player.face_up(),
				"Pato: RoomMarrano-Container-Pato-04",
				"Pato: RoomMarrano-Container-Pato-05"
			])
	else:
		E.run([
			"Pato: RoomMarrano-Container-Pato-06"
		])

func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
