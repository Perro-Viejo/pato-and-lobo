tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		'Pato: RoomSea-Umbrella-Pato-01',
		A.play('sfx_umbrella_pu', global_position),
		disable(),
		I.add_item('Umbrella'),
		'Pato: RoomSea-Umbrella-Pato-02',
		'Pato: RoomSea-Umbrella-Pato-03'
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
