tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	
	if Globals.has_done(Globals.GameState.GOT_HOME):
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			yield(
				E.run_cutscene([
				'Pato: We can water our house-seed now.',
				'Lobo: Our dream come true.',
				'Pato: ...',
				'Lobo: Water it. Then have me.',
			]), 'completed')
			D.finish_dialog()
		else:
			yield(E.run([
				'Pato: We need to find water to water our future home.',
				'Lobo: I\'ve hear that space water is special. ',
			]), 'completed')
			D.finish_dialog()

			if C.player.last_room != 'Bar':
				E.goto_room('Bar')
	elif Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(
			E.run_cutscene([
			'Pato: All we need now is one of those house-seeds.',
			'Lobo: I\'m sure I saw a homes plantation planet a couple of parsecs from here.',
			'Pato: So what are we waiting for.',
			'Lobo: To consume our love a little before leaving.',
		]), 'completed')
		D.finish_dialog()

		if C.player.last_room != 'Bar':
			E.goto_room('Bar')
	else:
		yield(E.run([
			'Lobo: We\'ll need water and a house-seed to build our home here.',
			'Pato: Yes yes yes. Let\'s do it.'
		]), 'completed')
		D.finish_dialog()


func option_selected(_opt: DialogOption) -> void:
	pass
