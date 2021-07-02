tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.SEA_DREAMED):
		yield(E.run([
			C.walk_to_clicked(),
			C.player.face_up(),
			'Pato: RoomBar-Sink-Pato-01',
			A.play({cue_name = 'sfx_sink_head', pos = global_position}),
			A.play({cue_name = 'sfx_sink_loop', pos = global_position}),
			E.wait(),
			'Pato: RoomBar-Sink-Pato-02',
			A.play({cue_name = 'sfx_sink_wash', pos = global_position}),
			'...',
			A.play({cue_name = 'sfx_sink_wash', pos = global_position}),
			'Pato: RoomBar-Sink-Pato-03',
			A.play({cue_name = 'sfx_sink_wash', pos = global_position}),
			A.stop('sfx_sink_loop'),
			'...'
		]), 'completed')
		A.play({cue_name = 'sfx_dream_transition', pos = Vector2.ZERO, is_in_queue = false})
		C.get_character('Lagarto').stop_music(false)
		C.get_character('Lagarto').timer.stop()
		E.goto_room('Sea')
	else:
		E.run([
			C.player_say('RoomBar-Sink-Pato-04'),
			C.player_say('RoomBar-Sink-Pato-05')
		])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
