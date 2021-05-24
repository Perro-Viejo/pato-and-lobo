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
	A.play('bg_marrano', Vector2.ZERO, false)
	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		A.play('sfx_dome', $Props/Container.global_position, false)
	
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

	A.stop('bg_marrano', 0, false)
	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		A.stop('sfx_dome', 0, false)
	else:
		A.stop('sfx_alarm', 0, false)

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
			G.display('Beep Beep Beep Beep Beep'),
			C.character_walk_to('Marrano', get_point('Middle')),
			'Pato: The pig moved... this is my chance!',
			C.character_walk_to('Marrano', get_prop('Container').walk_to_point),
		]), 'completed')

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
