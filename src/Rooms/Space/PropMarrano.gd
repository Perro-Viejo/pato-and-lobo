tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(E.run([
			A.play({cue_name = 'sfx_space_marrano_transition', pos = Vector2.ZERO}),
			E.current_room.goto_planet(script_name)
		]), 'completed')
		E.goto_room('Marrano')
	else:
		yield(E.run([
			'Pato: RoomSpace-Marrano-Pato-01'
		]), 'completed')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
