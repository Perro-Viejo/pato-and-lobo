extends Area2D

var _inside = false

func _ready():
	connect('area_entered', self, '_on_area_entered')
	connect('area_exited', self, '_on_area_exited')

func _process(delta):
	if _inside:
		var bar_volume = range_lerp(global_position.distance_to(C.player.global_position), 700, 150, 0, -5)
		var bar_filter = range_lerp(global_position.distance_to(C.player.global_position), 800, 350, 20000, 1450)
		var music_volume = range_lerp(global_position.distance_to(C.player.global_position), 700, 150, 0, -4)
		var music_filter = range_lerp(global_position.distance_to(C.player.global_position), 800, 350, 20000, 1800)
		
		if bar_volume <= 0:
			AudioServer.set_bus_volume_db(2, bar_volume)
			AudioServer.set_bus_volume_db(1, music_volume)
			if bar_filter <= 1450:
				AudioServer.get_bus_effect(2, 0).cutoff_hz = 1450
				AudioServer.get_bus_effect(1, 0).cutoff_hz = 1800
			else:
				AudioServer.get_bus_effect(2, 0).cutoff_hz = bar_filter
				AudioServer.get_bus_effect(1, 0).cutoff_hz = music_filter
		else:
			AudioServer.get_bus_effect(2, 0).cutoff_hz = 20000
			AudioServer.get_bus_effect(1, 0).cutoff_hz = 20000
			AudioServer.set_bus_volume_db(2, 0)
			AudioServer.set_bus_volume_db(1, 0)
		

func _on_area_entered(body) -> void:
	if body.name == 'CharacterPato':
		_inside = true

func _on_area_exited(body) -> void:
	if body.name == 'CharacterPato':
		_inside = false
