tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_dentures = false
	Globals.did(Globals.GameState.DENTURES_TAKEN)
	E.run([
		C.walk_to_clicked(),
		C.player_say('Es el momento, ahora puedo tomar la dentadura.'),
		C.player.grab(),
		A.play('sfx_dentures_pu', global_position),
		disable(),
		I.add_item('Dentures'),
		C.player_say('Listo el pollo.'),
		C.player_say('Ya tengo los dientes pa\' parecer un lobo')
	])


func on_look() -> void:
	E.run([
		C.player_say('Es la dentadura postiza de ese lobo vejete que no se aleja de la barra')
	])


func on_item_used(_item: Item) -> void:
	pass
