tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		'Pato: RoomLuna-HomeSeed-Pato-01',
		'Lobo: RoomLuna-HomeSeed-Lobo-01'
	])


func on_look() -> void:
	E.run(['Pato: RoomLuna-HomeSeed-Pato-02'])


func on_item_used(item: Item) -> void:
	if item.script_name == 'WaterCase':
		yield(E.run([
			I.remove_item('WaterCase'),
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: RoomLuna-HomeSeed-Pato-03',
			A.play({cue_name = 'sfx_watercase_use', pos = Vector2.ZERO, is_in_queue = true, wait_audio_complete = true}),
			C.player_walk_to(E.current_room.get_point('WolfPoint')),
			A.play({cue_name = 'sfx_seed_grow', pos = Vector2.ZERO}),
			
			_shake_camera(),
			disable(),
			E.current_room.get_prop('Home').enable(),
			_offset_camera(),
			'...',
			'Pato: RoomLuna-HomeSeed-Pato-04',
			'Lobo: RoomLuna-HomeSeed-Lobo-02'
		]), 'completed')
		E.goto_room('Bar')
		C.get_character('Lagarto').check_music()
		A.play({cue_name = 'bg_bar', pos = global_position, is_in_queue = false, fade = true, 
			from = -30, to = -10, duration = 2.2})
		A.stop('bg_space', 0, false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _offset_camera() -> void:
	yield()
	E.main_camera.offset_v = -5.0
	yield(get_tree(), 'idle_frame')


func _shake_camera() -> void:
	yield()
	E.shake_camera({
		strength = 10.0,
		duration = 0.8
	})
	yield(E.wait(0.9, false), 'completed')
