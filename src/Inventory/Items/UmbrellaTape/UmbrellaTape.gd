extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_umbrella_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mop':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play('sfx_mopbrella_pu', Vector2.ZERO),
			'Pato: Great! I can reach Lobo with this. No doubt!',
			I.add_item('Mopbrella'),
			'Pato: Hold on! I\'m comming for you!',
		])