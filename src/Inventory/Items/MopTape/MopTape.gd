extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play({cue_name = 'sfx_mop_active', pos = Vector2.ZERO, is_in_queue = false})
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Umbrella':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: Items-MopTape-Pato-01',
			A.play({cue_name = 'sfx_mopbrella_pu', pos = Vector2.ZERO}),
			I.add_item('Mopbrella'),
			'Pato: Items-MopTape-Pato-02',
		])
