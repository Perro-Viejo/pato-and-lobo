tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times,
		last_player_pos = Vector2.ZERO
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	if visited_first_time:
		C.player.global_position = $Points/EntryPoint.global_position
		I.add_item('Pato', false)
		I.add_item('Lobo', false)
	else:
		C.player.global_position = state.last_player_pos

	C.player.enable(false)
	C.get_character('Lobo').disable(false)


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position

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
