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
	A.play({cue_name = 'sfx_dream_transition', pos = Vector2.ZERO, is_in_queue = false})
	E.goto_room('Space')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
