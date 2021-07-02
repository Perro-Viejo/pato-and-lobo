extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if E.current_room.script_name != 'Spaceship':
		E.goto_room('Spaceship')
		A.play({cue_name = 'sfx_space_character_transition', pos = Vector2.ZERO, is_in_queue = false})
	else:
		E.run(['Lobo: Items-ItemLobo-Lobo-01'])


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	.on_item_used(item)
