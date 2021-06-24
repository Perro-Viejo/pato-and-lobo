tool
extends Room

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times,
		has_mask = true,
		has_dentures = false,
		has_coat = true,
		dj_uses_mask = true,
		vieja_sleeping = false,
		last_player_pos = Vector2.ZERO,
		cocktail_unlocked = false
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	$WavingBar.hide()
	C.player.current_surface = 'tile'
	# Quitar los elementos de inventario que hayan podido quedar del mundo de
	# los sueños
	I.remove_item('Pato', false)
	I.remove_item('Lobo', false)
	I.remove_item('WaterCase', false)
	
	# TODO: Que audio siga desde donde quedó antes de abandonar la habitación
#	A.play_music('mx_bar_gen', false)
#	A.play('bg_bar', Vector2.ZERO, false)
	A.play('bg_bathroom', $Points/Bathroom.global_position, false)
	if state.vieja_sleeping:
		A.play('sfx_granny_sleep', C.get_character('Vieja').global_position, false)
	
	if visited_first_time:
		C.player.global_position = $Points/Entrance.global_position
		C.player.face_left(false)
	elif C.player.last_room == 'Sea':
		C.player.global_position = $Points/Sink.global_position
	else:
		C.player.global_position = state.last_player_pos
	
	if not state.has_mask or state.dj_uses_mask:
		$Props/WolfMask.disable(false)
	if not state.has_dentures:
		$Props/GlassWithDentures.disable(false)
	if not state.has_coat:
		$Props/Coat.disable(false)
	if state.vieja_sleeping:
		$Characters/CharacterVieja.sleep()

	# Verificar qué cosas ya agarró
	if Globals.has_done(Globals.GameState.LEGS_TAKEN):
		I.add_item('Legs', false)
	if Globals.has_done(Globals.GameState.DENTURES_TAKEN):
		I.add_item('Dentures', false)
	if Globals.has_done(Globals.GameState.MASK_TAKEN):
		I.add_item('Mask', false)
	if Globals.has_done(Globals.GameState.TAIL_TAKEN):
		I.add_item('Tail', false)


func on_room_transition_finished() -> void:
	if visited_first_time:
		E.run_cutscene([
			G.display('RoomBar-01'),
			'Pato: RoomBar-Pato-01',
			C.player.face_left(),
			'Pato: RoomBar-Pato-02',
			G.display('RoomBar-02'),
			C.change_camera_owner(C.get_character('Lobo')),
			A.play('sfx_camera_lobo_intro', Vector2.ZERO),
			E.wait(2.0),
			C.change_camera_owner(C.player),
			G.display('RoomBar-03'),
			C.player.face_right(),
			'Pato: RoomBar-Pato-03',
			G.display('RoomBar-04'),
			G.display('RoomBar-05'),
			'Pato: RoomBar-Pato-04',
		])
	elif C.player.last_room == 'Sea':
		Globals.courage += 20
		yield(I, 'courage_update_shown')

		yield(E.run(['Pato: RoomBar-Pato-05']), 'completed')
	elif C.player.last_room != 'MainMenu' and (Globals.has_done(Globals.GameState.GOT_HOME) or Globals.has_done(Globals.GameState.WATER_TAKEN)):
		Globals.courage += 20
		yield(I, 'courage_update_shown')

		yield(E.run(['Pato: RoomBar-Pato-06']), 'completed')
	
	if Globals.courage >= 60 \
		and (C.player.last_room == 'Sea' or C.player.last_room == 'Luna'):
		E.run(['Pato: RoomBar-Pato-07'])


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('bg_bar', 0, false)
	A.stop('bg_bathroom', 0, false)
	A.stop('mx_bar_01', 0, false)
	A.stop('mx_bar_02', 0, false)
	A.stop('mx_bar_03', 0, false)
	A.stop('mx_bar_04', 0, false)
	A.stop('mx_bar_gen', 0, false)
	A.stop('sfx_granny_sleep', 0, false)
	
	C.get_character('Lobo').idle(false)
	
	.on_room_exited()


func show_waving() -> void:
	yield()
	hide_props()
	$WavingBar.material.set_shader_param("aspect_ratio", $WavingBar.scale.y / $WavingBar.scale.x)
	$WavingBar.material.set_shader_param("sine_offset_scale", Vector2(1.0, 4.0))
	$WavingBar.show()
	yield(get_tree(), 'idle_frame')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
