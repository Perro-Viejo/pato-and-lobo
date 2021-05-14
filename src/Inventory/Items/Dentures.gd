extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	C.player_say('Esta dentadura de lobo me servirá resto', false)


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mask':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			C.player_say('Listo, ya tengo la jeta'),
			I.add_item('MaskWithFangs'),
		])
