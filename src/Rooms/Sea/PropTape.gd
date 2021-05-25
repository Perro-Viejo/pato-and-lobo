tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		'Pato: Maybe there is something here...',
		A.play('sfx_tape_pu', global_position, true, true),
		disable(),
		I.add_item('Tape'),
		'Pato: I\'ve found a tape.',
		'Pato: Might be useful.'
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
