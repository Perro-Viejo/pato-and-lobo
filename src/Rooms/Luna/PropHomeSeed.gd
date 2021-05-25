tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	pass


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	if item.script_name == 'WaterCase':
		yield(E.run([
			I.remove_item('WaterCase'),
			C.player_walk_to(E.current_room.get_point('WolfPoint')),
			disable(),
			E.current_room.get_prop('Home').enable(),
			'Pato: Look my love, is the house of our dreams.',
			'Lobo: Now we can give us love and have children.'
		]), 'completed')
		E.goto_room('Bar')
