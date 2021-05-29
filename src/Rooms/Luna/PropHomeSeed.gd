tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		'Pato: This is the seed we choose for our home',
		'Lobo: Yeeeyyyy... it has a front garden, two bedrooms, and bathroom with tub.'
	])


func on_look() -> void:
	E.run(['Pato: Our house will be awesome!'])


func on_item_used(item: Item) -> void:
	if item.script_name == 'WaterCase':
		yield(E.run([
			I.remove_item('WaterCase'),
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: And here comes the water',
			# TODO: Poner aquí un SFX de agua regándose sobre una planta
			'...',
			C.player_walk_to(E.current_room.get_point('WolfPoint')),
			_shake_camera(),
			disable(),
			E.current_room.get_prop('Home').enable(),
			_offset_camera(),
			'...',
			'Pato: Look my love, is the house of our dreams.',
			'Lobo: Now we can give us love and make children.'
		]), 'completed')
		E.goto_room('Bar')


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
