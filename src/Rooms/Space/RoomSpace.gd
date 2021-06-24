tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# TODO: Sobrescribir los métodos de Godot que hagan falta


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	C.player.global_position = $Points/EntryPoint.global_position
	C.player.disable(false)
	
	A.stop('bg_marrano', 0, false)
	A.stop('bg_homesplantation', 0, false)


func on_room_transition_finished() -> void:
	pass


func on_room_exited() -> void:
	C.player.enable(false)
	C.get_character('Spaceship').enable(false)
	.on_room_exited()


func goto_planet(planet_name: String) -> void:
	yield()
	var path_follow: PathFollow2D = $Paths.get_node(planet_name).get_child(0)
	var spaceship_copy: Character = C.get_character('Spaceship').duplicate()
	C.get_character('Spaceship').disable(false)
	path_follow.add_child(spaceship_copy)
	$Paths/Tween.interpolate_property(
		path_follow, 'unit_offset',
		0.0, 1.0,
		4.0, Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	$Paths/Tween.start()
	yield($Paths/Tween, 'tween_all_completed')
	spaceship_copy.queue_free()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
