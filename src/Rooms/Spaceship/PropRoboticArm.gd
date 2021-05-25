tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		if Globals.has_done(Globals.GameState.GOT_HOME):
			yield(
				E.run([
				'Lobo: I will use the picker to pull our house-seed.',
				'Pato: This is so exciting my love!',
				A.play('sfx_spaceship_hook', global_position),
				E.wait(2)
			]), 'completed')
			E.goto_room('HomesPlantation')
		else:
			E.run([
			'Lobo: I don\'t know which one to pick my love.'
			])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			E.run([
				'Lobo: I do not want to hurt Pato.'
			])
	else:
		E.run([
			'Lobo: I do not know what to do with the picker'
		])


func on_look() -> void:
	E.run(['Lobo: The picker can pull things with amazing force'])


func on_item_used(_item: Item) -> void:
	pass
