tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GOT_HOME) \
		or not Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(E.run([
			'Pato: RoomLuna-Spaceship-Pato-01',
			C.walk_to_clicked(),
			'Lobo: RoomLuna-Spaceship-Lobo-01',
			C.character_walk_to('Lobo', to_global(E.clicked.walk_to_point))
		]), 'completed')
		E.goto_room('Space')
	else:
		E.run([
			'Lobo: RoomLuna-Spaceship-Lobo-02',
			'Pato: RoomLuna-Spaceship-Pato-02',
			'Pato: RoomLuna-Spaceship-Pato-03',
			'Lobo: RoomLuna-Spaceship-Lobo-03',
			'Lobo: RoomLuna-Spaceship-Lobo-04'
		])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
