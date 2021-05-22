tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play('bg_marrano', Vector2.ZERO, false)
	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		A.play('sfx_dome', $Props/Container.global_position, false)
	C.player.global_position = $Points/EntryPoint.global_position
	C.player.enable(false)
	C.get_character('Lobo').disable(false)
	I.add_item('Pato', false)
	I.add_item('Lobo', false)


func on_room_exited() -> void:
	A.stop('bg_marrano', 0, false)
	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		A.stop('sfx_dome', 0, false)
	C.get_character('Lobo').enable(false)
	.on_room_exited()


func on_room_transition_finished() -> void:
	if Globals.has_done(Globals.GameState.DOME_SPOTTED):
		yield(
			E.run_cutscene([
			A.play('sfx_dome', $Props/Container.global_position),
			A.play('sfx_garbage_fall', Vector2.ZERO, true, true),
			A.play('sfx_alarm', Vector2.ZERO),
			A.stop('sfx_dome', 0),
			'Pato: Beep Beep Alerta',
			'Pato: Aquí el marrano corre pero el dev es lento',
			'Pato: ...',
			'Pato: Dejó la rancha sola... es mi momento',
		]), 'completed')

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
