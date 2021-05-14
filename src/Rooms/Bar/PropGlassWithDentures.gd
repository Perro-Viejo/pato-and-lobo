tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		C.player_say('Es el momento, ahora puedo tomar la dentadura.'),
		disable(),
		I.add_item('Dentures'),
		C.player_say('Listo el pollo.'),
		C.player_say('Ya tengo los dientes pa\' parecer un lobo')
	])


func on_look() -> void:
	E.run([
		C.player_say('Es la dentadura postiza de ese lobo vejete que no se aleja de la barra')
	])


func on_item_used(item: Item) -> void:
	pass
