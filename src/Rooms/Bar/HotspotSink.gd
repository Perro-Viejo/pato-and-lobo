tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.SEA_DREAMED):
		yield(E.run([
			C.walk_to_clicked(),
			C.player.face_up(),
			'Pato: RoomBar-Sink-Pato-01',
			A.play('sfx_sink_head', global_position),
			A.play('sfx_sink_loop', global_position),
			E.wait(),
			'Pato: RoomBar-Sink-Pato-02',
			A.play('sfx_sink_wash', global_position),
			'...',
			A.play('sfx_sink_wash', global_position),
			'Pato: RoomBar-Sink-Pato-03',
			A.play('sfx_sink_wash', global_position),
			A.stop('sfx_sink_loop'),
			'...'
		]), 'completed')
		A.play('sfx_dream_transition', Vector2.ZERO, false)
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
