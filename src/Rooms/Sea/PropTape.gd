tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		'Pato: RoomSea-Tape-Pato-01',
		A.play('sfx_tape_pu', global_position, true, true),
		disable(),
		I.add_item('Tape'),
		'Pato: RoomSea-Tape-Pato-02',
		'Pato: RoomSea-Tape-Pato-03'
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
