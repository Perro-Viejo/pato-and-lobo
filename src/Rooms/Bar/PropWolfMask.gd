tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.mask_grabbed = true
	E.run([
		C.walk_to_clicked(),
		C.player_say('Qué bueno que el DJ trajo esta máscara'),
		C.player_say('La tomaré prestada un rato.'),
		A.play('sfx_mask_pu', global_position),
		disable(),
		I.add_item('Mask')
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
