tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		E.run([
			'...',
			'Lobo: No voy a tirar mierdas sobre nuestro futuro hogar...'
			
		])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.DOME_SPOTTED):
			if not Globals.has_done(Globals.GameState.WATER_TAKEN):
				yield(
					E.run([
					'Lobo: Ahí voy, espero estes Patopreparade',
					'Pato: ¡Suelteloooo!',
				]), 'completed')
				E.goto_room('Marrano')
		elif Globals.has_done(Globals.GameState.WATER_TAKEN):
			E.run([
				'Lobo: ¿Para qué quiero esto? ¡Debo transportar a pato pronto!'
			])
		else:
			E.run([
			'Lobo: No quiero tirar basura al espacio epsterior'
			])

func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
