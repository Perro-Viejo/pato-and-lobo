tool
extends Room

var laguna_uno := 0
var laguna_dos := 0

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play_music('mx_bar_01', false)
	A.play('bg_bar', Vector2.ZERO, false)


func on_room_transition_finished() -> void:
	E.run([
		C.player_say('Esta fiesta está re-buena...'),
		C.player_say('y está más buena porque Lobo está aquí'),
		C.player_say('Hoy es el día.'),
		C.player_say('¡HOY LE HABLARÉ A LOBO!'),
	])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
