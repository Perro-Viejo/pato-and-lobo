tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		A.play('sfx_door_open', global_position),
	]), 'completed')
	E.goto_room('Bar')


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
