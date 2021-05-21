tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_mask = false
	E.run([
		C.walk_to_clicked(),
		C.player.face_left(),
		C.player_say('Qué bueno que el DJ trajo esta máscara'),
		C.player_say('La tomaré prestada un rato.'),
		A.play('sfx_mask_pu', global_position),
		C.player.grab(),
		disable(),
		I.add_item('Mask')
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
