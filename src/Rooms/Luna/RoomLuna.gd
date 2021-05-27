tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.global_position = $Points/EntryPoint.global_position

	C.player.enable(false)
	C.player.scale = Vector2.ONE * 0.5
	C.get_character('Lobo').scale = Vector2.ONE * 0.5
	C.get_character('Lobo').global_position = $Points/WolfPoint.global_position

	if Globals.has_done(Globals.GameState.GOT_HOME):
		$Props/HomeSeed.enable(false)
	
	if Globals.has_done(Globals.GameState.WATER_TAKEN):
		I.add_item('WaterCase', false)
	
	# Quitar elementos del inventario que haya podido agarrar Pato en el bar
	I.remove_item('Mask', false)
	I.remove_item('Dentures', false)
	I.remove_item('Tail', false)
	I.remove_item('Legs', false)


func on_room_transition_finished() -> void:
	if visited_first_time:
		E.run([
			'Pato: How calm and quiet it is around here',
			'Lobo: Yes... makes you want to... T.D.A.F.',
			'Pato: Awwwwww....',
			'Lobo: Let\'s search for materials to build our home here.',
			'Pato: Yes yes yes. Let\'s do it.'
		])
	else:
		D.show_dialog('ChatWithLoboInLuna')


func on_room_exited() -> void:
	C.player.scale = Vector2.ONE
	C.get_character('Lobo').scale = Vector2.ONE

	.on_room_exited()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
