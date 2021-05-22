tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_dentures = false
	Globals.did(Globals.GameState.DENTURES_TAKEN)
	E.run([
		C.walk_to_clicked(),
		'Pato: She won\'t miss her dentures. She is sleeping.',
		C.player.grab(),
		A.play('sfx_dentures_pu', global_position),
		disable(),
		I.add_item('Dentures'),
		'Pato: Easy peasy.',
		'Pato: Now I have the fangs for my costume'
	])


func on_look() -> void:
	E.run([
		C.player_say('Those are the dentures of the old wolf.')
	])


func on_item_used(_item: Item) -> void:
	pass
