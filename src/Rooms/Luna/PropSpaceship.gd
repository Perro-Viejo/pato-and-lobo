tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GOT_HOME) \
		or not Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(E.run([
			'Pato: Let\'s traverse the cosmos, my love.',
			C.walk_to_clicked(),
			'Lobo: Yeyyyyyyyyyy',
			C.character_walk_to('Lobo', to_global(E.clicked.walk_to_point))
		]), 'completed')
		E.goto_room('Space')
	else:
		E.run([
			'Lobo: Let\'s traverse the cosmos, my love.',
			'Pato: Nope. We have all we need.',
			'Pato: A house-seed and water for it.',
			'Lobo: Then...',
			'Lobo: Water it! water it!'
		])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
