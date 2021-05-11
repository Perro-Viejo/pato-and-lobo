tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.global_position = $Points/EntryPoint.global_position


func on_room_transition_finished() -> void:
	E.run([
		C.player_walk_to($Points/ProwPoint.global_position),
		C.player.face_right(),
		'Pato: No se me preocupes...',
		'...',
		'Pato: ¡¡¡Buscaré la forma de sacarte de ahí!!!',
		C.player.face_left(),
		E.wait(3),
		'Pato: Tiene que haber algo que pueda hacer'
	])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
