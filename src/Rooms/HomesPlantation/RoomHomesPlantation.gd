tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times,
		last_player_pos = Vector2.ZERO
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.current_surface = 'dirt'
	if visited_first_time:
		C.player.global_position = $Points/EntryPoint.global_position
		I.add_item('Pato', false)
		I.add_item('Lobo', false)
	else:
		C.player.global_position = state.last_player_pos
		
	A.play({cue_name = 'bg_homesplantation', is_in_queue = false, fade = true, 
			from = -30, to = 1, duration = 1})
	C.get_character('Lobo').disable(false)
	C.get_character('Lobo').vo_name = 'vo_lobo_com'
	C.player.enable(false)


func on_room_transition_finished() -> void:
	if not Globals.has_done(Globals.GameState.CHARACTER_CHANGE_EXPLAINED):
		yield(Globals.explain_character_change(), 'completed')
	
	if Globals.has_done(Globals.GameState.ARM_DOWN):
		yield(
			E.run_cutscene([
			_play(),
			{ dialog = 'Pato: RoomHomesPlantation-Pato-01', time = 2 },
			{ dialog = 'Pato: RoomHomesPlantation-Pato-02', time = 3 },
			{ dialog = 'Lobo: RoomHomesPlantation-Lobo-01', time = 3 },
			E.wait(3),
			'Pato: RoomHomesPlantation-Pato-03',
		]), 'completed')
		E.goto_room('Luna')
	elif visited_first_time:
		yield(E.run([
			'Pato: RoomHomesPlantation-Pato-04',
			'Pato: RoomHomesPlantation-Pato-05',
			'Pato: RoomHomesPlantation-Pato-06',
			'Pato: RoomHomesPlantation-Pato-07',
			'Lobo: RoomHomesPlantation-Lobo-02'
		]), 'completed')


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('sfx_spaceship_hook')
	A.stop('bg_homesplantation', 0, false, true, 3)
	C.player.enable(false)
	C.get_character('Lobo').enable(false)
	C.get_character('Lobo').vo_name = 'vo_wolf'
	.on_room_exited()


func shake_camera() -> void:
	E.shake_camera({
		strength = 10.0,
		duration = 0.4
	})


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _play() -> void:
	yield()
	$AnimationPlayer.play('pull')
	yield(get_tree(), 'idle_frame')
