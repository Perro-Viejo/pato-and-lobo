tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		'Pato: I take this.',
		A.play('sfx_umbrella_pu', global_position),
		disable(),
		I.add_item('Umbrella'),
		'Pato: The handle looks like a hook.',
		'Pato: I can try to pull Lobo with this...'
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
