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
	C.player.current_surface = 'rock'
	if C.player.last_room == 'Bar':
		A.play({cue_name = 'bg_space', pos = Vector2.ZERO, is_in_queue = false})
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
	if visited_first_time and C.player.last_room == 'Bar':
		E.run([
			'Pato: RoomLuna-Pato-01',
			'Lobo: RoomLuna-Lobo-01',
			'Pato: RoomLuna-Pato-02',
			'Lobo: RoomLuna-Lobo-02',
			'Pato: RoomLuna-Pato-03'
		])
	else:
		D.show_dialog('ChatWithLoboInLuna')


func on_room_exited() -> void:
	C.player.scale = Vector2.ONE
	C.get_character('Lobo').scale = Vector2.ONE
	E.main_camera.offset_v = 0.0

	.on_room_exited()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
