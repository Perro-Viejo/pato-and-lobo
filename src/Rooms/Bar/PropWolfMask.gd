tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_mask = false
	Globals.did(Globals.GameState.MASK_TAKEN)
	E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Pato: RoomBar-WolfMask-Pato-01',
		'Pato: RoomBar-WolfMask-Pato-02',
		A.play('sfx_mask_pu', global_position),
		C.player.grab(),
		disable(),
		I.add_item('Mask')
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
