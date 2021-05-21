tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	if visited_first_time:
		C.player.global_position = $Points/Entry.global_position
	else:
		C.player.global_position = $Points/Entrance.global_position


func on_room_transition_finished() -> void:
	if visited_first_time:
		E.run([
			G.display('Left clic to interact with objects and characters.'),
			G.display('Right clic to take a look.'),
			G.display('Your inventory and courage value will be in the top left corner.'),
			G.show_inventory(2.0),
		])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
