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
				C.get_character('Lagarto').check_music()
				A.play({cue_name = 'sfx_dream_transition', pos = Vector2.ZERO, is_in_queue = false})
				E.goto_room('Bar')
				A.play({cue_name = 'bg_bar', is_in_queue = false, fade = true, 
					from = -30, to = -10, duration = 2.2})
				A.stop('bg_space', 0, false, true, 8)
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
			C.get_character('Lagarto').check_music()
			A.play({cue_name = 'sfx_dream_transition', pos = Vector2.ZERO, is_in_queue = false})
			E.goto_room('Bar')
			A.play({cue_name = 'bg_bar', is_in_queue = false, fade = true, 
					from = -30, to = -10, duration = 2.2})
			A.stop('bg_space', 0, false, true, 8)
	else:
		yield(E.run([
			'Lobo: ChatWithLoboInLuna-Start-Lobo-11',
			'Pato: ChatWithLoboInLuna-Start-Pato-12'
		]), 'completed')
		D.finish_dialog()


func option_selected(_opt: DialogOption) -> void:
	pass
