tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		C.player_say('A ver el sombrillín.'),
		A.play('sfx_umbrella_pu', global_position),
		disable(),
		I.add_item('Umbrella'),
		C.player_say('El mango parece un gancho.'),
		C.player_say('Puedo intentar jalar a Lobo con esto...')
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
