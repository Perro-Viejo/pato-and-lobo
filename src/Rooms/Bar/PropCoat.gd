tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_coat = false
	Globals.did(Globals.GameState.TAIL_TAKEN)
	E.run([
		C.walk_to_clicked(),
		'Pato: RoomBar-Coat-Pato-01',
		C.player.grab(),
		A.play({cue_name = 'sfx_tail_pu', pos = global_position}),
		'Pato: RoomBar-Coat-Pato-02',
		disable(),
		I.add_item('Tail'),
		'Pato: RoomBar-Coat-Pato-03',
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
