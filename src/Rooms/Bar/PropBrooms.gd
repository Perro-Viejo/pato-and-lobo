tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		C.player_say('Uy severos escobastros...'),
		C.player_say('Los romperé para darme más altura.'),
		disable(),
		I.add_item('Legs')
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
