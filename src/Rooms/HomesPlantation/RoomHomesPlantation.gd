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


func on_room_exited() -> void:
	state.last_player_pos = C.player.global_position
	
	A.stop('bg_homesplantation', 0, false)
	C.player.enable(false)
	C.get_character('Lobo').enable(false)
	.on_room_exited()


func on_room_transition_finished() -> void:
	if Globals.has_done(Globals.GameState.GOT_HOME):
		yield(
			E.run_cutscene([
			'Pato: Hagale con cariño',
			'Pato: Eso, eso. Baje el bracito',
			'Lobo: Voy voy voy...',
			E.wait(2),
			'Pato: Listo. Ya tenemos la semilla-casa. Vamos a Luna a sembrarla.',
		]), 'completed')
		E.goto_room('Luna')
	else:
		yield(E.run([
			'Pato: Lobo y yo necesitamos un hogar para vivir y darnos amor',
			'Pato: En este planeta se siembran casas.',
			'Pato: Debemos escoger la más bonita para llevarla a la Luna.',
			'Pato: ¿Cierto amor mío?',
			'Lobo: Sí madrecita'
		]), 'completed')



# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
