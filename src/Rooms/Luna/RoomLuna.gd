tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.global_position = $Points/EntryPoint.global_position

	C.player.enable(false)
	C.player.scale = Vector2.ONE * 0.5
	C.get_character('Lobo').scale = Vector2.ONE * 0.5
	
	if Globals.has_done(Globals.GameState.GOT_HOME):
		$Props/HomeSeed.enable(false)


func on_room_exited() -> void:
	C.player.scale = Vector2.ONE
	C.get_character('Lobo').scale = Vector2.ONE
	.on_room_exited()


func on_room_transition_finished() -> void:
	if Globals.has_done(Globals.GameState.GOT_HOME):
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			yield(
				E.run_cutscene([
				'Pato: We can water our home-seed now.',
				'Lobo: Our dream come true.',
				'Pato: ...',
				'Lobo: Water it. Then have me.',
			]), 'completed')
		else:
			yield(E.run([
				'Pato: We need to find water to water our future home.',
				'Lobo: I\'ve hear thar space water is special. ',
			]), 'completed')
			E.goto_room('Bar')
	elif Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(
			E.run_cutscene([
			'Pato: All we need now is one of those home-seeds.',
			'Lobo: I\'m sure I saw a homes plantation planet a couple of parsecs from here.',
			'Pato: So what are we waiting for.',
			'Lobo: To consume our love a little before leaving.',
		]), 'completed')
		E.goto_room('Bar')
	else:
		E.run([
			'Pato: How calm and quiet it is around here',
			'Lobo: Yes... makes you want to... T.D.A.F.'
		])
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
