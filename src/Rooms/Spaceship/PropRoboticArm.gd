tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		if Globals.has_done(Globals.GameState.GOT_HOME):
			yield(
				E.run([
				'Lobo: Usaré este gancho para jalar nuestra maticasita',
				'Pato: ¡Qué emoción tan amarilla!',
				A.play('sfx_spaceship_hook', global_position, false)
			]), 'completed')
			E.goto_room('HomesPlantation')
		else:
			E.run([
			'Lobo: Pero... ¿Cuál agarro Pato de mis amores? '
			])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			E.run([
				'Lobo: Es muy fuerte para agarrar a Pato... podría hacerle daño :('
			])
	else:
		E.run([
			'Lobo: No se que hacer con el gancho roboto'
		])


func on_look() -> void:
	E.run([
			'Lobo: Este gancho agarra cosas con muchas fuerzas'
		])


func on_item_used(item: Item) -> void:
	pass
