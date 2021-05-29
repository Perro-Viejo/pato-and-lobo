tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.WATER_TAKEN):
		yield(E.run([
			A.play('sfx_spaceship_transition', Vector2.ZERO),
			E.current_room.goto_planet(script_name)
		]), 'completed')
		E.goto_room('Marrano')
	else:
		yield(E.run([
			'Pato: We already have the water for the house-seed. No need to back.'
		]), 'completed')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
