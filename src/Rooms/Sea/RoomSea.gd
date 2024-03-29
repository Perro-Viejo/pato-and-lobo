tool
extends Room

# Camera limits
# -960, 960, -960, 1


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.current_surface = 'wood'
	A.play({cue_name = 'bg_dream_boat', pos = Vector2.ZERO, is_in_queue = false, 
		fade = true, from = -30, to = -8, duration = 1})
	C.player.global_position = $Points/EntryPoint.global_position
	C.get_character('Lobo').drowning()
	E.main_camera.offset_v = -2.0
	
	# Quitar elementos del inventario que haya podido agarrar Pato en el bar
	I.remove_item('Mask', false)
	I.remove_item('Dentures', false)
	I.remove_item('Tail', false)
	I.remove_item('Legs', false)


func on_room_transition_finished() -> void:
	E.run_cutscene([
		C.player_walk_to($Points/ProwPoint.global_position),
		C.player.face_right(),
		'Pato: RoomSea-Pato-01',
		'...',
		C.player.face_left(),
		'...',
		C.player.face_right(),
		'...',
		C.player.face_left(),
		'...',
		C.player.face_right(),
		'...',
		'Pato: RoomSea-Pato-02',
		C.player.face_left(),
		'...',
		'Pato: RoomSea-Pato-03'
	])


func on_room_exited() -> void:
	Globals.did(Globals.GameState.SEA_DREAMED)
	
	C.get_character('Lobo').anim_suffix = ''
	C.get_character('Lobo').idle(false)
	
	A.play({cue_name = 'bg_bar', pos = global_position, is_in_queue = false, fade = true, 
		from = -30, to = -10, duration = 2.2})
	
	.on_room_exited()

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
