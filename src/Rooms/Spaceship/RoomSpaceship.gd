tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play('sfx_spaceship_idle', Vector2.ZERO, false)
	C.player.global_position = $Points/PlayerPos.global_position
	C.player.disable(false)
	C.get_character('Lobo').scale = Vector2.ONE * 0.8


func on_room_exited() -> void:
	A.stop('sfx_spaceship_idle', 0, false)
	A.stop('bg_space', 0, false)
	.on_room_exited()


func on_room_transition_finished() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
