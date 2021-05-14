extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if E.current_room.script_name != 'Spaceship':
		E.goto_room('Spaceship')
	else:
		E.run(['Lobo: Soy yo. Lobo.'])


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	.on_item_used(item)
