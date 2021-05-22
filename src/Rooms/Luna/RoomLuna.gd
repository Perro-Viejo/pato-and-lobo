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
				'Pato: Ahora podremos regar nuestra plantita',
				'Lobo: Nuestro sueño mojoso hecho realité',
				'Pato: ...',
				'Lobo: Echele agua y ámamame',
			]), 'completed')
		else:
			yield(E.run([
				'Pato: Debemos encontrar agüita pa crecer nuestrogare',
				'Lobo: he oido hablar que el agua espacial es especial :3',
			]), 'completed')
			E.goto_room('Bar')
	elif Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(
			E.run_cutscene([
			'Pato: Ahora solo necesitamos unas de esas planticasas de moda',
			'Lobo: Creo haber visto un planeta plantación a unos cuantos parsecs de aquí',
			'Pato: Uuuu allí no mai',
			'Lobo: Vamos juntis',
		]), 'completed')
		E.goto_room('Bar')
	else:
		E.run([
			'Pato: Qué tranquilo y silencioso es por aquí',
			'Lobo: Si... me dan ganas de bareto y arrunchis'
		])
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
