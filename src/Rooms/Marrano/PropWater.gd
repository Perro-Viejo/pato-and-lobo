	tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.DOME_DESTROYED):
		E.run([
			C.walk_to_clicked(),
			C.player.face_up_right(),
			'Pato: RoomMarrano-Water-Pato-01',
			'Marrano: RoomMarrano-Water-Pig-01',
			C.player.face_right(),
			'Pato: RoomMarrano-Water-Pato-02'
		])
	else:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: RoomMarrano-Water-Pato-03',
			disable(),
			A.play({cue_name = 'sfx_watercase_pu', pos = global_position}),
			I.add_item('WaterCase'),
			'Pato: RoomMarrano-Water-Pato-04',
			'Lobo: RoomMarrano-Water-Lobo-01',
		]), 'completed')
		Globals.did(Globals.GameState.WATER_TAKEN)
		A.play({cue_name = 'sfx_space_character_transition', pos = Vector2.ZERO, is_in_queue = false})
		E.goto_room('Spaceship')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
