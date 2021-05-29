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
	if visited_first_time:
		C.player.global_position = $Points/EntryPoint.global_position
		I.add_item('Pato', false)
		I.add_item('Lobo', false)
	else:
		C.player.global_position = state.last_player_pos
		
	A.play('bg_homesplantation', Vector2.ZERO, false)
	C.get_character('Lobo').disable(false)
	C.player.enable(false)


func on_room_transition_finished() -> void:
	if not Globals.has_done(Globals.GameState.CHARACTER_CHANGE_EXPLAINED):
		yield(Globals.explain_character_change(), 'completed')
	
	if Globals.has_done(Globals.GameState.GOT_HOME):
		yield(
			E.run_cutscene([
			_play(),
			{ dialog = 'Pato: Do it calmly', time = 2 },
			{ dialog = 'Pato: Good, good. Now take down the arm.', time = 3 },
			{ dialog = 'Lobo: Doing so. Doing so...', time = 3 },
			E.wait(3),
			'Pato: Done! We have our house-seed. Let\'s go to Luna and sow it.',
		]), 'completed')
		E.goto_room('Luna')
	elif visited_first_time:
		yield(E.run([
			'Pato: Lobo and I need a home to live and give each other love.',
			'Pato: Houses are planted on this planet.',
			'Pato: We must choose the most beautiful one to take to Luna.',
			'Pato: Is that true, love of mine?',
			'Lobo: Yes-it-is'
		]), 'completed')


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('sfx_spaceship_hook')
	A.stop('bg_homesplantation', 0, false)
	C.player.enable(false)
	C.get_character('Lobo').enable(false)
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
