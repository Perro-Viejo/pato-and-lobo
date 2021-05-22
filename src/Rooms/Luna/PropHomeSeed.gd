tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	pass


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	if item.script_name == 'WaterCase':
		E.current_room.get_prop('HomeSeed').disable(false)
		E.current_room.get_prop('Home').enable(false)
