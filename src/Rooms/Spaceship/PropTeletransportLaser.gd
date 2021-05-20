tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		E.run([
			'Lobo: Es muy pesado para transportarlo con esto...'
		])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			yield(
				E.run([
				'Lobo: Preparate Pato, ahí va la tecnología',
				'Pato: Ya me estaba preocupando',
			]), 'completed')
			E.goto_room('Luna')

func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
