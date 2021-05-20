tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.global_position = $Points/EntryPoint.global_position
	C.get_character('Lobo').disable(false)
	C.player.enable(false)
	I.add_item('Pato', false)
	I.add_item('Lobo', false)

func on_room_exited() -> void:
	C.player.enable(false)
	C.get_character('Lobo').enable(false)
	.on_room_exited()

func on_room_transition_finished() -> void:
	if Globals.has_done(Globals.GameState.GOT_HOME):
		yield(
			E.run_cutscene([
			'Pato: Hagale con cariño',
			'Pato: Eso, eso baje el bracito',
			'Lobo: Voy voy voy...',
			'Pato: Aquí falta como una animación... a plantarlo en nuestro futuro hogareeee',
		]), 'completed')
		E.goto_room('Bar')
		


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
