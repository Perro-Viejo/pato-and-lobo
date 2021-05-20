tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		C.player_say('A ver si encuentro algo...'),
		A.play('sfx_tape_pu', global_position, true, true),
		disable(),
		I.add_item('Tape'),
		C.player_say('Encontré la cinta.'),
		C.player_say('¡Péguelo perro!')
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
