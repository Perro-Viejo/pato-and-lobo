tool
extends Room

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times,
		mask_grabbed = false
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play_music('mx_bar_01', false)
	A.play('bg_bar', Vector2.ZERO, false)
	
	if visited_first_time:
		C.player.global_position = $Points/Entrance.global_position
		C.player.face_left(false)
	elif C.player.last_room == 'Sea':
		C.player.global_position = $Points/Sink.global_position
	
	if state.mask_grabbed:
		$Props/WolfMask.disable(false)


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
		Globals.courage += 100
		yield(I, 'courage_update_shown')
		E.run(['Pato: Siento que ora sí le voy a hablar'])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
