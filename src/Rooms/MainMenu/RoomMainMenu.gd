tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.current_surface = 'concrete'
	AudioServer.get_bus_effect(1, 0).cutoff_hz = 400
	AudioServer.set_bus_volume_db(1, 2)

	if visited_first_time:
		C.player.global_position = $Points/Entry.global_position
	else:
		C.player.global_position = $Points/Entrance.global_position


func on_room_transition_finished() -> void:
	if visited_first_time:
		E.run_cutscene([
			G.display('RoomMainMenu-01'),
			G.display('RoomMainMenu-02'),
			G.display('RoomMainMenu-03'),
			G.show_inventory(2.0),
		])


func on_room_exited() -> void:
	A.stop('bg_street', 0, false, true, 3.5)
	.on_room_exited()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
