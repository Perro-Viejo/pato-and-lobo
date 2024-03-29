extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play({cue_name = 'sfx_tape_active', pos = Vector2.ZERO, is_in_queue = false})
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Umbrella':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play({cue_name = 'sfx_tape_use', pos = Vector2.ZERO}),
			'Pato: Items-Tape-Pato-01',
			I.add_item('UmbrellaTape'),
		])
	elif item.script_name == 'Mop':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			A.play({cue_name = 'sfx_tape_use', pos = Vector2.ZERO}),
			'Pato: Items-Tape-Pato-02',
			I.add_item('MopTape'),
		])
