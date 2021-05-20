tool
extends Room

var laguna_uno := 0
var laguna_dos := 0

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	I.remove_item('Pato', false)
	I.remove_item('Lobo', false)
	A.play_music('mx_bar_01', false)
	A.play('bg_bar', Vector2.ZERO, false)
	
	if visited_first_time:
		C.player.global_position = $Points/Entrance.global_position
	elif C.player.last_room == 'Sea':
		C.player.global_position = $Points/Sink.global_position


func on_room_transition_finished() -> void:
	if not C.player.last_room:
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
