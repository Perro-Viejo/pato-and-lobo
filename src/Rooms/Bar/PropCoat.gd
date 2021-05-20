tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_coat = false
	E.run([
		C.walk_to_clicked(),
		C.player_say('Nadie esta viendo... es el momento'),
		C.player.grab(),
		A.play('sfx_tail_pu', global_position),
		C.player_say('¡Túmbilis!'),
		disable(),
		I.add_item('Tail')
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
