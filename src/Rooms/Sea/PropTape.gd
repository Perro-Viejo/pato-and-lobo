tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		A.play('sfx_tape_pu', global_position, true, true),
		C.player_say('Arranquemos esta vuelta a ver que...'),
		disable(),
		I.add_item('Tape'),
		C.player_say('Enrollé la cinta.'),
		C.player_say('¡Péguelo perro!')
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
