tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	pass


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mopbrella':
		yield(E.run([
			C.player_say('Te salve de la desgracía Lobo de mis amores'),
		]), 'completed')
		A.stop('bg_dream_boat', 0, false)
		I.remove_item(item.script_name, false)
		A.play('sfx_dream_transition', Vector2.ZERO, false)
		E.goto_room('Bar')
	else:
		E.run([
			C.player_say('No alcanzo hasta allá'),
		])
