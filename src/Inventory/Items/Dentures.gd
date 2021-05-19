extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_dentures_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	C.player_say('Esta dentadura de lobo me servirá resto', false)


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mask':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_mask_dentures_pu'),
			C.player_say('Listo, ya tengo la jeta'),
			I.add_item('MaskWithFangs'),
		])
