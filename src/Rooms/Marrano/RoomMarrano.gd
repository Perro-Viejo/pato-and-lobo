tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times,
		last_player_pos = Vector2.ZERO,
		container_weakness_revealed = false
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.current_surface = 'grass'
	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		A.play({cue_name = 'sfx_dome', pos = $Props/Container.global_position, is_in_queue = false})
	
	if visited_first_time:
		C.player.global_position = $Points/EntryPoint.global_position
		C.player.face_right(false)
		I.add_item('Pato', false)
		I.add_item('Lobo', false)
	else:
		C.player.global_position = state.last_player_pos

	A.play({cue_name = 'bg_marrano', pos = Vector2.ZERO, is_in_queue = false})
	C.player.enable(false)
	C.get_character('Lobo').disable(false)
	C.get_character('Lobo').vo_name = 'vo_lobo_com'
	
	# Verificar el estado de la habitación
	if state.container_weakness_revealed:
		get_prop('Container').description = 'Light-vault-3000X'
	
	if Globals.has_done(Globals.GameState.DOME_DESTROYED):
		C.get_character('Marrano').global_position = get_point('Container')
		C.get_character('Marrano').face_right(false)
		get_prop('Container').visible = false


func on_room_transition_finished() -> void:
	if not Globals.has_done(Globals.GameState.CHARACTER_CHANGE_EXPLAINED):
		yield(Globals.explain_character_change(), 'completed')
	
	if visited_first_time:
		E.run([
			G.display('RoomMarrano-01'),
			C.player.face_up_right(),
			'Pato: RoomMarrano-Pato-01'
		])
	elif Globals.has_done(Globals.GameState.GARBAGE_THROWN) \
		and not Globals.has_done(Globals.GameState.DOME_DESTROYED):
		Globals.did(Globals.GameState.DOME_DESTROYED)
		yield(E.run_cutscene([
			A.play({cue_name = 'sfx_dome', pos = $Props/Container.global_position}),
			'Pato: RoomMarrano-Pato-02',
			C.player_walk_to(get_point('Middle')),
			_play_fall(),
			A.play({cue_name = 'sfx_garbage_fall', pos = Vector2.ZERO, wait_audio_complete = true}),
			A.play({cue_name = 'sfx_alarm', pos = Vector2.ZERO}),
			A.stop('sfx_dome', 0),
			'Marrano: RoomMarrano-Pig-01',
			A.play({cue_name = 'sfx_pig_drive', pos = Vector2.ZERO}),
			C.character_walk_to('Marrano', get_point('Container')),
			"Marrano: RoomMarrano-Pig-02",
			C.player_walk_to(get_point('Water')),
			'Pato: RoomMarrano-Pato-03'
		]), 'completed')


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position

	if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		A.stop('sfx_dome', 0, false)
	else:
		A.stop('sfx_alarm', 0, false)

	A.stop('bg_marrano', 0, false)
	C.get_character('Lobo').enable(false)
	C.get_character('Lobo').vo_name = 'vo_wolf'

	.on_room_exited()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _play_fall() -> void:
	yield()
	$Props/Head/AnimationPlayer.play('fall')
	yield(get_tree(), 'idle_frame')
