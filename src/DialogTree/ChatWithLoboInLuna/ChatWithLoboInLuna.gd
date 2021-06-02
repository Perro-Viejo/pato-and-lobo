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
				'Pato: ChatWithLoboInLuna-Start-Pato-01',
				'Lobo: ChatWithLoboInLuna-Start-Lobo-02',
				'Pato: ChatWithLoboInLuna-Start-Pato-03',
				'Lobo: ChatWithLoboInLuna-Start-Lobo-04',
			]), 'completed')
			D.finish_dialog()
		else:
			yield(E.run([
				'Pato: ChatWithLoboInLuna-Start-Pato-05',
				'Lobo: ChatWithLoboInLuna-Start-Lobo-06',
			]), 'completed')
			D.finish_dialog()

			if C.player.last_room != 'Bar':
				E.goto_room('Bar')
	elif Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(
			E.run_cutscene([
			'Pato: ChatWithLoboInLuna-Start-Pato-07',
			'Lobo: ChatWithLoboInLuna-Start-Lobo-08',
			'Pato: ChatWithLoboInLuna-Start-Pato-09',
			'Lobo: ChatWithLoboInLuna-Start-Lobo-10',
		]), 'completed')
		D.finish_dialog()

		if C.player.last_room != 'Bar':
			E.goto_room('Bar')
	else:
		yield(E.run([
			'Lobo: ChatWithLoboInLuna-Start-Lobo-11',
			'Pato: ChatWithLoboInLuna-Start-Pato-12'
		]), 'completed')
		D.finish_dialog()


func option_selected(_opt: DialogOption) -> void:
	pass
