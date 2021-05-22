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
	I.remove_item('Pato', false)
	I.remove_item('Lobo', false)
	A.play_music('mx_bar_01', false)
	A.play('bg_bar', Vector2.ZERO, false)
	
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

func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('bg_bar', 0, false)
	A.stop('mx_bar_01', 0, false)
	A.stop('mx_bar_02', 0, false)
	.on_room_exited()

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
		Globals.courage += 25
		yield(I, 'courage_update_shown')
		E.run(['Pato: I feel I can talk to Lobo now'])
	elif Globals.has_done(Globals.GameState.GOT_HOME):
		Globals.courage += 25
		yield(I, 'courage_update_shown')
		E.run(['Pato: What a romantic dream...'])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
