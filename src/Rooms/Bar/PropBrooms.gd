tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_brooms = false
	E.run([
		C.walk_to_clicked(),
		C.player.face_right(),
		'...',
		C.player_say('Uy severos escobastros...'),
		C.player_say('Los romperé para darme más altura.'),
		C.player.grab(),
		disable(),
		I.add_item('Legs')
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
