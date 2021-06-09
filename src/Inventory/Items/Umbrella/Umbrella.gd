extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_umbrella_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Tape':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_tape_use', Vector2.ZERO),
			'Pato: Items-Umbrella-Pato-01',
			I.add_item('UmbrellaTape'),
		])
	elif item.script_name == 'Mop':
		E.run([
			'Pato: Items-Umbrella-Pato-02'
		])
	elif item.script_name == 'MopTape':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_mopbrella_pu', Vector2.ZERO),
			'Pato: Items-Umbrella-Pato-03',
			I.add_item('Mopbrella'),
			'Pato: Items-Umbrella-Pato-04',
		])
