tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.player_say('Uuuuyyyyyy'),
		C.player_say('La nueva película de Chicamocha'),
		C.player_say('...y si...'),
	]), 'completed')
	A.play('sfx_dream_transition', Vector2.ZERO, false)
	E.goto_room('Space')


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
