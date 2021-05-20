tool
extends Room

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times,
		has_mask = true,
		has_dentures = true,
		has_coat = true,
		has_brooms = true
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	I.remove_item('Pato', false)
	I.remove_item('Lobo', false)
	A.play_music('mx_bar_01', false)
	A.play('bg_bar', Vector2.ZERO, false)
	
	if visited_first_time:
		C.player.global_position = $Points/Entrance.global_position
		C.player.face_left(false)
	elif C.player.last_room == 'Sea':
		C.player.global_position = $Points/Sink.global_position
	
	if not state.has_mask:
		$Props/WolfMask.disable(false)
	if not state.has_dentures:
		$Props/GlassWithDentures.disable(false)
	if not state.has_coat:
		$Props/Coat.disable(false)
	if not state.has_brooms:
		$Props/Brooms.disable(false)


func on_room_transition_finished() -> void:
	if visited_first_time:
		E.run_cutscene([
			C.player_say('Esta fiesta está re-buena...'),
			C.player_walk_to($Points/DanceFloor.global_position),
			'...',
			C.player.face_right(),
			'...',
			C.player_say('y está más buena porque Lobo está aquí'),
			C.player_say('Hoy es el día.'),
			C.player_say('¡HOY LE HABLARÉ A LOBO!'),
		])
	elif C.player.last_room == 'Sea':
		Globals.courage += 25
		yield(I, 'courage_update_shown')
		E.run(['Pato: Siento que ora sí le voy a hablar'])
	elif Globals.has_done(Globals.GameState.GOT_HOME):
		Globals.courage += 25
		yield(I, 'courage_update_shown')
		E.run(['Pato: Que bonito sueño...'])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
