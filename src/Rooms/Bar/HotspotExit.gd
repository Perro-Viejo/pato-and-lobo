tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield (
		E.run([
			C.walk_to_clicked(),
			C.player.face_left(),
			'...',
			'Pato: RoomBar-Exit-Pato-01',
			A.play('sfx_door_open', global_position),
			A.stop('bg_bar'),
			A.stop('mx_bar_01')
		]),
		'completed'
	)
	E.goto_room('MainMenu')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
