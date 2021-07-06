tool
extends Room


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _init() -> void:
	# El estado común a todos los Room
	state = {
		visited = self.visited,
		visited_first_time = self.visited_first_time,
		visited_times = self.visited_times
	}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	G.hide_interface()
	A.play({cue_name = 'bg_street', pos = global_position, is_in_queue = false, 
		fade = true, from = -30, to = -4, duration = 0.8})
	AudioServer.get_bus_effect(1, 0).cutoff_hz = 400
	AudioServer.set_bus_volume_db(1, 2)
	C.get_character('Lagarto').play_music('mx_bar_gen', false)


func on_room_transition_finished() -> void:
	yield(get_tree().create_timer(2.0), 'timeout')
	E.goto_room('MainMenu')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
# TODO: Poner aquí los métodos privados
