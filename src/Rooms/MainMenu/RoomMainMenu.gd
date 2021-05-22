tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	A.play('bg_street', Vector2.ZERO, false)
	if visited_first_time:
		C.player.global_position = $Points/Entry.global_position
	else:
		C.player.global_position = $Points/Entrance.global_position

func on_room_exited() -> void:
	A.stop('bg_street', 0, false)
	.on_room_exited()

func on_room_transition_finished() -> void:
	if visited_first_time:
		E.run([
			G.display('Use left click to interact with objects and characters.'),
			G.display('Use right click to take a look on objects and characters.'),
			G.display('Your inventory and courage bar will be in the top-left corner.'),
			G.show_inventory(2.0),
		])


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
