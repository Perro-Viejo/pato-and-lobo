tool
extends Room

# Camera limits
# -960, 960, -540, 540


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play({cue_name = 'sfx_spaceship_idle', is_in_queue = false, fade = true, 
			from = -30, to = 1, duration = .8})
	C.player.global_position = $Points/PlayerPos.global_position
	C.player.disable(false)
	C.get_character('Lobo').scale = Vector2.ONE * 0.8
	C.get_character('Lobo').vo_name = 'vo_lobo_com'
	C.get_character('Pato').vo_name = 'vo_duck_com'


func on_room_exited() -> void:
	A.stop('sfx_spaceship_idle', 0, false)
	C.get_character('Lobo').vo_name = 'vo_wolf'
	C.get_character('Pato').vo_name = 'vo_duck'
	.on_room_exited()


func on_room_transition_finished() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
