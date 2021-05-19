extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_mop_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Tape':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_tape_use', Vector2.ZERO),
			C.player_say('Amarrao'),
			I.add_item('MopTape'),
		])
	elif item.script_name == 'Umbrella':
		E.run([
			C.player_say('Podría funcionar pero necesito algo para unirlos')
		])
	elif item.script_name == 'UmbrellaTape':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_mopbrella_pu', Vector2.ZERO),
			C.player_say('¡Listo el pollo, esto si es largor!'),
			I.add_item('Mopbrella'),
			C.player_say('¡Aguanta! ¡Te salvares!'),
		])
