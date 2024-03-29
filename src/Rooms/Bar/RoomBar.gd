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
	AudioServer.get_bus_effect(1, 0).cutoff_hz = 20000
	AudioServer.set_bus_volume_db(1, 0)
	C.player.current_surface = 'tile'
	# Quitar los elementos de inventario que hayan podido quedar del mundo de
	# los sueños
	I.remove_item('Pato', false)
	I.remove_item('Lobo', false)
	I.remove_item('WaterCase', false)
	
	# y que el DJ toque la mx_bar_gen cuando este en silencio por determinado
	# tiempo
	A.play({cue_name = 'bg_bathroom', pos = $Points/Bathroom.global_position, is_in_queue = false})
	if state.vieja_sleeping:
		A.play({cue_name = 'sfx_granny_sleep', pos = C.get_character('Vieja').global_position, is_in_queue = false})
	
	if visited_first_time:
		C.player.global_position = $Points/Entrance.global_position
		C.player.face_left(false)
	elif C.player.last_room == 'Sea':
		A.play({cue_name = 'sfx_sink_tail', pos = global_position, is_in_queue = false})
		C.player.global_position = $Points/Sink.global_position
	elif C.player.last_room == 'MainMenu':
		C.get_character('Lagarto').check_music()
		C.player.global_position = $Points/Entrance.global_position
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
			A.play({cue_name = 'sfx_camera_lobo_intro', pos = Vector2.ZERO}),
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

		# Se presenta escena de llegada del disco
		yield(E.run([
			'Pato: RoomBar-Pato-05',
			E.wait(0.5),
			C.change_camera_owner(C.get_character('Lagarto')),
			A.play({cue_name = 'sfx_camera_lobo_intro', pos = Vector2.ZERO}),
			'...',
			'Lagarto: ' +\
				E.get_text('RoomBar-Lagarto-06') % E.get_text('SongList-Opt2'),
			'...',
			C.change_camera_owner(C.player),
		]), 'completed')
	elif C.player.last_room != 'MainMenu' and (
		Globals.has_done(Globals.GameState.GOT_HOME)
		or Globals.has_done(Globals.GameState.WATER_TAKEN)
		):
		Globals.courage += 20
		yield(I, 'courage_update_shown')

		yield(E.run(['Pato: RoomBar-Pato-06']), 'completed')
		
		if (Globals.has_done(Globals.GameState.GOT_HOME)
			and Globals.has_done(Globals.GameState.WATER_TAKEN)
		):
			# Anunciar la descarga de una nueva canción.
			yield(E.run([
				C.change_camera_owner(C.get_character('Lagarto')),
				A.play({cue_name = 'sfx_camera_lobo_intro', pos = Vector2.ZERO}),
				'...',
				'Lagarto: ' +\
					E.get_text('RoomBar-Lagarto-06') % E.get_text('SongList-Opt4'),
				'...',
				C.change_camera_owner(C.player),
			]), 'completed')
	
	if Globals.courage >= 60 \
		and (C.player.last_room == 'Sea' or C.player.last_room == 'Luna'):
		E.run(['Pato: RoomBar-Pato-07'])


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('bg_bar', 0, false, true, 4)
	A.stop('bg_bathroom', 0, false)
#	Aquí se apagaba la música antes
	A.stop('sfx_granny_sleep', 0, false, true, 3.5)
	
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
