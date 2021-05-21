tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.global_position = $Points/EntryPoint.global_position
	C.player.enable(false)
	C.get_character('Lobo').disable(false)
	I.add_item('Pato', false)
	I.add_item('Lobo', false)


func on_room_exited() -> void:
	C.get_character('Lobo').enable(false)
	.on_room_exited()


func on_room_transition_finished() -> void:
	if Globals.has_done(Globals.GameState.DOME_SPOTTED):
		yield(
			E.run_cutscene([
			'Pato: Beep Beep Alerta',
			'Pato: Aquí el marrano corre pero el dev es lento',
			'Pato: ...',
			'Pato: Dejó la rancha sola... es mi momento',
		]), 'completed')

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
