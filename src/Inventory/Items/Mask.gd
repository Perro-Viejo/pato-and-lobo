extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Dentures':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			I.add_item('MaskWithFangs'),
			C.player_say('Listo, ya tengo la jeta')
		])
