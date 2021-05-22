tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GOT_HOME):
		yield(E.run([
			C.walk_to_clicked()
		]), 'completed')
		A.play('sfx_spaceship_transition', Vector2.ZERO, false)
		E.goto_room('HomesPlantation')
	else:
		yield(E.run([
			'Pato: We already have a home-seed. No need to back.'
		]), 'completed')


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
