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
			'Pato: Items-Mop-Pato-01',
			I.add_item('MopTape'),
		])
	elif item.script_name == 'Umbrella':
		E.run([
			'Pato: Items-Mop-Pato-02'
		])
	elif item.script_name == 'UmbrellaTape':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_mopbrella_pu', Vector2.ZERO),
			'Pato: Items-Mop-Pato-03',
			I.add_item('Mopbrella'),
			'Pato: Items-Mop-Pato-04',
		])
