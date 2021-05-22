tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		'Pato: It is disgusting... but can help.',
		A.play('sfx_mop_pu', global_position),
		disable(),
		I.add_item('Mop'),
		'Pato: It stinks... :S',
		'Pato: But is long'
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
