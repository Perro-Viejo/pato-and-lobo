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
	# Quitar los elementos de inventario que hayan podido quedar del mundo de
	# los sueños
	I.remove_item('Pato', false)
	I.remove_item('Lobo', false)
	I.remove_item('WaterCase', false)
	
	# TODO: Que audio siga desde donde quedó antes de abandonar la habitación
	A.play_music('mx_bar_01', false)
	A.play('bg_bar', Vector2.ZERO, false)
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
			G.display('She is Pato.'),
			'Pato: What an awesome party.',
			C.player.face_left(),
			'Pato: And Lobo is here <3.',
			G.display('She is in love with him.'),
			C.change_camera_owner(C.get_character('Lobo')),
			E.wait(2.0),
			C.change_camera_owner(C.player),
			G.display('But she doesn\'t has the guts to talk him.'),
			C.player.face_right(),
			'Pato: Today will be the day....',
			G.display('You can help her with a costume.'),
			G.display('Or by living her daydreams to increase her courage.'),
			'Pato: I WILL TALK WITH LOBO TODAY!',
		])
	elif C.player.last_room == 'Sea':
		yield(E.wait(0.5, false), 'completed')
		Globals.courage += 20
		yield(I, 'courage_update_shown')
		yield(E.run(['Pato: The savior of my love...']), 'completed')
	elif Globals.has_done(Globals.GameState.GOT_HOME) or Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(E.wait(0.5, false), 'completed')
		Globals.courage += 20
		yield(I, 'courage_update_shown')
		yield(E.run(['Pato: What a romantic dream...']), 'completed')
	
	if Globals.courage >= 60 \
		and (C.player.last_room == 'Sea' or C.player.last_room == 'Luna'):
		E.run(['Pato: I feel I have the courage to talk with Lobo'])


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('bg_bar', 0, false)
	A.stop('mx_bar_01', 0, false)
	A.stop('mx_bar_02', 0, false)
	A.stop('mx_bar_03', 0, false)
	A.stop('sfx_granny_sleep', 0, false)
	
	C.get_character('Lobo').idle(false)
	
	.on_room_exited()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
