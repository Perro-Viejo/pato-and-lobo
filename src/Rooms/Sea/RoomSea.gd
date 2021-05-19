tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play('bg_dream_boat', Vector2.ZERO, false)
	C.player.global_position = $Points/EntryPoint.global_position


func on_room_transition_finished() -> void:
	E.run_cutscene([
		C.player_walk_to($Points/ProwPoint.global_position),
		C.player.face_right(),
		'Pato: No se me preocupes...',
		'...',
		C.player.face_left(),
		'...',
		C.player.face_right(),
		'...',
		C.player.face_left(),
		'...',
		C.player.face_right(),
		'...',
		'Pato: ¡¡¡Buscaré la forma de sacarte de ahí!!!',
		C.player.face_left(),
		'...',
		'Pato: Tiene que haber algo que pueda hacer'
	])


func on_room_exited() -> void:
	Globals.did(Globals.GameState.SEA_DREAMED)
	.on_room_exited()

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
